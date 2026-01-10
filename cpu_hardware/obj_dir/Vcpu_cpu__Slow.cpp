// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vcpu.h for the primary calling header

#include "Vcpu__pch.h"
#include "Vcpu__Syms.h"
#include "Vcpu_cpu.h"

void Vcpu_cpu___ctor_var_reset(Vcpu_cpu* vlSelf);

Vcpu_cpu::Vcpu_cpu(Vcpu__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vcpu_cpu___ctor_var_reset(this);
}

void Vcpu_cpu::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vcpu_cpu::~Vcpu_cpu() {
}
