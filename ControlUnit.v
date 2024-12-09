module ControlUnit(
    Opcode,RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp
);

input [5:0] Opcode;
output reg RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch;
output reg [1:0] ALUOp;

    always @(*) begin
        case (Opcode)
            'b000000: begin
                RegDst = 1;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 'b10;
            end 

            'b100011: begin  //lw
                RegDst = 0;
                ALUSrc = 1;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead = 1;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 'b00;
            end 

            'b000100: begin   // beq
                RegDst = 'bx;
                ALUSrc = 0;
                MemtoReg = 'bx;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                ALUOp = 'b01;
            end 

            'b101011: begin    //sw
                RegDst = 'bx;
                ALUSrc = 1;
                MemtoReg = 'bx;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;
                Branch = 0;
                ALUOp = 'b00;
            end 

            default:  begin    
                RegDst = 'bx;
                ALUSrc = 'bx;
                MemtoReg = 'bx;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 'bx;
            end 
        endcase
    end

endmodule