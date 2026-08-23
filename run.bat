@echo off
cls

if not exist os.img (
    echo [ERROR] os.img not found! Please run build.bat first.
    pause
    exit /b 1
)

echo [SUCCESS] Launching FelineFantasy OS in QEMU...
qemu-system-x86_64 -drive format=raw,file=os.img

echo [SUCCESS] QEMU closed. Ready for next build!
pause
