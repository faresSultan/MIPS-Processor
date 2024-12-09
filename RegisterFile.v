module RegisterFile(clk,Read_register1,Read_register2,Write_register,Write_data,RegWrite,Read_data1,Read_data2);
    input clk,RegWrite;
    input [4:0]Read_register1,Read_register2,Write_register;
    input [31:0] Write_data;
    output [31:0] Read_data1,Read_data2;

    reg [31:0] RF [0:31];

    always @(posedge clk) begin
        if (RegWrite) begin
            RF [Write_register] = Write_data;
        end
    end

    assign Read_data1 = RF [Read_register1];
    assign Read_data2 = RF [Read_register2];


endmodule