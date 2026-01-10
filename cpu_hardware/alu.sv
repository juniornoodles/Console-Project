/*
Written by Chris Junior Tchapmou
January 5 2026
*/

module alu(
    input logic [31:0] reg1, reg2,
    input logic [4:0] alu_op,
    output logic [31:0] result
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
    always_comb begin 
            case(alu_op)
                ADD, ADDI,JALR: result = reg1 + reg2;
                SUB: result = reg1 - reg2;
                AND, ANDI: result = reg1 & reg2;
                OR, ORI: result = reg1 | reg2;
                XOR, XORI: result = reg1 ^ reg2;
                SLOG, SLOGI: result = $signed(reg2) > 0 ? $signed(reg1) >> reg2 : $signed(reg1) << ($signed(reg2)*-1);
                SARI, SARII: result = $signed(reg2) > 0 ? $signed(reg1) >>> reg2 : $signed(reg1) <<< ($signed(reg2)*-1);
                ILTU, ILTUI: result = {31'b0, reg1 < reg2};
                ILT, ILTI: result = {31'b0, $signed(reg1) < $signed(reg2)};
                EQI, EQ, BF: result = {31'b0, reg1 == reg2};
                NEQI, NEQ, BT: result = {31'b0, reg1 != reg2};
                default: result = reg1;
            endcase
    end
endmodule
