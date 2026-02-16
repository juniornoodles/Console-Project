/*
Written by Chris Junior Tchapmou
January 5 2026
*/

module cpu(
    input logic clk,
    input logic reset,
    input logic pause,
    input logic finish_debug
    //step and finish_debug are signals for debugging when ebreak is called.
    //The cpu detects the rising edge of step and allows one cycle to go through
    //When finish_debug is turned on, debug mode turns off
    input logic clk25, // Clock for vga timing
    input logic up,
    input logic down,
    input logic left,
    input logic right,
    input logic select,
    output logic hsync,
    output logic vsync,
    output logic [3:0] red,
    output logic [3:0] green,
    output logic [3:0] blue
);

logic [20:0] i;
logic step_sync;
logic step_prev;
logic debounced_step;
always_ff @(posedge clk) begin
    if (step) begin
        if(i != 21'h1FFFFF) begin 
            i <= i + 1;
        end else begin
            i <= i;
        end
    end else begin
        i <= 0;
    end
    if (i == 21'h1FFFFF) begin
        step_sync <= 1'b1;
    end else begin
        step_sync <= 1'b0;
    end
    step_prev <= step_sync;
end
assign debounced_step = step_sync & ~step_prev; // Rising edge detector

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
           SWR = 5'd29,
           ECALL = 5'd30,
           EBREAK = 5'd31;
localparam R_TYPE = 5'd10;
localparam NONE = 3'd0,
           UP = 3'd1,
           DOWN = 3'd2,
           LEFT = 3'd3,
           RIGHT = 3'd4,
           SELECT = 3'd5;
logic [31:0] RAM [RAM_SIZE-1:0];
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
logic [12:0] addr;
logic [31:0] RAM_read_data;
logic [31:0] mem_data_out;
logic [4:0] writeback_op;
    assign addr = flush ? (alu_op == JALR ? alu_result[12:0] : pc - 1 + not_predicted_offset ): pc - 1 + predicted_offset; // Logic to get the correct instruction from instruction memory
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
    .rd1_addr(instruction[4:0] != SW ? instruction[14:10] : instruction[9:5]), //Checks if it is a store to get contents from rd reg
    .rd2_addr(instruction[19:15]),
    .up(up),
    .down(down),
    .left(left),
    .right(right),
    .select(select),
    .rd1_data(reg_read_addr1),
    .rd2_data(reg_read_addr2)
);
Hazard_unit hazard_unit_inst(
    .clk(clk),
    .decode_reg1(instruction[4:0] != SW ?instruction[14:10] : instruction[9:5]), //Checks if it is a store to get contents from rd reg
    .decode_reg2(instruction[4:0] <= R_TYPE | instruction[4:0] == SWR ? instruction[19:15] : 5'b0), //If not R-type, no second reg to hazard check
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
    .opcode(instruction[4:0]),
    .branch_target(instruction[31:15]),
    .predicted_offset(predicted_offset),
    .not_predicted_offset(not_predicted_offset),
    .halted(halted)
);
pc_mem pc_mem_inst(
    .clk(clk),
    .reset(reset),
    .flush(flush),
    .halted(halted),
    .stall(stall),
    .addr(addr),
    .read_data(instruction)
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
    .memaddr_in(alu_op != LW ? operand2[16:0] : alu_result[16:0]),
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
always_comb begin  //If it is an R type then take the contents of the 2 read port, otherwise its an immediate, take it from he instruction itself. Contains sign extending logic.
    operand2_in = (instruction[4:0] <= R_TYPE ? reg_read_addr2 : (instruction[4:0] == ADDI | instruction[4:0] == ILT | instruction[4:0] == ILTI | instruction[4:0] == SLOG | instruction[4:0] == SLOGI | instruction[4:0] == SARI | instruction[4:0] == SARII | instruction[4:0] == BT | instruction[4:0] == BF | instruction[4:0] == JALR | instruction[4:0] == LW) & instruction[31] == 1 ? {{15{1'b1}},instruction[31:15]} : {{15{1'b0}},instruction[31:15]});
    operand1_in = reg_read_addr1;
end


//Execute stage
assign operand1 = hazard1 ? forward_data1 : decode_result1;
assign operand2 = (alu_op == BT | alu_op == BF) ? 32'b0 : hazard2 ? forward_data2 : decode_result2;
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
    if(reset) begin
        debug <= 1'b0;
    end else if (finish_debug) begin
        if (debug) begin
            debug <= 1'b0;
        end
    end else if (instruction[4:0] == EBREAK & !flush) begin
        debug <= 1'b1;
    end else begin
        debug <= debug;
    end
end

//Memory stage
always_ff @(posedge clk) begin
    RAM_read_data <= RAM[memaddr];
    writeback_op <= mem_alu_op;
    if(!halted) begin
        write_en <= (mem_alu_op == SW | mem_alu_op == BT | mem_alu_op == BF | mem_alu_op == EBREAK) ? 1'b0 : 1'b1;
        writeback_regaddr <= writeback_regaddr_in;
        if (mem_alu_op == SW | mem_alu_op == SWR) begin
            mem_data_out <= 32'b0;
            RAM[memaddr] <= memdata;
        end else if(mem_alu_op == LI) begin
            mem_data_out <= {{15{1'b0}},memaddr};
        end else if(mem_alu_op == LUI) begin
            mem_data_out <= {memaddr[14:0],17'b0};
        end else begin
            mem_data_out <= memdata;
        end
    end
    else begin
        write_en <= write_en;
        writeback_regaddr <= writeback_regaddr;
        mem_data_out <= mem_data_out;
        writeback_op <= writeback_op;
    end
end

//Writeback stage

assign writeback_data = (writeback_op == LW) ? RAM_read_data : mem_data_out;


//debuging
always_comb begin
    if(reset | !debug) begin
        halted = 1'b0;
    end else begin
        if(debounced_step) begin
            halted = 1'b0;
        end else begin
            halted = 1'b1;
        end
    end
end

//Video Memory Mapped I/O ---------------------------------------------------------------
localparam START_OF_PIXELS = 300;
logic [11:0] pixel_data;
logic [16:0] pixel_address;
logic visible_x;
logic visible_y;
VGA_Controller vga_controller_inst(
    .clk(clk25),
    .reset(reset),
    .pixel_data(pixel_data), 
    .hsync(hsync),
    .vsync(vsync),
    .red(red),
    .green(green),
    .blue(blue),
    .visible_x(visible_x),
    .visible_y(visible_y)
);
Pixel_Buffer pixel_buffer_inst(
    .clk(clk25),
    .reset(reset),
    .hsync(hsync),
    .vsync(vsync),
    .visible_x(visible_x),
    .visible_y(visible_y),
    .read_address(pixel_address)
);
always_ff @(posedge clk25) begin
    pixel_data <= RAM[pixel_address][11:0]; //Get pixel data from video memory
end


endmodule

module top(
  input logic clk,
    input logic reset_low,
    input logic step,
    input logic finish_debug,
    output logic hsync,
    output logic vsync,
    output logic [3:0] red,
    output logic [3:0] green,
    output logic [3:0] blue
);
    logic reset;
    assign reset = ~reset_low; //Active low button
    cpu cpu_inst(
        .clk(clk),
        .clk25(), // Use CAD tool of choice to create a clock that is 25MHz. I used vivado's clocking wizard
        .reset(reset),
        .step(step),
        .finish_debug(finish_debug),
        .vsync(vsync),
        .hsync(hsync),
        .red(red),
        .blue(blue),
        .green(green)
    );
endmodule

/* This is if you just want to simulate in the terminal and not implement it on an fpga
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
*/






