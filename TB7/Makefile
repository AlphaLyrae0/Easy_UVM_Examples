
SRC_FILES := test_lib_pkg.sv
SRC_FILES += bfm.sv
SRC_FILES += test_if.sv
SRC_FILES += bfm_if.sv

all : run_my_test run_random_test

run_% :
	make run  RUN_OPT="-testplusarg UVM_TESTNAME=$*"
dump_% :
	make dump RUN_OPT="-testplusarg UVM_TESTNAME=$*"
gui_% :
	make gui  RUN_OPT="-testplusarg UVM_TESTNAME=$*"

include ../common.mk