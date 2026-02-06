module Pixel_Buffer( // Would work for 640 x 480 resolution, but I made it 64 x 48 for easue of use
    input logic clk,
    input logic reset,
    input logic visible_x,
    input logic visible_y,
    input logic hsync,
    input logic vsync,
    output logic[16:0] read_address
);
localparam START_OF_PIXELS = 300;
logic [9:0] x;
logic [9:0] y;
logic [3:0] a;
logic [3:0] b;
logic hsync_prev;
logic vsync_prev;
logic hsync_falling;
logic vsync_falling;
always_ff @(posedge clk) begin
    hsync_prev <= hsync;
    vsync_prev <= vsync;
end
assign hsync_falling = ~hsync & hsync_prev;
assign vsync_falling = ~vsync & vsync_prev;
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        x <= 0;
        y <= 0;
        a <= 0;
        b <= 0;
    end else if (vsync_falling) begin
        x <= 0;
        y <= 0;
        a <= 0;
        b <= 0;
    end else if (hsync_falling) begin
        x <= 0;
        a <= 0;
        if (b == 4'd9 & visible_y) begin
            b <= 0;
            y <= y + 1;
        end else if(visible_y) begin
            b <= b + 1;
        end else begin
            b <= b;
        end
    end else if (visible_x & visible_y) begin
        if (a == 4'd9) begin
            a <= 0;
            x <= x + 1;
        end else begin
            a <= a + 1;
        end
    end else begin
        a <= a;
        b <= b;
        x <= x;
        y <= y;
    end
end
logic m;
logic n;
assign m = a == 4'd9; // Gets the next color in time from ram for vga controller
assign read_address = START_OF_PIXELS + (y * 64) + x + m;

endmodule
