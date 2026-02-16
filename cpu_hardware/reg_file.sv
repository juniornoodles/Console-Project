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
    input logic up,
    input logic down,
    input logic left,
    input logic right,
    input logic select,
    output logic [31:0] rd1_data,
    output logic [31:0] rd2_data
);
localparam NONE = 3'd0,
           UP = 3'd1,
           DOWN = 3'd2,
           LEFT = 3'd3,
           RIGHT = 3'd4,
           SELECT = 3'd5;
logic [31:0] registers [30:0];
logic [31:0] input_reg;
assign rd1_data = rd1_addr == 0 ? 32'b0 : rd1_addr == 5'd31 ? input_reg : rd1_addr == wr_addr & write_en ? wr_data : registers[rd1_addr];
assign rd2_data = rd2_addr == 0 ? 32'b0 : rd2_addr == 5'd31 ? input_reg : rd2_addr == wr_addr & write_en ? wr_data : registers[rd2_addr];
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        for (int i = 0; i < 32; i++) begin
            registers[i] <= 32'b0;
        end
    end else if (write_en) begin
        registers[wr_addr] <= wr_data;
    end
end

always_comb begin
    if(select) begin
        input_reg = SELECT;
    end else if (up) begin
        input_reg = UP;
    end else if (down) begin
        input_reg = DOWN;
    end else if (left) begin
        input_reg = LEFT;
    end else if (right) begin
        input_reg = RIGHT;
    end else begin
        input_reg = NONE;
    end
end
endmodule
