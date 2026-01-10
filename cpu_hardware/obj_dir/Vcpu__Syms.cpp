// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vcpu__pch.h"
#include "Vcpu.h"
#include "Vcpu___024root.h"
#include "Vcpu_cpu.h"

// FUNCTIONS
Vcpu__Syms::~Vcpu__Syms()
{
}

Vcpu__Syms::Vcpu__Syms(VerilatedContext* contextp, const char* namep, Vcpu* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup module instances
    , TOP{this, namep}
    , TOP__cpu{this, Verilated::catName(namep, "cpu")}
{
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-12);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    TOP.cpu = &TOP__cpu;
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
    TOP__cpu.__Vconfigure(true);
    // Setup scopes
    __Vscope_cpu.configure(this, name(), "cpu", "cpu", 0, VerilatedScope::SCOPE_OTHER);
    // Setup export functions
    for (int __Vfinal = 0; __Vfinal < 2; ++__Vfinal) {
        __Vscope_cpu.varInsert(__Vfinal,"pc_mem", &(TOP__cpu.pc_mem), false, VLVT_UINT32,VLVD_NODIR|VLVF_PUB_RW,2 ,31,0 ,8191,0);
    }
}
