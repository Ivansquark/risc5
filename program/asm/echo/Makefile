.PHONY: all, clean

SRC = src/
INC = inc
BLD = build/

#CC = riscv64-linux-gnu-gcc
CC = /opt/riscv32/bin/riscv32-unknown-elf-gcc
#AS = riscv64-linux-gnu-as
AS = /opt/riscv32/bin/riscv32-unknown-elf-as
#OBJCOPY = riscv64-linux-gnu-objcopy  
OBJCOPY = /opt/riscv32/bin/riscv32-unknown-elf-objcopy  
#OBJDUMP = riscv64-linux-gnu-objdump
OBJDUMP = /opt/riscv32/bin/riscv32-unknown-elf-objdump
SIZE = /opt/riscv32/bin/riscv32-unknown-elf-size
CFLAGS = -g -O0 -march=rv32ima -mabi=ilp32 -mcmodel=medany -nostdlib  
#-mcmodel=medany
#LFLAGS = -T$(LIB)gd32f103vf.ld -Xlinker -Map=$(BLD)prog.map
ASFLAGS = -g -march=rv32ima -mabi=ilp32 

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
	@$(SIZE) $(BLD)prog.elf
	@echo "******************************************************"	
$(BLD)main.o: $(SRC)main.S
	#$(AS) -c $(SRC)main.S -o $(BLD)main.o $(ASFLAGS) -I$(INC)
	$(AS) $(SRC)main.S -o $(BLD)main.o $(ASFLAGS) -I$(INC)
	#$(CC) -c $(SRC)main.S -o $(BLD)main.o $(CFLAGS) $(INC)
	$(OBJDUMP) -dr -S $(BLD)main.o > $(BLD)main.lst

clean:
	rm -R build
	mkdir build
