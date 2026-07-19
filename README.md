# ORION: RISC-V RV32I Processor + AI Accelerator System-on-Chip (SoC)

A complete SystemVerilog implementation of a 32-bit RISC-V (RV32I) single-cycle CPU core integrated with a dedicated AI / Neural Network hardware accelerator co-processor.

---

## 🌟 Key Features

- **32-Bit RISC-V RV32I CPU Core**:
  - Full support for RV32I base instructions: Arithmetic, Logical, Immediate, Load/Store, Branching (`BEQ`, `BNE`, `BLT`, `BGE`, `BLTU`, `BGEU`), and Unconditional Jumps (`JAL`, `JALR`, `LUI`, `AUIPC`).
  - Hardwired $x0$ zero-register implementation adhering to standard RISC-V ISA spec.
  - Full Immediate Generator supporting I, S, B, U, and J immediate formats.

- **Custom Datapath Extensions**:
  - Hardware **MAC (Multiply-Accumulate)** pipeline stage.
  - **4-Lane 8-Bit SIMD Vector Addition** instruction execution.

- **Neural Network Hardware Accelerator Co-Processor**:
  - **Inference Controller FSM**: 3-state state machine managing `IDLE`, `COMPUTE`, and `DONE` states.
  - **Artificial Neuron Engine**: Dual-input signed 8-bit neuron with bias and integrated ReLU activation function.
  - **Neural Network Layer**: Multi-neuron hardware layer.
  - **1x2 Systolic Array**: Systolic processing element array for matrix/vector operations.
  - **Quantization & Post-Processing**: Saturation quantizer and customizable activation units.

- **Integrated System-on-Chip (SoC)**:
  - Memory-mapped coprocessor interface allowing the CPU core to control feature input loading, trigger inference, and retrieve classification results.

- **100% Verification Coverage**:
  - Comprehensive SystemVerilog testbenches for all 26 modules with zero compilation warnings or errors.

---

## 📁 Repository Structure

```
risc-v/
├── README.md                           # Project documentation
├── .gitignore                          # Git ignore configuration
│
├── orion_soc.sv                        # Top-level SoC integrating CPU + AI Co-Processor
├── tb_orion_soc.sv                     # Top-level SoC testbench
│
├── orion_rv32.sv                       # 32-Bit RISC-V CPU Core
├── tb_orion_rv32.sv                    # CPU Core testbench
│
├── orion_pc.sv                         # Program Counter Register
├── orion_imem.sv                       # Instruction Memory with test program
├── orion_dmem.sv                       # Data Memory
├── orion_regfile.sv                    # 32x32-bit Register File (x0 hardwired 0)
├── orion_control.sv                    # Main Control Unit Decoder
├── orion_alu_controller.sv             # ALU Control Unit
├── orion_alu.sv                        # 32-Bit ALU (Arithmetic, Logic, Shifts, MAC, SIMD)
├── orion_immgen.sv                     # Immediate Generator (I, S, B, U, J)
├── orion_branch.sv                     # Branch Decision Unit
│
├── orion_inference_controller.sv       # AI Coprocessor FSM Controller
├── orion_neuron.sv                     # Artificial Neuron Unit (with ReLU)
├── orion_nn_layer.sv                   # 2-Neuron Layer Block
├── orion_systolic2.sv                  # 1x2 Systolic Array Processing Unit
├── orion_pe.sv                         # Systolic Processing Element
├── orion_mac.sv                        # Hardware MAC Unit
├── orion_matrix2x2.sv                  # 2x2 Matrix Multiplier Unit
├── orion_activation.sv                 # Multi-mode Activation Unit
├── orion_quantizer.sv                  # Quantization Unit
├── orion_saturation_quantizer.sv       # Saturation Quantizer
├── orion_weight_mem.sv                 # Neural Network Weight Memory
├── orion_relu.sv                       # Standalone ReLU Unit
├── orion_register.sv                   # Parameterized Register Unit
├── mux2to1.sv                          # 2-to-1 Multiplexer
├── priority_encoder_8to3.sv            # 8-to-3 Priority Encoder
├── priority_encoder_param.sv           # Parameterized Priority Encoder
│
└── tb_*.sv                             # Testbenches for all corresponding modules
```

---

## 🚀 Running Simulations

### Prerequisites
- [Icarus Verilog (`iverilog`)](http://iverilog.icarus.com/) v10.0+
- `vvp` simulation runner

### Simulate Full SoC
To compile and simulate the complete RISC-V + AI Accelerator System-on-Chip:

```bash
iverilog -g2012 -o test_soc tb_orion_soc.sv orion_soc.sv orion_rv32.sv orion_pc.sv orion_imem.sv orion_control.sv orion_regfile.sv orion_immgen.sv orion_alu_controller.sv orion_alu.sv orion_dmem.sv orion_branch.sv orion_inference_controller.sv orion_nn_layer.sv orion_neuron.sv
vvp test_soc
```

### Simulate RISC-V CPU Core
To verify CPU execution:

```bash
iverilog -g2012 -o test_cpu tb_orion_rv32.sv orion_rv32.sv orion_pc.sv orion_imem.sv orion_control.sv orion_regfile.sv orion_immgen.sv orion_alu_controller.sv orion_alu.sv orion_dmem.sv orion_branch.sv
vvp test_cpu
```

---

## 🔬 Simulation Results

```
=== STARTING INTEGRATED RISC-V + AI ACCELERATOR SoC SIMULATION ===
Time | PC       | CPU Reg x3 | NN Input (x1,x2) | NN Done | NN Output (y0, y1)
-----------------------------------------------------------------------------
  16 | 0x00000004 |          0 | ( 0,  0)       |    0    | (     0,      1)
  26 | 0x00000008 |          0 | ( 0,  0)       |    0    | (     0,      1)
  36 | 0x0000000c |         15 | ( 0,  0)       |    0    | (     0,      1)
...
>>> SUCCESS: ORION RISC-V + AI ACCELERATOR SOC COMPLETED RUN! <<<
```

---

## 📜 License
Open-source under MIT License.
>>>>>>> 599350e (Initial commit: Complete RISC-V RV32I Processor + AI Accelerator SoC with full test suite)
