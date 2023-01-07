
all : my_test random_test

%_test :
	make run RUN_OPT="--testplusarg "UVM_TESTNAME=$@""

include ../common.mk

$(COM_DIR)/bfm.sdb : ./bfm.sv
	$(XVLOG) -L uvm --sv $<

$(COM_DIR).test_bench : $(COM_DIR)/bfm.sdb

