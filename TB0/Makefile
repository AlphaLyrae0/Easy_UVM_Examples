VIVADO_DIR := /tools/Xilinx/Vivado/2022.2/bin
XVLOG := $(VIVADO_DIR)/xvlog
XELAB := $(VIVADO_DIR)/xelab
XSIM  := $(VIVADO_DIR)/xsim

SRC_DIR := ~/Sandbox/Verilog/src
COM_DIR := xsim.dir/work

run : $(COM_DIR).test_bench
	$(XSIM) test_bench --runall

gui : $(COM_DIR).test_bench
	$(XSIM) test_bench --gui

$(COM_DIR)/dut.sdb : ../dut.sv
	$(XVLOG) --sv $<
$(COM_DIR)/test_bench.sdb : ./test_bench.sv
	$(XVLOG) --sv $<

$(COM_DIR).test_bench : $(COM_DIR)/dut.sdb $(COM_DIR)/test_bench.sdb
	$(XELAB) test_bench

clean :
	rm -rf *.log *.jou *.pb *.dir *.wdb *.vcd 

