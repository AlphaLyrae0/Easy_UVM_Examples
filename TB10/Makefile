
all : my_test random_test

%_test :
	make run RUN_OPT="--testplusarg "UVM_TESTNAME=$@""

include ../common.mk

$(COM_DIR)/sig_agent_pkg.sdb : ./sig_agent/sig_agent_pkg.sv
	$(XVLOG) -L uvm --sv $<
$(COM_DIR)/sig_if.sdb        : ./sig_agent/sig_if.sv
	$(XVLOG) -L uvm --sv $<
$(COM_DIR)/xyz_agent_pkg.sdb : ./xyz_agent/xyz_agent_pkg.sv
	$(XVLOG) -L uvm --sv $<
$(COM_DIR)/xyz_if.sdb        : ./xyz_agent/xyz_if.sv
	$(XVLOG) -L uvm --sv $<

$(COM_DIR).test_bench : $(COM_DIR)/sig_agent_pkg.sdb
$(COM_DIR).test_bench : $(COM_DIR)/xyz_agent_pkg.sdb
$(COM_DIR).test_bench : $(COM_DIR)/test_lib_pkg.sdb
$(COM_DIR).test_bench : $(COM_DIR)/dut_if.sdb
$(COM_DIR).test_bench : $(COM_DIR)/sig_if.sdb
$(COM_DIR).test_bench : $(COM_DIR)/xyz_if.sdb

$(COM_DIR)/test_lib_pkg.sdb : $(COM_DIR)/sig_agent_pkg.sdb
$(COM_DIR)/test_lib_pkg.sdb : $(COM_DIR)/xyz_agent_pkg.sdb
$(COM_DIR)/test_bench.sdb   : $(COM_DIR)/test_lib_pkg.sdb

