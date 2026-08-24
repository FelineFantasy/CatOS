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

echo [SUCCESS] Build finished. Image ready!
pause
