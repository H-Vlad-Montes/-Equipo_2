onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_mips/clk_tb
add wave -noupdate /tb_mips/reset_tb
add wave -noupdate -expand -group PC -radix hexadecimal /tb_mips/DUT/PC/d
add wave -noupdate -expand -group PC -radix hexadecimal /tb_mips/DUT/PC/q
add wave -noupdate -radix decimal /tb_mips/GPIO_i_tb
add wave -noupdate -radix decimal /tb_mips/GPIO_o_tb
add wave -noupdate -label instr -radix hexadecimal /tb_mips/DUT/RD/d
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/Op
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/funct
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/IorD
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/MemWrite
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/IRWrite
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/RegDest
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/Mem_to_Reg
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/RegWrite
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/ALUSrcA
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/PCSrc
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/select_ori
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/jump_select
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/PCWrite
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/branch
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/ALUSrcB
add wave -noupdate -group control_unit /tb_mips/DUT/FSM/ALUControl
add wave -noupdate -group ALU /tb_mips/DUT/ALUC/a
add wave -noupdate -group ALU /tb_mips/DUT/ALUC/b
add wave -noupdate -group ALU /tb_mips/DUT/ALUC/y
add wave -noupdate -expand -group RDA -radix hexadecimal /tb_mips/DUT/RD1_A/d
add wave -noupdate -expand -group RDA -radix hexadecimal /tb_mips/DUT/RD1_A/q
add wave -noupdate -expand -group RDB -radix hexadecimal /tb_mips/DUT/RD2_B/d
add wave -noupdate -expand -group RDB -radix hexadecimal /tb_mips/DUT/RD2_B/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {1 ns}
