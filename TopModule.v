module TopModule (clk,rst_n,ALU_MemResult);

input clk, rst_n;
output [31:0] ALU_MemResult;


//-------Internal wires-------
wire [31:0] Instruction;
wire [31:0] nextInstruction;


Fetch_Instruction FetchInstruction (.clk (clk),.rst_n(rst_n),.nextInstruction(nextInstruction),.instructionCode(Instruction));

Decode DecodeInstruction (.Instruction(Instruction),Write_Data,Branch,MemRead,MemtoReg,MemWrite,ALUop1,ALUop2,ALUfunction);

Execute ExecuteInstruction (CurrentPcValue,ImmiedaiteValue,Branch,MemRead,MemtoReg,MemWrite,ALUop1,ALUop2,ALUfunction,WriteData,
NextPcValue,RfWriteData);


    
endmodule
