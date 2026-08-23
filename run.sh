#!/bin/bash

if [ ! -f "os.img" ]; then
    echo "[ERROR] os.img not found! Please run ./build.sh first."
    exit 1
fi

echo "[SUCCESS] Launching in QEMU..."
qemu-system-x86_64 -drive format=raw,file=os.img

echo "[SUCCESS] Execution finished."
