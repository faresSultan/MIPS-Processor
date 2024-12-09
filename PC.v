module PC(rst_n,clk,nextInstructionAddress,currentInstructionAddress);

    input rst_n,clk;
    input [31:0] nextInstructionAddress;
    output reg [31:0] currentInstructionAddress;

    always @(posedge clk or negedge rst_n ) begin
        if(!rst_n) 
            currentInstructionAddress <= 0;
        else 
            currentInstructionAddress <= nextInstructionAddress;
    end
endmodule


module ADD4(currentInstructionAddress,nextInstructionAddress);
    input [31:0] currentInstructionAddress;
    output [31:0] nextInstructionAddress;

    assign nextInstructionAddress = currentInstructionAddress+4;
endmodule