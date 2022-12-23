VIVADO_DIR := /tools/Xilinx/Vivado/2022.2/bin
XVLOG := $(VIVADO_DIR)/xvlog
XELAB := $(VIVADO_DIR)/xelab
XSIM  := $(VIVADO_DIR)/xsim

COM_DIR := xsim.dir/work
TESTNAME := my_test

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
$(COM_DIR)/agent_pkg.sdb : ./agent_pkg.sv
	$(XVLOG) -L uvm --sv $<
$(COM_DIR)/scoreboard_pkg.sdb : ./scoreboard_pkg.sv
	$(XVLOG) -L uvm --sv $<
$(COM_DIR)/test_lib_pkg.sdb : ./test_lib_pkg.sv
	$(XVLOG) -L uvm --sv $<
$(COM_DIR)/dut_prm_if.sdb : ./dut_prm_if.sv
	$(XVLOG) -L uvm --sv $<
$(COM_DIR)/dut_in_if.sdb : ./dut_in_if.sv
	$(XVLOG) -L uvm --sv $<
$(COM_DIR)/dut_out_if.sdb : ./dut_out_if.sv
	$(XVLOG) -L uvm --sv $<
$(COM_DIR)/test_bench.sdb : ./test_bench.sv
	$(XVLOG) -L uvm --sv $<

$(COM_DIR).test_bench : $(COM_DIR)/dut.sdb $(COM_DIR)/agent_pkg.sdb $(COM_DIR)/scoreboard_pkg.sdb $(COM_DIR)/test_lib_pkg.sdb $(COM_DIR)/dut_prm_if.sdb  $(COM_DIR)/dut_in_if.sdb $(COM_DIR)/dut_out_if.sdb $(COM_DIR)/test_bench.sdb
	$(XELAB) -L uvm test_bench

clean :
	rm -rf *.log *.jou *.pb *.dir *.wdb *.vcd 

