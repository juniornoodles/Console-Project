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
    output logic [31:0] rd2_data,
    output logic [31:0] reg1,
    output logic [31:0] reg2,
    output logic [31:0] reg3,
    output logic [31:0] reg4,
    output logic [31:0] reg5,
    output logic [31:0] reg6,
    output logic [31:0] reg7,
    output logic [31:0] reg8,
    output logic [31:0] reg9,
    output logic [31:0] reg10
);
assign rd1_data = rd1_addr == 0 ? 32'b0 : rd1_addr == wr_addr & write_en ? wr_data : registers[rd1_addr];
assign rd2_data = rd2_addr == 0 ? 32'b0 : rd2_addr == wr_addr & write_en ? wr_data : registers[rd2_addr];
assign reg1 = registers[1];//for testing
assign reg2 = registers[2];
assign reg3 = registers[3];
assign reg4 = registers[4];
assign reg5 = registers[5];
assign reg6 = registers[6];
assign reg7 = registers[7];
assign reg8 = registers[8];
assign reg9 = registers[9];
assign reg10 = registers[10];
genvar i;
logic [31:0] registers [31:0];
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        for (int i = 11; i < 32; i++) begin
            registers[i] <= 32'b0;
        end
        registers[1] <=32'd1;
        registers[2] <=32'd2;
        registers[3] <=32'd3;
        registers[4] <=32'd4;
        registers[5] <=32'd5;
        registers[6] <=32'd6;
        registers[7] <=32'd7;
        registers[8] <=32'd8;
        registers[9] <=32'd9;
        registers[10] <=32'd10;
    end else if (write_en) begin
        registers[wr_addr] <= wr_data;
    end
end
endmodule