Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbeETL5j (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 07:57:39 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:46780 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeETL5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 07:57:35 -0400
X-Google-Smtp-Source: AB8JxZrLWs5KT11p+3wXE7jpzbB6M5WYDP8a2v4aoaux9Ogkb3dIWXMTzE0OgSZwLvE6VC44pj0r97S/vaCaLx/V6Vs=
MIME-Version: 1.0
In-Reply-To: <20180514162752.GG23049@pd.tnic>
References: <CAG=yYwmnHgAvauZLxfFcUEACF_J+qh4d2tvYY=AdjHvyeSFK_A@mail.gmail.com>
 <20180514162752.GG23049@pd.tnic>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sun, 20 May 2018 17:27:32 +0530
Message-ID: <CAG=yYwk-dbMF_7eS9bUraAru8b4fyCosxp+MpQA=1ZYH0nd_hg@mail.gmail.com>
Subject: Re: PROBLEM: mce: [Hardware Error] from dmesg -l emerg
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-edac@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

output for "dmesg | mcelog --ascii"  command related


--------------------------------------------------------------------------------------------------------------------------------------------------------------------->
microcode: microcode updated early to revision 0x2a, date = 2018-01-18
Linux version 4.17.0-rc5+ (root@debian) (gcc version 7.3.0 (Debian
7.3.0-19)) #31 SMP Sun May 20 16:45:54 IST 2018
Command line: BOOT_IMAGE=/boot/vmlinuz-4.17.0-rc5+
root=UUID=e78bf553-c8fd-42a0-b6f8-5876e86bc14e ro quiet
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Enabled xstate features 0x3, context size is 576 bytes, using
'standard' format.
e820: BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
BIOS-e820: [mem 0x0000000000059000-0x0000000000087fff] usable
BIOS-e820: [mem 0x0000000000088000-0x000000000009ffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x000000009bbddfff] usable
BIOS-e820: [mem 0x000000009bbde000-0x000000009bdddfff] type 20
BIOS-e820: [mem 0x000000009bdde000-0x000000009cc8dfff] reserved
BIOS-e820: [mem 0x000000009cc8e000-0x000000009cf8dfff] ACPI NVS
BIOS-e820: [mem 0x000000009cf8e000-0x000000009cffdfff] ACPI data
BIOS-e820: [mem 0x000000009cffe000-0x000000009cffefff] usable
BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
BIOS-e820: [mem 0x00000000feb00000-0x00000000feb03fff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] reserved
BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000ffa00000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000015effffff] usable
NX (Execute Disable) protection: active
efi: EFI v2.40 by INSYDE Corp.
efi:  SMBIOS=0x9be81000  ESRT=0x9bfa8218  ACPI 2.0=0x9cffd014
SMBIOS 2.8 present.
DMI: Hewlett-Packard HP Notebook/80C1, BIOS F.02 03/24/2015
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
e820: last_pfn = 0x15f000 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
00000-9FFFF write-back
A0000-BFFFF uncachable
C0000-E7FFF write-protect
E8000-EFFFF write-combining
F0000-FFFFF write-protect
MTRR variable ranges enabled:
0 base 0000000000 mask 7E00000000 write-back
1 base 009CFFF000 mask 7FFFFFF000 uncachable
2 base 009D000000 mask 7FFF000000 uncachable
3 base 009E000000 mask 7FFE000000 uncachable
4 base 00A0000000 mask 7FE0000000 uncachable
5 base 00C0000000 mask 7FC0000000 uncachable
6 disabled
7 disabled
8 disabled
9 disabled
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
e820: update [mem 0x9cfff000-0xffffffff] usable ==> reserved
e820: last_pfn = 0x9cfff max_arch_pfn = 0x400000000
esrt: Reserving ESRT space from 0x000000009bfa8218 to 0x000000009bfa8250.
Base memory trampoline at [        (ptrval)] 2e000 size 24576
Using GB pages for direct mapping
BRK [0x152473000, 0x152473fff] PGTABLE
BRK [0x152474000, 0x152474fff] PGTABLE
BRK [0x152475000, 0x152475fff] PGTABLE
BRK [0x152476000, 0x152476fff] PGTABLE
BRK [0x152477000, 0x152477fff] PGTABLE
BRK [0x152478000, 0x152478fff] PGTABLE
BRK [0x152479000, 0x152479fff] PGTABLE
BRK [0x15247a000, 0x15247afff] PGTABLE
Secure boot could not be determined
RAMDISK: [mem 0x32681000-0x35337fff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x000000009CFFD014 000024 (v02 HPQOEM)
ACPI: XSDT 0x000000009CFC5188 0000D4 (v01 HPQOEM SLIC-MPC 00000001
 01000013)
ACPI: FACP 0x000000009CFEA000 00010C (v05 HPQOEM SLIC-MPC 00000001 HP
 00040000)
ACPI: DSDT 0x000000009CFD5000 00F690 (v02 HPQOEM SLIC-MPC 00000000
ACPI 00040000)
ACPI: FACS 0x000000009CF86000 000040
ACPI: UEFI 0x000000009CFFC000 000236 (v01 HPQOEM INSYDE   00000001 HP
 00040000)
ACPI: UEFI 0x000000009CFFB000 000042 (v01 HPQOEM INSYDE   00000000 HP
 00040000)
ACPI: SSDT 0x000000009CFF4000 006647 (v01 HPQOEM INSYDE   00001000
ACPI 00040000)
ACPI: SSDT 0x000000009CFEF000 003AA0 (v02 HPQOEM INSYDE   00001000
ACPI 00040000)
ACPI: ASF! 0x000000009CFEE000 0000A5 (v32 HPQOEM INSYDE   00000001 HP
 00040000)
ACPI: ASPT 0x000000009CFED000 000034 (v07 HPQOEM INSYDE   00000001 HP
 00040000)
ACPI: BOOT 0x000000009CFEC000 000028 (v01 HPQOEM INSYDE   00000001 HP
 00040000)
ACPI: DBGP 0x000000009CFEB000 000034 (v01 HPQOEM SLIC-MPC 00000001 HP
 00040000)
ACPI: HPET 0x000000009CFE9000 000038 (v01 HPQOEM INSYDE   00000001 HP
 00040000)
ACPI: LPIT 0x000000009CFE8000 000094 (v01 HPQOEM INSYDE   00000000 HP
 00040000)
ACPI: APIC 0x000000009CFE7000 00008C (v03 HPQOEM SLIC-MPC 00000001 HP
 00040000)
ACPI: MCFG 0x000000009CFE6000 00003C (v01 HPQOEM INSYDE   00000001 HP
 00040000)
ACPI: WDAT 0x000000009CFE5000 000224 (v01 HPQOEM INSYDE   00000001 HP
 00040000)
ACPI: SSDT 0x000000009CFD1000 003003 (v02 HPQOEM INSYDE   00001000
ACPI 00040000)
ACPI: SSDT 0x000000009CFD0000 000C12 (v02 HPQOEM INSYDE   00001000
ACPI 00040000)
ACPI: SSDT 0x000000009CFCF000 000539 (v02 HPQOEM INSYDE   00003000
ACPI 00040000)
ACPI: SSDT 0x000000009CFCE000 000B74 (v02 HPQOEM INSYDE   00003000
ACPI 00040000)
ACPI: SSDT 0x000000009CFC8000 005FC2 (v02 HPQOEM INSYDE   00003000
ACPI 00040000)
ACPI: DMAR 0x000000009CFC7000 0000B0 (v01 HPQOEM INSYDE   00000001 HP
 00040000)
ACPI: FPDT 0x000000009CFC6000 000044 (v01 HPQOEM SLIC-MPC 00000002 HP
 00040000)
ACPI: BGRT 0x000000009CFC4000 000038 (v01 HPQOEM INSYDE   00000001 HP
 00040000)
ACPI: Local APIC address 0xfee00000
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x000000015effffff]
NODE_DATA(0) allocated [mem 0x15effb000-0x15effffff]
tsc: Fast TSC calibration using PIT
Zone ranges:
DMA      [mem 0x0000000000001000-0x0000000000ffffff]
DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Normal   [mem 0x0000000100000000-0x000000015effffff]
Device   empty
Movable zone start for each node
Early memory node ranges
node   0: [mem 0x0000000000001000-0x0000000000057fff]
node   0: [mem 0x0000000000059000-0x0000000000087fff]
node   0: [mem 0x0000000000100000-0x000000009bbddfff]
node   0: [mem 0x000000009cffe000-0x000000009cffefff]
node   0: [mem 0x0000000100000000-0x000000015effffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000015effffff]
On node 0 totalpages: 1026917
DMA zone: 64 pages used for memmap
DMA zone: 96 pages reserved
DMA zone: 3974 pages, LIFO batch:0
DMA32 zone: 9904 pages used for memmap
DMA32 zone: 633823 pages, LIFO batch:31
Normal zone: 6080 pages used for memmap
Normal zone: 389120 pages, LIFO batch:31
Reserved but unavailable: 100 pages
Reserving Intel graphics memory at [mem 0x9e000000-0x9fffffff]
ACPI: PM-Timer IO Port: 0x1808
ACPI: Local APIC address 0xfee00000
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
smpboot: Allowing 4 CPUs, 0 hotplug CPUs
PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
PM: Registered nosave memory: [mem 0x00088000-0x0009ffff]
PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
PM: Registered nosave memory: [mem 0x9bbde000-0x9bdddfff]
PM: Registered nosave memory: [mem 0x9bdde000-0x9cc8dfff]
PM: Registered nosave memory: [mem 0x9cc8e000-0x9cf8dfff]
PM: Registered nosave memory: [mem 0x9cf8e000-0x9cffdfff]
PM: Registered nosave memory: [mem 0x9cfff000-0x9dffffff]
PM: Registered nosave memory: [mem 0x9e000000-0x9fffffff]
PM: Registered nosave memory: [mem 0xa0000000-0xdfffffff]
PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
PM: Registered nosave memory: [mem 0xf0000000-0xfeafffff]
PM: Registered nosave memory: [mem 0xfeb00000-0xfeb03fff]
PM: Registered nosave memory: [mem 0xfeb04000-0xfebfffff]
PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
PM: Registered nosave memory: [mem 0xfec01000-0xfed0ffff]
PM: Registered nosave memory: [mem 0xfed10000-0xfed19fff]
PM: Registered nosave memory: [mem 0xfed1a000-0xfed1bfff]
PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
PM: Registered nosave memory: [mem 0xfee01000-0xff9fffff]
PM: Registered nosave memory: [mem 0xffa00000-0xffffffff]
e820: [mem 0xa0000000-0xdfffffff] available for PCI devices
Booting paravirtualized kernel on bare hardware
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 7645519600211568 ns
random: get_random_bytes called from start_kernel+0x94/0x4d3 with crng_init=0
setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
percpu: Embedded 44 pages/cpu @        (ptrval) s142040 r8192 d29992 u524288
pcpu-alloc: s142040 r8192 d29992 u524288 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3
Built 1 zonelists, mobility grouping on.  Total pages: 1010773
Policy zone: Normal
Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.17.0-rc5+
root=UUID=e78bf553-c8fd-42a0-b6f8-5876e86bc14e ro quiet
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Memory: 3719392K/4107668K available (10252K kernel code, 1267K rwdata,
3288K rodata, 1572K init, 668K bss, 388276K reserved, 0K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Kernel/User page tables isolation: enabled
ftrace: allocating 31320 entries in 123 pages
Hierarchical RCU implementation.
RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
NR_IRQS: 33024, nr_irqs: 728, preallocated irqs: 16
Console: colour dummy device 80x25
console [tty0] enabled
ACPI: Core revision 20180313
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 133484882848 ns
hpet clockevent registered
APIC: Switch to symmetric I/O mode setup
DMAR: Host address width 39
DMAR: DRHD base: 0x000000fed90000 flags: 0x0
DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 7e1ff0505e
DMAR: DRHD base: 0x000000fed91000 flags: 0x1
DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c20660462 ecap f010da
DMAR: RMRR base: 0x0000009cc63000 end: 0x0000009cc82fff
DMAR: RMRR base: 0x0000009d800000 end: 0x0000009fffffff
DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
DMAR-IR: HPET id 0 under DRHD base 0xfed91000
DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
DMAR-IR: Enabled IRQ remapping in xapic mode
x2apic: IRQ remapping doesn't support X2APIC mode
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
tsc: Fast TSC calibration using PIT
tsc: Detected 1895.623 MHz processor
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:
0x36a60aaf4fd, max_idle_ns: 881590650275 ns
Calibrating delay loop (skipped), value calculated using timer
frequency.. 3791.24 BogoMIPS (lpj=7582492)
pid_max: default: 32768 minimum: 301
Security Framework initialized
Yama: becoming mindful.
AppArmor: AppArmor initialized
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
mce: CPU supports 7 MCE banks
CPU0: Thermal monitoring enabled (TM1)
process: using mwait in idle threads
Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
Spectre V2 : Mitigation: Full generic retpoline
Spectre V2 : Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier
Spectre V2 : Enabling Restricted Speculation for firmware calls
Freeing SMP alternatives memory: 32K
Hardware event. This is not a software error.
CPU 0 BANK 0 TSC dead
STATUS 0 MCGSTATUS 0
line timer enabled
smpboot: CPU0: Intel(R) Pentium(R) CPU 3825U @ 1.90GHz (family: 0x6,
model: 0x3d, stepping: 0x4)
Machine check events logged
Hardware event. This is not a software error.
CPU 0 BANK 0
TIME 1526815774 Sun May 20 16:59:34 2018
MCG status:
MCi status:
Machine check not valid
Corrected error
MCA: No Error
STATUS 0 MCGSTATUS 0
CPUID Vendor Intel Family 6 Model 61
(Fields were incomplete)
SOCKET 0 APIC 0 microcode 2a
Performance Events: PEBS fmt2+, Broadwell events, 16-deep LBR,
full-width counters, Intel PMU driver.
... version:                3
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   3
... event mask:             000000070000000f
Hierarchical SRCU implementation.
NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1 #2 #3
smp: Brought up 1 node, 4 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 4 processors activated (15164.98 BogoMIPS)
devtmpfs: initialized
x86/mm: Memory block size: 128MB
PM: Registering ACPI NVS region [mem 0x9cc8e000-0x9cf8dfff] (3145728 bytes)
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 7645041785100000 ns
futex hash table entries: 1024 (order: 4, 65536 bytes)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1526815774.048:1): state=initialized
audit_enabled=0 res=1
cpuidle: using governor ladder
cpuidle: using governor menu
Simple Boot Flag at 0x44 set to 0x1
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
ACPI: bus type PCI registered
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
pmd_set_huge: Cannot satisfy [mem 0xe0000000-0xe0200000] with a
huge-page mapping due to MTRR override.
PCI: Using configuration type 1 for base access
HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Added _OSI(Linux-Dell-Video)
ACPI: 8 ACPI AML tables successfully acquired and loaded
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF987E99253000 0003D3 (v02 PmRef  Cpu0Cst  00003001
INTL 20130117)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF987E9915A000 0005AA (v02 PmRef  ApIst    00003000
INTL 20130117)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF987E992D2800 000119 (v02 PmRef  ApCst    00003000
INTL 20130117)
ACPI: EC: EC started
ACPI: EC: interrupt blocked
ACPI: \_SB_.PCI0.LPCB.EC0_: Used as first EC
ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0xa, EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: \_SB_.PCI0.LPCB.EC0_: Used as boot DSDT EC to handle transactions
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use
"pci=nocrs" and report a bug
ACPI: Enabled 8 GPEs in block 00 to 7F
ACPI: Power Resource [FN00] (off)
ACPI: Power Resource [FN01] (off)
ACPI: Power Resource [FN02] (off)
ACPI: Power Resource [FN03] (off)
ACPI: Power Resource [FN04] (off)
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xa0000000-0xfeafffff window]
pci_bus 0000:00: root bus resource [bus 00-fe]
pci 0000:00:00.0: [8086:1604] type 00 class 0x060000
pci 0000:00:02.0: [8086:1606] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xc0000000-0xc0ffffff 64bit]
pci 0000:00:02.0: reg 0x18: [mem 0xb0000000-0xbfffffff 64bit pref]
pci 0000:00:02.0: reg 0x20: [io  0x4000-0x403f]
pci 0000:00:02.0: BAR 2: assigned to efifb
pci 0000:00:03.0: [8086:160c] type 00 class 0x040300
pci 0000:00:03.0: reg 0x10: [mem 0xc1318000-0xc131bfff 64bit]
pci 0000:00:04.0: [8086:1603] type 00 class 0x118000
pci 0000:00:04.0: reg 0x10: [mem 0xc1310000-0xc1317fff 64bit]
pci 0000:00:14.0: [8086:9cb1] type 00 class 0x0c0330
pci 0000:00:14.0: reg 0x10: [mem 0xc1300000-0xc130ffff 64bit]
pci 0000:00:14.0: PME# supported from D3hot D3cold
pci 0000:00:16.0: [8086:9cba] type 00 class 0x078000
pci 0000:00:16.0: reg 0x10: [mem 0xc1321000-0xc132101f 64bit]
pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: [8086:9ca0] type 00 class 0x040300
pci 0000:00:1b.0: reg 0x10: [mem 0xc131c000-0xc131ffff 64bit]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: [8086:9c90] type 01 class 0x060400
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.2: [8086:9c94] type 01 class 0x060400
pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.5: [8086:9c9a] type 01 class 0x060400
pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.0: [8086:9ca6] type 00 class 0x0c0320
pci 0000:00:1d.0: reg 0x10: [mem 0xc1325000-0xc13253ff]
pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1f.0: [8086:9cc5] type 00 class 0x060100
pci 0000:00:1f.2: [8086:9c83] type 00 class 0x010601
pci 0000:00:1f.2: reg 0x10: [io  0x4088-0x408f]
pci 0000:00:1f.2: reg 0x14: [io  0x4094-0x4097]
pci 0000:00:1f.2: reg 0x18: [io  0x4080-0x4087]
pci 0000:00:1f.2: reg 0x1c: [io  0x4090-0x4093]
pci 0000:00:1f.2: reg 0x20: [io  0x4060-0x407f]
pci 0000:00:1f.2: reg 0x24: [mem 0xc1324000-0xc13247ff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.3: [8086:9ca2] type 00 class 0x0c0500
pci 0000:00:1f.3: reg 0x10: [mem 0xc1320000-0xc13200ff 64bit]
pci 0000:00:1f.3: reg 0x20: [io  0x4040-0x405f]
pci 0000:00:1f.6: [8086:9ca4] type 00 class 0x118000
pci 0000:00:1f.6: reg 0x10: [mem 0xc1323000-0xc1323fff 64bit]
pci 0000:00:1c.0: PCI bridge to [bus 01]
pci 0000:02:00.0: [10ec:8136] type 00 class 0x020000
pci 0000:02:00.0: reg 0x10: [io  0x3000-0x30ff]
pci 0000:02:00.0: reg 0x18: [mem 0xc1200000-0xc1200fff 64bit]
pci 0000:02:00.0: reg 0x20: [mem 0xc1000000-0xc1003fff 64bit pref]
pci 0000:02:00.0: supports D1 D2
pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:1c.2: PCI bridge to [bus 02]
pci 0000:00:1c.2:   bridge window [io  0x3000-0x3fff]
pci 0000:00:1c.2:   bridge window [mem 0xc1200000-0xc12fffff]
pci 0000:00:1c.2:   bridge window [mem 0xc1000000-0xc10fffff 64bit pref]
pci 0000:03:00.0: [14e4:4365] type 00 class 0x028000
pci 0000:03:00.0: reg 0x10: [mem 0xc1100000-0xc1107fff 64bit]
pci 0000:03:00.0: enabling Extended Tags
pci 0000:03:00.0: supports D1 D2
pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.5: PCI bridge to [bus 03]
pci 0000:00:1c.5:   bridge window [mem 0xc1100000-0xc11fffff]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *7
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *7
ACPI: EC: interrupt unblocked
ACPI: EC: event unblocked
ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0xa, EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: \_SB_.PCI0.LPCB.EC0_: Used as boot DSDT EC to handle
transactions and events
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
pci 0000:00:02.0: vgaarb: bridge control possible
vgaarb: loaded
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
<giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
Registered efivars operations
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
e820: reserve RAM buffer [mem 0x00088000-0x0008ffff]
e820: reserve RAM buffer [mem 0x9bbde000-0x9bffffff]
e820: reserve RAM buffer [mem 0x9cfff000-0x9fffffff]
e820: reserve RAM buffer [mem 0x15f000000-0x15fffffff]
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 14.318180 MHz counter
clocksource: Switched to clocksource tsc-early
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
AppArmor: AppArmor Filesystem Enabled
pnp: PnP ACPI init
system 00:00: [io  0x0680-0x069f] has been reserved
system 00:00: [io  0xfd60-0xfd63] has been reserved
system 00:00: [io  0xffff] has been reserved
system 00:00: [io  0xffff] has been reserved
system 00:00: [io  0xffff] has been reserved
system 00:00: [io  0x1800-0x18fe] has been reserved
system 00:00: [io  0x164e-0x164f] has been reserved
system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
system 00:02: [io  0x1854-0x1857] has been reserved
system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
pnp 00:04: Plug and Play ACPI device, IDs SYN1efb SYN1e00 SYN0002
PNP0f13 (active)
system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:06: [mem 0xfed90000-0xfed93fff] could not be reserved
system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
system 00:06: [mem 0xff000000-0xff000fff] has been reserved
system 00:06: [mem 0xff010000-0xffffffff] could not be reserved
system 00:06: [mem 0xfee00000-0xfeefffff] could not be reserved
system 00:06: [mem 0xa0010000-0xa001ffff] has been reserved
system 00:06: [mem 0xa0000000-0xa000ffff] has been reserved
system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp: PnP ACPI: found 7 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,
max_idle_ns: 2085701024 ns
pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref]
to [bus 01] add_size 200000 add_align 100000
pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus
01] add_size 200000 add_align 100000
pci 0000:00:1c.0: BAR 14: assigned [mem 0xa0100000-0xa02fffff]
pci 0000:00:1c.0: BAR 15: assigned [mem 0xa0300000-0xa04fffff 64bit pref]
pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
pci 0000:00:1c.0: PCI bridge to [bus 01]
pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
pci 0000:00:1c.0:   bridge window [mem 0xa0100000-0xa02fffff]
pci 0000:00:1c.0:   bridge window [mem 0xa0300000-0xa04fffff 64bit pref]
pci 0000:00:1c.2: PCI bridge to [bus 02]
pci 0000:00:1c.2:   bridge window [io  0x3000-0x3fff]
pci 0000:00:1c.2:   bridge window [mem 0xc1200000-0xc12fffff]
pci 0000:00:1c.2:   bridge window [mem 0xc1000000-0xc10fffff 64bit pref]
pci 0000:00:1c.5: PCI bridge to [bus 03]
pci 0000:00:1c.5:   bridge window [mem 0xc1100000-0xc11fffff]
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xa0000000-0xfeafffff window]
pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
pci_bus 0000:01: resource 1 [mem 0xa0100000-0xa02fffff]
pci_bus 0000:01: resource 2 [mem 0xa0300000-0xa04fffff 64bit pref]
pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
pci_bus 0000:02: resource 1 [mem 0xc1200000-0xc12fffff]
pci_bus 0000:02: resource 2 [mem 0xc1000000-0xc10fffff 64bit pref]
pci_bus 0000:03: resource 1 [mem 0xc1100000-0xc11fffff]
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
UDP hash table entries: 2048 (order: 4, 65536 bytes)
UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
NET: Registered protocol family 1
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:14.0: can't derive routing for PCI INT A
pci 0000:00:14.0: PCI INT A: no GSI
pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x6b0 took 18428 usecs
PCI: CLS 64 bytes, default 64
Unpacking initramfs...
Freeing initrd memory: 45788K
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB [mem 0x8f15b000-0x9315b000] (64MB) mapped at [
(ptrval)-        (ptrval)]
Initialise system trusted keyrings
workingset: timestamp_bits=40 max_order=20 bucket_order=0
zbud: loaded
pstore: using deflate compression
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
io scheduler mq-deadline registered
test_firmware: interface ready
efifb: probing for efifb
efifb: framebuffer at 0xb0000000, using 4160k, total 4160k
efifb: mode is 1366x768x32, linelength=5504, pages=1
efifb: scrolling: redraw
efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 170x48
fb0: EFI VGA frame buffer device
intel_idle: MWAIT substates: 0x11142120
intel_idle: v0.4.1 model 0x3D
intel_idle: lapic_timer_reliable_states 0xffffffff
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Linux agpgart interface v0.103
AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
AMD IOMMUv2 functionality not available on this system
i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mousedev: PS/2 mouse device common for all mice
rtc_cmos 00:01: RTC can wake from S4
rtc_cmos 00:01: registered as rtc0
rtc_cmos 00:01: alarms up to one month, 242 bytes nvram, hpet irqs
intel_pstate: Intel P-state driver initializing
ledtrig-cpu: registered to indicate activity on CPUs
NET: Registered protocol family 10
Segment Routing with IPv6
mip6: Mobile IPv6
NET: Registered protocol family 17
mpls_gso: MPLS GSO support
microcode: sig=0x306d4, pf=0x40, revision=0x2a
microcode: Microcode Update Driver: v2.2.
sched_clock: Marking stable (1580748597, 0)->(3167933312, -1587184715)
registered taskstats version 1
Loading compiled-in X.509 certificates
zswap: loaded using pool lzo/zbud
AppArmor: AppArmor sha1 policy hashing enabled
ima: No TPM chip found, activating TPM-bypass! (rc=-19)
ima: Allocated hash algorithm: sha256
rtc_cmos 00:01: setting system clock to 2018-05-20 11:29:37 UTC (1526815777)
input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
Freeing unused kernel memory: 1572K
Write protecting the kernel read-only data: 16384k
Freeing unused kernel memory: 2008K
Freeing unused kernel memory: 808K
x86/mm: Checked W+X mappings: passed, no W+X pages found.
x86/mm: Checking user space page tables
x86/mm: Checked W+X mappings: passed, no W+X pages found.
hidraw: raw HID events driver (C) Jiri Kosina
ACPI BIOS Error (bug): Failure looking up [\_SB.PCI0.LPCB.HEC.ECWT],
AE_NOT_FOUND (20180313/psargs-330)
ACPI Error: Method parse/execution failed \_TZ.FN00._ON, AE_NOT_FOUND
(20180313/psparse-516)
acpi PNP0C0B:00: Failed to change power state to D0
ACPI BIOS Error (bug): Failure looking up [\_SB.PCI0.LPCB.HEC.ECWT],
AE_NOT_FOUND (20180313/psargs-330)
ACPI Error: Method parse/execution failed \_TZ.FN00._ON, AE_NOT_FOUND
(20180313/psparse-516)
ACPI BIOS Error (bug): Failure looking up [\_SB.PCI0.LPCB.HEC.ECRD],
AE_NOT_FOUND (20180313/psargs-330)
ACPI Error: Method parse/execution failed \_TZ.TZ00._TMP, AE_NOT_FOUND
(20180313/psparse-516)
acpi PNP0C0B:00: Failed to set initial power state
acpi PNP0C0B:00: Cannot transition from (unknown) to D3hot
ACPI BIOS Error (bug): Failure looking up [\_SB.PCI0.LPCB.HEC.ECRD],
AE_NOT_FOUND (20180313/psargs-330)
ACPI Error: Method parse/execution failed \_TZ.TZ00._TMP, AE_NOT_FOUND
(20180313/psparse-516)
ACPI BIOS Error (bug): Failure looking up [\_SB.PCI0.LPCB.HEC.ECRD],
AE_NOT_FOUND (20180313/psargs-330)
ACPI Error: Method parse/execution failed \_TZ.TZ01._TMP, AE_NOT_FOUND
(20180313/psparse-516)
ACPI BIOS Error (bug): Failure looking up [\_SB.PCI0.LPCB.HEC.ECRD],
AE_NOT_FOUND (20180313/psargs-330)
ACPI Error: Method parse/execution failed \_TZ.TZ01._TMP, AE_NOT_FOUND
(20180313/psparse-516)
thermal LNXTHERM:02: registered as thermal_zone0
ACPI: Thermal Zone [TZ02] (28 C)
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
r8169 0000:02:00.0 eth0: RTL8106e at 0x        (ptrval),
48:0f:cf:df:14:80, XID 04900000 IRQ 42
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i801_smbus 0000:00:1f.3: SPD Write Disable is set
i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
SCSI subsystem initialized
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-pci 0000:00:1d.0: EHCI Host Controller
ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:1d.0: debug port 2
libata version 3.00 loaded.
ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
ehci-pci 0000:00:1d.0: irq 23, io mem 0xc1325000
ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.17
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 4.17.0-rc5+ ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
xhci_hcd 0000:00:14.0: can't derive routing for PCI INT A
xhci_hcd 0000:00:14.0: PCI INT A: no GSI
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0004b810
xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.17
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: xHCI Host Controller
usb usb2: Manufacturer: Linux 4.17.0-rc5+ xhci-hcd
usb usb2: SerialNumber: 0000:00:14.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 11 ports detected
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
xhci_hcd 0000:00:14.0: Host supports USB 3.0  SuperSpeed
usb usb3: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.17
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: xHCI Host Controller
usb usb3: Manufacturer: Linux 4.17.0-rc5+ xhci-hcd
usb usb3: SerialNumber: 0000:00:14.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo only pio slum part deso
sadm sds apst
scsi host0: ahci
scsi host1: ahci
ata1: SATA max UDMA/133 abar m2048@0xc1324000 port 0xc1324100 irq 44
ata2: SATA max UDMA/133 abar m2048@0xc1324000 port 0xc1324180 irq 44
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: TOSHIBA MQ01ABF050, AM0P2C, max UDMA/100
ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata2.00: ATAPI: hp       DVDRW  GUB0N, UB00, max UDMA/133
ata1.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MQ01ABF0 2C   PQ: 0 ANSI: 5
ata2.00: configured for UDMA/133
usb 1-1: new high-speed USB device number 2 using ehci-pci
usb 2-4: new full-speed USB device number 2 using xhci_hcd
scsi 1:0:0:0: CD-ROM            hp       DVDRW  GUB0N     UB00 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
sd 0:0:0:0: [sda] 4096-byte physical blocks
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
tsc: Refined TSC clocksource calibration: 1895.611 MHz
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a5f415104,
max_idle_ns: 881590682539 ns
clocksource: Switched to clocksource tsc
sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw
xa/form2 cdda tray
cdrom: Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sda: sda1 sda2 sda3 sda4 sda5
sd 0:0:0:0: [sda] Attached SCSI disk
usb 2-4: New USB device found, idVendor=0a5c, idProduct=216d, bcdDevice= 1.12
usb 2-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-4: Product: BCM43142A0
usb 2-4: Manufacturer: Broadcom Corp
usb 2-4: SerialNumber: D85DE2C6DEC4
usb 1-1: New USB device found, idVendor=8087, idProduct=8001, bcdDevice= 0.03
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 8 ports detected
usb 2-5: new high-speed USB device number 3 using xhci_hcd
random: fast init done
psmouse serio1: synaptics: queried max coordinates: x [..5652], y [..4846]
psmouse serio1: synaptics: queried min coordinates: x [1330..], y [1094..]
psmouse serio1: synaptics: The touchpad can support a better bus than
the too old PS/2 protocol. Make sure MOUSE_PS2_SYNAPTICS_SMBUS and
RMI4_SMB are enabled to get a better touchpad experience.
psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1,
caps: 0xf00123/0x840300/0x2e800/0x0, board id: 3127, fw id: 8526786
usb 2-5: New USB device found, idVendor=064e, idProduct=930b, bcdDevice= 1.01
usb 2-5: New USB device strings: Mfr=3, Product=1, SerialNumber=2
usb 2-5: Product: HP Truevision HD
usb 2-5: Manufacturer: SuYin
usb 2-5: SerialNumber: HF1026-T841-HN01-1-REV0101
input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input2
PM: Image not found (code -22)
EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
random: crng init done
systemd[1]: systemd 238 running in system mode. (+PAM +AUDIT +SELINUX
+IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS
+ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2
default-hierarchy=hybrid)
systemd[1]: Detected architecture x86-64.
systemd[1]: Set hostname to <debian>.
systemd[1]: Listening on udev Kernel Socket.
systemd[1]: Created slice User and Session Slice.
systemd[1]: Reached target Slices.
systemd[1]: Listening on Journal Socket (/dev/log).
systemd[1]: Created slice system-getty.slice.
systemd[1]: Reached target User and Group Name Lookups.
systemd[1]: Listening on udev Control Socket.
lp: driver loaded but no devices found
ppdev: user-space parallel port driver
EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
loop: module loaded
systemd-journald[207]: Received request to flush runtime journal from PID 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:18/PNP0C0D:00/input/input3
ACPI: Lid Switch [LID0]
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input4
ACPI: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
ACPI: Power Button [PWRF]
input: HP Wireless hotkeys as /devices/virtual/input/input6
ACPI: AC Adapter [ACAD] (on-line)
wmi_bus wmi_bus-PNP0C14:00: WQBJ data block query control method not found
[Firmware Bug]: battery: (dis)charge rate invalid.
ACPI: Battery Slot [BAT1] (battery present)
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:0:0: Attached scsi generic sg1 type 5
EFI Variables Facility v0.08 2004-May-17
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pstore: Registered efi as persistent store backend
input: PC Speaker as /devices/platform/pcspkr/input/input7
RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
RAPL PMU: hw unit of domain package 2^-14 Joules
RAPL PMU: hw unit of domain dram 2^-14 Joules
RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
cfg80211: Loading compiled-in X.509 certificates for regulatory database
cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
platform regulatory.0: Direct firmware load for regulatory.db failed
with error -2
cfg80211: failed to load regulatory.db
media: Linux media interface: v0.10
snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3227: line_outs=1
(0x14/0x0/0x0/0x0/0x0) type:speaker
snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
snd_hda_codec_realtek hdaudioC1D0:    inputs:
snd_hda_codec_realtek hdaudioC1D0:      Mic=0x19
snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card1/input8
input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input9
input: HDA Intel PCH Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input10
Linux video capture interface: v2.00
cryptd: max_cpu_qlen set to 1000
wl: loading out-of-tree module taints kernel.
wl: module license 'MIXED/Proprietary' taints kernel.
Disabling lock debugging due to kernel taint
wlan0: Broadcom BCM4365 802.11 Hybrid Wireless Controller 6.30.223.271 (r587334)
Bluetooth: Core ver 2.22
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
uvcvideo: Found UVC 1.00 device HP Truevision HD (064e:930b)
uvcvideo 2-5:1.0: Entity type for entity Extension 4 was not initialized!
uvcvideo 2-5:1.0: Entity type for entity Processing 2 was not initialized!
uvcvideo 2-5:1.0: Entity type for entity Camera 1 was not initialized!
input: HP Truevision HD: HP Truevision as
/devices/pci0000:00/0000:00:14.0/usb2/2-5/2-5:1.0/input/input11
usbcore: registered new interface driver uvcvideo
USB Video Class driver (1.1.1)
iTCO_vendor_support: vendor-support=0
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
iTCO_wdt: Found a Wildcat Point_LP TCO device (Version=2, TCOBASE=0x1860)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
hp_wmi: query 0xd returned error 0x5
input: HP WMI hotkeys as /devices/virtual/input/input12
checking generic (b0000000 410000) vs hw (b0000000 10000000)
fb: switching to inteldrmfb from EFI VGA
Console: switching to colour dummy device 80x25
[drm] Replacing VGA console driver
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
i915 0000:00:02.0: vgaarb: changed VGA decodes:
olddecodes=io+mem,decodes=io+mem:owns=io+mem
usbcore: registered new interface driver btusb
[drm] Initialized i915 1.6.0 20180308 for 0000:00:02.0 on minor 0
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input13
snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
Bluetooth: hci0: BCM: chip id 70
Bluetooth: hci0: BCM: features 0x06
fbcon: inteldrmfb (fb0) is primary device
Bluetooth: hci0: debian-0
Bluetooth: hci0: BCM (001.001.011) build 0000
bluetooth hci0: Direct firmware load for brcm/BCM.hcd failed with error -2
Bluetooth: hci0: BCM: Patch brcm/BCM.hcd not found
intel_rapl: Found RAPL domain package
intel_rapl: Found RAPL domain core
intel_rapl: Found RAPL domain uncore
intel_rapl: Found RAPL domain dram
intel_rapl: RAPL package 0 domain package locked by BIOS
intel_rapl: RAPL package 0 domain dram locked by BIOS
wl 0000:03:00.0 wlp3s0: renamed from wlan0
Console: switching to colour frame buffer device 170x48
i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
input: HDA Intel HDMI HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input14
input: HDA Intel HDMI HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input15
input: HDA Intel HDMI HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input16
input: HDA Intel HDMI HDMI/DP,pcm=9 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input17
input: HDA Intel HDMI HDMI/DP,pcm=10 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input18
Bluetooth: hci0: command 0x1003 tx timeout
Adding 4107260k swap on /dev/sda3.  Priority:-2 extents:1 across:4107260k FS
audit: type=1400 audit(1526815799.521:2): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="/usr/bin/man"
pid=596 comm="apparmor_parser"
audit: type=1400 audit(1526815799.521:3): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="man_filter"
pid=596 comm="apparmor_parser"
audit: type=1400 audit(1526815799.521:4): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="man_groff" pid=596
comm="apparmor_parser"
audit: type=1400 audit(1526815799.561:5): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="libreoffice-oopslash" pid=598 comm="apparmor_parser"
audit: type=1400 audit(1526815799.645:6): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="libreoffice-senddoc" pid=599 comm="apparmor_parser"
audit: type=1400 audit(1526815799.669:7): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="libreoffice-xpdfimport" pid=605 comm="apparmor_parser"
audit: type=1400 audit(1526815800.217:8): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="/usr/lib/cups/backend/cups-pdf" pid=609 comm="apparmor_parser"
audit: type=1400 audit(1526815800.221:9): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="/usr/sbin/cupsd"
pid=609 comm="apparmor_parser"
audit: type=1400 audit(1526815800.221:10): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="/usr/sbin/cupsd//third_party" pid=609 comm="apparmor_parser"
audit: type=1400 audit(1526815800.729:11): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="/usr/lib/telepathy/mission-control-5" pid=607
comm="apparmor_parser"
r8169 0000:02:00.0 eth0: link down
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
r8169 0000:02:00.0 eth0: link up
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Bluetooth: hci0: command 0x1003 tx timeout
IPv6: ADDRCONF(NETDEV_UP): wlp3s0: link is not ready
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11
fuse init (API version 7.26)
rfkill: input handler disabled
r8169 0000:02:00.0 eth0: link down
r8169 0000:02:00.0 eth0: link up

---------------------------------------------------------------------------------------------------------------------------------------------------------------->




On Mon, May 14, 2018 at 9:57 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, May 14, 2018 at 09:19:11PM +0530, Jeffrin Thalakkottoor wrote:
>> hello,
>>
>> output related of  "sudo dmesg -l emerg" from my laptop...
>>
>> --------------------------------------------------------------------------------------------------->
>> $sudo dmesg -l emerg
>> [sudo] password for jeffrin:
>> [    0.041023] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 5:
>> ee0000000040110b
>> [    0.041028] mce: [Hardware Error]: TSC 0 ADDR 160000080 MISC 5040008086
>> [    0.041034] mce: [Hardware Error]: PROCESSOR 0:306d4 TIME
>> 1526300792 SOCKET 0 APIC 0 microcode 2a
>
> Run it through mcelog to see what it decodes to:
>
> dmesg | mcelog --ascii
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.



-- 
software engineer
rajagiri school of engineering and technology
