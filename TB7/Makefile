
all : my_test random_test

%_test :
	make run RUN_OPT="--testplusarg "UVM_TESTNAME=$@""

include ../common.mk

$(COM_DIR)/test_lib_pkg.sdb : ./test_lib_pkg.sv
	$(XVLOG) -L uvm --sv $<
$(COM_DIR)/test_if.sdb      : ./test_if.sv
	$(XVLOG) -L uvm --sv $<
$(COM_DIR)/bfm.sdb          : ./bfm.sv
	$(XVLOG) -L uvm --sv $<

$(COM_DIR).test_bench : $(COM_DIR)/test_lib_pkg.sdb
$(COM_DIR).test_bench : $(COM_DIR)/test_if.sdb
$(COM_DIR).test_bench : $(COM_DIR)/bfm.sdb

$(COM_DIR)/test_bench.sdb : $(COM_DIR)/test_lib_pkg.sdb

