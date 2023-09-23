VIVADO_DIR := /tools/Xilinx/Vivado/2022.2
#export LD_LIBRARY_PATH := ${LD_LIBRARY_PATH}:${VIVADO_DIR}/lib/lnx64.o:${VIVADO_DIR}/lib/lnx64.o/Default
XVLOG := $(VIVADO_DIR)/bin/xvlog
XELAB := $(VIVADO_DIR)/bin/xelab
XSIM  := $(VIVADO_DIR)/bin/xsim

#SRC_FILES := $(shell ls -R *.sv)
SRC_FILES += test_bench.sv
SRC_FILES += ../dut.sv

run : ./xsim.dir/alone/axsim axsim.sh  
	./axsim.sh $(RUN_OPT)
cli : ./xsim.dir/debug/xsimk
	$(XSIM) debug $(RUN_OPT)
gui : ./xsim.dir/debug/xsimk
	$(XSIM) debug $(RUN_OPT) -gui &
dump : ./xsim.dir/debug/xsimk
	$(XSIM) debug $(RUN_OPT) -tclbatch ../dump.tcl -wdb wave.wdb
wave : wave.wdb
	$(XSIM) wave.wdb -gui &

./xsim.dir/debug/xsimk axsim.sh : $(SRC_FILES) 
	$(XVLOG) -L uvm -sv $^
	$(XELAB) test_bench -L uvm -debug all  -snapshot debug

./xsim.dir/alone/axsim : $(SRC_FILES) 
	$(XVLOG) -L uvm -sv $^
	$(XELAB) test_bench -L uvm -standalone -snapshot alone


clean :
	rm -rf *.log *.jou *.pb *.dir *.wdb *.vcd axsim.sh .Xil

