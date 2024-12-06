
module Decode(Instruction,Write_Data,Branch,MemRead,MemtoReg,MemWrite,ALUop1,ALUop2,ALUfunction,ImmiedaiteValue);

    //----Ports----
    input [31:0] Instruction,Write_Data;
    output Branch,MemRead,MemtoReg,MemWrite;
    output [31:0] ALUop1;
    output reg [31:0] ALUop2;
    output [3:0] ALUfunction;
    output [31:0]ImmiedaiteValue;
    
    //----Internal wires----
    wire [31:0]ReadData2;
    wire [4:0] WriteRegister;
    wire [1:0] ALUop;
    wire RegDst;
    wire ALUSrc;
    wire RegWrite;
    
    // ----Internal modules---- 
    ControlUnit CU (.RegDst(RegDst),.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),
    .ALUOp(ALUop),.MemWrite(MemWrite),.ALUSrc(ALUSrc),.RegWrite(RegWrite),.opCode(Instruction[31:26]));
    
    RegisterFile RF (.Read_data1(ALUop1),.Read_data2(ReadData2),.Write_data(Write_Data),.Write_register(WriteRegister),
    .Read_register1(Instruction[25:21]),.Read_register2(Instruction[20:16]),.RegWrite(RegWrite));

    Sign_extend SE(.in(Instruction[15:0]),.out(ImmiedaiteValue));
 
    ALU_control ALU_CU (.ALUOp(ALUop),.instruction(Instruction[5:0]),.ALUfunction(ALUfunction));
    
   
   //----Internal wires assignment---- 
    always @(ALUSrc) begin
        if(ALUSrc) ALUop2 = ReadData2;
        else ALUop2 = ImmiedaiteValue;
    end
    assign WriteRegister = (RegDst == 0)? Instruction[20:16] : Instruction[15:11];
     

endmodule


module ControlUnit (RegDst,Branch,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite,opCode);

input [5:0] opCode;

output reg RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
output reg [1:0]ALUOp;

    always@ (opCode) begin
        
        case (opCode)
            'b000000: begin   // R-format instructions
                
                RegDst = 1;   // writeReg address will be rd (15:11)
                ALUSrc = 0;   // second alu operand to be the 2nd register file output
                MemtoReg = 0; // Value fed to WriteReg will come from the ALU
                RegWrite = 1; // laod the result to the RF at RF[WriteReg]
                MemRead = 0;
                MemWrite = 0; // no read or write ops are done on data memory
                Branch = 0;   // no branching operation (pc = pc+4)
                ALUOp = 'b10; // ALUcontrol will decode the functionality and guides the ALU to do the operation
            
            end 

            'b100011: begin   // lw opcode = 35

                RegDst = 0;   // writeReg address will be rt (20:16)
                ALUSrc = 1;   // second alu operand to be the lower 16 bits of the instruction after sign extention
                MemtoReg = 1; // Value fed to WriteReg will come from the data memory
                RegWrite = 1; // laod the result to the RF at RF[WriteReg]
                MemRead = 1;  // memory content will be fed to RF
                MemWrite = 0; // no write op is done on data memory
                Branch = 0;   // no branching operation (pc = pc+4)
                ALUOp = 'b00; // ALUcontrol will decode the functionality and guides the ALU to do the operation

            end

            'b101011: begin   // sw opcode = 43

                RegDst = 0;   // dont care
                ALUSrc = 1;   // second alu operand to be the lower 16 bits of the instruction after sign extention
                MemtoReg = 0; // don't care
                RegWrite = 0; // write on RF is disabled
                MemRead = 0;  // no read op is done on the data memory
                MemWrite = 1; // Value of WriteData will be stored in address input of data memory
                Branch = 0;   // no branching operation (pc = pc+4)
                ALUOp = 'b00; // ALUcontrol will decode the functionality and guides the ALU to do the operation

            end

            'b000100: begin   // beq opcode = 4

                RegDst = 0;   // dont care
                ALUSrc = 0;   // second alu operand to be the 2nd register file output
                MemtoReg = 0; // don't care
                RegWrite = 0; // write on RF is disabled
                MemRead = 0;  // no read op is done on the data memory
                MemWrite = 0; // no write op is done on the data memor
                Branch = 1;   // branch is on ,if zero flag is high pc = lower 16 bits of instruction
                ALUOp = 'b01; // ALUcontrol will decode the functionality and guides the ALU to do the operation

            end

            default: begin

                RegDst = 0;   
                ALUSrc = 0;   
                MemtoReg = 0; 
                RegWrite = 0; 
                MemRead = 0;  
                MemWrite = 0; 
                Branch = 0;   
                ALUOp = 'b00; 
                
            end
        endcase
    end
endmodule



module RegisterFile (Read_data1,Read_data2,Write_data,Write_register,Read_register1,Read_register2,RegWrite);

input [4:0]Read_register1,Read_register2,Write_register;
input [31:0] Write_data;
input RegWrite;

output reg [31:0] Read_data1,Read_data2;
//------------------------

reg [31:0]RF [0:31];

    always@(*) begin

        if(RegWrite) begin
            RF[Write_register] = Write_data;
        end 
        Read_data1 = RF[Read_register1];
        Read_data2 = RF[Read_register2];
       
    end    
endmodule


module Sign_extend(in,out);
    input [15:0] in;
    output [31:0] out;

    assign out = {{16{in[15]}}, in} ;

endmodule

module ALU_control (ALUOp,instruction,ALUfunction);

    input [1:0] ALUOp;
    input [5:0] instruction;
    output reg [3:0] ALUfunction;

    always @(*) begin
        
        case (ALUOp)

            'b00: ALUfunction = 0010; // sw,lw -> add
            'b01: ALUfunction = 0110; // beq -> sub
            'b10: begin
                case (instruction)
                    'b100000: ALUfunction = 0010; // add
                    'b100010: ALUfunction = 0110; // subtract
                    default: 
                    ALUfunction = 0000;  // add more instructions later
                endcase
            end  
            default: ALUfunction = 0000;  // add more instructions later
        endcase
    end   
endmodule

