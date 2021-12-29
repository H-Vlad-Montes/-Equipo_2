onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /tb_mips/GPIO_o_tb
add wave -noupdate /tb_mips/DUT/FSM/RegWrite
add wave -noupdate -expand -group PC -radix hexadecimal /tb_mips/DUT/PC/q
add wave -noupdate -expand -group reg_instr -radix hexadecimal /tb_mips/DUT/RD/q
add wave -noupdate -expand -group CU -expand -group CU /tb_mips/DUT/FSM/MemWrite
add wave -noupdate -expand -group CU -expand -group CU /tb_mips/DUT/FSM/IRWrite
add wave -noupdate -expand -group CU -expand -group CU /tb_mips/DUT/FSM/Mem_to_Reg
add wave -noupdate -expand -group CU -expand -group CU /tb_mips/DUT/FSM/RegWrite
add wave -noupdate -expand -group CU -expand -group CU /tb_mips/DUT/FSM/ALUSrcA
add wave -noupdate -expand -group CU -expand -group CU /tb_mips/DUT/FSM/PCSrc
add wave -noupdate -expand -group CU -expand -group CU /tb_mips/DUT/FSM/jump_select
add wave -noupdate -expand -group CU -expand -group CU /tb_mips/DUT/FSM/PCWrite
add wave -noupdate -expand -group CU -expand -group CU /tb_mips/DUT/FSM/branch
add wave -noupdate -expand -group CU -radix hexadecimal /tb_mips/DUT/FSM/Op
add wave -noupdate -expand -group CU -radix hexadecimal /tb_mips/DUT/FSM/funct
add wave -noupdate -expand -group CU /tb_mips/DUT/FSM/ALUSrcB
add wave -noupdate -expand -group CU /tb_mips/DUT/FSM/select_ori
add wave -noupdate -expand -group CU /tb_mips/DUT/FSM/RegDest
add wave -noupdate -expand -group CU /tb_mips/DUT/FSM/ALUControl
add wave -noupdate -expand -group CU /tb_mips/DUT/FSM/c_state
add wave -noupdate -expand -group CU /tb_mips/DUT/FSM/n_state
add wave -noupdate -expand -group CU /tb_mips/DUT/FSM/IorD
add wave -noupdate -expand -group Mux4to1_A3 /tb_mips/DUT/A3/a
add wave -noupdate -expand -group Mux4to1_A3 /tb_mips/DUT/A3/b
add wave -noupdate -expand -group Mux4to1_A3 /tb_mips/DUT/A3/c
add wave -noupdate -expand -group Mux4to1_A3 /tb_mips/DUT/A3/d
add wave -noupdate -expand -group Mux4to1_A3 /tb_mips/DUT/A3/SrcB
add wave -noupdate -group MUX_WD3 -radix hexadecimal /tb_mips/DUT/RD_WD3_1/x
add wave -noupdate -group MUX_WD3 -radix hexadecimal /tb_mips/DUT/RD_WD3_1/y
add wave -noupdate -group MUX_WD3 -radix hexadecimal /tb_mips/DUT/RD_WD3_1/Data_out
add wave -noupdate -group MUX4TO1_GPIO -label output -radix hexadecimal /tb_mips/DUT/GPIO_SIGN/SrcB
add wave -noupdate -group MUX4TO1_GPIO -radix hexadecimal /tb_mips/DUT/GPIO_SIGN/a
add wave -noupdate -group MUX4TO1_GPIO -radix hexadecimal /tb_mips/DUT/GPIO_SIGN/b
add wave -noupdate -group MUX4TO1_GPIO -radix hexadecimal /tb_mips/DUT/GPIO_SIGN/c
add wave -noupdate -group MUX4TO1_GPIO -radix hexadecimal /tb_mips/DUT/GPIO_SIGN/d
add wave -noupdate -group MUX4to1_SrcB -radix hexadecimal /tb_mips/DUT/Src/a
add wave -noupdate -group MUX4to1_SrcB -radix hexadecimal /tb_mips/DUT/Src/b
add wave -noupdate -group MUX4to1_SrcB -radix hexadecimal /tb_mips/DUT/Src/c
add wave -noupdate -group MUX4to1_SrcB -radix hexadecimal /tb_mips/DUT/Src/d
add wave -noupdate -group MUX4to1_SrcB -radix hexadecimal /tb_mips/DUT/Src/SrcB
add wave -noupdate -expand -group ALU -radix hexadecimal /tb_mips/DUT/ALUC/a
add wave -noupdate -expand -group ALU -radix hexadecimal /tb_mips/DUT/ALUC/b
add wave -noupdate -expand -group ALU -radix hexadecimal /tb_mips/DUT/ALUC/y
add wave -noupdate -expand -group ALU /tb_mips/DUT/ALUC/select
add wave -noupdate -expand -group Register_file -label A3_indice -radix hexadecimal -childformat {{{/tb_mips/DUT/reg_file/write_register_i[4]} -radix hexadecimal} {{/tb_mips/DUT/reg_file/write_register_i[3]} -radix hexadecimal} {{/tb_mips/DUT/reg_file/write_register_i[2]} -radix hexadecimal} {{/tb_mips/DUT/reg_file/write_register_i[1]} -radix hexadecimal} {{/tb_mips/DUT/reg_file/write_register_i[0]} -radix hexadecimal}} -subitemconfig {{/tb_mips/DUT/reg_file/write_register_i[4]} {-height 15 -radix hexadecimal} {/tb_mips/DUT/reg_file/write_register_i[3]} {-height 15 -radix hexadecimal} {/tb_mips/DUT/reg_file/write_register_i[2]} {-height 15 -radix hexadecimal} {/tb_mips/DUT/reg_file/write_register_i[1]} {-height 15 -radix hexadecimal} {/tb_mips/DUT/reg_file/write_register_i[0]} {-height 15 -radix hexadecimal}} /tb_mips/DUT/reg_file/write_register_i
add wave -noupdate -expand -group Register_file -radix hexadecimal /tb_mips/DUT/reg_file/write_data_i
add wave -noupdate -expand -group Register_file /tb_mips/DUT/reg_file/reg_write_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {213 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 74
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {211 ps} {229 ps}
