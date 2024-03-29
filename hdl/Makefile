DESIGN          = j1soc
PINS            = $(DESIGN).xdc
DEVICE          = xc7a100t-1csg324
TOP_MODULE 		= j1soc
TARJETA			= Nexys4
VIVADO_VERSION 	= 2021.1
VIVADO_BIN   	= /tools/Xilinx/Vivado/2020.1/bin/vivado
VIVADO_SYNTH 	= synthesis_vivado.tcl
IVERILOG     	= iverilog
BUILD_DIR		= build_vivado

MULT		= ../multiplier
MULT_32		= ../multiplier/mult_32
DIV			= ../divider
DIV_16		= ../divider/div_16
UART		= ../uart
dp_RAM		= ../dpRAM


SRC     = ../$(DESIGN).v ../j1.v ../dpram.v \
          $(MULT)/peripheral_mult.v $(MULT_32)/acc.v $(MULT_32)/comp.v \
		  $(MULT_32)/control_mult.v $(MULT_32)/lsr.v $(MULT_32)/rsr.v $(MULT_32)/mult_32.v \
          $(DIV)/peripheral_div.v $(DIV_16)/control_div.v $(DIV_16)/counter_div.v \
		  $(DIV_16)/div_16.v $(DIV_16)/final_result.v $(DIV_16)/lsr_div.v \
		  $(DIV_16)/subtractor.v $(dp_RAM)/core_peripheric.v $(dp_RAM)/dualport_RAM.v \
		  $(UART)/uart.v $(UART)/peripheral_uart.v \
		  $(dp_RAM)/dpRAM_interface.v

SIM_SRC = ../$(DESIGN)_TB.v

all: $(DESIGN).bit

build/project:
	@[ -d $(BUILD_DIR) ] || mkdir $(BUILD_DIR)
	@rm -f $@

$(DESIGN).bit: build/project
	cd $(BUILD_DIR) && $(VIVADO_BIN) -mode batch -source ../$(VIVADO_SYNTH) -tclargs $(DESIGN)  "$(SRC)" $(DEVICE) ../$(PINS)

clean:
	rm -rf $(DESIGN).runs $(DESIGN).sdk $(DESIGN).srcs $(DESIGN).cache 
	rm -rf $(DESIGN).hw $(DESIGN).xpr 
	rm -rf *.log *.jou *.cache *.hw .Xil *.rpt *.dcp
	rm -rf $(BUILD_DIR) 

iversim: build/project
	cd $(BUILD_DIR) && $(IVERILOG) -gno-io-range-error -o $(DESIGN)_TB.vvp $(VINCDIR) $(SRC) $(SIM_SRC) -s $(DESIGN)_TB 
	vvp $(BUILD_DIR)/$(DESIGN)_TB.vvp; 
	gtkwave $(BUILD_DIR)/$(DESIGN)_TB.vcd&

program:       
	djtgcfg init -d $(TARJETA)
	djtgcfg prog -d $(TARJETA) -i 0 -f $(BUILD_DIR)/$(DESIGN).bit

.PHONY: all clean