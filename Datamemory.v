module DataMemory(clk,MemRead,MemWrite,Address,Write_data,Read_data);

    input MemRead,MemWrite,clk;
    input [31:0] Address,Write_data;
    output reg [31:0] Read_data;

    reg [7:0] DataMem [0:10239];
    
    always @(posedge clk) begin
        if (MemWrite) begin
            {DataMem[Address],DataMem[Address+1],DataMem[Address+2],DataMem[Address+3]} = Write_data; 
        end    
    end   

    always @(*) begin
        if (MemRead) begin
            Read_data = {DataMem[Address],DataMem[Address+1],DataMem[Address+2],DataMem[Address+3]};
        end
    end
   

endmodule