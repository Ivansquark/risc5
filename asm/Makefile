.PHONY: all, clean

SRC = src/
INC = inc/
BLD = build/

CC = riscv64-linux-gnu-gcc
AS = riscv64-linux-gnu-as
OBJCOPY = riscv64-linux-gnu-objcopy  
OBJDUMP = riscv64-linux-gnu-objdump
CFLAGS = -g -O0 -march=rv32ima -mabi=ilp32 -mcmodel=medany -nostdlib  
#-mcmodel=medany
#LFLAGS = -T$(LIB)gd32f103vf.ld -Xlinker -Map=$(BLD)prog.map
ASFLAGS = -march=rv32ima -mabi=ilp32 

all: $(BLD)prog.elf $(BLD)prog.bin $(BLD)prog.lst $(BLD)prog.hex
$(BLD)prog.hex: $(BLD)prog.elf
	$(OBJCOPY) -O ihex $(BLD)prog.elf $(BLD)prog.hex
$(BLD)prog.bin: $(BLD)prog.elf
	$(OBJCOPY) -O binary $(BLD)prog.elf $(BLD)prog.bin
$(BLD)prog.lst: $(BLD)prog.elf
	$(OBJDUMP) -dr -S $(BLD)prog.elf > $(BLD)prog.lst

#$(BLD)main.elf: $(SRC)start.s
#	$(CC) $(SRC)start.s -o $(BLD)main.elf $(CFLAGS) $(LFLAGS)
$(BLD)prog.elf: $(BLD)main.o
	$(CC)	$(BLD)main.o $(LFLAGS) -o $(BLD)prog.elf $(CFLAGS) -I$(INC)
	@echo "********************  SIZE  **************************"
	@riscv64-linux-gnu-size $(BLD)prog.elf
	@echo "******************************************************"	
$(BLD)main.o: $(SRC)main.S
	$(AS) -c $(SRC)main.S -o $(BLD)main.o $(ASFLAGS)
	#$(CC) -c $(SRC)main.S -o $(BLD)main.o $(CFLAGS) $(INC)
	$(OBJDUMP) -dr -S $(BLD)main.o > $(BLD)main.lst

clean:
	rm -R build
	mkdir build
