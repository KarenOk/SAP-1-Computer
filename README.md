# Designing and Implementing a SAP-1 Computer

Simple as Possible (SAP) computers in general were designed to introduce beginners to some of the crucial ideas behind computer operations. SAP computers are broken down stages, each stage a more evolved and considering more advanced concepts in computer architecture than the previous.

The SAP-1 computer is the first stage in this evolution and contains the basic necessities for a functional computer. Its primary purpose is to develop a basic understanding of how a computer works, interacts with memory and other parts of the system like input and output. The instruction set is very limited and is simple.

In this project, I together with a group of people implement a SAP-1 computer using an FPGA (Field Programmable Gate Array) - an integrated circuit designed to be configured by a customer or a designer after manufacturing - and the FPGA programmed using VHDL (VHSIC-HDL, Very High Speed Integrated Circuit Hardware Description Language). [The collated report about this project can be found in this document](https://drive.google.com/file/d/17fH-JBU5OX_4AG123AO47y879YxzmDwX/view?usp=sharing).

## Table of Content

- SAP-1 Computer Architecture
- Design Process
- Implementation Process
- Result
- Learn more about SAP computers

## SAP-1 Computer Architecture

The SAP-1 computer is a bus-organized computer and makes use of Von-Neumann architecture. It makes use of an 8-bit central bus and has ten main components. A pictorial representation of its architecture is shown below. Each of the individual components that make up this computer are described right after.

![SAP-1 Computer Architecture](./images/sap-1-architecture.png)

### SAP-1 Components

1. **Program Counter**: The program counter’s job is to store and send out the memory address of the next instruction to be fetched and executed. The program counter, which is part of the control unit, counts from 0000 to 1111 as the program is stored at the beginning of the memory with the first instruction at binary address 0000, the second instruction at address 0001, the third at address 0010, and so on. At the start of each computer run, the program counter is reset to 0000. When the computer run starts, the program counter sends out the address 0000 to the memory and is then incremented by 1. After the first instruction is fetched and executed, the program counter sends the next address 0001 to the memory and again, after that, the program counter is incremented. In this way, the program counter keeps track of the next instruction to be fetched and executed.
2. **Input and Memory Address Register (MAR)**: The MAR stores the 4-bit address of data or instruction which are placed in memory. When the SAP-1 is running, the 4-bit address is gotten from the Program Counter through the W-bus and then stored. This stored address is sent to the RAM where data or instructions are read from.
3. **Random-Access Memory (RAM)**: The SAP-1 makes use of a 16 x 8 RAM (16 memory locations each storing 8 bits of data). The RAM can be programmed by means of the address and data switches allowing you to write to the memory before a computer run. During a computer run, the RAM receives its 4-bit address from the MAR and read operation is performed. In this way the instruction or data word stored in the RAM is placed on the W bus for use in some other part of the computer.
4. **Instruction Register**: The instruction receives and stores the instruction placed on the bus from the RAM. The content of the instruction register are then split into two nibbles. The upper nibble is a two-state output that goes into the Controller-sequencer while the lower nibble is a three-state output that is read from the bus when needed.
5. **Controller-Sequencer**: The controller-sequencer sends out signals that control the computer and makes sure things happen only when they are supposed to. The 12 bit output signals from controller-sequencer is called the control word which determines how the registers will react to the next positive clock edge. It has the following format:
   ` CON = Cp Ep ~Lm ~CE ~Li ~Ei ~La Eu Su Eu ~Lb ~Lo`
6. **Accumulator**: The accumulator is an 8-bit buffer register that stores intermediate answers during a computer run. The accumulator has two outputs. The two-state output goes directly to the adder-subtractor and the three-state output goes to the bus. This implies that the 8-bit accumulator word continuously drives the adder- subtractor but only appears on the W bus when Ea is high.
7. **Adder-Subtractor**: The adder-subtractor asynchronously adds to or subtracts a value from the the accumulator depending on the value of Su. It makes use of 2’s complement to achieve this When Su is low the output of the adder-subtractor is the sum of the values in the accumulator and in the B-register (O/P = A + B). When Su is high, the output is the difference between them (O/P = A + B’).
8. **B-Register**: The B-register is a buffer register used in performing arithmetic operations. It supplies the number to be added or subtracted from the contents of the accumulator to the adder/subtractor. When data is available at the bus and Lb is low, at the positive clock edge, B register gets and stores the data.
9. **Output Register**: The output register gets and stores the value stored in the accumulator usually after the performance of an arithmetic operation. The answer that is stored in the accumulator is loaded into the output register through the W bus. This is done in the next positive clock edge when Ea is high and Lo is low. The processed data can now be displayed to the outside world.
10. **Binary Display**: The binary display is row of eight light emitting diodes(LEDs). The binary display shows us the contents of the output by connecting each LED to the output of the output register. This therefore enables viewing of the answer transferred from the accumulator to the output register in binary.

### SAP-1 Instruction Set

The instruction set of a computer are the basic operations it can perform. The instruction set of the SAP-1 is described in table below.

| Operation | Description                                             |
| --------- | ------------------------------------------------------- |
| Load      | Load data from memory to the accumulator                |
| Add       | Add data from memory to value in the accumulator        |
| Subtract  | Subtract data from memory from value in the accumulator |
| Output    | Load data from accumulator to the output register       |
| Halt      | Stop processing                                         |

For more details about programming the SAP-1 and the fetch and execution cycle of the SAP-1, check out [reference #1 in the Learn More section](#learn-more-about-sap-computers)
