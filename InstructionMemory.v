module InstructionMemory(ReadAddress,Instruction);

    input [31:0] ReadAddress;
    output [31:0] Instruction;

    reg [7:0] InstructionMem [0:4095];

    assign Instruction = {InstructionMem[ReadAddress],InstructionMem[ReadAddress+1],
    InstructionMem[ReadAddress+2],InstructionMem[ReadAddress+3]};

endmodule