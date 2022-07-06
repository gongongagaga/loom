KERNEL := loom.elf

CC = x86_64-elf-gcc
AS = nasm

CFLAGS = -Wall -Wextra -O2 -pipe -I stivale/

INTERNALLDFLAGS := \
	-fno-pic -fpie \
	-Wl,-static,-pie,--no-dynamic-linker,-ztext \
	-Wl,-static \
	-static-pie \
	-nostdlib \
	-T kernel/linker.ld \
	-z max-page-size=0x1000

INTERNALCFLAGS := \
	-I. \
	-std=gnu11 \
	-ffreestanding \
	-fno-stack-protector \
	-fno-pic -fpie \
	-mgeneral-regs-only \
	-mno-red-zone

CFILES := $(wildcard kernel/*/*.c)
ASMFILES := $(wildcard kernel/*/*.asm)
OBJ := $(CFILES:.c=.o) $(ASMFILES:.asm=.o)

.PHONY: all run clean

all: $(KERNEL) image

$(KERNEL): $(OBJ)
	@$(CC) $(INTERNALLDFLAGS) $(OBJ) -o $@
	@echo " LD       $@"

%.o: %.c
	@$(CC) $(CFLAGS) $(INTERNALCFLAGS) -c $< -o $@
	@echo " CC       $<"

%.o: %.asm
	@$(AS) -felf64 $< -o $@
	@echo " ASM      $<"

clean:
	@rm -rf $(KERNEL) $(OBJ)
	@rm -rf loom.img
	@echo " RM       all"

image:
	@sudo ./image.sh

run:
	@sudo qemu-system-x86_64 -hda loom.img