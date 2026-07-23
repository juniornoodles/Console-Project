# Console-project
All of the code that I produce to be used to create my own gaming console



CPU specs:


32 bit cpu

32 registers in register file

512KB of RAM

32KB of instruction storage

Encoding fomrat 

XXXXXXXXXXXXXXXXX XXXXX XXXXX XXXXX

Immediate value    Reg1  Reg2 opcode

cpu instructions
0-ADD

1-SUB

2-AND

3-OR

4-XOR

5-SHIFT LOGICAL

6-SHIFT ARITH

7-IS LESS THAN UNSIGNED

8-IS LESS THAN SIGNED

9-IS EQUAL

10-IS NOT EQUAL

11-ADDI

12-ANDI

13-ORI

14-XORI

15-SHIFT LOGICALI

16-SHIFT ARITHI

17-IS LESS THAN UNSIGNEDI

18-IS LESS THAN SIGNEDI

19-IS EQUALI

20-IS NOT EQUALI

21-LOAD WORD

22-STORE WORD

23-BRANCH IF TRUE

24-BRANCH IF FALSE

25-JUMP AND LINK

26-JUMP AND LINK REG

27 LOAD IMM

28-LOAD UPPER IMM

29-STORE WORD REGISTER

30-ENVIORNMENT CALL

31-ENVIORNMENT BREAK

CPU Notes: 

Store word register just allows you to use the contents of a register as an address. Load word can already do this which will be explained later. It is this way because I did not put this implementation early on and this was the easiest solution.

ECALL currently does not do anything. I do not currently plan on making an OS, but I kept it in just in case I change my mind later.

LI sign extends the msb of the 17 immediate value. Keep that in mind if you want to load numbers bigger than 2^17

With shifts, positive values shift to the right, and negative values shift to the left.

If using SW, always make reg1 zero.

False is 0, true is anything else.

With branch instructions, it will check reg1, we do not care what rd is.

With jump and link, we do not care what reg1 is.

Register 31 is used holds the input of the FPGA buttons, where no button pressed is 0, up is 1, down is 2, left is 3, right is 4, and center is 5


# How to use Assembler

The assembler I made is very rudimentry, I made it to make it easier to program the cpu, not for it to be used by others. However, I still think it is worth sharing.

Make sure the machine code that gets produces goes to the Machine_code.mem file i the cpu_hardware folder. The instruction memory reads that file to fill the ROM with instructions.

R types:  instr reg1, reg2, rd

I types:  instr reg1, imm, rd

Loads and Stores:  instr rd, imm

branches:  instr reg1(test reg), label

jal:  jal rd, label

jalr and lw:  instr reg1, imm, rd (reg1 is the reg with the address, imm is the offset ammount, rd is where the execution is stored)

swr:  swr reg1, rd  (reg1 is the reg with the address, rd is the data to be stored)

ebreak:  ebreak

To put labels, put a colon followed by the name of the label. You must put the label on the same line you want the instruction to jump to. For example:

add 4, 3, 1 :here //This is a comment, even without the slashes this would still be a comment

jal 2, here

Anything written after the instruction (or after the label) on the same line is considered a comment.

If you look at the assembler code, you will probably find work arounds to still assemble the machine code, which is fine if you'd like to do so. I just wanted to explain my intent with the assembler.

# Games

I have Snake, Tic-Tac-Toe, and Pong on the console. The machine code to run the games is in Machine_code.mem in the cpu_hardware directory.

The logic for the games themselves are in the software directory. I have each game seperate if anyone wants to see the logic, and I have the entire code for the console in Console_Games.txt.
