module MIPS_tb ();

    reg clk,rst_n;

    wire [31:0] Instruction;

    TopModule DUT (.clk(clk),.rst_n(rst_n),.Instruction(Instruction));

    initial begin
        clk =0;

        forever begin
            #1 clk = ~clk;
        end
    end


    initial begin

        $readmemh("mem.dat", DUT.FetchInstruction.InstructionMemory);
        rst_n = 0;
        @(negedge clk);
        rst_n = 1 ;
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);

        $stop;

        
    end
    
endmodule