/* Test program
        //$t0-$t7 8-15
        00000 nop ->0x0000_0000
        00004 add $t1, $t1, $t2 -> 000000 01001 01010 01001 00000 100000->0x012A_4820
        00008 lw  $t0, 4 ($t1)  -> 100011 01001 01000 0000 0000 0000 0100 ->0x8D28_0004 // laod at t0
        00012 beq $t0, $t1, L1  -> 000100 01000 01001 0000 0000 0000 0010->0x1109_0002
        00016 nop ->0x0000_0000
        00020 nop ->0x0000_0000
        00024 sub $t1, $t1, $t2 -> 000000 01001 01010 01001 00000 100010->0x012A_4822
        00028 sw  $t0, 4 ($t1)  -> 101011 01001 01000 0000 0000 0000 0100 ->0xAD28_0004
    */

module MIPS_tb ();

    reg clk,rst_n;

    wire [31:0] Result;

    TopModule (.clk(clk),.rst_n(rst_n),.ALU_MemResult(Result));

    initial begin

        $readmemh("mem.dat", DUT.FetchInstruction.InstructionMemory);
        $readmemh("RF.dat", DUT.DecodeInstruction.RF);
        $readmemh("datamem.dat", DUT.ExecuteInstruction.dataMem);
        rst_n = 0;
        @(negedge clk);
        rst_n = 1 ;
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);

        $stop;     
    end

     initial begin
        clk =0;

        forever begin
            #1 clk = ~clk;
        end
    end

    
endmodule