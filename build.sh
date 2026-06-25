#!/bin/bash

echo "[1/2] Compiling boot.asm..."
nasm -f bin src/boot.asm -o boot.bin

if [ $? -ne 0 ]; then
    echo "[ERROR] NASM compilation failed!"
    exit 1
fi

echo "[2/2] Launching in QEMU..."
qemu-system-x86_64 -fda boot.bin

echo "[SUCCESS] Execution finished."