/*
Written by Chris Junior Tchapmou
January 5 2026
*/

module Hazard_unit(
    input logic clk,
    input logic [4:0] decode_reg1,
    input logic [4:0] decode_reg2,
    input logic [4:0] execute_reg_check, //awful name, change this later
    input logic [4:0] memory_reg,
    input logic [4:0] writeback_reg,
    input logic [31:0] memory_data,
    input logic [31:0] writeback_data,
    input logic [4:0] opcode,
    input logic halted,
    output logic hazard1,
    output logic hazard2,
    output logic [31:0] forward_data1,
    output logic [31:0] forward_data2,
    output logic stall
);
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
    logic [4:0] execute_reg1;
    logic [4:0] execute_reg2;
    logic [4:0] mem_opcode;
    logic [4:0] wb_opcode;
    always_ff @(posedge clk) begin
        if(halted) begin
        execute_reg1 <= execute_reg1;
        execute_reg2 <= execute_reg2;
        mem_opcode <= mem_opcode;
        wb_opcode <= wb_opcode;
        end else if(!stall) begin
        execute_reg1 <= decode_reg1;
        execute_reg2 <= decode_reg2;
        mem_opcode <= opcode;
        wb_opcode <= mem_opcode;
        end else begin
        execute_reg1 <= execute_reg1;
        execute_reg2 <= execute_reg2;
        mem_opcode <= opcode;
        wb_opcode <= mem_opcode;
        end
    end

    always_comb begin
        if (memory_reg != 0 && memory_reg == execute_reg1 && mem_opcode != SW && mem_opcode != BT && mem_opcode != BF && mem_opcode != EBREAK) begin
            forward_data1 = memory_data;
            hazard1 = 1'b1;
        end else if (writeback_reg != 0 && writeback_reg == execute_reg1 && wb_opcode != SW && wb_opcode != BT && wb_opcode != BF && wb_opcode != EBREAK) begin
            forward_data1 = writeback_data;
            hazard1 = 1'b1;
        end else begin
            forward_data1 = 32'b0;
            hazard1 = 1'b0;
        end
        if(memory_reg != 0 && memory_reg == execute_reg2 && mem_opcode != SW && mem_opcode != BT && mem_opcode != BF && mem_opcode != EBREAK) begin
            forward_data2 = memory_data;
            hazard2 = 1'b1;
        end else if (writeback_reg != 0 && writeback_reg == execute_reg2 && wb_opcode != SW && wb_opcode != BT && wb_opcode != BF && wb_opcode != EBREAK) begin
            forward_data2 = writeback_data;
            hazard2 = 1'b1;
        end else begin
            forward_data2 = 32'b0;
            hazard2 = 1'b0;
        end
        if(((opcode == LW) | (opcode == LI) | (opcode == LUI)) & 
           ((execute_reg_check == decode_reg1) | (execute_reg_check == decode_reg2))) begin
            stall = 1'b1;
        end else begin
            stall = 1'b0;
        end
    end
endmodule