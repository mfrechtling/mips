FILES = src/*
VHDLEX = .vhd

TESTBENCHPATH = tb/${TESTBENCHFILE}$(VHDLEX)
TESTBENCHFILE = ${TESTBENCH}_tb

GHDL_CMD = ghdl

SIMDIR = simulation
WORKDIR = work
STOP_TIME = 500ns
GHDL_SIM_OPT = --stop-time=$(STOP_TIME)
GHDL_FLAGS = --workdir=$(SIMDIR) --work=$(WORKDIR)

WAVEFORM_VIEWER = gtkwave

.PHONY: clean

all: clean make run view

compile:
		@$(GHDL_CMD) -i $(GHDL_FLAGS) $(TESTBENCHPATH) $(FILES)
		@$(GHDL_CMD) -m $(GHDL_FLAGS) $(TESTBENCHFILE)

make:
ifeq ($(strip $(TESTBENCH)), )
	@echo "TESTBENCH not set. Use TESTBENCH=<value> to set it."
	@exit 1
endif

	@mkdir -p simulation
	make compile

run:
	@$(GHDL_CMD) -r $(GHDL_FLAGS) $(TESTBENCHFILE) $(GHDL_SIM_OPT) --vcdgz=$(SIMDIR)/$(TESTBENCHFILE).vcdgz

view:
	@gunzip --stdout $(SIMDIR)/$(TESTBENCHFILE).vcdgz | $(WAVEFORM_VIEWER) --vcd

clean:
	@rm -rf $(SIMDIR)
