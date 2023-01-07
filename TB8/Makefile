
all : my_test random_test

%_test :
	make run RUN_OPT="--testplusarg "UVM_TESTNAME=$@""

include ../common.mk

$(COM_DIR).test_bench : $(COM_DIR)/test_lib_pkg.sdb
$(COM_DIR).test_bench : $(COM_DIR)/dut_if.sdb

$(COM_DIR)/test_bench.sdb : $(COM_DIR)/test_lib_pkg.sdb

