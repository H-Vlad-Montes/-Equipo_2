onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_data_path/clk_tb
add wave -noupdate /TB_data_path/reset_tb
add wave -noupdate /TB_data_path/IorD_tb
add wave -noupdate -radix hexadecimal /TB_data_path/op_tb
add wave -noupdate -radix hexadecimal /TB_data_path/Funct_tb
add wave -noupdate -radix hexadecimal /TB_data_path/GPIO_tb
add wave -noupdate -radix hexadecimal /TB_data_path/ffwd_disp_tb
add wave -noupdate -radix hexadecimal /TB_data_path/ffrd_disp_tb
add wave -noupdate -radix hexadecimal /TB_data_path/RD1_disp_tb
add wave -noupdate -radix hexadecimal /TB_data_path/RD2_disp_tb
add wave -noupdate -radix hexadecimal /TB_data_path/SrcB_disp_tb
add wave -noupdate /TB_data_path/ALUControl_tb
add wave -noupdate /TB_data_path/ALUSrcB_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {187 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {344 ps}
