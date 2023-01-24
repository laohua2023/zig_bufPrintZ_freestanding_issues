
zig build elf

"d:\Program Files\qemu\qemu-system-riscv64.exe" -nographic -machine virt -bios none -m 800M -kernel ".\zig-out\bin\out.elf"
