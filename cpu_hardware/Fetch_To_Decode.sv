/*
Written by Chris Junior Tchapmou
January 5 2026
*/

module Fetch_To_Decode(
    input logic clk,
    input logic reset,
    input logic stall,
    input logic halted,
    input logic [31:0] instruction_in,
    input logic flush,
    output logic [31:0] instruction_out
);

always_ff @(posedge clk, posedge reset) begin
    if (reset | flush) begin
        instruction_out <= 32'b0;
    end else if (!stall & !halted) begin
        instruction_out <= instruction_in;
    end else begin
        instruction_out <= instruction_out;
    end
end
endmodule