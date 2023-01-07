
all : my_test random_test

%_test :
	make run RUN_OPT="--testplusarg "UVM_TESTNAME=$@""

include ../common.mk

$(COM_DIR).test_bench/axsim : $(COM_DIR)/bfm.sdb

$(COM_DIR).test_bench/xsimk : $(COM_DIR)/bfm.sdb

