#include "Vcpu.h"
#include "verilated.h"
#include <cstdio>
#include <cstdint>

#define ADD   0
#define ADDI 11
#define XOR  4

#define NOP   0  // ADD x0,x0,x0

uint32_t R(uint32_t rs2, uint32_t rs1, uint32_t rd, uint32_t op) {
    return (rs2 << 20) | (rs1 << 15) | (rd << 5) | op;
}

uint32_t I(uint32_t imm, uint32_t rs1, uint32_t rd, uint32_t op) {
    return (imm << 15) | (rs1 << 15) | (rd << 5) | op;
}

void tick(Vcpu* cpu) {
    cpu->clk = 0; cpu->eval();
    cpu->clk = 1; cpu->eval();
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    Vcpu* cpu = new Vcpu;

    // Reset
    cpu->reset = 1;
    tick(cpu);
    cpu->reset = 0;

    // -----------------------------
    // Load program into instruction memory
    // -----------------------------

    int pc = 0;

    // x1 = 10
    cpu->pc_mem[pc++] = I(10, 0, 1, ADDI);
    for (int i = 0; i < 4; i++) cpu->pc_mem[pc++] = NOP;

    // x2 = 20
    cpu->pc_mem[pc++] = I(20, 0, 2, ADDI);
    for (int i = 0; i < 4; i++) cpu->pc_mem[pc++] = NOP;

    // x3 = x1 + x2 = 30
    cpu->pc_mem[pc++] = R(2, 1, 3, ADD);
    for (int i = 0; i < 4; i++) cpu->pc_mem[pc++] = NOP;

    // x4 = x3 XOR x1 = 30 ^ 10 = 20
    cpu->pc_mem[pc++] = R(1, 3, 4, XOR);
    for (int i = 0; i < 4; i++) cpu->pc_mem[pc++] = NOP;

    // -----------------------------
    // Run CPU
    // -----------------------------
    for (int cycle = 0; cycle < 40; cycle++) {
        tick(cpu);

        printf("Cycle %2d | x1=%d x2=%d x3=%d x4=%d\n",
            cycle,
            cpu->reg_file_inst.regs[1],
            cpu->reg_file_inst.regs[2],
            cpu->reg_file_inst.regs[3],
            cpu->reg_file_inst.regs[4]
        );
    }

    delete cpu;
    return 0;
}
