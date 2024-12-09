module ALU_control (ALUOp,instruction,ALUfunction);

    input [1:0] ALUOp;
    input [5:0] instruction;
    output reg [3:0] ALUfunction;

    always @(*) begin
        
        case (ALUOp)

            'b00: ALUfunction = 'b0010; // sw,lw -> add
            'b01: ALUfunction = 'b0110; // beq -> sub
            'b10: begin
                case (instruction)
                    'b100000: ALUfunction = 'b0010; // add
                    'b100010: ALUfunction = 'b0110; // subtract
                    default: 
                    ALUfunction = 'b0000;  // add more instructions later
                endcase
            end  
            default: ALUfunction = 'b0000;  // add more instructions later
        endcase
    end   
endmodule