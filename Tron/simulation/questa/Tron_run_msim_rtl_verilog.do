transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/Tron.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/SignExtend.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/Shifter.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/ProgramCounter.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/Multiplexer.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/InstructionDecoder.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/FetchDecoder.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/Datapath.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/Controller.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/Bus.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/ALU.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/BitGen.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/VGAControl.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/Registers.v}
vlog -vlog01compat -work work +incdir+C:/IntelQuartus/23.1.1/ece3710/Tron {C:/IntelQuartus/23.1.1/ece3710/Tron/exmem.v}

