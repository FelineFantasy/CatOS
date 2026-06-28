#!/bin/bash

echo "[1/3] Compiling boot.asm..."
nasm -f bin src/boot.asm -o boot.bin
if [ $? -ne 0 ]; then
    echo "[ERROR] Bootloader compilation failed!"
    exit 1
fi

echo "[2/3] Compiling kernel.asm..."
nasm -f bin src/kernel.asm -o kernel.bin
if [ $? -ne 0 ]; then
    echo "[ERROR] Kernel compilation failed!"
    exit 1
fi

echo "[3/3] Gluing into os.img..."
cat boot.bin kernel.bin > os.img

echo "[SUCCESS] Launching in QEMU..."
qemu-system-x86_64 -drive format=raw,file=os.img

echo "[SUCCESS] Execution finished."