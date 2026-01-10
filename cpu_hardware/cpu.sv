/*
Written by Chris Junior Tchapmou
January 5 2026
*/

module cpu(
    input logic clk,
    input logic reset,
    input logic pause,
    input logic finish_debug
);

localparam START_OF_PROGRAM = 13'h0000;
localparam RAM_SIZE = 131072;
localparam PC_SIZE = 8192;   
localparam ADD = 5'd0,
           SUB = 5'd1,
           AND = 5'd2,
           OR  = 5'd3,
           XOR = 5'd4,
           SLOG = 5'd5,
           SARI = 5'd6,
           ILTU = 5'd7,
           ILT = 5'd8,  
           EQ  = 5'd9,
           NEQ = 5'd10,
           ADDI= 5'd11,
           ANDI= 5'd12,
           ORI = 5'd13,
           XORI= 5'd14,
           SLOGI= 5'd15,
           SARII= 5'd16,
           ILTUI= 5'd17,
           ILTI = 5'd18,
           EQI = 5'd19,
           NEQI= 5'd20,
           LW = 5'd21,
           SW = 5'd22,
           BT = 5'd23,
           BF = 5'd24,
           JAL = 5'd25,
           JALR = 5'd26,
           LI = 5'd27,
           LUI = 5'd28,
           AUITPC = 5'd29,
           ECALL = 5'd30,
           EBREAK = 5'd31;
