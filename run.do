vlib work
vlog TopModule.v Fetech_Instruction.v Decode_Instruction.v
vlog Execute_Instruction.v MIPS_tb.v
vsim -voptargs=+acc work.MIPS_tb
add wave *
run -all
#quit -sim