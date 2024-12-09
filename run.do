vsim -voptargs=+acc work.tb
add wave -position insertpoint sim:/tb/DUT/*
add wave -position insertpoint  \
sim:/tb/DUT/RF/RegWrite \
sim:/tb/DUT/RF/Read_register1 \
sim:/tb/DUT/RF/Read_register2 \
sim:/tb/DUT/RF/Write_register \
sim:/tb/DUT/RF/Write_data \
sim:/tb/DUT/RF/Read_data1 \
sim:/tb/DUT/RF/Read_data2 \
sim:/tb/DUT/RF/RF
add wave -position insertpoint  \
sim:/tb/DUT/DataMem/MemRead \
sim:/tb/DUT/DataMem/MemWrite \
sim:/tb/DUT/DataMem/Address \
sim:/tb/DUT/DataMem/Write_data \
sim:/tb/DUT/DataMem/Read_data \
sim:/tb/DUT/DataMem/DataMem
run