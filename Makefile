#Terrible makefile, copied from online and modified to use dfu-programmer
# https://gist.github.com/holachek/3304890
# DO NOT COPY WHOLESALE
# The DFU section is from TMK

# MCU ....... The AVR device you compile for
# F_CPU ........ Target AVR clock rate in Hertz

MCU     = at90usb1287
F_CPU      = 1000000
TARGET    = blink


######################################################################
######################################################################

# Tune the lines below only if you know what you are doing:

COMPILE = avr-gcc -Wall -Os -DF_CPU=$(F_CPU) -mmcu=$(MCU)

# symbolic targets:
all:	$(TARGET).hex

.c.o:
	$(COMPILE) -c $< -o $@

.S.o:
	$(COMPILE) -x assembler-with-cpp -c $< -o $@
# "-x assembler-with-cpp" should not be necessary since this is the default
# file type for the .S (with capital S) extension. However, upper case
# characters are not always preserved on Windows. To ensure WinAVR
# compatibility define the file type manually.

.c.s:
	$(COMPILE) -S $< -o $@

.PHONY: dfu
dfu: all
	@echo -n dfu-programmer: waiting, press rst+hwb, release rst, release hwb
	@echo
	@until dfu-programmer $(MCU) get bootloader-version > /dev/null 2>&1; do \
		echo  -n "."; \
		sleep 1; \
	done
	@echo
	dfu-programmer $(MCU) erase
	dfu-programmer $(MCU) flash $(TARGET).hex
	dfu-programmer $(MCU) reset


# if you use a bootloader, change the command below appropriately:
load: all
	bootloadHID $(TARGET).hex

clean:
	rm -f $(TARGET).hex $(TARGET).elf $(TARGET).o

# file targets:
$(TARGET).elf: $(TARGET).o
	$(COMPILE) -o $(TARGET).elf $(TARGET).o

$(TARGET).hex: $(TARGET).elf
	rm -f $(TARGET).hex
	avr-objcopy -j .text -j .data -O ihex $(TARGET).elf $(TARGET).hex
# If you have an EEPROM section, you must also create a hex file for the
# EEPROM and add it to the "flash" target.

# Targets for code debugging and analysis:
disasm:	$(TARGET).elf
	avr-objdump -d $(TARGET).elf
