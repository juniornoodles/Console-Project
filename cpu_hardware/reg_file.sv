/*
Written by Chris Junior Tchapmou
January 5 2026
*/

module reg_file (
    input logic clk,
    input logic reset,
    input logic [4:0] rd1_addr,
    input logic [4:0] rd2_addr,
    input logic [4:0] wr_addr,
    input logic [31:0] wr_data,
    input logic write_en,
    output logic [31:0] rd1_data,
    output logic [31:0] rd2_data
);
assign rd1_data = rd1_addr == 0 ? 32'b0 : rd1_addr == wr_addr & write_en ? wr_data : registers[rd1_addr];
assign rd2_data = rd2_addr == 0 ? 32'b0 : rd2_addr == wr_addr & write_en ? wr_data : registers[rd2_addr];
logic [31:0] registers [31:0];
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        for (int i = 11; i < 32; i++) begin
            registers[i] <= 32'b0;
        end
       
    end else if (write_en) begin
        registers[wr_addr] <= wr_data;
    end
end

endmodule


