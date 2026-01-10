/*
Written by Chris Junior Tchapmou
January 5 2026
*/

module Branch_Prediction_Unit(
    input logic clk,
    input logic stall,
    input logic halted,
    input logic [4:0] opcode,
    input logic [16:0] branch_target,
    input logic guess_wrong,
    output logic [16:0] predicted_offset,
    output logic [16:0] not_predicted_offset
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
logic [16:0] not_predicted_offset_IF;
logic [16:0] not_predicted_offset_ID;

always_ff @(posedge clk) begin
    if (stall | halted) begin
        not_predicted_offset_ID <= not_predicted_offset_ID;
        not_predicted_offset <= not_predicted_offset;
    end else begin
        not_predicted_offset_ID <= not_predicted_offset_IF;
        not_predicted_offset <= not_predicted_offset_ID;
    end
end

always_comb begin
    if (opcode == BT || opcode == BF) begin
        if ($signed(branch_target) >= 0) begin
            predicted_offset = 17'd1;
            not_predicted_offset_IF = branch_target - 17'd2;
        end else begin
            predicted_offset = branch_target;
            not_predicted_offset_IF = 17'd0 - branch_target;
        end
    end else if (opcode == JAL) begin
        predicted_offset = branch_target;
        not_predicted_offset_IF = 17'd0;
    end else begin
        predicted_offset = 17'd1;
        not_predicted_offset_IF = 17'd0;
    end
end

endmodule