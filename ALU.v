module ALU (ALUoprand1,ALUoprand2,ALUOP,Zero,ALUresult);

input [31:0] ALUoprand1,ALUoprand2;
input [3:0] ALUOP;
output reg [31:0] ALUresult;
output Zero;

always @(*) begin
    case (ALUOP)
        'b0010: ALUresult = ALUoprand1 + ALUoprand2; 
        'b0110: ALUresult = ALUoprand1 - ALUoprand2; 
        
        default: ALUresult = 'b0; 
    endcase
end

assign Zero = (ALUresult === 0);
    
endmodule