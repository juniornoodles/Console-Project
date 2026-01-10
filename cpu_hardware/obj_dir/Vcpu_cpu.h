// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vcpu.h for the primary calling header

#ifndef VERILATED_VCPU_CPU_H_
#define VERILATED_VCPU_CPU_H_  // guard

#include "verilated.h"


class Vcpu__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vcpu_cpu final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(reset,0,0);
    VlUnpacked<IData/*31:0*/, 8192> pc_mem;

    // INTERNAL VARIABLES
    Vcpu__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vcpu_cpu(Vcpu__Syms* symsp, const char* v__name);
    ~Vcpu_cpu();
    VL_UNCOPYABLE(Vcpu_cpu);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
