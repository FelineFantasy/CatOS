# CatOS 🐱

[![Assembly](https://img.shields.io/badge/Assembly-x86-blue)](https://en.wikipedia.org/wiki/X86_assembly_language)
[![NASM](https://img.shields.io/badge/NASM-2.15+-orange)](https://nasm.us)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

A hardcore, minimalist 16-bit real-mode operating system bootloader written completely from scratch in x86 Assembly.

```text
       /\_/\
      ( o.o )
       > ^ <   [ Meow! CatOS is booting... ]
```

## 📝 Description

**CatOS** is an independent bootloader that takes full control of the CPU immediately after the BIOS POST screen. It does not rely on heavy modern loaders like GRUB or any third-party kernels.

**Technical Details:**
- 🛠️ **Pure Assembly**: Written 100% in 16-bit x86 Real Mode NASM.
- ⚡ **BIOS Interruption Free**: Renders text cleanly without risking typical hardware-specific screen clearing conflicts on custom motherboards.
- 🛑 **Safe Halting**: Implements a strict `cli` + `hlt` loop. It completely disables hardware interrupts, safely freezing the CPU into a absolute zero-power saving state, preventing toxic boot loops.
- 💾 **512-Byte Hard Limit**: Perfectly optimized to fit into the master boot record (Sector 1) with the mandatory `0xAA55` boot signature.

## 📁 Project Files

```text
CatOS/
├── .github/
│   └── workflows/
│       └── build.yml       # CI/CD Automated Cloud Build
├── src/
│   ├── api/
│   │   ├── io/
│   │   │   ├── clear_screen.asm   # Video Buffer Clearing Routine
│   │   │   └── print_string.asm   # Teletype String Output Routine
│   │   └── io.asm          # Core OS API & Submodule Dispatcher
│   ├── boot.asm            # MBR Bootloader Code (Sector 1)
│   └── kernel.asm          # Main Operating System Kernel Code
├── .gitignore              # Hides compilation binaries & venv
├── LICENSE                 # Project License Terms
├── build.bat               # Windows Universal Lazy Script
├── build.sh                # Linux Universal Lazy Script
└── README.md               # Documentation
```

## ⚙️ Installation & Testing

### Option 1: Test in Emulator (QEMU)
Make sure **NASM** and **QEMU** are added to your System PATH variables, then simply run the universal lazy script:
- **Windows**: Double-click `build.bat`
- **Linux/macOS**: Run `./build.sh`

### Option 2: Flash onto real hardware (Bare Metal)
1. Go to [Releases] to download the compiled `os.img`.
2. Open **Rufus**, select your USB flash drive.
3. Choose `os.img` (switch filter to "All Files *.*").
4. Set Partition Scheme to **MBR** and Target System to **BIOS (or UEFI-CSM)**.
5. Click **START**, reboot your PC, mash **F11** and select the USB drive.

---

## 👤 Author
- **FelineFantasy**
- **License**: MIT
