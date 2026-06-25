@echo off
cls
echo [1/2] Compiling boot.asm with NASM...
nasm -f bin src/boot.asm -o boot.bin

if %errorlevel% neq 0 (
    echo [ERROR] NASM not found or compilation failed!
    echo Make sure NASM and QEMU are added to your System PATH variables.
    pause
    exit /b %errorlevel%
)

echo [2/2] Launching FelineFantasy OS in QEMU...
qemu-system-x86_64 -fda boot.bin

echo [SUCCESS] QEMU closed. Ready for next build!
pause
