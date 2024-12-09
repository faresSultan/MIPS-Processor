module BranchModule(Branch,ImmediateValue,Zero,currentInstructionAddress,nextInstructionAddress);

    input Branch,Zero;
    input [31:0] currentInstructionAddress,ImmediateValue;
    output [31:0] nextInstructionAddress;

    wire [31:0]op2;
    wire [31:0]addResult;
    wire BranchEn;


   
    assign op2 = ImmediateValue<<2;
    assign addResult = currentInstructionAddress + op2;
    assign BranchEn = Branch && Zero;
    assign nextInstructionAddress = (BranchEn)? addResult : currentInstructionAddress;

endmodule