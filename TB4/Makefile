VIVADO_DIR := /tools/Xilinx/Vivado/2022.2/bin
XVLOG := $(VIVADO_DIR)/xvlog
XELAB := $(VIVADO_DIR)/xelab
XSIM  := $(VIVADO_DIR)/xsim

COM_DIR := xsim.dir/work
TESTNAME := my_test

all : my_test random_test

my_test :
	make run TESTNAME=$@

random_test :
	make run TESTNAME=$@

run : $(COM_DIR).test_bench
	$(XSIM) test_bench --runall --testplusarg "UVM_TESTNAME=$(TESTNAME)"

gui : $(COM_DIR).test_bench
	$(XSIM) test_bench --gui

$(COM_DIR)/dut.sdb : ../dut.sv
	$(XVLOG) -L uvm --sv $<
$(COM_DIR)/test_bench.sdb : ./test_bench.sv
	$(XVLOG) -L uvm --sv $<

$(COM_DIR).test_bench : $(COM_DIR)/dut.sdb $(COM_DIR)/test_bench.sdb
	$(XELAB) -L uvm test_bench

clean :
	rm -rf *.log *.jou *.pb *.dir *.wdb *.vcd 

