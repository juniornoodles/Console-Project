/*
Written by Chris Junior Tchapmou
January 5 2026
*/

module Decode_To_Execute(
    input logic clk,
    input logic reset,
    input logic stall,
    input logic flush,
    input logic halted,
    input logic [31:0] operand1_in,
    input logic [31:0] operand2_in,
    input logic [4:0] rd_in,
    input logic [4:0] alu_op_in,
    output logic [31:0] operand1_out,
    output logic [31:0] operand2_out,
    output logic [4:0] alu_op_out,
    output logic [4:0] rd_out
);
    always_ff @(posedge clk,posedge reset) begin
        if (reset | flush) begin
            operand1_out <= 32'b0;
            operand2_out <= 32'b0;
            alu_op_out <= 5'b0;
            rd_out <= 5'b0;
        end else if (halted) begin
            operand1_out <= operand1_out;
            operand2_out <= operand2_out;
            alu_op_out <= alu_op_out;
            rd_out <= rd_out;
        end else if (!stall) begin
            operand1_out <= operand1_in;
            operand2_out <= operand2_in;
            alu_op_out <= alu_op_in;
            rd_out <= rd_in;
        end else begin
            operand1_out <= 32'b0;
            operand2_out <= 32'b0;
            alu_op_out <= 5'b0;
            rd_out <= 5'b0;
        end
    end
endmodule