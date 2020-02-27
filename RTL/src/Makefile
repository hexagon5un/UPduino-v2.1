PROJ=audio_test
CONSTRAINT=upduino.lpf

%.json: %.v 
	yosys -q -p "synth_ice40 -json $@" $< 

%.asc: %.json 
	nextpnr-ice40 --up5k --package sg48 --json $< --pcf $(CONSTRAINT) --asc $@   

%.bit: %.asc
	icepack $< $@

.PHONY: flash
flash: $(PROJ).bit
	iceprog $(PROJ).bit


