# Folders
SRC_DIR=src
OBJ_DIR=obj
BIN_DIR=bin

# Tools
AS=as
LD=ld
QEMU=qemu-system-x86_64

# Flags
ASFLAGS=--32
LDFLAGS=-m elf_i386 -Ttext 0x7C00 --oformat binary
QEMUFLAGS=-drive format=raw,file=$(BIN_DIR)/main.bin

# Targets
all: $(BIN_DIR)/main.bin

$(BIN_DIR)/main.bin: $(OBJ_DIR)/main.o
	$(LD) $(LDFLAGS) $< -o $@

$(OBJ_DIR)/main.o: $(SRC_DIR)/main.s $(SRC_DIR)/macros.s
	$(AS) $(ASFLAGS) $(SRC_DIR)/main.s -o $@

run: $(BIN_DIR)/main.bin
	$(QEMU) $(QEMUFLAGS)

clean:
	rm -f $(OBJ_DIR)/*.o $(BIN_DIR)/*.bin

.PHONY: all run clean
