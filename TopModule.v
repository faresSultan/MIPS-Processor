module TopModule (clk,rst_n,ALU_MemResult);

input clk, rst_n;
output [31:0] ALU_MemResult;


//-------Internal wires-------
wire [31:0]Instruction;
wire [31:0]nextInstruction;
wire [31:0]currentInstructionAddress;
wire [31:0]Write_Data,ALUop1,ALUop2,ImmiedaiteValue;
wire [3:0]ALUfunction;
wire MemRead,MemtoReg,MemWrite,Branch;



Fetch_Instruction FetchInstruction (
.clk (clk),.rst_n(rst_n),.nextInstruction(nextInstruction),
.instructionCode(Instruction),.currentInstructionAddress(currentInstructionAddress));

Decode DecodeInstruction (
.Instruction(Instruction),.Write_Data(Write_Data),.Branch(Branch),.MemRead(MemRead),
.MemtoReg(MemtoReg),.MemWrite(MemWrite),.ALUop1(ALUop1),.ALUop2(ALUop2),.ALUfunction(ALUfunction),
.ImmiedaiteValue(ImmiedaiteValue));

Execute ExecuteInstruction (
.CurrentPcValue(currentInstructionAddress+4),.ImmiedaiteValue(ImmiedaiteValue),
.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.MemWrite(MemWrite),.ALUop1(ALUop1),.ALUop2(ALUop2),
.ALUfunction(ALUfunction),.WriteData(Write_Data),.NextPcValue(nextInstruction),.RfWriteData(ALU_MemResult));


    
endmodule
