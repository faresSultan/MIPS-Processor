/* Test program
        //$t0-$t7 8-15
        00000 add $t1, $t1, $t2 -> 000000 01001 01010 01001 00000 100000->0x012A_4820
        00004 lw  $t0, 4 ($t1)  -> 100011 01001 01000 0000 0000 0000 0100 ->0x8D28_0004 // laod at t0
        00008 beq $t0, $t1, L1  -> 000100 01000 01001 0000 0000 0000 0010->0x1109_0002
        00012 nop ->0x0000_0000
        00016 nop ->0x0000_0000
        00020 sub $t1, $t1, $t2 -> 000000 01001 01010 01001 00000 100010->0x012A_4822
        00024 sw  $t1, 0 ($t0)  -> 101011 01000 01001 0000 0000 0000 0000 ->0xAD090000
*/
module tb();
    reg clk,rst_n;
    wire [31:0]Instruction;
    
    TopModule DUT(rst_n,clk,Instruction);

    initial begin
        clk =0;

        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin

        $readmemh("insMem.dat",DUT.instructionMem.InstructionMem);
        $readmemh("RF.dat",DUT.RF.RF);
        $readmemh("dataMem.dat",DUT.DataMem.DataMem);

        rst_n = 0;
        @(negedge clk);
        rst_n = 1;
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        $stop;
    end

endmodule