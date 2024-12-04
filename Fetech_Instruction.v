module Fetch_Instruction(rst_n,clk,nextInstruction,instructionCode,currentInstructionAddress);

    input clk,rst_n;
    input [31:0] nextInstruction;
    output reg[31:0] currentInstruction,instructionCode;

    reg [7:0] InstructionMemory [0:4095];  // 4 Kbyte instruction memory (Byte addressing)
    wire [31:0] instructionAddress;
    PC pcCounter (.clk(clk),.rst_n(rst_n),.nextInstruction(nextInstruction),.currentInstruction(currentInstructionAddress));


    always @(currentInstructionAddress) begin
        instructionCode = {InstructionMemory[currentInstructionAddress],InstructionMemory[currentInstructionAddress+1],
        InstructionMemory[currentInstructionAddress+2],InstructionMemory[currentInstructionAddress+3]};
    end


endmodule

module PC(clk,rst_n,nextInstruction,currentInstruction);

    input clk,rst_n;
    input [31:0]nextInstruction;
    output reg [31:0]currentInstruction;  

    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin 
            currentInstruction <= 0;
        end 
        else begin
            currentInstruction <= nextInstruction;
        end
        
    end

endmodule
