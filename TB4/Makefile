
all : my_test random_test

%_test :
	make run RUN_OPT="--testplusarg "UVM_TESTNAME=$@""

include ../common.mk