localparam R_TYPE = 5'd10;
logic [31:0] RAM [RAM_SIZE-1:0];
logic [31:0] pc_mem [PC_SIZE-1:0]; 
logic [12:0] pc = START_OF_PROGRAM;
logic [31:0] instruction;
logic [31:0] operand1;
logic [31:0] operand2;
logic [4:0] alu_op;
logic [4:0] rd;
logic [31:0] alu_result;
logic [16:0] memaddr;
logic [31:0] memdata;
logic [31:0] writeback_data;
logic [31:0] writeback_data_in;
logic [4:0] writeback_regaddr;
logic [4:0] writeback_regaddr_in;
logic [31:0] reg_read_addr1;
logic [31:0] reg_read_addr2;
logic [31:0] reg_read_addr3;
logic write_en_in;
logic write_en;
logic [31:0] operand1_in;
logic [31:0] operand2_in;
logic hazard1;
logic hazard2;
logic [31:0] forward_data1;
logic [31:0] forward_data2;
logic [4:0] mem_alu_op;
logic [31:0] decode_result1;
logic [31:0] decode_result2;
logic stall;
logic flush;
logic [16:0] predicted_offset;
logic [16:0] not_predicted_offset;
logic [12:0] pc_ID;
logic [12:0] pc_EX;
logic halted;
logic debug;
alu alu_inst(
    .reg1(operand1),
    .reg2(operand2),
    .alu_op(alu_op),
    .result(alu_result)
);
reg_file reg_file_inst(
    .clk(clk),
    .reset(reset),
    .write_en(write_en),
    .wr_addr(writeback_regaddr), 
    .wr_data(writeback_data), 
    .rd1_addr(instruction[4:0] != SW  ? instruction[14:10] : instruction[9:5]), //Checks if it is a store to get contents from rd reg
    .rd2_addr(instruction[19:15]),
    .rd1_data(reg_read_addr1),
    .rd2_data(reg_read_addr2)
);
Hazard_unit hazard_unit_inst(
    .clk(clk),
    .decode_reg1(instruction[4:0] != SW ?instruction[14:10] : instruction[9:5]), //Checks if it is a store to get contents from rd reg
    .decode_reg2(instruction[4:0] <= R_TYPE ? instruction[19:15] : 5'b0), //If not R-type, no second reg to hazard check
    .execute_reg_check(rd),
    .memory_reg(writeback_regaddr_in),
    .writeback_reg(writeback_regaddr),
    .memory_data(memdata),
    .writeback_data(writeback_data),
    .hazard1(hazard1),
    .hazard2(hazard2),
    .forward_data1(forward_data1),
    .forward_data2(forward_data2),
    .opcode(alu_op),
    .stall(stall),
    .halted(halted)
);
Branch_Prediction_Unit branch_prediction_unit_inst(
    .clk(clk),
    .stall(stall),
    .opcode(pc_mem[pc][4:0]),
    .branch_target(pc_mem[pc][31:15]),
    .guess_wrong(flush),
    .predicted_offset(predicted_offset),
    .not_predicted_offset(not_predicted_offset),
    .halted(halted)
);
Fetch_To_Decode fetch_to_decode_inst(
    .clk(clk),
    .reset(reset),
    .flush(flush),
    .stall(stall),
    .instruction_in(pc_mem[pc]),
    .instruction_out(instruction),
    .halted(halted)
);
Decode_To_Execute decode_to_execute_inst(
    .clk(clk),
    .reset(reset),
    .stall(stall),
    .flush(flush),
    .operand1_in(operand1_in), 
    .operand2_in(operand2_in),
    .rd_in(instruction[9:5]),
    .alu_op_in(instruction[4:0]),   
    .operand1_out(decode_result1),
    .operand2_out(decode_result2),
    .alu_op_out(alu_op),   
    .rd_out(rd),
    .halted(halted)
);
Execute_To_Memory execute_to_memory_inst(
    .clk(clk),
    .reset(reset),
    .alu_result_in(alu_op != JAL && alu_op != JALR ? alu_result : pc_EX), 
    .rd_in(rd),
    .memaddr_in(operand2[16:0]),
    .alu_op_in(alu_op),
    .alu_result_out(memdata), 
    .memaddr_out(memaddr),         
    .rd_out(writeback_regaddr_in),
    .alu_op_out(mem_alu_op),
    .halted(halted)
);
//Fetch stage
always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
        pc <= START_OF_PROGRAM;
    end else if (flush) begin
        if(alu_op == JALR) begin
            pc <= alu_result[12:0]; //Whatever is in the register plus the immidate value for the jump address
        end else begin
            pc <= pc + not_predicted_offset; //If a flush is needed then the wrong branch outcome was predicted
        end
    end else if (stall | halted) begin
        pc <= pc;
    end else begin
        pc <= pc + predicted_offset;
    end
end

    always_ff @(posedge clk) begin //Here just so JAL and JALR can have the program instruction to store in a register
    if (!stall & !halted) begin
        pc_ID <= pc + 1;
        pc_EX <= pc_ID;
    end else begin
        pc_ID <= pc_ID;
        pc_EX <= pc_EX;
    end
end

//Decode stage
    always_comb begin  //If it is an R type then take the contents of the 2 read port, otherwise its an immediate, take it from he instruction itself. Contains sign extending logic.
    operand2_in = (instruction[4:0] <= R_TYPE ? reg_read_addr2 : (instruction[4:0] == ADDI | instruction[4:0] == ILT | instruction[4:0] == ILTI | instruction[4:0] == SLOG | instruction[4:0] == SLOGI | instruction[4:0] == SARI | instruction[4:0] == SARII | instruction[4:0] == BT | instruction[4:0] == BF | instruction[4:0] == JALR) & instruction[31] == 1 ? {{15{1'b1}},instruction[31:15]} : {{15{1'b0}},instruction[31:15]});
    operand1_in = reg_read_addr1;
end


//Execute stage
assign operand1 = hazard1 ? forward_data1 : decode_result1;
    assign operand2 = (alu_op == BT | alu_op == BF) ? 32'b0 : hazard2 ? forward_data2 : decode_result2; // If a branch instruction, set the second operand to 0 to check if it equals zero or not in the alu
always_comb begin
    if(alu_op == JALR) begin
        flush = 1'b1;
    end else if((alu_op == BT | alu_op == BF)) begin
        if(decode_result2[31] ^ alu_result[0]) begin // With BTFNT prediction, if the offset is negative and the alu determines a branch shouldn't happen the predicition is wrong and vice versa
            flush = 1'b1;
        end else begin
            flush = 1'b0;
        end
    end else begin
        flush = 1'b0;
    end
end

    always_ff @(posedge clk or posedge reset or posedge finish_debug) begin 
    if(reset | (debug & finish_debug)) begin
        debug = 1'b0;
    end else if(alu_op == EBREAK) begin
        debug = 1'b1;
    end else begin
        debug = debug;
    end
end

//Memory stage
always_ff @(posedge clk) begin
    if(!halted) begin
        write_en = (mem_alu_op == SW | mem_alu_op == BT | mem_alu_op == BF | mem_alu_op == EBREAK) ? 1'b0 : 1'b1;
        writeback_regaddr = writeback_regaddr_in;
        if (mem_alu_op == LW ) begin
            writeback_data = RAM[memaddr];
        end else if (mem_alu_op == SW) begin
            writeback_data = 32'b0;
            RAM[memaddr] = memdata;
        end else if(mem_alu_op == LI) begin
            writeback_data = {{15{1'b0}},memaddr};
        end else if(mem_alu_op == LUI) begin
            writeback_data = {memaddr[14:0],17'b0};
        end else begin
            writeback_data = memdata;
        end
    end
    else begin
        write_en = write_en;
        writeback_regaddr = writeback_regaddr;
        writeback_data = writeback_data;
    end
end

//debuging
always_ff @(posedge clk or posedge reset) begin
    if(reset | !debug) begin
        halted <= 1'b0; 
    end else begin
        halted <= 1'b1; //If debug is on then everything halts, if the pause signal is off then the program goes through one cycle.
        if(!pause) begin
            halted <= 1'b0;
        end
    end
end

initial begin
    integer i;
    for (i = 0; i < PC_SIZE; i = i + 1) begin
        pc_mem[i] = 32'b0;
    end
    for (i = 0; i < RAM_SIZE; i = i + 1) begin
        RAM[i] = 32'b0;
    end 
    // Either put a file here to read from or manually enter the contents of the PC memory and the RAM
end
endmodule


