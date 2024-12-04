module Execute (CurrentPcValue,ImmiedaiteValue,Branch,MemRead,MemtoReg,MemWrite,ALUop1,ALUop2,ALUfunction,WriteData,
NextPcValue,RfWriteData);

// -------Inputs--------
    input [31:0] CurrentPcValue,ImmiedaiteValue,ALUop1,ALUop2,WriteData;
    input [3:0] ALUfunction;
    input Branch,MemRead,MemtoReg,MemWrite;

// -------Outputs--------
    output [31:0] NextPcValue,RfWriteData;

// -------Internal wires--------
    wire [31:0] ALUresult,MemAddress,MemReadData,branchAddr;
    wire Zero;


// -------Internal modules--------
    ALU alu (.ALUresult(ALUresult),.Zero(Zero),.Operand1(ALUop1),.Operand2(ALUop2),.operation(ALUfunction));
    DataMem dataMem (.Address(MemAddress),.WriteData(WriteData),.MemWrite(MemWrite),.MemRead(MemRead),.ReadData(MemReadData));
    BranchAddress Br (.ImmiedaiteValue(ImmiedaiteValue),.CurrentPcValue(CurrentPcValue),.branchAddr(branchAddr));


// -------Outputs assignments-------
    assign NextPcValue = ((Branch&&Zero) == 0)? CurrentPcValue : branchAddr;
    assign RfWriteData = (MemtoReg == 1)? MemReadData : ALUresult; 
    
endmodule


module ALU (ALUresult,Zero, Operand1,Operand2, operation);

// -------Inputs--------
    input [31:0] Operand1,Operand2;
    input [3:0] operation;

// -------outputs--------
    output reg [31:0] ALUresult;
    output Zero;

    always @(*) begin
        case (operation)

            0010: ALUresult = Operand1 + Operand2;
            0110: ALUresult = Operand1 - Operand2;

            default: ALUresult = 1;  // support more operations in the future 
        endcase
    end

    assign Zero = (ALUresult == 0)? 1:0;

endmodule


module DataMem(Address,WriteData,MemWrite,MemRead,ReadData);

// -------Inputs--------
    input [31:0] Address,WriteData;
    input MemWrite,MemRead;

// -------outputs-------- 
    output reg [31:0] ReadData;

    reg [7:0] DataMemory [0:10239];  // 10-KB byte addressing memory 

    always @(*) begin
        
        if(MemWrite) begin
            {DataMemory[Address],DataMemory[Address+1],DataMemory[Address+2],DataMemory[Address+3]} = WriteData;
        end
        else if (MemRead) begin
            ReadData = {DataMemory[Address],DataMemory[Address+1],DataMemory[Address+2],DataMemory[Address+3]};
        end
    end

endmodule


module BranchAddress(ImmiedaiteValue,CurrentPcValue,branchAddr);

    input [31:0] ImmiedaiteValue,CurrentPcValue;
    output [31:0] branchAddr;
    wire [31:0] Operand2;
    ALU adder (.ALUresult(branchAddr),.Operand1(CurrentPcValue),.Operand2(Operand2),.operation(4'b0010));

    assign Operand2 = ImmiedaiteValue<<2;
endmodule