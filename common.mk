VIVADO_DIR := /tools/Xilinx/Vivado/2022.2/bin
XVLOG := $(VIVADO_DIR)/xvlog --incr
XELAB := $(VIVADO_DIR)/xelab --incr
XSIM  := $(VIVADO_DIR)/xsim

COM_DIR = xsim.dir/work

run : $(COM_DIR).test_bench/axsim
	./axsim.sh $(RUN_OPT)
#	$(XSIM) test_bench --runall $(RUN_OPT)

gui : $(COM_DIR).test_bench/xsimk
	$(XSIM) test_bench --gui

$(COM_DIR)/dut.sdb : ../dut.sv
	$(XVLOG) -L uvm --sv $<
#$(COM_DIR)/test_bench.sdb : ./test_bench.sv
#	$(XVLOG) -L uvm --sv $<
$(COM_DIR)/%.sdb : ./%.sv
	$(XVLOG) -L uvm --sv $<

$(COM_DIR).test_bench/xsimk : $(COM_DIR)/dut.sdb $(COM_DIR)/test_bench.sdb
	$(XELAB) -L uvm --debug typical test_bench

$(COM_DIR).test_bench/axsim : $(COM_DIR)/dut.sdb $(COM_DIR)/test_bench.sdb
	$(XELAB) -L uvm --standalone    test_bench


clean :
	rm -rf *.log *.jou *.pb *.dir *.wdb *.vcd axsim.sh

