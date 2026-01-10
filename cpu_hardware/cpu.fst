$date
	Wed Dec 31 15:35:52 2025
$end
$version
	Icarus Verilog
$end
$timescale
	1s
$end
$scope module tb $end
$var reg 1 ! clk $end
$var reg 1 " reset $end
$scope module cpu_inst $end
$var wire 1 ! clk $end
$var wire 32 # current [31:0] $end
$var wire 1 " reset $end
$var wire 5 $ writeback_regaddr_in [4:0] $end
$var wire 5 % writeback_regaddr [4:0] $end
$var wire 32 & writeback_data [31:0] $end
$var wire 1 ' write_en $end
$var wire 1 ( stall $end
$var wire 32 ) reg_read_addr2 [31:0] $end
$var wire 32 * reg_read_addr1 [31:0] $end
$var wire 5 + rd [4:0] $end
$var wire 32 , operand2 [31:0] $end
$var wire 32 - operand1 [31:0] $end
$var wire 32 . memdata [31:0] $end
$var wire 17 / memaddr [16:0] $end
$var wire 5 0 mem_alu_op [4:0] $end
$var wire 32 1 instruction [31:0] $end
$var wire 1 2 hazard2 $end
$var wire 1 3 hazard1 $end
$var wire 32 4 forward_data2 [31:0] $end
$var wire 32 5 forward_data1 [31:0] $end
$var wire 32 6 alu_result [31:0] $end
$var wire 5 7 alu_op [4:0] $end
$var parameter 5 8 ADD $end
$var parameter 5 9 ADDI $end
$var parameter 5 : AND $end
$var parameter 5 ; ANDI $end
$var parameter 5 < AUITPC $end
$var parameter 5 = BF $end
$var parameter 5 > BT $end
$var parameter 5 ? EBREAK $end
$var parameter 5 @ ECALL $end
$var parameter 5 A EQ $end
$var parameter 5 B EQI $end
$var parameter 5 C ILT $end
$var parameter 5 D ILTI $end
$var parameter 5 E ILTU $end
$var parameter 5 F ILTUI $end
$var parameter 5 G JAL $end
$var parameter 5 H JALR $end
$var parameter 5 I LI $end
$var parameter 5 J LUI $end
$var parameter 5 K LW $end
$var parameter 5 L NEQ $end
$var parameter 5 M NEQI $end
$var parameter 5 N OR $end
$var parameter 5 O ORI $end
$var parameter 32 P PC_SIZE $end
$var parameter 32 Q RAM_SIZE $end
$var parameter 5 R R_TYPE $end
$var parameter 5 S SARI $end
$var parameter 5 T SARII $end
$var parameter 5 U SLOG $end
$var parameter 5 V SLOGI $end
$var parameter 13 W START_OF_PROGRAM $end
$var parameter 5 X SUB $end
$var parameter 5 Y SW $end
$var parameter 5 Z XOR $end
$var parameter 5 [ XORI $end
$var reg 32 \ operand1_in [31:0] $end
$var reg 32 ] operand2_in [31:0] $end
$var reg 13 ^ pc [12:0] $end
$var reg 1 _ was_stalled $end
$var reg 1 ` write_en_in $end
$var reg 32 a writeback_data_in [31:0] $end
$scope module alu_inst $end
$var wire 32 b reg2 [31:0] $end
$var wire 32 c reg1 [31:0] $end
$var wire 5 d alu_op [4:0] $end
$var parameter 5 e ADD $end
$var parameter 5 f ADDI $end
$var parameter 5 g AND $end
$var parameter 5 h ANDI $end
$var parameter 5 i EQ $end
$var parameter 5 j EQI $end
$var parameter 5 k ILT $end
$var parameter 5 l ILTI $end
$var parameter 5 m ILTU $end
$var parameter 5 n ILTUI $end
$var parameter 5 o NEQ $end
$var parameter 5 p NEQI $end
$var parameter 5 q OR $end
$var parameter 5 r ORI $end
$var parameter 5 s SARI $end
$var parameter 5 t SARII $end
$var parameter 5 u SLOG $end
$var parameter 5 v SLOGI $end
$var parameter 5 w SUB $end
$var parameter 5 x XOR $end
$var parameter 5 y XORI $end
$var reg 32 z result [31:0] $end
$upscope $end
$scope module decode_to_execute_inst $end
$var wire 5 { alu_op_in [4:0] $end
$var wire 1 ! clk $end
$var wire 32 | operand1_in [31:0] $end
$var wire 32 } operand2_in [31:0] $end
$var wire 5 ~ rd_in [4:0] $end
$var wire 1 " reset $end
$var wire 1 ( stall $end
$var reg 5 !" alu_op_out [4:0] $end
$var reg 32 "" operand1_out [31:0] $end
$var reg 32 #" operand2_out [31:0] $end
$var reg 5 $" rd_out [4:0] $end
$upscope $end
$scope module execute_to_memory_inst $end
$var wire 5 %" alu_op_in [4:0] $end
$var wire 32 &" alu_result_in [31:0] $end
$var wire 1 ! clk $end
$var wire 17 '" memaddr_in [16:0] $end
$var wire 5 (" rd_in [4:0] $end
$var wire 1 " reset $end
$var reg 5 )" alu_op_out [4:0] $end
$var reg 32 *" alu_result_out [31:0] $end
$var reg 17 +" memaddr_out [16:0] $end
$var reg 5 ," rd_out [4:0] $end
$upscope $end
$scope module fetch_to_decode_inst $end
$var wire 1 ! clk $end
$var wire 32 -" instruction_in [31:0] $end
$var wire 1 " reset $end
$var wire 1 ( stall $end
$var reg 32 ." instruction_out [31:0] $end
$upscope $end
$scope module hazard_unit_inst $end
$var wire 5 /" decode_reg1 [4:0] $end
$var wire 5 0" decode_reg2 [4:0] $end
$var wire 32 1" execute_data [31:0] $end
$var wire 5 2" execute_reg [4:0] $end
$var wire 32 3" memory_data [31:0] $end
$var wire 5 4" memory_reg [4:0] $end
$var wire 5 5" opcode [4:0] $end
$var wire 1 _ was_stalled $end
$var wire 5 6" writeback_reg [4:0] $end
$var wire 32 7" writeback_data [31:0] $end
$var parameter 5 8" ADD $end
$var parameter 5 9" ADDI $end
$var parameter 5 :" AND $end
$var parameter 5 ;" ANDI $end
$var parameter 5 <" AUITPC $end
$var parameter 5 =" BF $end
$var parameter 5 >" BT $end
$var parameter 5 ?" EBREAK $end
$var parameter 5 @" ECALL $end
$var parameter 5 A" EQ $end
$var parameter 5 B" EQI $end
$var parameter 5 C" ILT $end
$var parameter 5 D" ILTI $end
$var parameter 5 E" ILTU $end
$var parameter 5 F" ILTUI $end
$var parameter 5 G" JAL $end
$var parameter 5 H" JALR $end
$var parameter 5 I" LI $end
$var parameter 5 J" LUI $end
$var parameter 5 K" LW $end
$var parameter 5 L" NEQ $end
$var parameter 5 M" NEQI $end
$var parameter 5 N" OR $end
$var parameter 5 O" ORI $end
$var parameter 5 P" SARI $end
$var parameter 5 Q" SARII $end
$var parameter 5 R" SLOG $end
$var parameter 5 S" SLOGI $end
$var parameter 5 T" SUB $end
$var parameter 5 U" SW $end
$var parameter 5 V" XOR $end
$var parameter 5 W" XORI $end
$var reg 32 X" forward_data1 [31:0] $end
$var reg 32 Y" forward_data2 [31:0] $end
$var reg 1 3 hazard1 $end
$var reg 1 2 hazard2 $end
$var reg 1 ( stall $end
$upscope $end
$scope module memory_to_writeback_inst $end
$var wire 1 ! clk $end
$var wire 1 " reset $end
$var wire 1 ` write_en_in $end
$var wire 32 Z" writeback_data_in [31:0] $end
$var wire 5 [" writeback_regaddr_in [4:0] $end
$var reg 1 ' write_en_out $end
$var reg 32 \" writeback_data_out [31:0] $end
$var reg 5 ]" writeback_regaddr_out [4:0] $end
$upscope $end
$scope module reg_file_inst $end
$var wire 1 ! clk $end
$var wire 5 ^" rd1_addr [4:0] $end
$var wire 5 _" rd2_addr [4:0] $end
$var wire 32 `" reg1 [31:0] $end
$var wire 32 a" reg10 [31:0] $end
$var wire 32 b" reg11 [31:0] $end
$var wire 32 c" reg12 [31:0] $end
$var wire 32 d" reg13 [31:0] $end
$var wire 32 e" reg14 [31:0] $end
$var wire 32 f" reg15 [31:0] $end
$var wire 32 g" reg16 [31:0] $end
$var wire 32 h" reg17 [31:0] $end
$var wire 32 i" reg18 [31:0] $end
$var wire 32 j" reg19 [31:0] $end
$var wire 32 k" reg2 [31:0] $end
$var wire 32 l" reg20 [31:0] $end
$var wire 32 m" reg21 [31:0] $end
$var wire 32 n" reg22 [31:0] $end
$var wire 32 o" reg23 [31:0] $end
$var wire 32 p" reg24 [31:0] $end
$var wire 32 q" reg25 [31:0] $end
$var wire 32 r" reg26 [31:0] $end
$var wire 32 s" reg27 [31:0] $end
$var wire 32 t" reg28 [31:0] $end
$var wire 32 u" reg29 [31:0] $end
$var wire 32 v" reg3 [31:0] $end
$var wire 32 w" reg30 [31:0] $end
$var wire 32 x" reg31 [31:0] $end
$var wire 32 y" reg4 [31:0] $end
$var wire 32 z" reg5 [31:0] $end
$var wire 32 {" reg6 [31:0] $end
$var wire 32 |" reg7 [31:0] $end
$var wire 32 }" reg8 [31:0] $end
$var wire 32 ~" reg9 [31:0] $end
$var wire 1 " reset $end
$var wire 5 !# wr_addr [4:0] $end
$var wire 32 "# wr_data [31:0] $end
$var wire 1 ' write_en $end
$var wire 32 ## rd2_data [31:0] $end
$var wire 32 $# rd1_data [31:0] $end
$scope begin $ivl_for_loop0 $end
$var integer 32 %# i [31:0] $end
$upscope $end
$upscope $end
$scope begin $unm_blk_14 $end
$var integer 32 &# i [31:0] $end
$upscope $end
$upscope $end
$upscope $end
$enddefinitions $end
$comment Show the parameter values. $end
$dumpall
b1110 W"
b100 V"
b10110 U"
b1 T"
b1111 S"
b101 R"
b10000 Q"
b110 P"
b1101 O"
b11 N"
b10100 M"
b1010 L"
b10101 K"
b11100 J"
b11011 I"
b11010 H"
b11001 G"
b10001 F"
b111 E"
b10010 D"
b1000 C"
b10011 B"
b1001 A"
b11110 @"
b11111 ?"
b10111 >"
b11000 ="
b11101 <"
b1100 ;"
b10 :"
b1011 9"
b0 8"
b1110 y
b100 x
b1 w
b1111 v
b101 u
b10000 t
b110 s
b1101 r
b11 q
b10100 p
b1010 o
b10001 n
b111 m
b10010 l
b1000 k
b10011 j
b1001 i
b1100 h
b10 g
b1011 f
b0 e
b1110 [
b100 Z
b10110 Y
b1 X
b0 W
b1111 V
b101 U
b10000 T
b110 S
b1010 R
b100000000000000000 Q
b10000000000000 P
b1101 O
b11 N
b10100 M
b1010 L
b10101 K
b11100 J
b11011 I
b11010 H
b11001 G
b10001 F
b111 E
b10010 D
b1000 C
b10011 B
b1001 A
b11110 @
b11111 ?
b10111 >
b11000 =
b11101 <
b1100 ;
b10 :
b1011 9
b0 8
$end
#0
$dumpvars
b100000000000000000 &#
b100000 %#
b0 $#
b0 ##
b0 "#
b0 !#
b1001 ~"
b1000 }"
b111 |"
b110 {"
b101 z"
b100 y"
b11111 x"
b11110 w"
b11 v"
b11101 u"
b11100 t"
b11011 s"
b11010 r"
b11001 q"
b11000 p"
b10111 o"
b10110 n"
b10101 m"
b10100 l"
b10 k"
b10011 j"
b10010 i"
b10001 h"
b10000 g"
b1111 f"
b1110 e"
b1101 d"
b1100 c"
b1011 b"
b1010 a"
b1 `"
b0 _"
b0 ^"
b0 ]"
b0 \"
b0 ["
bx Z"
b0 Y"
b0 X"
b0 7"
b0 6"
b0 5"
b0 4"
b0 3"
b0 2"
b0 1"
b0 0"
b0 /"
b0 ."
b1010011010101101010010100110 -"
b0 ,"
b0 +"
b0 *"
b0 )"
b0 ("
b0 '"
b0 &"
b0 %"
b0 $"
b0 #"
b0 ""
b0 !"
b0 ~
b0 }
b0 |
b0 {
b0 z
b0 d
b0 c
b0 b
bx a
x`
x_
b0 ^
b0 ]
b0 \
b0 7
b0 6
b0 5
b0 4
03
02
b0 1
b0 0
b0 /
b0 .
b0 -
b0 ,
b0 +
b0 *
b0 )
0(
0'
b0 &
b0 %
b0 $
b1010011010101101010010100110 #
1"
0!
$end
#10
0"
#15
b10101 \
b10101 |
b10101 ]
b10101 }
b10101 *
b10101 $#
b10101 0"
b10101 /"
b10101 )
b10101 ##
b10101 ^"
b110 {
b101 ~
b10101 _"
b11111101011111101101010000000011 #
b11111101011111101101010000000011 -"
b1 ^
1'
b1010011010101101010010100110 1
b1010011010101101010010100110 ."
0_
b0 a
b0 Z"
1`
1!
#20
0!
#25
b11101 ]
b11101 }
b11101 0"
b11101 )
b11101 ##
b11 {
b0 ~
b11101 _"
b10101 '"
b11111101011111101101010000000011 1
b11111101011111101101010000000011 ."
b101 +
b101 $"
b101 ("
b101 2"
b110 7
b110 d
b110 !"
b110 %"
b110 5"
b10101 ,
b10101 b
b10101 #"
b10101 -
b10101 c
b10101 ""
b10000010001011011111100010110110 #
b10000010001011011111100010110110 -"
b10 ^
1!
#30
0!
#35
13
b0 \
b0 |
b101 *
b101 $#
b0 0"
b101 /"
b11011 )
b11011 ##
b101 ^"
b11101 '"
b11101 6
b11101 z
b11101 &"
b11101 1"
b10110 {
b101 ~
b11011 _"
b10000010001011011 ]
b10000010001011011 }
b1111000010100001110001010101001 #
b1111000010100001110001010101001 -"
b11 ^
b110 0
b110 )"
b101 $
b101 ,"
b101 4"
b101 ["
b10101 /
b10101 +"
b0 +
b0 $"
b0 ("
b0 2"
b11 7
b11 d
b11 !"
b11 %"
b11 5"
b11101 ,
b11101 b
b11101 #"
b10000010001011011111100010110110 1
b10000010001011011111100010110110 ."
1!
#40
0!
#45
03
b11000 *
b11000 $#
b1 0"
b11000 /"
b1 )
b1 ##
b11000 ^"
b1001 {
b10101 ~
b1 _"
b11000 \
b11000 |
b1 ]
b1 }
b10000010001011011 '"
b0 6
b0 z
b0 &"
b0 1"
b0 5
b0 X"
b1111000010100001110001010101001 1
b1111000010100001110001010101001 ."
b101 +
b101 $"
b101 ("
b101 2"
b10110 7
b10110 d
b10110 !"
b10110 %"
b10110 5"
b10000010001011011 ,
b10000010001011011 b
b10000010001011011 #"
b0 -
b0 c
b0 ""
b11 0
b11 )"
b0 $
b0 ,"
b0 4"
b0 ["
b11101 /
b11101 +"
b11101 .
b11101 *"
b11101 3"
b101 %
b101 6"
b101 ]"
b101 !#
b10111101101011100010010101010001 #
b10111101101011100010010101010001 -"
b100 ^
1!
#50
0!
#55
b1001 \
b1001 |
b1001 *
b1001 $#
b0 0"
b1001 /"
b11100 )
b11100 ##
b1001 ^"
b1 '"
b10001 {
b1010 ~
b11100 _"
b10111101101011100 ]
b10111101101011100 }
b11100111101010101100011011110000 #
b11100111101010101100011011110000 -"
b101 ^
b0 %
b0 6"
b0 ]"
b0 !#
b11101 &
b11101 7"
b11101 \"
b11101 "#
b10110 0
b10110 )"
b101 $
b101 ,"
b101 4"
b101 ["
b10000010001011011 /
b10000010001011011 +"
b0 .
b0 *"
b0 3"
b10101 +
b10101 $"
b10101 ("
b10101 2"
b1001 7
b1001 d
b1001 !"
b1001 %"
b1001 5"
b1 ,
b1 b
b1 #"
b11000 -
b11000 c
b11000 ""
b10111101101011100010010101010001 1
b10111101101011100010010101010001 ."
b0 z"
b11101 a
b11101 Z"
1!
#60
0!
#65
b10001 \
b10001 |
b10001 *
b10001 $#
b10001 /"
b10101 )
b10101 ##
b10001 ^"
b10000 {
b10111 ~
b10101 _"
b11111111111111111100111101010101 ]
b11111111111111111100111101010101 }
b10111101101011100 '"
b1 6
b1 z
b1 &"
b1 1"
b11100111101010101100011011110000 1
b11100111101010101100011011110000 ."
b1010 +
b1010 $"
b1010 ("
b1010 2"
b10001 7
b10001 d
b10001 !"
b10001 %"
b10001 5"
b10111101101011100 ,
b10111101101011100 b
b10111101101011100 #"
b1001 -
b1001 c
b1001 ""
b1001 0
b1001 )"
b10101 $
b10101 ,"
b10101 4"
b10101 ["
b1 /
b1 +"
0'
b101 %
b101 6"
b101 ]"
b101 !#
b0 &
b0 7"
b0 \"
b0 "#
b10011010000001100000001101110 #
b10011010000001100000001101110 -"
b110 ^
b0 a
b0 Z"
0`
1!
#70
0!
#75
b10000 \
b10000 |
b10000 *
b10000 $#
b10000 /"
b1 )
b1 ##
b10000 ^"
b11100111101010101 '"
b0 6
b0 z
b0 &"
b0 1"
b1110 {
b11 ~
b1 _"
b10011010000001 ]
b10011010000001 }
b1100110110001100100000110101101 #
b1100110110001100100000110101101 -"
b111 ^
1'
b10101 %
b10101 6"
b10101 ]"
b10101 !#
b10001 0
b10001 )"
b1010 $
b1010 ,"
b1010 4"
b1010 ["
b10111101101011100 /
b10111101101011100 +"
b1 .
b1 *"
b1 3"
b10111 +
b10111 $"
b10111 ("
b10111 2"
b10000 7
b10000 d
b10000 !"
b10000 %"
b10000 5"
b11111111111111111100111101010101 ,
b11111111111111111100111101010101 b
b11111111111111111100111101010101 #"
b10001 -
b10001 c
b10001 ""
b10011010000001100000001101110 1
b10011010000001100000001101110 ."
1`
1!
#80
0!
#85
b1100 )
b1100 ##
b1101 {
b1101 ~
b1100 _"
b1100110110001100 ]
b1100110110001100 }
b10011010000001 '"
b10011010010001 6
b10011010010001 z
b10011010010001 &"
b10011010010001 1"
b0 m"
b1100110110001100100000110101101 1
b1100110110001100100000110101101 ."
b11 +
b11 $"
b11 ("
b11 2"
b1110 7
b1110 d
b1110 !"
b1110 %"
b1110 5"
b10011010000001 ,
b10011010000001 b
b10011010000001 #"
b10000 -
b10000 c
b10000 ""
b10000 0
b10000 )"
b10111 $
b10111 ,"
b10111 4"
b10111 ["
b11100111101010101 /
b11100111101010101 +"
b0 .
b0 *"
b0 3"
b1010 %
b1010 6"
b1010 ]"
b1010 !#
b1 &
b1 7"
b1 \"
b1 "#
b1101110100011011100001011001111 #
b1101110100011011100001011001111 -"
b1000 ^
b1 a
b1 Z"
1!
#90
0!
#95
b11011 )
b11011 ##
b1100110110001100 '"
b1100110110011100 6
b1100110110011100 z
b1100110110011100 &"
b1100110110011100 1"
b1111 {
b10110 ~
b11011 _"
b1101110100011011 ]
b1101110100011011 }
b11110010101110000000011100001100 #
b11110010101110000000011100001100 -"
b1001 ^
b10111 %
b10111 6"
b10111 ]"
b10111 !#
b0 &
b0 7"
b0 \"
b0 "#
b1110 0
b1110 )"
b11 $
b11 ,"
b11 4"
b11 ["
b10011010000001 /
b10011010000001 +"
b10011010010001 .
b10011010010001 *"
b10011010010001 3"
b1101 +
b1101 $"
b1101 ("
b1101 2"
b1101 7
b1101 d
b1101 !"
b1101 %"
b1101 5"
b1100110110001100 ,
b1100110110001100 b
b1100110110001100 #"
b1101110100011011100001011001111 1
b1101110100011011100001011001111 ."
b1 a"
b0 a
b0 Z"
1!
#100
0!
#105
b1 \
b1 |
b1 *
b1 $#
b1 /"
b10000 )
b10000 ##
b1 ^"
b1100 {
b11000 ~
b10000 _"
b11110010101110000 ]
b11110010101110000 }
b1101110100011011 '"
b0 6
b0 z
b0 &"
b0 1"
b0 o"
b11110010101110000000011100001100 1
b11110010101110000000011100001100 ."
b10110 +
b10110 $"
b10110 ("
b10110 2"
b1111 7
b1111 d
b1111 !"
b1111 %"
b1111 5"
b1101110100011011 ,
b1101110100011011 b
b1101110100011011 #"
b1101 0
b1101 )"
b1101 $
b1101 ,"
b1101 4"
b1101 ["
b1100110110001100 /
b1100110110001100 +"
b1100110110011100 .
b1100110110011100 *"
b1100110110011100 3"
b11 %
b11 6"
b11 ]"
b11 !#
b10011010010001 &
b10011010010001 7"
b10011010010001 \"
b10011010010001 "#
b11010011110101011101010000110010 #
b11010011110101011101010000110010 -"
b1010 ^
b10011010010001 a
b10011010010001 Z"
1!
#110
0!
#115
b0 \
b0 |
b0 *
b0 $#
b10101 /"
b1011 )
b1011 ##
b10101 ^"
b11110010101110000 '"
b10010 {
b1 ~
b1011 _"
b11111111111111111010011110101011 ]
b11111111111111111010011110101011 }
b10011100100101100011001001100111 #
b10011100100101100011001001100111 -"
b1011 ^
b1101 %
b1101 6"
b1101 ]"
b1101 !#
b1100110110011100 &
b1100110110011100 7"
b1100110110011100 \"
b1100110110011100 "#
b1111 0
b1111 )"
b10110 $
b10110 ,"
b10110 4"
b10110 ["
b1101110100011011 /
b1101110100011011 +"
b0 .
b0 *"
b0 3"
b11000 +
b11000 $"
b11000 ("
b11000 2"
b1100 7
b1100 d
b1100 !"
b1100 %"
b1100 5"
b11110010101110000 ,
b11110010101110000 b
b11110010101110000 #"
b1 -
b1 c
b1 ""
b11010011110101011101010000110010 1
b11010011110101011101010000110010 ."
b10011010010001 v"
b1100110110011100 a
b1100110110011100 Z"
1!
#120
0!
#125
b1100 \
b1100 |
b1100 *
b1100 $#
b1100 0"
b1100 /"
b1100 )
b1100 ##
b1100 ^"
b111 {
b10011 ~
b1100 _"
b1100 ]
b1100 }
b11010011110101011 '"
b1100110110011100 d"
b10011100100101100011001001100111 1
b10011100100101100011001001100111 ."
b1 +
b1 $"
b1 ("
b1 2"
b10010 7
b10010 d
b10010 !"
b10010 %"
b10010 5"
b11111111111111111010011110101011 ,
b11111111111111111010011110101011 b
b11111111111111111010011110101011 #"
b0 -
b0 c
b0 ""
b1100 0
b1100 )"
b11000 $
b11000 ,"
b11000 4"
b11000 ["
b11110010101110000 /
b11110010101110000 +"
b10110 %
b10110 6"
b10110 ]"
b10110 !#
b0 &
b0 7"
b0 \"
b0 "#
b11100010111101000100110101000001 #
b11100010111101000100110101000001 -"
b1100 ^
b0 a
b0 Z"
1!
#130
0!
#135
13
b0 \
b0 |
b1000 ]
b1000 }
b10011 *
b10011 $#
b1000 0"
b10011 /"
b1000 )
b1000 ##
b10011 ^"
b1100 '"
b1 {
b1010 ~
b1000 _"
b10010011000111111001010110101000 #
b10010011000111111001010110101000 -"
b1101 ^
b11000 %
b11000 6"
b11000 ]"
b11000 !#
b10010 0
b10010 )"
b1 $
b1 ,"
b1 4"
b1 ["
b11010011110101011 /
b11010011110101011 +"
b10011 +
b10011 $"
b10011 ("
b10011 2"
b111 7
b111 d
b111 !"
b111 %"
b111 5"
b1100 ,
b1100 b
b1100 #"
b1100 -
b1100 c
b1100 ""
b11100010111101000100110101000001 1
b11100010111101000100110101000001 ."
b0 n"
1!
#140
0!
#145
03
b11111 ]
b11111 }
b0 *
b0 $#
b11111 0"
b101 /"
b11111 )
b11111 ##
b101 ^"
b1000 {
b1101 ~
b11111 _"
b1000 '"
b11111111111111111111111111111000 6
b11111111111111111111111111111000 z
b11111111111111111111111111111000 &"
b11111111111111111111111111111000 1"
b0 p"
b10010011000111111001010110101000 1
b10010011000111111001010110101000 ."
b1010 +
b1010 $"
b1010 ("
b1010 2"
b1 7
b1 d
b1 !"
b1 %"
b1 5"
b1000 ,
b1000 b
b1000 #"
b0 -
b0 c
b0 ""
b111 0
b111 )"
b10011 $
b10011 ,"
b10011 4"
b10011 ["
b1100 /
b1100 +"
b1 %
b1 6"
b1 ]"
b1 !#
b1011010011010100001111000001010 #
b1011010011010100001111000001010 -"
b1110 ^
1!
#150
0!
#155
b111 \
b111 |
b10100 ]
b10100 }
b111 *
b111 $#
b10100 0"
b111 /"
b10100 )
b10100 ##
b111 ^"
b11111 '"
b1 6
b1 z
b1 &"
b1 1"
b1010 {
b10000 ~
b10100 _"
b100000001011011000100000100101 #
b100000001011011000100000100101 -"
b1111 ^
b10011 %
b10011 6"
b10011 ]"
b10011 !#
b1 0
b1 )"
b1010 $
b1010 ,"
b1010 4"
b1010 ["
b1000 /
b1000 +"
b11111111111111111111111111111000 .
b11111111111111111111111111111000 *"
b11111111111111111111111111111000 3"
b1101 +
b1101 $"
b1101 ("
b1101 2"
b1000 7
b1000 d
b1000 !"
b1000 %"
b1000 5"
b11111 ,
b11111 b
b11111 #"
b1011010011010100001111000001010 1
b1011010011010100001111000001010 ."
b0 `"
1!
#160
0!
#165
b10 \
b10 |
b11011 ]
b11011 }
b10 *
b10 $#
b11011 0"
b10 /"
b11011 )
b11011 ##
b10 ^"
b101 {
b1 ~
b11011 _"
b10100 '"
b0 j"
b100000001011011000100000100101 1
b100000001011011000100000100101 ."
b10000 +
b10000 $"
b10000 ("
b10000 2"
b1010 7
b1010 d
b1010 !"
b1010 %"
b1010 5"
b10100 ,
b10100 b
b10100 #"
b111 -
b111 c
b111 ""
b1000 0
b1000 )"
b1101 $
b1101 ,"
b1101 4"
b1101 ["
b11111 /
b11111 +"
b1 .
b1 *"
b1 3"
b1010 %
b1010 6"
b1010 ]"
b1010 !#
b11111111111111111111111111111000 &
b11111111111111111111111111111000 7"
b11111111111111111111111111111000 \"
b11111111111111111111111111111000 "#
b100110110000000011001010100100 #
b100110110000000011001010100100 -"
b10000 ^
b11111111111111111111111111111000 a
b11111111111111111111111111111000 Z"
1!
#170
0!
#175
b1100 \
b1100 |
b0 ]
b0 }
b1100 *
b1100 $#
b0 0"
b1100 /"
b0 )
b0 ##
b1100 ^"
b11011 '"
b0 6
b0 z
b0 &"
b0 1"
b100 {
b10101 ~
b0 _"
b11101010101110101000000101111011 #
b11101010101110101000000101111011 -"
b10001 ^
b1101 %
b1101 6"
b1101 ]"
b1101 !#
b1 &
b1 7"
b1 \"
b1 "#
b1010 0
b1010 )"
b10000 $
b10000 ,"
b10000 4"
b10000 ["
b10100 /
b10100 +"
b1 +
b1 $"
b1 ("
b1 2"
b101 7
b101 d
b101 !"
b101 %"
b101 5"
b11011 ,
b11011 b
b11011 #"
b10 -
b10 c
b10 ""
b100110110000000011001010100100 1
b100110110000000011001010100100 ."
b11111111111111111111111111111000 a"
b1 a
b1 Z"
1!
#180
0!
#185
b0 \
b0 |
b0 *
b0 $#
b0 /"
b0 ^"
b11011 {
b1011 ~
b10101 _"
b11101010101110101 ]
b11101010101110101 }
b0 '"
b1100 6
b1100 z
b1100 &"
b1100 1"
b1 d"
b11101010101110101000000101111011 1
b11101010101110101000000101111011 ."
b10101 +
b10101 $"
b10101 ("
b10101 2"
b100 7
b100 d
b100 !"
b100 %"
b100 5"
b0 ,
b0 b
b0 #"
b1100 -
b1100 c
b1100 ""
b101 0
b101 )"
b1 $
b1 ,"
b1 4"
b1 ["
b11011 /
b11011 +"
b0 .
b0 *"
b0 3"
b10000 %
b10000 6"
b10000 ]"
b10000 !#
b1110111010011011111001110000000 #
b1110111010011011111001110000000 -"
b10010 ^
1!
#190
0!
#195
b11100 \
b11100 |
b11100 *
b11100 $#
b11011 0"
b11100 /"
b11011 )
b11011 ##
b11100 ^"
1(
b11101010101110101 '"
b0 6
b0 z
b0 &"
b0 1"
b0 {
b11100 ~
b11011 _"
b11011 ]
b11011 }
b11110000111100100001011100101011 #
b11110000111100100001011100101011 -"
b10011 ^
b1 %
b1 6"
b1 ]"
b1 !#
b0 &
b0 7"
b0 \"
b0 "#
b100 0
b100 )"
b10101 $
b10101 ,"
b10101 4"
b10101 ["
b0 /
b0 +"
b1100 .
b1100 *"
b1100 3"
b1011 +
b1011 $"
b1011 ("
b1011 2"
b11011 7
b11011 d
b11011 !"
b11011 %"
b11011 5"
b11101010101110101 ,
b11101010101110101 b
b11101010101110101 #"
b0 -
b0 c
b0 ""
b1110111010011011111001110000000 1
b1110111010011011111001110000000 ."
b1 g"
b0 a
b0 Z"
1!
#200
0!
#205
b0 '"
b0 +
b0 $"
b0 ("
b0 2"
b0 7
b0 d
b0 !"
b0 %"
b0 5"
b0 ,
b0 b
b0 #"
b11011 0
b11011 )"
b1011 $
b1011 ,"
b1011 4"
b1011 ["
b11101010101110101 /
b11101010101110101 +"
b0 .
b0 *"
b0 3"
b10101 %
b10101 6"
b10101 ]"
b10101 !#
b1100 &
b1100 7"
b1100 \"
b1100 "#
1_
b1100 a
b1100 Z"
1!
#210
0!
#215
0(
b1011 %
b1011 6"
b1011 ]"
b1011 !#
b11101010101110101 &
b11101010101110101 7"
b11101010101110101 \"
b11101010101110101 "#
b0 0
b0 )"
b0 $
b0 ,"
b0 4"
b0 ["
b0 /
b0 +"
b1100 m"
0_
b11101010101110101 a
b11101010101110101 Z"
1!
#220
0!
#225
b0 *
b0 $#
b0 0"
b101 /"
b100 )
b100 ##
b101 ^"
b0 5
b0 X"
b1011 {
b11001 ~
b100 _"
b0 \
b0 |
b11111111111111111110000111100100 ]
b11111111111111111110000111100100 }
b11011 '"
b110111 6
b110111 z
b110111 &"
b110111 1"
03
b11101010101110101 b"
b11110000111100100001011100101011 1
b11110000111100100001011100101011 ."
b11100 +
b11100 $"
b11100 ("
b11100 2"
b11011 ,
b11011 b
b11011 #"
b11100 -
b11100 c
b11100 ""
b0 %
b0 6"
b0 ]"
b0 !#
b0 &
b0 7"
b0 \"
b0 "#
b0 #
b0 -"
b10100 ^
b0 a
b0 Z"
1!
#230
0!
#235
b0 /"
b0 )
b0 ##
b0 ^"
b11110000111100100 '"
b11111111111111111110000111100100 6
b11111111111111111110000111100100 z
b11111111111111111110000111100100 &"
b11111111111111111110000111100100 1"
b0 {
b0 ~
b0 _"
b0 ]
b0 }
b10101 ^
b11100 $
b11100 ,"
b11100 4"
b11100 ["
b11011 /
b11011 +"
b110111 .
b110111 *"
b110111 3"
b11001 +
b11001 $"
b11001 ("
b11001 2"
b1011 7
b1011 d
b1011 !"
b1011 %"
b1011 5"
b11111111111111111110000111100100 ,
b11111111111111111110000111100100 b
b11111111111111111110000111100100 #"
b0 -
b0 c
b0 ""
b0 1
b0 ."
1!
#240
0!
#245
b0 '"
b0 6
b0 z
b0 &"
b0 1"
b0 +
b0 $"
b0 ("
b0 2"
b0 7
b0 d
b0 !"
b0 %"
b0 5"
b0 ,
b0 b
b0 #"
b1011 0
b1011 )"
b11001 $
b11001 ,"
b11001 4"
b11001 ["
b11110000111100100 /
b11110000111100100 +"
b11111111111111111110000111100100 .
b11111111111111111110000111100100 *"
b11111111111111111110000111100100 3"
b11100 %
b11100 6"
b11100 ]"
b11100 !#
b110111 &
b110111 7"
b110111 \"
b110111 "#
b10110 ^
b110111 a
b110111 Z"
1!
#250
0!
#255
b10111 ^
b11001 %
b11001 6"
b11001 ]"
b11001 !#
b11111111111111111110000111100100 &
b11111111111111111110000111100100 7"
b11111111111111111110000111100100 \"
b11111111111111111110000111100100 "#
b0 0
b0 )"
b0 $
b0 ,"
b0 4"
b0 ["
b0 /
b0 +"
b0 .
b0 *"
b0 3"
b110111 t"
b11111111111111111110000111100100 a
b11111111111111111110000111100100 Z"
1!
#260
0!
#265
b11111111111111111110000111100100 q"
b0 %
b0 6"
b0 ]"
b0 !#
b0 &
b0 7"
b0 \"
b0 "#
b11000 ^
b0 a
b0 Z"
1!
#270
0!
#275
b11001 ^
1!
#280
0!
#285
b11010 ^
1!
#290
0!
#295
b11011 ^
1!
#300
0!
#305
b11100 ^
1!
#310
0!
