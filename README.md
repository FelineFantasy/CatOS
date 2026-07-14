# CatOS 🐱 v1.10.0

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
│   │   └── functions.asm   # System Call API and Shared Functions
│   ├── boot.asm            # Core Operating System Bootloader Code
│   └── kernel.asm          # Main Operating System Kernel Code
├── .gitignore              # Hides compilation binaries
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

## 👤 Author
- **FelineFantasy**
- **License**: MIT

---

## 📦 Changelog

### v1.10.0 (2026-07-14)
- **Architecture**: Modularized the codebase by moving common BIOS routines (`print_string`, `clear_screen`) into an isolated System OS API directory (`src/api/functions.asm`), linked via `%include`.

### v1.9.0 (2026-07-14)
- **Architecture**: Modularized the codebase by moving common BIOS routines (`print_string`, `clear_screen`) into a standalone `src/functions.asm` library, linked via `%include`.

### v1.8.0 (2026-07-13)
- **Refactor**: Replaced NASM assembly macros with standalone procedures (`call`/`ret`) to improve code modularity.

### v1.7.1 (12.07.2026)
- **String Corruption Fix**: Added mandatory `cld` instruction at the kernel entry point to reset the CPU Direction Flag (DF). This guarantees that string indexing via `lodsb` moves forward and prevents random text corruption or infinite loops caused by post-BIOS flags.

### v1.7.0 (11.07.2026)
- **Menu Placeholder**: Added a temporary stub screen ("soon...") for future OS features instead of freezing the system immediately after a keypress

### v1.6.0 (06.07.2026)
- **Disk Read Error Handler**: Added a friendly (and furry) error message for disk read failures.
- **User Experience**: Instead of hanging, the system now displays a panic cat when the kernel cannot be loaded.

### v1.5.0 (05.07.2026)
- **Kernel Relocation**: Moved kernel load address from `0x7E00` to `0x1000` to avoid overlapping with bootloader and BIOS IVT.

### v1.4.0 (01.07.2026)
- **Buffer Address Fix**: Shifted kernel loading destination from `0x1000` to a safe memory area at `0x7E00` (right after the bootloader) to prevent corrupting the BIOS Interrupt Vector Table (IVT).
- **Segment Alignment**: Updated `[org]` directives and added mandatory segment register initialization (`DS`/`ES` reset to `0`) inside the kernel main entry point to guarantee that string indexing and `lodsb` instructions map to correct memory offsets.

### v1.3.2 (30.06.2026)
- **Drive ID Fix**: Implemented a memory variable `boot_drive` to preserve the BIOS-passed boot drive ID from the `DL` register at initial startup.
- **Stability Fix**: Restored the exact drive ID to `DL` before the `int 0x13` interrupt call to guarantee absolute data loading compatibility.

### v1.3.1 (30.06.2026)
- **Stack Fix**: Initialized safe stack registers (`ss = 0x0000`, `sp = 0x7C00`) to prevent data corruption during `int 0x13` disk operations.
- **Far Jump Fix**: Replaced short jump with a proper far jump (`jmp 0x0000:0x1000`) to hard-reset the `CS` segment register for absolute bare-metal compatibility.

### v1.3.0 (29.06.2026)
- **Modular architecture**: the monolithic bootloader has been successfully split into separate bootloader (`src/boot.asm`) and kernel (`src/kernel.asm`) spaces using the BIOS interrupt `int 0x13`.
- **Build automation**: the local scripts for lazy users (`build.bat` / `build.sh`) have been completely rewritten to automatically compile and merge the binaries into a ready-to-test `os.img`. 
- **Continuous Integration and Continuous Deployment**: The GitHub Actions workflow has been updated to allow seamless compilation at both stages and deployment of a single `os.img` directly to GitHub Releases.

### v1.2.0 (29.06.2026)
- Implemented a two-stage architecture (separation into Bootloader and Kernel space via int 0x13 interrupt).
- Added the CLEAR_SCREEN macro for hardware-based clearing of the text buffer.
- Implemented an interactive pause for input ("Press any key to continue...") before freezing the processor.

### v1.1.0 (26.06.2026)
- Added automatic video-mode reset (`int 0x10`) to purge hardware-specific SeaBIOS screen artifacts.
- Converted `build.sh` line endings to LF for perfect Linux and WSL cross-platform compatibility.
- Upgraded the `PRINT` macro to support custom 16-color hex palettes natively.
- Cleaned up root repository structure by isolating core logic into the `src/` directory.

### v1.0.0 (25.06.2026)
- Initial release of the core bootloader
- Added clean compile-time `PRINT` macro system
- Integrated bulletproof `cli` + `hlt` sleep stack
- Optimized sector padding up to 510 bytes
- Verified on real AMD Ryzen bare metal hardware.
