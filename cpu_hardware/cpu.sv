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
logic [31:0] registers [9:0];
logic [31:0] current; // for testing
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
assign current = pc_mem[pc]; // for testing
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
    .rd2_data(reg_read_addr2),
    .reg1(registers[0]), //for testing
    .reg2(registers[1]),
    .reg3(registers[2]),
    .reg4(registers[3]),
    .reg5(registers[4]),
    .reg6(registers[5]),
    .reg7(registers[6]),
    .reg8(registers[7]),
    .reg9(registers[8]),
    .reg10(registers[9])
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
    .operand1_in(operand1_in), // Connect appropriately
    .operand2_in(operand2_in), // Connect appropriately
    .rd_in(instruction[9:5]),
    .alu_op_in(instruction[4:0]),   // Connect appropriately
    .operand1_out(decode_result1),// Connect appropriately
    .operand2_out(decode_result2),// Connect appropriately
    .alu_op_out(alu_op),   // Connect appropriately
    .rd_out(rd),
    .halted(halted)
);
Execute_To_Memory execute_to_memory_inst(
    .clk(clk),
    .reset(reset),
    .alu_result_in(alu_op != JAL && alu_op != JALR ? alu_result : pc_EX), // Connect appropriately
    .rd_in(rd),
    .memaddr_in(operand2[16:0]),
    .alu_op_in(alu_op),
    .alu_result_out(memdata), // Connect appropriately
    .memaddr_out(memaddr),         // Connect appropriately
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
            pc <= alu_result[12:0];
        end else begin
            pc <= pc + not_predicted_offset;
        end
    end else if (stall | halted) begin
        pc <= pc;
    end else begin
        pc <= pc + predicted_offset;
    end
end

always_ff @(posedge clk) begin
    if (!stall & !halted) begin
        pc_ID <= pc + 1;
        pc_EX <= pc_ID;
    end else begin
        pc_ID <= pc_ID;
        pc_EX <= pc_EX;
    end
end

//Decode stage
always_comb begin
    operand2_in = (instruction[4:0] <= R_TYPE ? reg_read_addr2 : (instruction[4:0] == ADDI | instruction[4:0] == ILT | instruction[4:0] == ILTI | instruction[4:0] == SLOG | instruction[4:0] == SLOGI | instruction[4:0] == SARI | instruction[4:0] == SARII | instruction[4:0] == BT | instruction[4:0] == BF | instruction[4:0] == JALR) & instruction[31] == 1 ? {{15{1'b1}},instruction[31:15]} : {{15{1'b0}},instruction[31:15]});
    operand1_in = reg_read_addr1;
end


//Execute stage
assign operand1 = hazard1 ? forward_data1 : decode_result1;
assign operand2 = (alu_op == BT | alu_op == BF) ? 32'b0 : hazard2 ? forward_data2 : decode_result2;
always_comb begin
    if(alu_op == JALR) begin
        flush = 1'b1;
    end else if((alu_op == BT | alu_op == BF)) begin
        if(decode_result2[31] ^ alu_result[0]) begin
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
        halted <= 1'b1;
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
    RAM[0] = 32'd74;
    pc_mem[0] = {17'd0,5'd0,5'd1,LW};
    pc_mem[1] = {17'd10,5'd1,5'd3,EBREAK};
    pc_mem[2] = {17'd17,5'd0,5'd6,JAL};
    pc_mem[3] = {17'd2,5'd2,5'd3,ADDI};
    pc_mem[4] = {17'd0,5'd3,5'd4,ILTI};
    pc_mem[19] = {17'd21,5'd0,5'd3,LI};
    pc_mem[20] = {17'd4,5'd2,5'd8,ADDI};
    pc_mem[21] = {17'd1,5'd5,5'd10,SLOGI};
    pc_mem[22] = {17'd2,5'd6,5'd7,JALR};
    pc_mem[23] = {17'b11111111111111110,5'd4,5'd5,BT};



    #10; 
    $monitor(
        "PC: %d \n \
        Newest Instruction %b: \n \
\n \
\n \
        Reg 1: %b \n \
        Reg 2: %b \n \
        Reg 3: %b \n \
        Reg 4: %b \n \
        Reg 5: %b \n \
        Reg 6: %b \n \
        Reg 7: %b \n \
        Reg 8: %b \n \
        Reg 9: %b \n \
        Reg 10: %b \n \
        RAM[0]: %b \n \
\n \
\n \
        Fetch to Decode Stage: Instruction: %b \n \
        Decode to Execute Stage: Op1: %b Op2: %b ALU_OP: %b RD: %d Hazard1: %b Hazard2: %b \n \
        Execute to Memory Stage: ALU_RESULT: %d MEMADDR: %b RD: %d \n \
        Memory to Writeback Stage: Writeback data: %b Writeback addr: %d \
        \n \
        -------------------------------\n",
        pc,
        current,
        registers[0],
        registers[1],
        registers[2],
        registers[3],
        registers[4],
        registers[5],
        registers[6],
        registers[7],
        registers[8],
        registers[9],
        RAM[0],
        instruction,
        operand1, operand2, alu_op, rd, hazard1, hazard2,
        memdata, memaddr, writeback_regaddr_in,
        writeback_data, writeback_regaddr);
    // Example instruction
    // Add more initialization as needed
end


endmodule

module tb;

    logic clk;
    logic reset;
    logic pause;
    logic finish_debug;
    cpu cpu_inst(
        .clk(clk),
        .reset(reset),
        .pause(pause),
        .finish_debug(finish_debug)
    );


    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, tb);
        clk = 0;
        reset = 1;
        pause = 1;
        finish_debug = 0;
        #10;
        reset = 0;
        repeat (15) begin
            #5 clk = ~clk;
            #5 clk = ~clk;
        end
        pause = 0;
        repeat (4) begin
            #5 clk = ~clk;
            #5 clk = ~clk;
        end
        pause = 1;
        repeat (40) begin
            #5 clk = ~clk;
            #5 clk = ~clk;
        end
        finish_debug = 1;
        #10;
        finish_debug = 0;
        repeat (10) begin
            #5 clk = ~clk;
            #5 clk = ~clk;
        end


    end
endmodule
