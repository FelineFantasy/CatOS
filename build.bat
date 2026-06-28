@echo off
cls
echo [1/3] Compiling boot.asm with NASM...
nasm -f bin src/boot.asm -o boot.bin

if %errorlevel% neq 0 (
    echo [ERROR] Bootloader compilation failed!
    pause
    exit /b %errorlevel%
)

echo [2/3] Compiling kernel.asm with NASM...
nasm -f bin src/kernel.asm -o kernel.bin

if %errorlevel% neq 0 (
    echo [ERROR] Kernel compilation failed!
    pause
    exit /b %errorlevel%
)

echo [3/3] Gluing bootloader and kernel into os.img...
copy /b boot.bin + kernel.bin os.img > nul

echo [SUCCESS] Launching FelineFantasy OS in QEMU...
qemu-system-x86_64 -drive format=raw,file=os.img

echo [SUCCESS] QEMU closed. Ready for next build!
pause