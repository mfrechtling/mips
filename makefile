FILES = src/*
VHDLEX = .vhd

TESTBENCHPATH = tb/${TESTBENCHFILE}$(VHDLEX)
TESTBENCHFILE = ${TESTBENCH}_tb

GHDL_CMD = ghdl

SIMDIR = simulation
STOP_TIME = 500ns
GHDL_SIM_OPT = --stop-time=$(STOP_TIME)

WAVEFORM_VIEWER = gtkwave

.PHONY: clean

all: clean make run view

compile:
		@$(GHDL_CMD) -i $(GHDL_FLAGS) --workdir=simulation --work=work $(TESTBENCHPATH) $(FILES)
		@$(GHDL_CMD) -m $(GHDL_FLAGS) --workdir=simulation --work=work $(TESTBENCHFILE)

make:
ifeq ($(strip $(TESTBENCH)), )
	@echo "TESTBENCH not set. Use TESTBENCH=<value> to set it."
	@exit 1
endif

	@mkdir -p simulation
	make compile

run:
	@$(GHDL_CMD) -r --workdir=simulation --work=work $(TESTBENCHFILE) $(GHDL_SIM_OPT) --vcdgz=$(SIMDIR)/$(TESTBENCHFILE).vcdgz

view:
	@gunzip --stdout $(SIMDIR)/$(TESTBENCHFILE).vcdgz | $(WAVEFORM_VIEWER) --vcd

clean:
	@rm -rf $(SIMDIR)
