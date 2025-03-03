
#SRC_FILES := $(shell ls -R *.sv)
SRC_FILES += test_bench.sv
SRC_FILES += ../dut.sv

SIMULATOR := DSIM
ifdef XILINX_VIVADO
SIMULATOR := XSIM
endif
ifdef DSIM_HOME
SIMULATOR := DSIM
endif
ifdef USE_XSIM
SIMULATOR := XSIM
endif
ifdef USE_DSIM
SIMULATOR := DSIM
endif


#------------------ Metrics DSim --------------------------------------
ifeq ($(SIMULATOR),DSIM)

ifdef DSIM_HOME
  DSIM_CMD  := dsim 
else
  DSIM_DIR  := ${HOME}/metrics-ca/dsim
 #DSIM_DIR  := ${HOME}/AltairDSim
  DSIM_HOME := $(shell ls -t1d $(DSIM_DIR)/* | head -n 1)
  DSIM_CMD  := $(DSIM_HOME)/shell_activate.bash; dsim 
 #export DSIM_LICENSE := $(DSIM_DIR)/dsim-license.json
  export DSIM_LICENSE := ${HOME}/metrics-ca/dsim/dsim-license.json
endif

ifdef TESTNAME
  RUN_OPT := +UVM_TESTNAME=$(TESTNAME)
endif

run : dsim_work/batch.so 
	$(DSIM_CMD) -uvm 1.2 -image batch $(RUN_OPT)
dump : dsim_work/wave.so
	$(DSIM_CMD) -uvm 1.2 -image wave  $(RUN_OPT) -waves waves.mxd
gui  :
	code
wave : waves.mxd
	code waves.mxd
log  : dsim.log
	code dsim.log

dsim_work/batch.so : $(SRC_FILES)
	$(DSIM_CMD) -uvm 1.2 -top test_bench $(SRC_FILES) -genimage batch

dsim_work/wave.so :  $(SRC_FILES)
	$(DSIM_CMD) -uvm 1.2 -top test_bench $(SRC_FILES) -genimage wave +acc+b

clean:
	rm -rf dsim_work *.env *.db *.mxd *.vcd *.log
help :
	$(DSIM_CMD) -help

endif
#----------------------------------------------------------------------

#------------------ Vivado XSIM ---------------------------------------
ifeq ($(SIMULATOR),XSIM)

ifdef XILINX_VIVADO
 XVLOG := xvlog
 XELAB := xelab
 XSIM  := xsim
else
#VIVADO_DIR := /tools/Xilinx/Vivado/2022.2
 VIVADO_DIR := /tools/Xilinx/Vivado/2023.1
#export LD_LIBRARY_PATH := ${LD_LIBRARY_PATH}:${VIVADO_DIR}/lib/lnx64.o:${VIVADO_DIR}/lib/lnx64.o/Default
 XVLOG := $(VIVADO_DIR)/bin/xvlog
 XELAB := $(VIVADO_DIR)/bin/xelab
 XSIM  := $(VIVADO_DIR)/bin/xsim
endif

ifdef TESTNAME
  RUN_OPT := -testplusarg UVM_TESTNAME=$(TESTNAME)
endif

run : ./xsim.dir/alone/axsim axsim.sh  
	./axsim.sh $(RUN_OPT)
cli : ./xsim.dir/debug/xsimk
	$(XSIM) debug $(RUN_OPT)
gui : ./xsim.dir/debug/xsimk
	$(XSIM) debug $(RUN_OPT) -gui &
dump : ./xsim.dir/debug/xsimk
	$(XSIM) debug $(RUN_OPT) -tclbatch ../dump.tcl -wdb wave.wdb
wave : wave.wdb
	$(XSIM) wave.wdb -gui &

./xsim.dir/alone/axsim : $(SRC_FILES) 
	$(XVLOG) -L uvm -sv $^
	$(XELAB) test_bench -L uvm -standalone -snapshot alone

./xsim.dir/debug/xsimk axsim.sh : $(SRC_FILES) 
	$(XVLOG) -L uvm -sv $^
	$(XELAB) test_bench -L uvm -debug all  -snapshot debug

clean :
	rm -rf *.log *.jou *.pb *.dir *.wdb *.vcd axsim.sh .Xil

endif
#----------------------------------------------------------------------

run_% :
	make run  TESTNAME=$*
dump_% :
	make dump TESTNAME=$*
gui_% :
	make gui  TESTNAME=$*