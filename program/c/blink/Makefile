.PHONY: all, clean

SRC = src/
INC = inc/
LIB = lib/
BLD = build/


CC = riscv64-unknown-elf-gcc
#CC = /opt/riscv32/bin/riscv32-unknown-elf-gcc
AS = riscv64-unknown-elf-as
#AS = /opt/riscv32/bin/riscv32-unknown-elf-as
OBJCOPY = riscv64-unknown-elf-objcopy  
#OBJCOPY = /opt/riscv32/bin/riscv32-unknown-elf-objcopy  
OBJDUMP = riscv64-unknown-elf-objdump
#OBJDUMP = /opt/riscv32/bin/riscv32-unknown-elf-objdump
SIZE = riscv64-unknown-elf-size
#SIZE = /opt/riscv32/bin/riscv32-unknown-elf-size
CFLAGS = -O1 -specs=picolibc.specs -march=rv32i -mabi=ilp32 -mcmodel=medany -nostartfiles
#-mcmodel=medany
LFLAGS = -T$(LIB)rv.ld -Xlinker -Map=$(BLD)prog.map -nostartfiles
#ASFLAGS = -g -march=rv32ima -mabi=ilp32 

all: $(BLD)prog.elf $(BLD)prog.bin $(BLD)prog.lst $(BLD)prog.hex

$(BLD)prog.hex: $(BLD)prog.elf
	$(OBJCOPY) -O ihex $(BLD)prog.elf $(BLD)prog.hex
$(BLD)prog.bin: $(BLD)prog.elf
	$(OBJCOPY) -O binary $(BLD)prog.elf $(BLD)prog.bin
$(BLD)prog.lst: $(BLD)prog.elf
	$(OBJDUMP) -Dr -S $(BLD)prog.elf > $(BLD)prog.lst -M no-aliases

#$(BLD)main.elf: $(SRC)start.s
#	$(CC) $(SRC)start.s -o $(BLD)main.elf $(CFLAGS) $(LFLAGS)
$(BLD)prog.elf: $(BLD)startup.o $(BLD)main.o 
	$(CC)	$(BLD)startup.o $(BLD)main.o \
		$(LFLAGS) -o $(BLD)prog.elf $(CFLAGS) -I$(INC)
	@echo "********************  SIZE  **************************"
	@$(SIZE) $(BLD)prog.elf
	@echo "******************************************************"
#    $@ — target name
#    $< — first dependancy name
#    $? — all dependancies names, thats newer than target
#    $^ — all dependencies names of the target
#	 %	- template for all files


$(BLD)startup.o: $(LIB)startup.c
	$(CC) -c $(LIB)startup.c -o $(BLD)startup.o $(CFLAGS) -I$(INC)
	$(OBJDUMP) -dr -S $(BLD)startup.o > $(BLD)startup.lst

$(BLD)%.o: $(SRC)%.c
	$(CC) -c $< -o $@ $(CFLAGS) -I$(INC)
	$(OBJDUMP) -dr -S $@ > $@.lst

clean:
	rm -R build
	mkdir build
