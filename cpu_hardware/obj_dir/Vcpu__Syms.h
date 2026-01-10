// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VCPU__SYMS_H_
#define VERILATED_VCPU__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vcpu.h"

// INCLUDE MODULE CLASSES
#include "Vcpu___024root.h"
#include "Vcpu_cpu.h"

// DPI TYPES for DPI Export callbacks (Internal use)

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Vcpu__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vcpu* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vcpu___024root                 TOP;
    Vcpu_cpu                       TOP__cpu;

    // SCOPE NAMES
    VerilatedScope __Vscope_cpu;

    // CONSTRUCTORS
    Vcpu__Syms(VerilatedContext* contextp, const char* namep, Vcpu* modelp);
    ~Vcpu__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
