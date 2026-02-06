module VGA_Controller( // Controls timing for vga
    input logic clk,
    input logic reset,
    input logic [11:0] pixel_data,
    output logic hsync,
    output logic vsync,
    output logic [3:0] red,
    output logic [3:0] green,
    output logic [3:0] blue,
    output logic visible_x,
    output logic visible_y
);
logic [9:0] h_count;
logic [9:0] v_count;
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        h_count <= 0;
        v_count <= 0;
    end else begin
        if (h_count == 799) begin
            h_count <= 0;
            if (v_count == 524) begin
                v_count <= 0;
            end else begin
                v_count <= v_count + 1;
            end
        end else begin
            h_count <= h_count + 1;
        end
    end
end

always_comb begin
    // Horizontal sync pulse
    if (h_count >= 656 && h_count < 752) begin
        hsync = 0;
    end else begin
        hsync = 1;
    end

    // Vertical sync pulse
    if (v_count >= 490 && v_count < 492) begin
        vsync = 0;
    end else begin
        vsync = 1;
    end
    red = pixel_data[11:8];
    green = pixel_data[7:4];
    blue = pixel_data[3:0];
end
assign visible_x = (h_count < 640);
assign visible_y = (v_count < 480);

endmodule
