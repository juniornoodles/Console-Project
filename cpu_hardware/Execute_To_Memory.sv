/*
Written by Chris Junior Tchapmou
January 5 2026
*/

module Execute_To_Memory(
    input logic clk,
    input logic reset,
    input logic halted,
    input logic [31:0] alu_result_in,
    input logic [16:0] memaddr_in,
    input logic [4:0] rd_in,
    input logic [4:0] alu_op_in,
    output logic [31:0] alu_result_out,
    output logic [16:0] memaddr_out,
    output logic [4:0] rd_out,
    output logic [4:0] alu_op_out
);
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            alu_result_out <= 32'b0;
            memaddr_out <= 17'b0;
            rd_out <= 5'b0;
            alu_op_out <= 5'b0;
        end else if (!halted) begin
            alu_result_out <= alu_result_in;
            memaddr_out <= memaddr_in;
            rd_out <= rd_in;
            alu_op_out <= alu_op_in;
        end else begin
            alu_result_out <= alu_result_out;
            memaddr_out <= memaddr_out;
            rd_out <= rd_out;
            alu_op_out <= alu_op_out;
        end

    end
endmodule