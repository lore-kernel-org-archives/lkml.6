Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDSLFe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 07:05:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:25299 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752590AbeDSLFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 07:05:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,468,1517904000";
   d="scan'208";a="43081212"
Date: Thu, 19 Apr 2018 19:05:05 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Ben Widawsky <ben@bwidawsk.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lkp@01.org
Subject: Re: [i915] WARNING: CPU: 2 PID: 183 at
 drivers/gpu/drm/i915/intel_display.c:14584 intel_modeset_init+0x3be/0x1060
Message-ID: <20180419110505.wy47nheshalanxek@wfg-t540p.sh.intel.com>
References: <20180419025256.vtt37aljreb2wzrj@wfg-t540p.sh.intel.com>
 <0427eb0b-0382-db2c-72c5-0cbc867d4370@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="j4a75sbkumscrd46"
Content-Disposition: inline
In-Reply-To: <0427eb0b-0382-db2c-72c5-0cbc867d4370@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j4a75sbkumscrd46
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Maarten,

>What extra dmesg output do you get when you boot with drm.debug=0x1f ?

Attached is the dmesg with drm.debug=0x1f.

Thanks,
Fengguang

--j4a75sbkumscrd46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kmsg
Content-Transfer-Encoding: quoted-printable

kern  :notice: [    0.000000] Linux version 4.17.0-rc1 (kbuild@lkp-ib04) (g=
cc version 7.3.0 (Debian 7.3.0-1)) #1 SMP Mon Apr 16 12:27:23 CST 2018
kern  :info  : [    0.000000] Command line: ip=3D::::lkp-u410::dhcp root=3D=
/dev/ram0 user=3Dlkp job=3D/lkp/scheduled/lkp-u410/netperf-ipv4-300s-200%-c=
s-localhost-SCTP_STREAM-performance-debian-x86_64-2016-08-31.cgz-60cc43fc88=
8428bb2f18f08997432d426a243338-20180419-37334-dtcoce-0.yaml ARCH=3Dx86_64 k=
config=3Dx86_64-rhel-7.2 branch=3Dinternal-devel/devel-hourly-2018041612-in=
ternal commit=3D60cc43fc888428bb2f18f08997432d426a243338 BOOT_IMAGE=3D/pkg/=
linux/x86_64-rhel-7.2/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmlinu=
z-4.17.0-rc1 drm.debug=3D0x1f max_uptime=3D1500 RESULT_ROOT=3D/result/netpe=
rf/ipv4-300s-200%-cs-localhost-SCTP_STREAM-performance/lkp-u410/debian-x86_=
64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/60cc43fc888428bb2f18f08997432d426a2=
43338/4 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabled rcupdate.r=
cu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 s=
oftlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prom=
pt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_loglevel=
 console=3Dtty0 early
kern  :info  : [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87=
 floating point registers'
kern  :info  : [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE=
 registers'
kern  :info  : [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX=
 registers'
kern  :info  : [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes=
[2]:  256
kern  :info  : [    0.000000] x86/fpu: Enabled xstate features 0x7, context=
 size is 832 bytes, using 'standard' format.
kern  :info  : [    0.000000] e820: BIOS-provided physical RAM map:
kern  :info  : [    0.000000] BIOS-e820: [mem 0x0000000000000100-0x00000000=
0009d7ff] usable
kern  :info  : [    0.000000] BIOS-e820: [mem 0x000000000009d800-0x00000000=
0009ffff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000=
000fffff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000=
1fffffff] usable
kern  :info  : [    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000=
201fffff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x0000000020200000-0x00000000=
40003fff] usable
kern  :info  : [    0.000000] BIOS-e820: [mem 0x0000000040004000-0x00000000=
40004fff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x0000000040005000-0x00000000=
c5d2cfff] usable
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000c5d2d000-0x00000000=
c5f2efff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000c5f2f000-0x00000000=
d8382fff] usable
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000d8383000-0x00000000=
daeeefff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000daeef000-0x00000000=
daf9efff] ACPI NVS
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000daf9f000-0x00000000=
daffefff] ACPI data
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000dafff000-0x00000000=
daffffff] usable
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000db000000-0x00000000=
df9fffff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000=
fbffffff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000=
fec00fff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000=
fed08fff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000=
fed19fff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000=
fed1ffff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000=
fee00fff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x00000000ff980000-0x00000000=
ffffffff] reserved
kern  :info  : [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000001=
1f5fffff] usable
kern  :info  : [    0.000000] debug: ignoring loglevel setting.
kern  :info  : [    0.000000] bootconsole [earlyser0] enabled
kern  :info  : [    0.000000] NX (Execute Disable) protection: active
kern  :notice: [    0.000000] random: fast init done
kern  :info  : [    0.000000] SMBIOS 2.7 present.
kern  :info  : [    0.000000] DMI: LENOVO IdeaPad U410    /Lenovo          =
, BIOS 65CN15WW 06/05/2012
kern  :debug : [    0.000000] e820: update [mem 0x00000000-0x00000fff] usab=
le =3D=3D> reserved
kern  :debug : [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usab=
le
kern  :info  : [    0.000000] e820: last_pfn =3D 0x11f600 max_arch_pfn =3D =
0x400000000
kern  :debug : [    0.000000] MTRR default type: uncachable
kern  :debug : [    0.000000] MTRR fixed ranges enabled:
kern  :debug : [    0.000000]   00000-9FFFF write-back
kern  :debug : [    0.000000]   A0000-BFFFF uncachable
kern  :debug : [    0.000000]   C0000-FFFFF write-protect
kern  :debug : [    0.000000] MTRR variable ranges enabled:
kern  :debug : [    0.000000]   0 base 0FF800000 mask FFF800000 write-prote=
ct
kern  :debug : [    0.000000]   1 base 000000000 mask F80000000 write-back
kern  :debug : [    0.000000]   2 base 080000000 mask FC0000000 write-back
kern  :debug : [    0.000000]   3 base 0C0000000 mask FE0000000 write-back
kern  :debug : [    0.000000]   4 base 0DC000000 mask FFC000000 uncachable
kern  :debug : [    0.000000]   5 base 0DB000000 mask FFF000000 uncachable
kern  :debug : [    0.000000]   6 base 100000000 mask FE0000000 write-back
kern  :debug : [    0.000000]   7 base 11F800000 mask FFF800000 uncachable
kern  :debug : [    0.000000]   8 base 11F600000 mask FFFE00000 uncachable
kern  :debug : [    0.000000]   9 disabled
kern  :info  : [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC =
 WB  WP  UC- WT =20
kern  :info  : [    0.000000] e820: last_pfn =3D 0xdb000 max_arch_pfn =3D 0=
x400000000
kern  :warn  : [    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
kern  :warn  : [    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
kern  :warn  : [    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
kern  :info  : [    0.000000] found SMP MP-table at [mem 0x000f0130-0x000f0=
13f] mapped at [        (ptrval)]
kern  :warn  : [    0.000000]   mpc: fa9c0-fac7c
kern  :debug : [    0.000000] Base memory trampoline at [        (ptrval)] =
96000 size 24576
kern  :debug : [    0.000000] BRK [0x11ef4b000, 0x11ef4bfff] PGTABLE
kern  :debug : [    0.000000] BRK [0x11ef4c000, 0x11ef4cfff] PGTABLE
kern  :debug : [    0.000000] BRK [0x11ef4d000, 0x11ef4dfff] PGTABLE
kern  :debug : [    0.000000] BRK [0x11ef4e000, 0x11ef4efff] PGTABLE
kern  :debug : [    0.000000] BRK [0x11ef4f000, 0x11ef4ffff] PGTABLE
kern  :debug : [    0.000000] BRK [0x11ef50000, 0x11ef50fff] PGTABLE
kern  :info  : [    0.000000] RAMDISK: [mem 0x10898a000-0x11cffffff]
kern  :info  : [    0.000000] ACPI: Early table checksum verification disab=
led
kern  :info  : [    0.000000] ACPI: RSDP 0x00000000000F0150 000024 (v02 LEN=
OVO)
kern  :info  : [    0.000000] ACPI: XSDT 0x00000000DAFFE170 00009C (v01 LEN=
OVO CB-01    06040000  LTP 00000000)
kern  :info  : [    0.000000] ACPI: FACP 0x00000000DAFEE000 0000F4 (v03 LEN=
OVO CB-01    06040000  LTP 00000000)
kern  :info  : [    0.000000] ACPI: DSDT 0x00000000DAFF1000 00AD64 (v02 LEN=
OVO IVB-CPT  00000000 INTL 20061109)
kern  :info  : [    0.000000] ACPI: FACS 0x00000000DAF78000 000040
kern  :info  : [    0.000000] ACPI: FACS 0x00000000DAF78000 000040
kern  :info  : [    0.000000] ACPI: SLIC 0x00000000DAFFD000 000176 (v01 LEN=
OVO CB-01    06040000  LTP 00000000)
kern  :info  : [    0.000000] ACPI: SSDT 0x00000000DAFFC000 00052F (v01 LEN=
OVO PtidDevc 00001000 INTL 20061109)
kern  :info  : [    0.000000] ACPI: ASF! 0x00000000DAFF0000 0000A5 (v32 LEN=
OVO CB-01    06040000  LTP 00000000)
kern  :info  : [    0.000000] ACPI: HPET 0x00000000DAFED000 000038 (v01 LEN=
OVO CB-01    06040000  LTP 00000000)
kern  :info  : [    0.000000] ACPI: APIC 0x00000000DAFEC000 000098 (v01 LEN=
OVO CB-01    06040000  LTP 00000000)
kern  :info  : [    0.000000] ACPI: MCFG 0x00000000DAFEB000 00003C (v01 LEN=
OVO CB-01    06040000  LTP 00000000)
kern  :info  : [    0.000000] ACPI: FPDT 0x00000000DAFEA000 000064 (v01 LEN=
OVO CB-01    06040000  LTP 00000000)
kern  :info  : [    0.000000] ACPI: SSDT 0x00000000DAFE9000 0008A2 (v01 PmR=
ef  Cpu0Ist  00003000 INTL 20061109)
kern  :info  : [    0.000000] ACPI: SSDT 0x00000000DAFE8000 000A92 (v01 PmR=
ef  CpuPm    00003000 INTL 20061109)
kern  :info  : [    0.000000] ACPI: UEFI 0x00000000DAFE7000 00003E (v01 LEN=
OVO CB-01    06040000  LTP 00000000)
kern  :info  : [    0.000000] ACPI: UEFI 0x00000000DAFE6000 000042 (v01 PTL=
    COMBUF   00000001 PTL  00000001)
kern  :info  : [    0.000000] ACPI: POAT 0x00000000DAFE5000 000055 (v03 LEN=
OVO CB-01    06040000  LTP 00000000)
kern  :info  : [    0.000000] ACPI: UEFI 0x00000000DAFE4000 0002E2 (v01 LEN=
OVO CB-01    06040000  LTP 00000000)
kern  :info  : [    0.000000] ACPI: SSDT 0x00000000DAFE3000 000390 (v01 LEN=
OVO AoacTabl 00001000 INTL 20061109)
kern  :debug : [    0.000000] ACPI: Local APIC address 0xfee00000
kern  :warn  : [    0.000000] mapped APIC to ffffffffff5fc000 (        fee0=
0000)
kern  :info  : [    0.000000] No NUMA configuration found
kern  :info  : [    0.000000] Faking a node at [mem 0x0000000000000000-0x00=
0000011f5fffff]
kern  :info  : [    0.000000] NODE_DATA(0) allocated [mem 0x11f5cf000-0x11f=
5f9fff]
kern  :info  : [    0.000000] cma: Reserved 200 MiB at 0x00000000cb800000
kern  :info  : [    0.000000] tsc: Fast TSC calibration using PIT
kern  :info  : [    0.000000] Zone ranges:
kern  :info  : [    0.000000]   DMA      [mem 0x0000000000001000-0x00000000=
00ffffff]
kern  :info  : [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000=
ffffffff]
kern  :info  : [    0.000000]   Normal   [mem 0x0000000100000000-0x00000001=
1f5fffff]
kern  :info  : [    0.000000]   Device   empty
kern  :info  : [    0.000000] Movable zone start for each node
kern  :info  : [    0.000000] Early memory node ranges
kern  :info  : [    0.000000]   node   0: [mem 0x0000000000001000-0x0000000=
00009cfff]
kern  :info  : [    0.000000]   node   0: [mem 0x0000000000100000-0x0000000=
01fffffff]
kern  :info  : [    0.000000]   node   0: [mem 0x0000000020200000-0x0000000=
040003fff]
kern  :info  : [    0.000000]   node   0: [mem 0x0000000040005000-0x0000000=
0c5d2cfff]
kern  :info  : [    0.000000]   node   0: [mem 0x00000000c5f2f000-0x0000000=
0d8382fff]
kern  :info  : [    0.000000]   node   0: [mem 0x00000000dafff000-0x0000000=
0daffffff]
kern  :info  : [    0.000000]   node   0: [mem 0x0000000100000000-0x0000000=
11f5fffff]
kern  :info  : [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-=
0x000000011f5fffff]
kern  :debug : [    0.000000] On node 0 totalpages: 1013021
kern  :debug : [    0.000000]   DMA zone: 64 pages used for memmap
kern  :debug : [    0.000000]   DMA zone: 22 pages reserved
kern  :debug : [    0.000000]   DMA zone: 3996 pages, LIFO batch:0
kern  :debug : [    0.000000]   DMA32 zone: 13759 pages used for memmap
kern  :debug : [    0.000000]   DMA32 zone: 880513 pages, LIFO batch:31
kern  :debug : [    0.000000]   Normal zone: 2008 pages used for memmap
kern  :debug : [    0.000000]   Normal zone: 128512 pages, LIFO batch:31
kern  :info  : [    0.000000] Reserved but unavailable: 100 pages
kern  :info  : [    0.000000] Reserving Intel graphics memory at [mem 0xdba=
00000-0xdf9fffff]
kern  :info  : [    0.000000] ACPI: PM-Timer IO Port: 0x408
kern  :debug : [    0.000000] ACPI: Local APIC address 0xfee00000
kern  :info  : [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint=
[0x1])
kern  :info  : [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint=
[0x1])
kern  :info  : [    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xf=
ec00000, GSI 0-23
kern  :info  : [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq=
 2 dfl dfl)
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, A=
PIC ID 2, APIC INT 02
kern  :info  : [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq=
 9 high level)
kern  :warn  : [    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, A=
PIC ID 2, APIC INT 09
kern  :debug : [    0.000000] ACPI: IRQ0 used by override.
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, A=
PIC ID 2, APIC INT 01
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, A=
PIC ID 2, APIC INT 03
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, A=
PIC ID 2, APIC INT 04
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, A=
PIC ID 2, APIC INT 05
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, A=
PIC ID 2, APIC INT 06
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, A=
PIC ID 2, APIC INT 07
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, A=
PIC ID 2, APIC INT 08
kern  :debug : [    0.000000] ACPI: IRQ9 used by override.
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, A=
PIC ID 2, APIC INT 0a
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, A=
PIC ID 2, APIC INT 0b
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, A=
PIC ID 2, APIC INT 0c
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, A=
PIC ID 2, APIC INT 0d
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, A=
PIC ID 2, APIC INT 0e
kern  :warn  : [    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, A=
PIC ID 2, APIC INT 0f
kern  :info  : [    0.000000] Using ACPI (MADT) for SMP configuration infor=
mation
kern  :info  : [    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
kern  :info  : [    0.000000] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
kern  :warn  : [    0.000000] mapped IOAPIC to ffffffffff5fb000 (fec00000)
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0x00000000=
-0x00000fff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0x0009d000=
-0x0009dfff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0x0009e000=
-0x0009ffff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0x000a0000=
-0x000dffff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0x000e0000=
-0x000fffff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0x20000000=
-0x201fffff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0x40004000=
-0x40004fff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xc5d2d000=
-0xc5f2efff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xd8383000=
-0xdaeeefff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xdaeef000=
-0xdaf9efff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xdaf9f000=
-0xdaffefff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xdb000000=
-0xdf9fffff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xdfa00000=
-0xf7ffffff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xf8000000=
-0xfbffffff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xfc000000=
-0xfebfffff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xfec00000=
-0xfec00fff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xfec01000=
-0xfed07fff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xfed08000=
-0xfed08fff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xfed09000=
-0xfed0ffff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xfed10000=
-0xfed19fff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xfed1a000=
-0xfed1bfff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xfed1c000=
-0xfed1ffff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xfed20000=
-0xfedfffff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xfee00000=
-0xfee00fff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xfee01000=
-0xff97ffff]
kern  :info  : [    0.000000] PM: Registered nosave memory: [mem 0xff980000=
-0xffffffff]
kern  :info  : [    0.000000] e820: [mem 0xdfa00000-0xf7ffffff] available f=
or PCI devices
kern  :info  : [    0.000000] Booting paravirtualized kernel on bare hardwa=
re
kern  :info  : [    0.000000] clocksource: refined-jiffies: mask: 0xfffffff=
f max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
kern  :info  : [    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 =
nr_cpu_ids:8 nr_node_ids:1
kern  :info  : [    0.000000] percpu: Embedded 45 pages/cpu @        (ptrva=
l) s147032 r8192 d29096 u262144
kern  :debug : [    0.000000] pcpu-alloc: s147032 r8192 d29096 u262144 allo=
c=3D1*2097152
kern  :debug : [    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7=20
kern  :info  : [    0.000000] Built 1 zonelists, mobility grouping on.  Tot=
al pages: 997168
kern  :info  : [    0.000000] Policy zone: Normal
kern  :notice: [    0.000000] Kernel command line: ip=3D::::lkp-u410::dhcp =
root=3D/dev/ram0 user=3Dlkp job=3D/lkp/scheduled/lkp-u410/netperf-ipv4-300s=
-200%-cs-localhost-SCTP_STREAM-performance-debian-x86_64-2016-08-31.cgz-60c=
c43fc888428bb2f18f08997432d426a243338-20180419-37334-dtcoce-0.yaml ARCH=3Dx=
86_64 kconfig=3Dx86_64-rhel-7.2 branch=3Dinternal-devel/devel-hourly-201804=
1612-internal commit=3D60cc43fc888428bb2f18f08997432d426a243338 BOOT_IMAGE=
=3D/pkg/linux/x86_64-rhel-7.2/gcc-7/60cc43fc888428bb2f18f08997432d426a24333=
8/vmlinuz-4.17.0-rc1 drm.debug=3D0x1f max_uptime=3D1500 RESULT_ROOT=3D/resu=
lt/netperf/ipv4-300s-200%-cs-localhost-SCTP_STREAM-performance/lkp-u410/deb=
ian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/60cc43fc888428bb2f18f089974=
32d426a243338/4 LKP_SERVER=3Dinn debug apic=3Ddebug sysrq_always_enabled rc=
update.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don pani=
c=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=
=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore=
_loglevel console=3Dtty
kern  :info  : [    0.000000] sysrq: sysrq always enabled.
kern  :info  : [    0.000000] Memory: 3347640K/4052084K available (12300K k=
ernel code, 2592K rwdata, 4168K rodata, 2384K init, 2472K bss, 499644K rese=
rved, 204800K cma-reserved)
kern  :info  : [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D8, Nodes=3D1
kern  :info  : [    0.000000] Kernel/User page tables isolation: enabled
kern  :info  : [    0.000000] ftrace: allocating 39726 entries in 156 pages
kern  :info  : [    0.000000] Hierarchical RCU implementation.
kern  :info  : [    0.000000] 	RCU restricting CPUs from NR_CPUS=3D8192 to =
nr_cpu_ids=3D8.
kern  :info  : [    0.000000] 	RCU CPU stall warnings timeout set to 100 (r=
cu_cpu_stall_timeout).
kern  :info  : [    0.000000] 	Tasks RCU enabled.
kern  :info  : [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=
=3D16, nr_cpu_ids=3D8
kern  :info  : [    0.000000] NR_IRQS: 524544, nr_irqs: 488, preallocated i=
rqs: 16
kern  :info  : [    0.000000] 	Offload RCU callbacks from CPUs: (none).
kern  :info  : [    0.000000] Console: colour VGA+ 80x25
kern  :info  : [    0.000000] console [tty0] enabled
kern  :info  : [    0.000000] console [ttyS0] enabled
kern  :info  : [    0.000000] bootconsole [earlyser0] disabled
kern  :info  : [    0.000000] ACPI: Core revision 20180313
kern  :info  : [    0.000000] clocksource: hpet: mask: 0xffffffff max_cycle=
s: 0xffffffff, max_idle_ns: 133484882848 ns
kern  :debug : [    0.000000] hpet clockevent registered
kern  :info  : [    0.001000] APIC: Switch to symmetric I/O mode setup
kern  :info  : [    0.001000] x2apic: IRQ remapping doesn't support X2APIC =
mode
kern  :warn  : [    0.002000] enabled ExtINT on CPU#0
kern  :warn  : [    0.002000] ENABLING IO-APIC IRQs
kern  :debug : [    0.002000] init IO_APIC IRQs
kern  :debug : [    0.003000]  apic 2 pin 0 not connected
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-1 -> 0xef -> =
IRQ 1 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-2 -> 0x30 -> =
IRQ 0 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-3 -> 0xef -> =
IRQ 3 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-4 -> 0xef -> =
IRQ 4 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-5 -> 0xef -> =
IRQ 5 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-6 -> 0xef -> =
IRQ 6 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-7 -> 0xef -> =
IRQ 7 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-8 -> 0xef -> =
IRQ 8 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-9 -> 0xef -> =
IRQ 9 Mode:1 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-10 -> 0xef ->=
 IRQ 10 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-11 -> 0xef ->=
 IRQ 11 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-12 -> 0xef ->=
 IRQ 12 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-13 -> 0xef ->=
 IRQ 13 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-14 -> 0xef ->=
 IRQ 14 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000] IOAPIC[0]: Set routing entry (2-15 -> 0xef ->=
 IRQ 15 Mode:0 Active:0 Dest:1)
kern  :debug : [    0.003000]  apic 2 pin 16 not connected
kern  :debug : [    0.003000]  apic 2 pin 17 not connected
kern  :debug : [    0.003000]  apic 2 pin 18 not connected
kern  :debug : [    0.003000]  apic 2 pin 19 not connected
kern  :debug : [    0.003000]  apic 2 pin 20 not connected
kern  :debug : [    0.003000]  apic 2 pin 21 not connected
kern  :debug : [    0.003000]  apic 2 pin 22 not connected
kern  :debug : [    0.003000]  apic 2 pin 23 not connected
kern  :info  : [    0.003000] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 api=
c2=3D-1 pin2=3D-1
kern  :info  : [    0.008000] tsc: Fast TSC calibration using PIT
kern  :info  : [    0.009000] tsc: Detected 1696.104 MHz processor
kern  :info  : [    0.009000] clocksource: tsc-early: mask: 0xfffffffffffff=
fff max_cycles: 0x1872c6ce2ca, max_idle_ns: 440795220169 ns
kern  :info  : [    0.010002] Calibrating delay loop (skipped), value calcu=
lated using timer frequency.. 3392.20 BogoMIPS (lpj=3D1696104)
kern  :info  : [    0.010680] pid_max: default: 32768 minimum: 301
kern  :info  : [    0.011022] Security Framework initialized
kern  :info  : [    0.011321] SELinux:  Initializing.
kern  :debug : [    0.011596] SELinux:  Starting in permissive mode
kern  :info  : [    0.013048] Dentry cache hash table entries: 524288 (orde=
r: 10, 4194304 bytes)
kern  :info  : [    0.013976] Inode-cache hash table entries: 262144 (order=
: 9, 2097152 bytes)
kern  :info  : [    0.014025] Mount-cache hash table entries: 8192 (order: =
4, 65536 bytes)
kern  :info  : [    0.014482] Mountpoint-cache hash table entries: 8192 (or=
der: 4, 65536 bytes)
kern  :info  : [    0.015210] CPU: Physical Processor ID: 0
kern  :info  : [    0.015505] CPU: Processor Core ID: 0
kern  :info  : [    0.016009] mce: CPU supports 7 MCE banks
kern  :info  : [    0.016313] CPU0: Thermal monitoring enabled (TM1)
kern  :info  : [    0.016654] process: using mwait in idle threads
kern  :info  : [    0.017003] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
kern  :info  : [    0.017377] Last level dTLB entries: 4KB 512, 2MB 32, 4MB=
 32, 1GB 0
kern  :info  : [    0.017798] Spectre V2 : Mitigation: Full generic retpoli=
ne
kern  :info  : [    0.018102] Freeing SMP alternatives memory: 40K
kern  :debug : [    0.019860] TSC deadline timer enabled
kern  :info  : [    0.020000] smpboot: CPU0: Intel(R) Core(TM) i5-3317U CPU=
 @ 1.70GHz (family: 0x6, model: 0x3a, stepping: 0x9)
kern  :info  : [    0.020000] Performance Events: PEBS fmt1+, IvyBridge eve=
nts, 16-deep LBR, full-width counters, Intel PMU driver.
kern  :info  : [    0.020004] ... version:                3
kern  :info  : [    0.020320] ... bit width:              48
kern  :info  : [    0.020640] ... generic registers:      4
kern  :info  : [    0.020957] ... value mask:             0000ffffffffffff
kern  :info  : [    0.021001] ... max period:             00007fffffffffff
kern  :info  : [    0.021389] ... fixed-purpose events:   3
kern  :info  : [    0.021706] ... event mask:             000000070000000f
kern  :info  : [    0.022046] Hierarchical SRCU implementation.
kern  :info  : [    0.023659] NMI watchdog: Enabled. Permanently consumes o=
ne hw-PMU counter.
kern  :info  : [    0.024024] smp: Bringing up secondary CPUs ...
kern  :info  : [    0.024458] x86: Booting SMP configuration:
kern  :info  : [    0.024786] .... node  #0, CPUs:      #1
kern  :warn  : [    0.001000] masked ExtINT on CPU#1
kern  :warn  : [    0.026114]  #2
kern  :warn  : [    0.001000] masked ExtINT on CPU#2
kern  :warn  : [    0.027109]  #3
kern  :warn  : [    0.001000] masked ExtINT on CPU#3
kern  :info  : [    0.028030] smp: Brought up 1 node, 4 CPUs
kern  :info  : [    0.028331] smpboot: Max logical packages: 2
kern  :info  : [    0.028663] smpboot: Total of 4 processors activated (135=
68.83 BogoMIPS)
kern  :info  : [    0.030232] devtmpfs: initialized
kern  :info  : [    0.030338] x86/mm: Memory block size: 128MB
kern  :info  : [    0.032160] Built 1 zonelists, mobility grouping on.  Tot=
al pages: 888120
kern  :info  : [    0.032629] Policy zone: Normal
kern  :info  : [    0.032969] evm: security.selinux
kern  :info  : [    0.033005] evm: security.ima
kern  :info  : [    0.033266] evm: security.capability
kern  :info  : [    0.033577] PM: Registering ACPI NVS region [mem 0xdaeef0=
00-0xdaf9efff] (720896 bytes)
kern  :info  : [    0.034071] clocksource: jiffies: mask: 0xffffffff max_cy=
cles: 0xffffffff, max_idle_ns: 1911260446275000 ns
kern  :info  : [    0.035015] futex hash table entries: 2048 (order: 5, 131=
072 bytes)
kern  :info  : [    0.035533] pinctrl core: initialized pinctrl subsystem
kern  :info  : [    0.036027] NET: Registered protocol family 16
kern  :info  : [    0.036614] audit: initializing netlink subsys (disabled)
kern  :notice: [    0.037010] audit: type=3D2000 audit(1524172904.037:1): s=
tate=3Dinitialized audit_enabled=3D0 res=3D1
kern  :info  : [    0.037132] cpuidle: using governor menu
kern  :info  : [    0.037530] ACPI: bus type PCI registered
kern  :info  : [    0.038003] acpiphp: ACPI Hot Plug PCI Controller Driver =
version: 0.5
kern  :info  : [    0.038521] PCI: MMCONFIG for domain 0000 [bus 00-3f] at =
[mem 0xf8000000-0xfbffffff] (base 0xf8000000)
kern  :info  : [    0.039014] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] =
reserved in E820
kern  :info  : [    0.040009] PCI: Using configuration type 1 for base acce=
ss
kern  :info  : [    0.040599] core: PMU erratum BJ122, BV98, HSD29 worked a=
round, HT is on
kern  :info  : [    0.042507] HugeTLB registered 2.00 MiB page size, pre-al=
located 0 pages
kern  :info  : [    0.043057] ACPI: Added _OSI(Module Device)
kern  :info  : [    0.043057] ACPI: Added _OSI(Processor Device)
kern  :info  : [    0.043343] ACPI: Added _OSI(3.0 _SCP Extensions)
kern  :info  : [    0.044003] ACPI: Added _OSI(Processor Aggregator Device)
kern  :info  : [    0.044003] ACPI: Added _OSI(Linux-Dell-Video)
kern  :info  : [    0.055501] ACPI: 5 ACPI AML tables successfully acquired=
 and loaded
kern  :notice: [    0.059208] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query =
ignored
kern  :info  : [    0.060235] ACPI: Dynamic OEM Table Load:
kern  :info  : [    0.060559] ACPI: SSDT 0xFFFF880103A51000 00083B (v01 PmR=
ef  Cpu0Cst  00003001 INTL 20061109)
kern  :info  : [    0.061568] ACPI: Dynamic OEM Table Load:
kern  :info  : [    0.061892] ACPI: SSDT 0xFFFF880103B22000 000303 (v01 PmR=
ef  ApIst    00003000 INTL 20061109)
kern  :info  : [    0.063355] ACPI: Dynamic OEM Table Load:
kern  :info  : [    0.063679] ACPI: SSDT 0xFFFF880103B0DA00 000119 (v01 PmR=
ef  ApCst    00003000 INTL 20061109)
kern  :info  : [    0.065075] ACPI: EC: EC started
kern  :info  : [    0.065352] ACPI: EC: interrupt blocked
kern  :info  : [    0.496120] ACPI: \_SB_.PCI0.LPCB.EC0_: Used as first EC
kern  :info  : [    0.496512] ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=3D0x17, EC_CM=
D/EC_SC=3D0x66, EC_DATA=3D0x62
kern  :info  : [    0.497003] ACPI: \_SB_.PCI0.LPCB.EC0_: Used as boot DSDT=
 EC to handle transactions
kern  :info  : [    0.497562] ACPI: Interpreter enabled
kern  :info  : [    0.497880] ACPI: (supports S0 S1 S3 S4 S5)
kern  :info  : [    0.498002] ACPI: Using IOAPIC for interrupt routing
kern  :info  : [    0.498402] PCI: Using host bridge windows from ACPI; if =
necessary, use "pci=3Dnocrs" and report a bug
kern  :info  : [    0.499228] ACPI: Enabled 8 GPEs in block 00 to 3F
kern  :info  : [    0.508968] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bu=
s 00-3e])
kern  :info  : [    0.510007] acpi PNP0A08:00: _OSC: OS supports [ExtendedC=
onfig ASPM ClockPM Segments MSI]
kern  :info  : [    0.510797] acpi PNP0A08:00: _OSC failed (AE_ERROR); disa=
bling ASPM
kern  :info  : [    0.511574] PCI host bridge to bus 0000:00
kern  :info  : [    0.511898] pci_bus 0000:00: root bus resource [io  0x000=
0-0x0cf7 window]
kern  :info  : [    0.512003] pci_bus 0000:00: root bus resource [io  0x0d0=
0-0xffff window]
kern  :info  : [    0.512473] pci_bus 0000:00: root bus resource [mem 0x000=
a0000-0x000bffff window]
kern  :info  : [    0.513002] pci_bus 0000:00: root bus resource [mem 0xdfa=
00000-0xfeafffff window]
kern  :info  : [    0.513554] pci_bus 0000:00: root bus resource [mem 0xfed=
40000-0xfed44fff window]
kern  :info  : [    0.515003] pci_bus 0000:00: root bus resource [bus 00-3e]
kern  :debug : [    0.515409] pci 0000:00:00.0: [8086:0154] type 00 class 0=
x060000
kern  :debug : [    0.515939] pci 0000:00:01.0: [8086:0151] type 01 class 0=
x060400
kern  :debug : [    0.516037] pci 0000:00:01.0: PME# supported from D0 D3ho=
t D3cold
kern  :debug : [    0.516558] pci 0000:00:02.0: [8086:0166] type 00 class 0=
x030000
kern  :debug : [    0.516994] pci 0000:00:02.0: reg 0x10: [mem 0xf0000000-0=
xf03fffff 64bit]
kern  :debug : [    0.517006] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0=
xefffffff 64bit pref]
kern  :debug : [    0.517550] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303=
f]
kern  :debug : [    0.518064] pci 0000:00:14.0: [8086:1e31] type 00 class 0=
x0c0330
kern  :debug : [    0.518517] pci 0000:00:14.0: reg 0x10: [mem 0xf0600000-0=
xf060ffff 64bit]
kern  :debug : [    0.519057] pci 0000:00:14.0: PME# supported from D3hot D=
3cold
kern  :debug : [    0.519566] pci 0000:00:16.0: [8086:1e3a] type 00 class 0=
x078000
kern  :debug : [    0.520019] pci 0000:00:16.0: reg 0x10: [mem 0xf0615000-0=
xf061500f 64bit]
kern  :debug : [    0.520563] pci 0000:00:16.0: PME# supported from D0 D3ho=
t D3cold
kern  :debug : [    0.521093] pci 0000:00:1a.0: [8086:1e2d] type 00 class 0=
x0c0320
kern  :debug : [    0.521540] pci 0000:00:1a.0: reg 0x10: [mem 0xf0619000-0=
xf06193ff]
kern  :debug : [    0.522064] pci 0000:00:1a.0: PME# supported from D0 D3ho=
t D3cold
kern  :debug : [    0.522590] pci 0000:00:1b.0: [8086:1e20] type 00 class 0=
x040300
kern  :debug : [    0.523024] pci 0000:00:1b.0: reg 0x10: [mem 0xf0610000-0=
xf0613fff 64bit]
kern  :debug : [    0.523568] pci 0000:00:1b.0: PME# supported from D0 D3ho=
t D3cold
kern  :debug : [    0.524092] pci 0000:00:1c.0: [8086:1e10] type 01 class 0=
x060400
kern  :debug : [    0.524605] pci 0000:00:1c.0: PME# supported from D0 D3ho=
t D3cold
kern  :debug : [    0.525100] pci 0000:00:1c.1: [8086:1e12] type 01 class 0=
x060400
kern  :debug : [    0.525614] pci 0000:00:1c.1: PME# supported from D0 D3ho=
t D3cold
kern  :debug : [    0.527102] pci 0000:00:1c.2: [8086:1e14] type 01 class 0=
x060400
kern  :debug : [    0.527612] pci 0000:00:1c.2: PME# supported from D0 D3ho=
t D3cold
kern  :debug : [    0.528105] pci 0000:00:1d.0: [8086:1e26] type 00 class 0=
x0c0320
kern  :debug : [    0.528553] pci 0000:00:1d.0: reg 0x10: [mem 0xf0618000-0=
xf06183ff]
kern  :debug : [    0.529081] pci 0000:00:1d.0: PME# supported from D0 D3ho=
t D3cold
kern  :debug : [    0.529605] pci 0000:00:1f.0: [8086:1e57] type 00 class 0=
x060100
kern  :debug : [    0.530196] pci 0000:00:1f.2: [8086:1e03] type 00 class 0=
x010601
kern  :debug : [    0.530639] pci 0000:00:1f.2: reg 0x10: [io  0x3088-0x308=
f]
kern  :debug : [    0.531009] pci 0000:00:1f.2: reg 0x14: [io  0x3094-0x309=
7]
kern  :debug : [    0.531418] pci 0000:00:1f.2: reg 0x18: [io  0x3080-0x308=
7]
kern  :debug : [    0.531829] pci 0000:00:1f.2: reg 0x1c: [io  0x3090-0x309=
3]
kern  :debug : [    0.532009] pci 0000:00:1f.2: reg 0x20: [io  0x3060-0x307=
f]
kern  :debug : [    0.532419] pci 0000:00:1f.2: reg 0x24: [mem 0xf0617000-0=
xf06177ff]
kern  :debug : [    0.532903] pci 0000:00:1f.2: PME# supported from D3hot
kern  :debug : [    0.533088] pci 0000:00:1f.3: [8086:1e22] type 00 class 0=
x0c0500
kern  :debug : [    0.533535] pci 0000:00:1f.3: reg 0x10: [mem 0xf0614000-0=
xf06140ff 64bit]
kern  :debug : [    0.534022] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefb=
f]
kern  :info  : [    0.534555] pci 0000:00:01.0: PCI bridge to [bus 01]
kern  :info  : [    0.534981] pci 0000:00:1c.0: PCI bridge to [bus 02]
kern  :debug : [    0.535085] pci 0000:03:00.0: [10ec:8136] type 00 class 0=
x020000
kern  :debug : [    0.535544] pci 0000:03:00.0: reg 0x10: [io  0x2000-0x20f=
f]
kern  :debug : [    0.535979] pci 0000:03:00.0: reg 0x18: [mem 0xf0404000-0=
xf0404fff 64bit pref]
kern  :debug : [    0.537023] pci 0000:03:00.0: reg 0x20: [mem 0xf0400000-0=
xf0403fff 64bit pref]
kern  :debug : [    0.537681] pci 0000:03:00.0: supports D1 D2
kern  :debug : [    0.538002] pci 0000:03:00.0: PME# supported from D0 D1 D=
2 D3hot D3cold
kern  :info  : [    0.538588] pci 0000:00:1c.1: PCI bridge to [bus 03]
kern  :debug : [    0.538960] pci 0000:00:1c.1:   bridge window [io  0x2000=
-0x2fff]
kern  :debug : [    0.539009] pci 0000:00:1c.1:   bridge window [mem 0xf040=
0000-0xf04fffff 64bit pref]
kern  :debug : [    0.539684] pci 0000:04:00.0: [14e4:4727] type 00 class 0=
x028000
kern  :debug : [    0.541048] pci 0000:04:00.0: reg 0x10: [mem 0xf0500000-0=
xf0503fff 64bit]
kern  :debug : [    0.541689] pci 0000:04:00.0: supports D1 D2
kern  :debug : [    0.542002] pci 0000:04:00.0: PME# supported from D0 D3ho=
t D3cold
kern  :info  : [    0.542559] pci 0000:00:1c.2: PCI bridge to [bus 04]
kern  :debug : [    0.542935] pci 0000:00:1c.2:   bridge window [mem 0xf050=
0000-0xf05fffff]
kern  :info  : [    0.543646] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5=
 6 10 *11 12 14 15), disabled.
kern  :info  : [    0.544080] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5=
 6 *10 11 12 14 15), disabled.
kern  :info  : [    0.544742] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5=
 6 10 11 12 14 15) *7, disabled.
kern  :info  : [    0.546077] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5=
 6 10 11 12 14 15) *7, disabled.
kern  :info  : [    0.546750] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5=
 6 10 11 12 14 15) *0, disabled.
kern  :info  : [    0.547078] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5=
 6 10 11 12 14 15) *0, disabled.
kern  :info  : [    0.547752] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5=
 6 *10 11 12 14 15), disabled.
kern  :info  : [    0.548077] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5=
 6 10 *11 12 14 15), disabled.
kern  :info  : [    0.549250] ACPI: EC: interrupt unblocked
kern  :info  : [    0.549585] ACPI: EC: event unblocked
kern  :info  : [    0.549906] ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=3D0x17, EC_CM=
D/EC_SC=3D0x66, EC_DATA=3D0x62
kern  :info  : [    0.551003] ACPI: \_SB_.PCI0.LPCB.EC0_: Used as boot DSDT=
 EC to handle transactions and events
kern  :info  : [    0.551680] pci 0000:00:02.0: vgaarb: setting as boot VGA=
 device
kern  :info  : [    0.551680] pci 0000:00:02.0: vgaarb: VGA device added: d=
ecodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
kern  :info  : [    0.552004] pci 0000:00:02.0: vgaarb: bridge control poss=
ible
kern  :info  : [    0.552417] vgaarb: loaded
kern  :notice: [    0.552735] SCSI subsystem initialized
kern  :info  : [    0.553020] ACPI: bus type USB registered
kern  :info  : [    0.553352] usbcore: registered new interface driver usbfs
kern  :info  : [    0.553756] usbcore: registered new interface driver hub
kern  :info  : [    0.555019] usbcore: registered new device driver usb
kern  :info  : [    0.555415] pps_core: LinuxPPS API ver. 1 registered
kern  :info  : [    0.555784] pps_core: Software ver. 5.3.6 - Copyright 200=
5-2007 Rodolfo Giometti <giometti@linux.it>
kern  :info  : [    0.556004] PTP clock support registered
kern  :info  : [    0.556331] EDAC MC: Ver: 3.0.0
kern  :info  : [    0.557019] PCI: Using ACPI for IRQ routing
kern  :debug : [    0.558527] PCI: pci_cache_line_size set to 64 bytes
kern  :debug : [    0.558974] e820: reserve RAM buffer [mem 0x0009d800-0x00=
09ffff]
kern  :debug : [    0.560002] e820: reserve RAM buffer [mem 0x40004000-0x43=
ffffff]
kern  :debug : [    0.560429] e820: reserve RAM buffer [mem 0xc5d2d000-0xc7=
ffffff]
kern  :debug : [    0.560856] e820: reserve RAM buffer [mem 0xd8383000-0xdb=
ffffff]
kern  :debug : [    0.561002] e820: reserve RAM buffer [mem 0xdb000000-0xdb=
ffffff]
kern  :debug : [    0.561427] e820: reserve RAM buffer [mem 0x11f600000-0x1=
1fffffff]
kern  :info  : [    0.561955] NetLabel: Initializing
kern  :info  : [    0.562001] NetLabel:  domain hash size =3D 128
kern  :info  : [    0.562338] NetLabel:  protocols =3D UNLABELED CIPSOv4 CA=
LIPSO
kern  :info  : [    0.562761] NetLabel:  unlabeled traffic allowed by defau=
lt
kern  :info  : [    0.563208] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0=
, 0, 0, 0
kern  :info  : [    0.564003] hpet0: 8 comparators, 64-bit 14.318180 MHz co=
unter
kern  :info  : [    0.567015] clocksource: Switched to clocksource tsc-early
kern  :notice: [    0.579620] VFS: Disk quotas dquot_6.6.0
kern  :info  : [    0.579953] VFS: Dquot-cache hash table entries: 512 (ord=
er 0, 4096 bytes)
kern  :info  : [    0.580489] pnp: PnP ACPI init
kern  :info  : [    0.580915] system 00:00: [io  0x0680-0x069f] has been re=
served
kern  :info  : [    0.581344] system 00:00: [io  0x1000-0x100f] has been re=
served
kern  :info  : [    0.581765] system 00:00: [io  0xffff] has been reserved
kern  :info  : [    0.582157] system 00:00: [io  0xffff] has been reserved
kern  :info  : [    0.582546] system 00:00: [io  0x0400-0x0453] has been re=
served
kern  :info  : [    0.582967] system 00:00: [io  0x0458-0x047f] has been re=
served
kern  :info  : [    0.584682] system 00:00: [io  0x0500-0x057f] has been re=
served
kern  :info  : [    0.585105] system 00:00: [io  0x164e-0x164f] has been re=
served
kern  :debug : [    0.585529] system 00:00: Plug and Play ACPI device, IDs =
PNP0c02 (active)
kern  :debug : [    0.586026] pnp 00:01: Plug and Play ACPI device, IDs PNP=
0b00 (active)
kern  :info  : [    0.586543] system 00:02: [io  0x0454-0x0457] has been re=
served
kern  :debug : [    0.586967] system 00:02: Plug and Play ACPI device, IDs =
INT3f0d PNP0c02 (active)
kern  :debug : [    0.587551] pnp 00:03: Plug and Play ACPI device, IDs PNP=
0303 (active)
kern  :debug : [    0.588106] pnp 00:04: Plug and Play ACPI device, IDs SYN=
1051 SYN1000 SYN0002 PNP0f13 (active)
kern  :info  : [    0.588955] system 00:05: [mem 0xfed1c000-0xfed1ffff] has=
 been reserved
kern  :info  : [    0.589419] system 00:05: [mem 0xfed10000-0xfed17fff] has=
 been reserved
kern  :info  : [    0.589881] system 00:05: [mem 0xfed18000-0xfed18fff] has=
 been reserved
kern  :info  : [    0.590342] system 00:05: [mem 0xfed19000-0xfed19fff] has=
 been reserved
kern  :info  : [    0.590804] system 00:05: [mem 0xf8000000-0xfbffffff] has=
 been reserved
kern  :info  : [    0.591266] system 00:05: [mem 0xfed20000-0xfed3ffff] has=
 been reserved
kern  :info  : [    0.591726] system 00:05: [mem 0xfed90000-0xfed93fff] has=
 been reserved
kern  :info  : [    0.592189] system 00:05: [mem 0xfed45000-0xfed8ffff] has=
 been reserved
kern  :info  : [    0.592645] system 00:05: [mem 0xff000000-0xffffffff] cou=
ld not be reserved
kern  :info  : [    0.593125] system 00:05: [mem 0xfee00000-0xfeefffff] cou=
ld not be reserved
kern  :info  : [    0.593602] system 00:05: [mem 0xfffff000-0xffffffff] has=
 been reserved
kern  :debug : [    0.594068] system 00:05: Plug and Play ACPI device, IDs =
PNP0c02 (active)
kern  :info  : [    0.595092] pnp: PnP ACPI: found 6 devices
kern  :info  : [    0.601223] clocksource: acpi_pm: mask: 0xffffff max_cycl=
es: 0xffffff, max_idle_ns: 2085701024 ns
kern  :info  : [    0.601882] pci 0000:00:01.0: PCI bridge to [bus 01]
kern  :info  : [    0.602258] pci 0000:00:1c.0: PCI bridge to [bus 02]
kern  :info  : [    0.602638] pci 0000:00:1c.1: PCI bridge to [bus 03]
kern  :info  : [    0.603013] pci 0000:00:1c.1:   bridge window [io  0x2000=
-0x2fff]
kern  :info  : [    0.603450] pci 0000:00:1c.1:   bridge window [mem 0xf040=
0000-0xf04fffff 64bit pref]
kern  :info  : [    0.604025] pci 0000:00:1c.2: PCI bridge to [bus 04]
kern  :info  : [    0.604397] pci 0000:00:1c.2:   bridge window [mem 0xf050=
0000-0xf05fffff]
kern  :debug : [    0.604873] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf=
7 window]
kern  :debug : [    0.605311] pci_bus 0000:00: resource 5 [io  0x0d00-0xfff=
f window]
kern  :debug : [    0.605748] pci_bus 0000:00: resource 6 [mem 0x000a0000-0=
x000bffff window]
kern  :debug : [    0.606224] pci_bus 0000:00: resource 7 [mem 0xdfa00000-0=
xfeafffff window]
kern  :debug : [    0.606697] pci_bus 0000:00: resource 8 [mem 0xfed40000-0=
xfed44fff window]
kern  :debug : [    0.607175] pci_bus 0000:03: resource 0 [io  0x2000-0x2ff=
f]
kern  :debug : [    0.607576] pci_bus 0000:03: resource 2 [mem 0xf0400000-0=
xf04fffff 64bit pref]
kern  :debug : [    0.608117] pci_bus 0000:04: resource 1 [mem 0xf0500000-0=
xf05fffff]
kern  :info  : [    0.608660] NET: Registered protocol family 2
kern  :info  : [    0.609183] tcp_listen_portaddr_hash hash table entries: =
2048 (order: 3, 32768 bytes)
kern  :info  : [    0.609774] TCP established hash table entries: 32768 (or=
der: 6, 262144 bytes)
kern  :info  : [    0.610383] TCP bind hash table entries: 32768 (order: 7,=
 524288 bytes)
kern  :info  : [    0.610930] TCP: Hash tables configured (established 3276=
8 bind 32768)
kern  :info  : [    0.611424] UDP hash table entries: 2048 (order: 4, 65536=
 bytes)
kern  :info  : [    0.611866] UDP-Lite hash table entries: 2048 (order: 4, =
65536 bytes)
kern  :info  : [    0.612367] NET: Registered protocol family 1
kern  :info  : [    0.612826] RPC: Registered named UNIX socket transport m=
odule.
kern  :info  : [    0.613263] RPC: Registered udp transport module.
kern  :info  : [    0.613622] RPC: Registered tcp transport module.
kern  :info  : [    0.613978] RPC: Registered tcp NFSv4.1 backchannel trans=
port module.
kern  :info  : [    0.614448] pci 0000:00:02.0: Video device with shadowed =
ROM at [mem 0x000c0000-0x000dffff]
kern  :debug : [    0.615154] IOAPIC[0]: Set routing entry (2-21 -> 0xef ->=
 IRQ 21 Mode:1 Active:1 Dest:1)
kern  :debug : [    0.615923] IOAPIC[0]: Set routing entry (2-16 -> 0xef ->=
 IRQ 16 Mode:1 Active:1 Dest:1)
kern  :debug : [    0.616677] IOAPIC[0]: Set routing entry (2-23 -> 0xef ->=
 IRQ 23 Mode:1 Active:1 Dest:1)
kern  :debug : [    0.617390] PCI: CLS 64 bytes, default 64
kern  :info  : [    0.617745] Unpacking initramfs...
kern  :info  : [    6.274461] Freeing initrd memory: 334296K
kern  :info  : [    6.274790] PCI-DMA: Using software bounce buffering for =
IO (SWIOTLB)
kern  :info  : [    6.275246] software IO TLB [mem 0xc7800000-0xcb800000] (=
64MB) mapped at [0000000026dce908-00000000994d3b07]
kern  :info  : [    6.276178] RAPL PMU: API unit is 2^-32 Joules, 3 fixed c=
ounters, 163840 ms ovfl timer
kern  :info  : [    6.276756] RAPL PMU: hw unit of domain pp0-core 2^-16 Jo=
ules
kern  :info  : [    6.277176] RAPL PMU: hw unit of domain package 2^-16 Jou=
les
kern  :info  : [    6.277585] RAPL PMU: hw unit of domain pp1-gpu 2^-16 Jou=
les
kern  :notice: [    6.279175] Initialise system trusted keyrings
kern  :info  : [    6.279548] workingset: timestamp_bits=3D36 max_order=3D2=
0 bucket_order=3D0
kern  :info  : [    6.281241] zbud: loaded
kern  :info  : [    6.282044] 9p: Installing v9fs 9p2000 file system support
kern  :info  : [    6.282457] pstore: using deflate compression
kern  :debug : [    6.282840] SELinux:  Registering netfilter hooks
kern  :info  : [    6.284203] NET: Registered protocol family 38
kern  :notice: [    6.284548] Key type asymmetric registered
kern  :notice: [    6.284870] Asymmetric key parser 'x509' registered
kern  :info  : [    6.285264] Block layer SCSI generic (bsg) driver version=
 0.4 loaded (major 247)
kern  :info  : [    6.285846] io scheduler noop registered
kern  :info  : [    6.286163] io scheduler deadline registered (default)
kern  :info  : [    6.286581] io scheduler cfq registered
kern  :info  : [    6.286888] io scheduler mq-deadline registered (default)
kern  :info  : [    6.287285] io scheduler kyber registered
kern  :info  : [    6.287630] atomic64_test: passed for x86-64 platform wit=
h CX8 and with SSE
kern  :debug : [    6.288289] IOAPIC[0]: Set routing entry (2-16 -> 0xef ->=
 IRQ 16 Mode:1 Active:1 Dest:1)
kern  :debug : [    6.289104] IOAPIC[0]: Set routing entry (2-17 -> 0xef ->=
 IRQ 17 Mode:1 Active:1 Dest:1)
kern  :debug : [    6.289813] IOAPIC[0]: Set routing entry (2-18 -> 0xef ->=
 IRQ 18 Mode:1 Active:1 Dest:1)
kern  :debug : [    6.290479] intel_idle: MWAIT substates: 0x21120
kern  :debug : [    6.290828] intel_idle: v0.4.1 model 0x3A
kern  :debug : [    6.291295] intel_idle: lapic_timer_reliable_states 0xfff=
fffff
kern  :info  : [    6.292989] ACPI: AC Adapter [ACAD] (on-line)
kern  :info  : [    6.293399] input: Lid Switch as /devices/LNXSYSTM:00/LNX=
SYBUS:00/PNP0C0D:00/input/input0
kern  :info  : [    6.294008] ACPI: Lid Switch [LID0]
kern  :info  : [    6.294334] input: Power Button as /devices/LNXSYSTM:00/L=
NXSYBUS:00/PNP0C0C:00/input/input1
kern  :info  : [    6.294931] ACPI: Power Button [PWRB]
kern  :info  : [    6.295288] input: Power Button as /devices/LNXSYSTM:00/L=
NXPWRBN:00/input/input2
kern  :info  : [    6.295848] ACPI: Power Button [PWRF]
kern  :info  : [    6.298829] thermal LNXTHERM:00: registered as thermal_zo=
ne0
kern  :info  : [    6.299255] ACPI: Thermal Zone [TZ00] (58 C)
kern  :info  : [    6.299630] ERST DBG: ERST support is disabled.
kern  :info  : [    6.300214] Serial: 8250/16550 driver, 4 ports, IRQ shari=
ng enabled
kern  :info  : [    6.301623] Non-volatile memory driver v1.3
kern  :info  : [    6.302025] Linux agpgart interface v0.103
kern  :info  : [    6.302882] rdac: device handler registered
kern  :info  : [    6.303348] hp_sw: device handler registered
kern  :info  : [    6.303693] emc: device handler registered
kern  :info  : [    6.304050] alua: device handler registered
kern  :info  : [    6.304377] MACsec IEEE 802.1AE
kern  :info  : [    6.304840] libphy: Fixed MDIO Bus: probed
kern  :info  : [    6.305334] e1000: Intel(R) PRO/1000 Network Driver - ver=
sion 7.3.21-k8-NAPI
kern  :info  : [    6.305919] e1000: Copyright (c) 1999-2006 Intel Corporat=
ion.
kern  :info  : [    6.306455] e1000e: Intel(R) PRO/1000 Network Driver - 3.=
2.6-k
kern  :info  : [    6.306977] e1000e: Copyright(c) 1999 - 2015 Intel Corpor=
ation.
kern  :info  : [    6.307620] igb: Intel(R) Gigabit Ethernet Network Driver=
 - version 5.4.0-k
kern  :info  : [    6.308170] igb: Copyright (c) 2007-2014 Intel Corporatio=
n.
kern  :info  : [    6.308636] ixgbe: Intel(R) 10 Gigabit PCI Express Networ=
k Driver - version 5.1.0-k
kern  :info  : [    6.309205] ixgbe: Copyright (c) 1999-2016 Intel Corporat=
ion.
kern  :info  : [    6.309925] r8169 Gigabit Ethernet driver 2.3LK-NAPI load=
ed
kern  :warn  : [    6.310394] r8169 0000:03:00.0: can't disable ASPM; OS do=
esn't have ASPM control
kern  :info  : [    6.311888] r8169 0000:03:00.0 eth0: RTL8105e at 0x000000=
005967482d, 04:7d:7b:f4:06:f3, XID 00c00000 IRQ 25
kern  :info  : [    6.312712] usbcore: registered new interface driver catc
kern  :info  : [    6.313174] usbcore: registered new interface driver kawe=
th
kern  :info  : [    6.313632] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus=
 II USB Ethernet driver
kern  :info  : [    6.314256] usbcore: registered new interface driver pega=
sus
kern  :info  : [    6.314739] usbcore: registered new interface driver rtl8=
150
kern  :info  : [    6.315174] usbcore: registered new interface driver asix
kern  :info  : [    6.315571] usbcore: registered new interface driver cdc_=
ether
kern  :info  : [    6.315994] usbcore: registered new interface driver cdc_=
eem
kern  :info  : [    6.316458] usbcore: registered new interface driver dm96=
01
kern  :info  : [    6.316931] usbcore: registered new interface driver smsc=
75xx
kern  :info  : [    6.317410] usbcore: registered new interface driver smsc=
95xx
kern  :info  : [    6.317886] usbcore: registered new interface driver gl62=
0a
kern  :info  : [    6.318368] usbcore: registered new interface driver net1=
080
kern  :info  : [    6.318849] usbcore: registered new interface driver plusb
kern  :info  : [    6.319318] usbcore: registered new interface driver rndi=
s_host
kern  :info  : [    6.319811] usbcore: registered new interface driver cdc_=
subset
kern  :info  : [    6.320305] usbcore: registered new interface driver zaur=
us
kern  :info  : [    6.320727] usbcore: registered new interface driver MOSC=
HIP usb-ethernet driver
kern  :info  : [    6.321346] usbcore: registered new interface driver int5=
1x1
kern  :info  : [    6.321823] usbcore: registered new interface driver iphe=
th
kern  :info  : [    6.322302] usbcore: registered new interface driver sier=
ra_net
kern  :info  : [    6.322927] ehci_hcd: USB 2.0 'Enhanced' Host Controller =
(EHCI) Driver
kern  :info  : [    6.323471] ehci-pci: EHCI PCI platform driver
kern  :info  : [    6.324135] ehci-pci 0000:00:1a.0: EHCI Host Controller
kern  :info  : [    6.324685] ehci-pci 0000:00:1a.0: new USB bus registered=
, assigned bus number 1
kern  :info  : [    6.325303] ehci-pci 0000:00:1a.0: debug port 2
kern  :debug : [    6.329685] ehci-pci 0000:00:1a.0: cache line size of 64 =
is not supported
kern  :info  : [    6.330228] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf0619=
000
kern  :info  : [    6.337068] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI =
1.00
kern  :info  : [    6.337524] usb usb1: New USB device found, idVendor=3D1d=
6b, idProduct=3D0002, bcdDevice=3D 4.17
kern  :info  : [    6.338126] usb usb1: New USB device strings: Mfr=3D3, Pr=
oduct=3D2, SerialNumber=3D1
kern  :info  : [    6.338675] usb usb1: Product: EHCI Host Controller
kern  :info  : [    6.339050] usb usb1: Manufacturer: Linux 4.17.0-rc1 ehci=
_hcd
kern  :info  : [    6.339470] usb usb1: SerialNumber: 0000:00:1a.0
kern  :info  : [    6.339988] hub 1-0:1.0: USB hub found
kern  :info  : [    6.340310] hub 1-0:1.0: 3 ports detected
kern  :debug : [    6.340841] IOAPIC[0]: Set routing entry (2-23 -> 0xef ->=
 IRQ 23 Mode:1 Active:1 Dest:1)
kern  :info  : [    6.342818] ehci-pci 0000:00:1d.0: EHCI Host Controller
kern  :info  : [    6.343356] ehci-pci 0000:00:1d.0: new USB bus registered=
, assigned bus number 2
kern  :info  : [    6.343923] ehci-pci 0000:00:1d.0: debug port 2
kern  :debug : [    6.348362] ehci-pci 0000:00:1d.0: cache line size of 64 =
is not supported
kern  :info  : [    6.348897] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf0618=
000
kern  :info  : [    6.353443] ACPI: Battery Slot [BAT1] (battery present)
kern  :info  : [    6.356060] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI =
1.00
kern  :info  : [    6.356541] usb usb2: New USB device found, idVendor=3D1d=
6b, idProduct=3D0002, bcdDevice=3D 4.17
kern  :info  : [    6.357169] usb usb2: New USB device strings: Mfr=3D3, Pr=
oduct=3D2, SerialNumber=3D1
kern  :info  : [    6.357718] usb usb2: Product: EHCI Host Controller
kern  :info  : [    6.358091] usb usb2: Manufacturer: Linux 4.17.0-rc1 ehci=
_hcd
kern  :info  : [    6.358509] usb usb2: SerialNumber: 0000:00:1d.0
kern  :info  : [    6.359018] hub 2-0:1.0: USB hub found
kern  :info  : [    6.359335] hub 2-0:1.0: 3 ports detected
kern  :info  : [    6.359787] ohci_hcd: USB 1.1 'Open' Host Controller (OHC=
I) Driver
kern  :info  : [    6.360246] ohci-pci: OHCI PCI platform driver
kern  :info  : [    6.360592] uhci_hcd: USB Universal Host Controller Inter=
face driver
kern  :debug : [    6.361155] IOAPIC[0]: Set routing entry (2-21 -> 0xef ->=
 IRQ 21 Mode:1 Active:1 Dest:1)
kern  :info  : [    6.361753] xhci_hcd 0000:00:14.0: xHCI Host Controller
kern  :info  : [    6.362206] xhci_hcd 0000:00:14.0: new USB bus registered=
, assigned bus number 3
kern  :info  : [    6.363886] xhci_hcd 0000:00:14.0: hcc params 0x20007181 =
hci version 0x100 quirks 0x0000b930
kern  :debug : [    6.364509] xhci_hcd 0000:00:14.0: cache line size of 64 =
is not supported
kern  :info  : [    6.365087] usb usb3: New USB device found, idVendor=3D1d=
6b, idProduct=3D0002, bcdDevice=3D 4.17
kern  :info  : [    6.365701] usb usb3: New USB device strings: Mfr=3D3, Pr=
oduct=3D2, SerialNumber=3D1
kern  :info  : [    6.366268] usb usb3: Product: xHCI Host Controller
kern  :info  : [    6.366637] usb usb3: Manufacturer: Linux 4.17.0-rc1 xhci=
-hcd
kern  :info  : [    6.367069] usb usb3: SerialNumber: 0000:00:14.0
kern  :info  : [    6.367546] hub 3-0:1.0: USB hub found
kern  :info  : [    6.367857] hub 3-0:1.0: 4 ports detected
kern  :info  : [    6.368566] xhci_hcd 0000:00:14.0: xHCI Host Controller
kern  :info  : [    6.369007] xhci_hcd 0000:00:14.0: new USB bus registered=
, assigned bus number 4
kern  :info  : [    6.369561] xhci_hcd 0000:00:14.0: Host supports USB 3.0 =
 SuperSpeed
kern  :info  : [    6.370052] usb usb4: New USB device found, idVendor=3D1d=
6b, idProduct=3D0003, bcdDevice=3D 4.17
kern  :info  : [    6.370647] usb usb4: New USB device strings: Mfr=3D3, Pr=
oduct=3D2, SerialNumber=3D1
kern  :info  : [    6.371200] usb usb4: Product: xHCI Host Controller
kern  :info  : [    6.371564] usb usb4: Manufacturer: Linux 4.17.0-rc1 xhci=
-hcd
kern  :info  : [    6.371973] usb usb4: SerialNumber: 0000:00:14.0
kern  :info  : [    6.372453] hub 4-0:1.0: USB hub found
kern  :info  : [    6.372760] hub 4-0:1.0: 4 ports detected
kern  :info  : [    6.373483] usbcore: registered new interface driver usbs=
erial_generic
kern  :info  : [    6.373940] usbserial: USB Serial support registered for =
generic
kern  :info  : [    6.374407] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP=
0f13:PS2B] at 0x60,0x64 irq 1,12
kern  :info  : [    6.378199] i8042: Detected active multiplexing controlle=
r, rev 1.1
kern  :info  : [    6.379467] serio: i8042 KBD port at 0x60,0x64 irq 1
kern  :info  : [    6.379838] serio: i8042 AUX0 port at 0x60,0x64 irq 12
kern  :info  : [    6.380259] serio: i8042 AUX1 port at 0x60,0x64 irq 12
kern  :info  : [    6.380653] serio: i8042 AUX2 port at 0x60,0x64 irq 12
kern  :info  : [    6.381081] serio: i8042 AUX3 port at 0x60,0x64 irq 12
kern  :info  : [    6.381560] mousedev: PS/2 mouse device common for all mi=
ce
kern  :info  : [    6.382181] rtc_cmos 00:01: RTC can wake from S4
kern  :info  : [    6.382715] rtc_cmos 00:01: registered as rtc0
kern  :info  : [    6.383087] rtc_cmos 00:01: alarms up to one month, y3k, =
242 bytes nvram, hpet irqs
kern  :info  : [    6.383795] i801_smbus 0000:00:1f.3: SMBus using PCI inte=
rrupt
kern  :info  : [    6.385785] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.=
11
kern  :info  : [    6.386213] iTCO_wdt: Found a Panther Point TCO device (V=
ersion=3D2, TCOBASE=3D0x0460)
kern  :info  : [    6.386879] iTCO_wdt: initialized. heartbeat=3D30 sec (no=
wayout=3D0)
kern  :info  : [    6.387323] iTCO_vendor_support: vendor-support=3D0
kern  :info  : [    6.387684] intel_pstate: Intel P-state driver initializi=
ng
kern  :info  : [    6.388834] hidraw: raw HID events driver (C) Jiri Kosina
kern  :info  : [    6.389541] usbcore: registered new interface driver usbh=
id
kern  :info  : [    6.390021] usbhid: USB HID core driver
kern  :info  : [    6.390622] drop_monitor: Initializing network drop monit=
or service
kern  :info  : [    6.391314] Initializing XFRM netlink socket
kern  :info  : [    6.392054] NET: Registered protocol family 10
kern  :info  : [    6.393183] Segment Routing with IPv6
kern  :info  : [    6.393584] NET: Registered protocol family 17
kern  :info  : [    6.394162] 9pnet: Installing 9P2000 support
kern  :info  : [    6.395977] microcode: sig=3D0x306a9, pf=3D0x10, revision=
=3D0x1f
kern  :info  : [    6.396651] microcode: Microcode Update Driver: v2.2.
kern  :info  : [    6.396702] ... APIC ID:      00000000 (0)
kern  :info  : [    6.397531] ... APIC VERSION: 01060015
kern  :warn  : [    6.397695] 000000000000000000000000000000000000000000000=
0000000000000000000
kern  :warn  : [    6.397695] 000000000200001200000000000200000000000000000=
0000002000000000002
kern  :warn  : [    6.397695] 000000000000000400000000000000000000000000000=
0000000000000001000
kern  :debug : [    6.399632] number of MP IRQ sources: 15.
kern  :debug : [    6.400044] number of IO-APIC #2 registers: 24.
kern  :info  : [    6.400473] testing the IO APIC.......................
kern  :debug : [    6.400925] IO APIC #2......
kern  :debug : [    6.401235] .... register #00: 02000000
kern  :debug : [    6.401601] .......    : physical APIC id: 02
kern  :debug : [    6.402017] .......    : Delivery Type: 0
kern  :debug : [    6.402394] .......    : LTS          : 0
kern  :debug : [    6.402773] .... register #01: 00170020
kern  :debug : [    6.403163] .......     : max redirection entries: 17
kern  :debug : [    6.403551] .......     : PRQ implemented: 0
kern  :debug : [    6.403882] .......     : IO APIC version: 20
kern  :debug : [    6.404233] .... IRQ redirection table:
kern  :debug : [    6.404550] IOAPIC 0:
kern  :debug : [    6.404774]  pin00, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.405367]  pin01, enabled , edge , high, V(22), IRR(0),=
 S(0), logical , D(08), M(0)
kern  :debug : [    6.405961]  pin02, enabled , edge , high, V(30), IRR(0),=
 S(0), logical , D(01), M(0)
kern  :debug : [    6.406549]  pin03, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.407138]  pin04, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.407710]  pin05, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.408309]  pin06, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.408920]  pin07, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.409506]  pin08, enabled , edge , high, V(22), IRR(0),=
 S(0), logical , D(01), M(0)
kern  :debug : [    6.410098]  pin09, enabled , level, high, V(21), IRR(0),=
 S(0), logical , D(02), M(0)
kern  :debug : [    6.410670]  pin0a, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.411265]  pin0b, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.411840]  pin0c, enabled , edge , high, V(22), IRR(0),=
 S(0), logical , D(04), M(0)
kern  :debug : [    6.412442]  pin0d, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.413043]  pin0e, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.413639]  pin0f, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.414233]  pin10, enabled , level, low , V(21), IRR(0),=
 S(0), logical , D(08), M(0)
kern  :debug : [    6.414805]  pin11, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.415398]  pin12, enabled , level, low , V(23), IRR(0),=
 S(0), logical , D(02), M(0)
kern  :debug : [    6.415971]  pin13, disabled, edge , high, V(8E), IRR(0),=
 S(0), physical, D(F3), M(2)
kern  :debug : [    6.416597]  pin14, disabled, edge , high, V(9E), IRR(0),=
 S(0), logical , D(55), M(2)
kern  :debug : [    6.417195]  pin15, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.417761]  pin16, disabled, edge , high, V(00), IRR(0),=
 S(0), physical, D(00), M(0)
kern  :debug : [    6.418348]  pin17, enabled , level, low , V(21), IRR(0),=
 S(0), logical , D(01), M(0)
kern  :debug : [    6.418914] IRQ to pin mappings:
kern  :debug : [    6.419209] IRQ0 -> 0:2
kern  :debug : [    6.419440] IRQ1 -> 0:1
kern  :debug : [    6.419668] IRQ3 -> 0:3
kern  :debug : [    6.419899] IRQ4 -> 0:4
kern  :debug : [    6.420157] IRQ5 -> 0:5
kern  :debug : [    6.420407] IRQ6 -> 0:6
kern  :debug : [    6.420637] IRQ7 -> 0:7
kern  :debug : [    6.420868] IRQ8 -> 0:8
kern  :debug : [    6.421115] IRQ9 -> 0:9
kern  :debug : [    6.421347] IRQ10 -> 0:10
kern  :debug : [    6.421587] IRQ11 -> 0:11
kern  :debug : [    6.421830] IRQ12 -> 0:12
kern  :debug : [    6.422091] IRQ13 -> 0:13
kern  :debug : [    6.422331] IRQ14 -> 0:14
kern  :debug : [    6.422570] IRQ15 -> 0:15
kern  :debug : [    6.422810] IRQ16 -> 0:16
kern  :info  : [    6.422954] input: AT Translated Set 2 keyboard as /devic=
es/platform/i8042/serio0/input/input3
kern  :debug : [    6.423067] IRQ17 -> 0:17
kern  :debug : [    6.423068] IRQ18 -> 0:18
kern  :debug : [    6.424212] IRQ21 -> 0:21
kern  :debug : [    6.424475] IRQ23 -> 0:23
kern  :info  : [    6.424726] .................................... done.
kern  :info  : [    6.425114] sched_clock: Marking stable (6425103738, 0)->=
(6428319984, -3216246)
kern  :info  : [    6.425924] registered taskstats version 1
kern  :notice: [    6.426249] Loading compiled-in X.509 certificates
kern  :info  : [    6.426627] zswap: loaded using pool lzo/zbud
kern  :notice: [    6.430255] Key type big_key registered
kern  :notice: [    6.433336] Key type trusted registered
kern  :notice: [    6.435316] Key type encrypted registered
kern  :info  : [    6.435678] ima: No TPM chip found, activating TPM-bypass=
! (rc=3D-19)
kern  :info  : [    6.436179] ima: Allocated hash algorithm: sha1
kern  :info  : [    6.436578] evm: HMAC attrs: 0x1
kern  :info  : [    6.437400] rtc_cmos 00:01: setting system clock to 2018-=
04-19 21:21:50 UTC (1524172910)
kern  :warn  : [    6.438589] r8169 0000:03:00.0: Direct firmware load for =
rtl_nic/rtl8105e-1.fw failed with error -2
kern  :warn  : [    6.439338] r8169 0000:03:00.0: Falling back to user help=
er
kern  :info  : [    6.666114] usb 1-1: new high-speed USB device number 2 u=
sing ehci-pci
kern  :info  : [    6.682113] usb 2-1: new high-speed USB device number 2 u=
sing ehci-pci
kern  :info  : [    6.690093] usb 3-1: new low-speed USB device number 2 us=
ing xhci_hcd
kern  :info  : [    6.795597] usb 1-1: New USB device found, idVendor=3D808=
7, idProduct=3D0024, bcdDevice=3D 0.00
kern  :info  : [    6.796315] usb 1-1: New USB device strings: Mfr=3D0, Pro=
duct=3D0, SerialNumber=3D0
kern  :info  : [    6.797455] hub 1-1:1.0: USB hub found
kern  :info  : [    6.797916] hub 1-1:1.0: 6 ports detected
kern  :info  : [    6.811881] usb 2-1: New USB device found, idVendor=3D808=
7, idProduct=3D0024, bcdDevice=3D 0.00
kern  :info  : [    6.812449] usb 2-1: New USB device strings: Mfr=3D0, Pro=
duct=3D0, SerialNumber=3D0
kern  :info  : [    6.813396] hub 2-1:1.0: USB hub found
kern  :info  : [    6.813813] hub 2-1:1.0: 8 ports detected
kern  :info  : [    6.825527] usb 3-1: New USB device found, idVendor=3D14d=
d, idProduct=3D1007, bcdDevice=3D 0.00
kern  :info  : [    6.826227] usb 3-1: New USB device strings: Mfr=3D1, Pro=
duct=3D2, SerialNumber=3D7
kern  :info  : [    6.826771] usb 3-1: Product: D2CIM-DVUSB
kern  :info  : [    6.827137] usb 3-1: Manufacturer: Raritan
kern  :info  : [    6.827499] usb 3-1: SerialNumber: HUX46008250000007
kern  :info  : [    6.835515] input: Raritan D2CIM-DVUSB as /devices/pci000=
0:00/0000:00:14.0/usb3/3-1/3-1:1.0/0003:14DD:1007.0001/input/input11
kern  :info  : [    6.888669] hid-generic 0003:14DD:1007.0001: input,hidraw=
0: USB HID v1.10 Keyboard [Raritan D2CIM-DVUSB] on usb-0000:00:14.0-1/input0
kern  :info  : [    6.896454] input: Raritan D2CIM-DVUSB as /devices/pci000=
0:00/0000:00:14.0/usb3/3-1/3-1:1.1/0003:14DD:1007.0002/input/input13
kern  :info  : [    6.898131] hid-generic 0003:14DD:1007.0002: input,hidraw=
1: USB HID v1.10 Mouse [Raritan D2CIM-DVUSB] on usb-0000:00:14.0-1/input1
kern  :info  : [    6.904314] input: Raritan D2CIM-DVUSB as /devices/pci000=
0:00/0000:00:14.0/usb3/3-1/3-1:1.2/0003:14DD:1007.0003/input/input14
kern  :info  : [    6.905201] hid-generic 0003:14DD:1007.0003: input,hidraw=
2: USB HID v1.10 Mouse [Raritan D2CIM-DVUSB] on usb-0000:00:14.0-1/input2
kern  :info  : [    7.020115] usb 3-3: new high-speed USB device number 3 u=
sing xhci_hcd
kern  :info  : [    7.155140] usb 3-3: New USB device found, idVendor=3D598=
6, idProduct=3D0295, bcdDevice=3D14.12
kern  :info  : [    7.155863] usb 3-3: New USB device strings: Mfr=3D1, Pro=
duct=3D2, SerialNumber=3D0
kern  :info  : [    7.156465] usb 3-3: Product: Lenovo EasyCamera
kern  :info  : [    7.156874] usb 3-3: Manufacturer: Vimicro corp.
kern  :info  : [    7.272117] usb 3-4: new full-speed USB device number 4 u=
sing xhci_hcd
kern  :info  : [    7.328114] tsc: Refined TSC clocksource calibration: 169=
6.146 MHz
kern  :info  : [    7.328666] clocksource: tsc: mask: 0xffffffffffffffff ma=
x_cycles: 0x1872ee7fb19, max_idle_ns: 440795224680 ns
kern  :info  : [    7.329562] clocksource: Switched to clocksource tsc
kern  :info  : [    7.402251] usb 3-4: New USB device found, idVendor=3D048=
9, idProduct=3De032, bcdDevice=3D 1.12
kern  :info  : [    7.402972] usb 3-4: New USB device strings: Mfr=3D1, Pro=
duct=3D2, SerialNumber=3D3
kern  :info  : [    7.403572] usb 3-4: Product: BCM20702A0
kern  :info  : [    7.403946] usb 3-4: Manufacturer: Broadcom Corp
kern  :info  : [    7.404374] usb 3-4: SerialNumber: 08EDB99BCE7E
kern  :info  : [    7.725991] psmouse serio4: synaptics: queried max coordi=
nates: x [..5664], y [..4682]
kern  :info  : [    7.791133] psmouse serio4: synaptics: Touchpad model: 1,=
 fw: 8.0, id: 0x1e2b1, caps: 0xd00123/0x840300/0x123c00/0x0, board id: 1800=
, fw id: 876955
kern  :info  : [    7.837389] input: SynPS/2 Synaptics TouchPad as /devices=
/platform/i8042/serio4/input/input12
kern  :warn  : [   66.528210] r8169 0000:03:00.0 eth0: unable to load firmw=
are patch rtl_nic/rtl8105e-1.fw (-11)
kern  :info  : [   66.642220] r8169 0000:03:00.0 eth0: link down
kern  :info  : [   66.642730] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not =
ready
kern  :info  : [   68.179668] r8169 0000:03:00.0 eth0: link up
kern  :info  : [   68.182169] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link bec=
omes ready
kern  :notice: [   68.194106] Sending DHCP requests ..., OK
kern  :info  : [   74.468506] IP-Config: Got DHCP answer from 192.168.1.1, =
my address is 192.168.1.206
kern  :info  : [   74.469200] IP-Config: Complete:
kern  :info  : [   74.469533]      device=3Deth0, hwaddr=3D04:7d:7b:f4:06:f=
3, ipaddr=3D192.168.1.206, mask=3D255.255.255.0, gw=3D192.168.1.1
kern  :info  : [   74.470372]      host=3Dlkp-u410, domain=3Dlkp.intel.com,=
 nis-domain=3D(none)
kern  :info  : [   74.470913]      bootserver=3D192.168.1.1, rootserver=3D1=
92.168.1.1, rootpath=3D     nameserver0=3D192.168.1.1
kern  :info  : [   74.476068] Freeing unused kernel memory: 2384K
kern  :info  : [   74.476435] Write protecting the kernel read-only data: 2=
0480k
kern  :info  : [   74.477626] Freeing unused kernel memory: 2012K
kern  :info  : [   74.484066] Freeing unused kernel memory: 1976K
kern  :info  : [   74.484437] rodata_test: all tests were successful
daemon:info  : [   74.488146] systemd[1]: RTC configured in localtime, appl=
ying delta of 480 minutes to system time.
kern  :info  : [   74.657737] shpchp: Standard Hot Plug PCI Controller Driv=
er version: 0.4
kern  :info  : [   74.657972] input: Ideapad extra buttons as /devices/pci0=
000:00/0000:00:1f.0/PNP0C09:00/VPC2004:00/input/input15
kern  :info  : [   74.663541] Linux video capture interface: v2.00
kern  :debug : [   74.669116] [drm:drm_core_init [drm]] Initialized
kern  :info  : [   74.673193] uvcvideo: Found UVC 1.00 device Lenovo EasyCa=
mera (5986:0295)
kern  :err   : [   74.676365] uvcvideo: Failed to query (GET_INFO) UVC cont=
rol 11 on unit 1: -32 (exp. 1).
kern  :err   : [   74.678744] uvcvideo: Failed to query (GET_INFO) UVC cont=
rol 13 on unit 1: -32 (exp. 1).
kern  :info  : [   74.682853] input: Lenovo EasyCamera: Lenovo EasyC as /de=
vices/pci0000:00/0000:00:14.0/usb3/3-3/3-3:1.0/input/input16
kern  :info  : [   74.683023] usbcore: registered new interface driver uvcv=
ideo
kern  :info  : [   74.683024] USB Video Class driver (1.1.1)
kern  :info  : [   74.727344] bcma: bus0: Found chip with id 0x4313, rev 0x=
01 and package 0x08
kern  :info  : [   74.727890] bcma: bus0: Core 0 found: ChipCommon (manuf 0=
x4BF, id 0x800, rev 0x24, class 0x0)
kern  :info  : [   74.728689] bcma: bus0: Core 1 found: IEEE 802.11 (manuf =
0x4BF, id 0x812, rev 0x18, class 0x0)
kern  :info  : [   74.729516] bcma: bus0: Core 2 found: PCIe (manuf 0x4BF, =
id 0x820, rev 0x11, class 0x0)
kern  :debug : [   74.733502] [drm:intel_pch_type [i915]] Found PantherPoin=
t PCH
kern  :debug : [   74.734020] [drm:intel_power_domains_init [i915]] Allowed=
 DC state mask 00
kern  :debug : [   74.735616] [drm:i915_check_and_clear_faults [i915]] Unex=
pected fault
                              	Addr: 0x7fdf7000
                              	Address space: PPGTT
                              	Source ID: 25
                              	Type: 0
kern  :debug : [   74.737231] libata version 3.00 loaded.
kern  :debug : [   74.737348] [drm:i915_driver_load [i915]] ppgtt mode: 1
kern  :debug : [   74.737986] [drm:intel_uc_sanitize_options [i915]] enable=
_guc=3D0 (submission:no huc:no)
kern  :debug : [   74.738628] [drm:i915_driver_load [i915]] guc_log_level=
=3D0 (enabled:no verbosity:-1)
kern  :debug : [   74.739440] [drm:i915_ggtt_probe_hw [i915]] GGTT size =3D=
 2048M
kern  :debug : [   74.739900] [drm:i915_ggtt_probe_hw [i915]] GMADR size =
=3D 256M
kern  :debug : [   74.740368] [drm:i915_ggtt_probe_hw [i915]] DSM size =3D =
64M
kern  :info  : [   74.740794] [drm] Replacing VGA console driver
kern  :info  : [   74.742507] Console: switching to colour dummy device 80x=
25
kern  :debug : [   74.742981] [drm:i915_gem_init_stolen [i915]] Memory rese=
rved for graphics device: 65536K, usable: 64512K
kern  :info  : [   74.743259] bcma: bus0: Bus registered
kern  :debug : [   74.743850] [drm:intel_opregion_setup [i915]] graphic opr=
egion physical addr: 0xdaf74018
kern  :debug : [   74.744468] [drm:intel_opregion_setup [i915]] Public ACPI=
 methods supported
kern  :debug : [   74.744995] [drm:intel_opregion_setup [i915]] SWSCI suppo=
rted
kern  :info  : [   74.756436] input: PC Speaker as /devices/platform/pcspkr=
/input/input17
kern  :err   : [   74.761279] Error: Driver 'pcspkr' is already registered,=
 aborting...
kern  :debug : [   74.764310] [drm:intel_opregion_setup [i915]] SWSCI GBDA =
callbacks 00000cf3, SBCB callbacks 00000241
kern  :debug : [   74.764909] [drm:intel_opregion_setup [i915]] ASLE suppor=
ted
kern  :debug : [   74.765365] [drm:intel_opregion_setup [i915]] ASLE extens=
ion supported
kern  :debug : [   74.765855] [drm:intel_opregion_setup [i915]] Found valid=
 VBT in ACPI OpRegion (Mailbox #4)
kern  :info  : [   74.767042] [drm] Supports vblank timestamp caching Rev 2=
 (21.10.2013).
kern  :info  : [   74.767453] [drm] Driver supports precise vblank timestam=
p query.
kern  :debug : [   74.767946] [drm:intel_bios_init [i915]] Set default to S=
SC at 120000 kHz
kern  :debug : [   74.768469] [drm:intel_bios_init [i915]] VBT signature "$=
VBT SNB/IVB-MOBILE ", BDB version 165
kern  :debug : [   74.769026] [drm:intel_bios_init [i915]] BDB_GENERAL_FEAT=
URES int_tv_support 0 int_crt_support 1 lvds_use_ssc 1 lvds_ssc_freq 120000=
 display_clock_mode 0 fdi_rx_polarity_inverted 0
kern  :debug : [   74.770008] [drm:intel_bios_init [i915]] crt_ddc_bus_pin:=
 2
kern  :debug : [   74.771422] [drm:intel_opregion_get_panel_type [i915]] Ig=
noring OpRegion panel type (0)
kern  :debug : [   74.772004] [drm:intel_bios_init [i915]] Panel type: 13 (=
VBT)
kern  :debug : [   74.772426] [drm:intel_bios_init [i915]] DRRS supported m=
ode is static
kern  :debug : [   74.773127] [drm:intel_bios_init [i915]] Found panel mode=
 in BIOS VBT tables:
kern  :debug : [   74.773545] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 0:"1366x768" 0 74980 1366 1404 1426 1572 768 771 777 794 0x8 0xa
kern  :debug : [   74.774217] [drm:intel_bios_init [i915]] VBT initial LVDS=
 value 300300
kern  :debug : [   74.774615] [drm:intel_bios_init [i915]] VBT backlight PW=
M modulation frequency 200 Hz, active high, min brightness 0, level 255, co=
ntroller 0
kern  :debug : [   74.776443] [drm:intel_bios_init [i915]] Found SDVO panel=
 mode in BIOS VBT tables:
kern  :debug : [   74.776898] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 0:"1600x1200" 0 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x8 0xa
kern  :debug : [   74.777672] [drm:intel_bios_init [i915]] DRRS State Enabl=
ed:0
kern  :debug : [   74.778060] [drm:intel_bios_init [i915]] No SDVO device i=
nfo is found in VBT
kern  :info  : [   74.780466] cryptd: max_cpu_qlen set to 1000
kern  :info  : [   74.782173] AVX version of gcm_enc/dec engaged.
kern  :info  : [   74.782444] AES CTR mode by8 optimization enabled
kern  :debug : [   74.784221] [drm:intel_dsm_detect [i915]] no _DSM method =
for intel device
kern  :debug : [   74.785373] [drm:i915_driver_load [i915]] rawclk rate: 12=
5000 kHz
kern  :debug : [   74.786289] [drm:intel_power_well_enable [i915]] enabling=
 always-on
kern  :debug : [   74.786663] [drm:drm_irq_install [drm]] irq=3D27
kern  :debug : [   74.788030] [drm:intel_fbc_init [i915]] Sanitized enable_=
fbc value: 0
kern  :debug : [   74.788455] [drm:intel_print_wm_latency [i915]] Primary W=
M0 latency 12 (1.2 usec)
kern  :debug : [   74.788926] [drm:intel_print_wm_latency [i915]] Primary W=
M1 latency 4 (2.0 usec)
kern  :debug : [   74.789399] [drm:intel_print_wm_latency [i915]] Primary W=
M2 latency 16 (8.0 usec)
kern  :debug : [   74.789865] [drm:intel_print_wm_latency [i915]] Primary W=
M3 latency 32 (16.0 usec)
kern  :debug : [   74.790345] [drm:intel_print_wm_latency [i915]] Sprite WM=
0 latency 12 (1.2 usec)
kern  :debug : [   74.790807] [drm:intel_print_wm_latency [i915]] Sprite WM=
1 latency 4 (2.0 usec)
kern  :debug : [   74.791266] [drm:intel_print_wm_latency [i915]] Sprite WM=
2 latency 16 (8.0 usec)
kern  :debug : [   74.791720] [drm:intel_print_wm_latency [i915]] Sprite WM=
3 latency 32 (16.0 usec)
kern  :debug : [   74.792193] [drm:intel_print_wm_latency [i915]] Cursor WM=
0 latency 12 (1.2 usec)
kern  :debug : [   74.792645] [drm:intel_print_wm_latency [i915]] Cursor WM=
1 latency 4 (2.0 usec)
kern  :debug : [   74.793097] [drm:intel_print_wm_latency [i915]] Cursor WM=
2 latency 16 (8.0 usec)
kern  :debug : [   74.793548] [drm:intel_print_wm_latency [i915]] Cursor WM=
3 latency 32 (16.0 usec)
kern  :debug : [   74.794015] [drm:intel_modeset_init [i915]] 3 display pip=
es available.
kern  :debug : [   74.794492] [drm:intel_modeset_init [i915]] FDI PLL freq=
=3D270000
kern  :debug : [   74.794873] [drm:intel_dump_cdclk_state [i915]] Current C=
DCLK 400000 kHz, VCO 0 kHz, ref 0 kHz, bypass 0 kHz, voltage level 0
kern  :debug : [   74.795548] [drm:intel_update_max_cdclk [i915]] Max CD cl=
ock rate: 400000 kHz
kern  :debug : [   74.795989] [drm:intel_modeset_init [i915]] Max dotclock =
rate: 360000 kHz
kern  :info  : [   74.796389] i915 0000:00:02.0: vgaarb: changed VGA decode=
s: olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
kern  :debug : [   74.797301] [drm:intel_lvds_init [i915]] LVDS PPS:t1+t2 4=
00 t3 100 t4 4000 t5 3000 tx 2500 divider 6249 port 0 powerdown_on_reset 1
user  :notice: [   74.801146] Kernel tests: Boot OK!

kern  :debug : [   74.813004] [drm:drm_add_edid_modes.part.27 [drm]] ELD: n=
o CEA Extension found
kern  :debug : [   74.813456] [drm:drm_add_display_info [drm]] non_desktop =
set to 0
kern  :debug : [   74.813813] [drm:drm_add_display_info [drm]] LVDS-1: Assi=
gning EDID-1.4 digital sink color depth as 6 bpc.
kern  :debug : [   74.814882] [drm:drm_add_display_info [drm]] non_desktop =
set to 0
kern  :debug : [   74.815252] [drm:drm_add_display_info [drm]] LVDS-1: Assi=
gning EDID-1.4 digital sink color depth as 6 bpc.
kern  :debug : [   74.819399] [drm:intel_lvds_init [i915]] using preferred =
mode from EDID:=20
kern  :debug : [   74.819424] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 67:"1366x768" 60 74980 1366 1404 1426 1572 768 771 777 794 0x48 0xa
kern  :debug : [   74.820757] [drm:intel_panel_setup_backlight [i915]] Conn=
ector LVDS-1 backlight initialized, enabled, brightness 4882/4882
kern  :debug : [   74.821462] [drm:intel_lvds_init [i915]] detected single-=
link lvds configuration
kern  :debug : [   74.822138] [drm:intel_crt_reset [i915]] crt adpa set to =
0xf40000
kern  :debug : [   74.822701] [drm:intel_gmbus_force_bit [i915]] enabling b=
it-banging on i915 gmbus dpb. force bit now 1
user  :notice: [   74.824217] install debs round one: dpkg -i --force-confd=
ef --force-depends /opt/deb/debconf_1.5.66_all.deb

kern  :debug : [   74.824870] [drm:intel_sdvo_read_byte [i915]] i2c transfe=
r returned -6
kern  :debug : [   74.824919] [drm:intel_sdvo_init [i915]] No SDVO device f=
ound on SDVOB
kern  :debug : [   74.825939] [drm:intel_gmbus_force_bit [i915]] disabling =
bit-banging on i915 gmbus dpb. force bit now 0
kern  :debug : [   74.826524] [drm:intel_hdmi_init_connector [i915]] Adding=
 HDMI connector on port B
kern  :debug : [   74.827000] [drm:intel_hdmi_init_connector [i915]] Using =
DDC pin 0x5 for port B (platform default)
kern  :debug : [   74.827572] [drm:intel_dp_init_connector [i915]] Adding D=
P connector on port B
kern  :debug : [   74.828280] [drm:intel_dp_init_connector [i915]] using AU=
X B for port B (platform default)
user  :notice: [   74.828514] /opt/deb/libtext-charwidth-perl_0.04-7.1_amd6=
4.deb

kern  :debug : [   74.828809] [drm:intel_init_pch_refclk [i915]] has_panel =
1 has_lvds 1 has_ck505 0 using_ssc_source 1
kern  :debug : [   74.829922] [drm:intel_modeset_setup_hw_state [i915]] pip=
e A active planes 0x1
kern  :debug : [   74.830442] [drm:intel_modeset_setup_hw_state [i915]] pip=
e A active planes 0x1
kern  :debug : [   74.830917] [drm:intel_modeset_setup_hw_state [i915]] pip=
e A active planes 0x1
kern  :debug : [   74.831374] [drm:intel_modeset_setup_hw_state [i915]] [CR=
TC:39:pipe A] hw state readout: enabled
kern  :debug : [   74.832074] [drm:intel_modeset_setup_hw_state [i915]] pip=
e B active planes 0x1
kern  :debug : [   74.832523] [drm:intel_modeset_setup_hw_state [i915]] pip=
e B active planes 0x1
kern  :debug : [   74.833279] [drm:intel_modeset_setup_hw_state [i915]] pip=
e B active planes 0x1
kern  :debug : [   74.833731] [drm:intel_modeset_setup_hw_state [i915]] [CR=
TC:51:pipe B] hw state readout: enabled
user  :notice: [   74.834146] /opt/deb/libtext-iconv-perl_1.7-5+b6_amd64.deb

kern  :debug : [   74.834425] [drm:intel_modeset_setup_hw_state [i915]] pip=
e C active planes 0x0
kern  :debug : [   74.835257] [drm:intel_modeset_setup_hw_state [i915]] pip=
e C active planes 0x0
kern  :debug : [   74.835832] [drm:intel_modeset_setup_hw_state [i915]] pip=
e C active planes 0x0
kern  :debug : [   74.836300] [drm:intel_modeset_setup_hw_state [i915]] [CR=
TC:63:pipe C] hw state readout: disabled
user  :notice: [   74.836930] /opt/deb/perl-base_5.26.1-5_amd64.deb

kern  :debug : [   74.837043] [drm:intel_modeset_setup_hw_state [i915]] PCH=
 DPLL A hw state readout: crtc_mask 0x00000001, on 1
kern  :debug : [   74.838323] [drm:intel_modeset_setup_hw_state [i915]] PCH=
 DPLL B hw state readout: crtc_mask 0x00000002, on 1
kern  :debug : [   74.838992] [drm:intel_modeset_setup_hw_state [i915]] [EN=
CODER:65:LVDS] hw state readout: enabled, pipe A
kern  :debug : [   74.839681] [drm:intel_modeset_setup_hw_state [i915]] [EN=
CODER:71:CRT] hw state readout: disabled, pipe A
user  :notice: [   74.840084] /opt/deb/liblocale-gettext-perl_1.07-3+b3_amd=
64.deb

kern  :debug : [   74.840526] [drm:intel_modeset_setup_hw_state [i915]] [EN=
CODER:72:HDMI B] hw state readout: enabled, pipe B
kern  :debug : [   74.841587] [drm:intel_modeset_setup_hw_state [i915]] [EN=
CODER:77:DP B] hw state readout: disabled, pipe A
kern  :debug : [   74.842280] [drm:intel_modeset_setup_hw_state [i915]] [CO=
NNECTOR:64:LVDS-1] hw state readout: enabled
kern  :debug : [   74.843036] [drm:intel_modeset_setup_hw_state [i915]] [CO=
NNECTOR:70:VGA-1] hw state readout: disabled
user  :notice: [   74.843429] /opt/deb/perl-modules-5.26_5.26.1-5_all.deb

kern  :debug : [   74.843760] [drm:intel_modeset_setup_hw_state [i915]] [CO=
NNECTOR:73:HDMI-A-1] hw state readout: enabled
kern  :debug : [   74.844564] [drm:intel_modeset_setup_hw_state [i915]] [CO=
NNECTOR:78:DP-1] hw state readout: disabled
kern  :debug : [   74.845143] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[MODE:1366x768] for CRTC state 000000008bd30e94
kern  :debug : [   74.845682] [drm:drm_calc_timestamping_constants [drm]] c=
rtc 39: hwmode: htotal 1572, vtotal 794, vdisplay 768
user  :notice: [   74.845860] /opt/deb/mime-support_3.60_all.deb
kern  :debug : [   74.846280] [drm:intel_modeset_setup_hw_state [i915]] crt=
c 39: clock 75238 kHz framedur 16589595 linedur 20893
kern  :debug : [   74.846440] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[MODE:1280x1024] for CRTC state 00000000eba6a197

kern  :debug : [   74.847101] [drm:drm_calc_timestamping_constants [drm]] c=
rtc 51: hwmode: htotal 1688, vtotal 1066, vdisplay 1024
kern  :debug : [   74.847146] [drm:intel_modeset_setup_hw_state [i915]] crt=
c 51: clock 108000 kHz framedur 16661185 linedur 15629
kern  :debug : [   74.848889] [drm:intel_dump_pipe_config [i915]] [CRTC:39:=
pipe A][setup_hw_state]
kern  :debug : [   74.849343] [drm:intel_dump_pipe_config [i915]] output_ty=
pes: LVDS (0x10)
kern  :debug : [   74.849758] [drm:intel_dump_pipe_config [i915]] cpu_trans=
coder: A, pipe bpp: 18, dithering: 0
kern  :debug : [   74.850266] [drm:intel_dump_pipe_config [i915]] fdi: lane=
s: 1; gmch_m: 2620740, gmch_n: 4194304, link_m: 145596, link_n: 524288, tu:=
 64
user  :notice: [   74.850681] /opt/deb/libgdbm-compat4_1.14.1-6_amd64.deb
kern  :debug : [   74.850963] [drm:intel_dump_pipe_config [i915]] audio: 0,=
 infoframes: 0

kern  :debug : [   74.851292] [drm:intel_dump_pipe_config [i915]] requested=
 mode:
kern  :debug : [   74.851315] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 0:"1366x768" 60 75238 1366 1404 1426 1572 768 771 777 794 0x40 0xa
kern  :debug : [   74.852776] [drm:intel_dump_pipe_config [i915]] adjusted =
mode:
kern  :debug : [   74.853160] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 0:"1366x768" 60 75238 1366 1404 1426 1572 768 771 777 794 0x40 0xa
user  :notice: [   74.853774] /opt/deb/libperl5.26_5.26.1-5_amd64.deb
kern  :debug : [   74.853889] [drm:intel_dump_pipe_config [i915]] crtc timi=
ngs: 75238 1366 1404 1426 1572 768 771 777 794, type: 0x40 flags: 0xa

kern  :debug : [   74.855028] [drm:intel_dump_pipe_config [i915]] port cloc=
k: 75238, pipe src size: 1366x768, pixel rate 75238
kern  :debug : [   74.855665] [drm:intel_dump_pipe_config [i915]] pch pfit:=
 pos: 0x00000000, size: 0x00000000, disabled
kern  :debug : [   74.856282] [drm:intel_dump_pipe_config [i915]] ips: 0, d=
ouble wide: 0
kern  :debug : [   74.856750] [drm:intel_dump_pipe_config [i915]] dpll_hw_s=
tate: dpll: 0x88046004, dpll_md: 0x0, fp0: 0x10c07, fp1: 0x10c07
user  :notice: [   74.857363] /opt/deb/libssl1.1_1.1.0h-2_amd64.deb

kern  :debug : [   74.857460] [drm:intel_dump_pipe_config [i915]] planes on=
 this crtc
kern  :debug : [   74.858147] [drm:intel_dump_pipe_config [i915]] [PLANE:28=
:primary A] disabled, scaler_id =3D 0
kern  :debug : [   74.858648] [drm:intel_dump_pipe_config [i915]] [PLANE:31=
:sprite A] disabled, scaler_id =3D 0
kern  :debug : [   74.859147] [drm:intel_dump_pipe_config [i915]] [PLANE:36=
:cursor A] disabled, scaler_id =3D 0
user  :notice: [   74.859453] /opt/deb/sysstat_11.6.1-1_amd64.deb

kern  :debug : [   74.859661] [drm:intel_dump_pipe_config [i915]] [CRTC:51:=
pipe B][setup_hw_state]
kern  :debug : [   74.860410] [drm:intel_dump_pipe_config [i915]] output_ty=
pes: HDMI (0x40)
kern  :debug : [   74.860844] [drm:intel_dump_pipe_config [i915]] cpu_trans=
coder: B, pipe bpp: 24, dithering: 0
kern  :debug : [   74.861365] [drm:intel_dump_pipe_config [i915]] fdi: lane=
s: 2; gmch_m: 5033164, gmch_n: 8388608, link_m: 209715, link_n: 524288, tu:=
 64
kern  :debug : [   74.862077] [drm:intel_dump_pipe_config [i915]] audio: 0,=
 infoframes: 1
user  :notice: [   74.862078] /opt/deb/gawk_1%3a4.1.4+dfsg-1+b1_amd64.deb

kern  :debug : [   74.862488] [drm:intel_dump_pipe_config [i915]] requested=
 mode:
kern  :debug : [   74.863206] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 0:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0=
x5
kern  :debug : [   74.863927] [drm:intel_dump_pipe_config [i915]] adjusted =
mode:
kern  :debug : [   74.864286] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 0:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0=
x5
kern  :debug : [   74.865014] [drm:intel_dump_pipe_config [i915]] crtc timi=
ngs: 108000 1280 1328 1440 1688 1024 1025 1028 1066, type: 0x40 flags: 0x5
kern  :debug : [   74.865725] [drm:intel_dump_pipe_config [i915]] port cloc=
k: 108000, pipe src size: 1280x1024, pixel rate 108000
kern  :debug : [   74.866347] [drm:intel_dump_pipe_config [i915]] pch pfit:=
 pos: 0x00000000, size: 0x00000000, disabled
user  :notice: [   74.866544] (Reading database ... 2202 files and director=
ies currently installed.)
kern  :debug : [   74.866952] [drm:intel_dump_pipe_config [i915]] ips: 0, d=
ouble wide: 0

kern  :debug : [   74.867951] [drm:intel_dump_pipe_config [i915]] dpll_hw_s=
tate: dpll: 0xc4040004, dpll_md: 0x0, fp0: 0x10c09, fp1: 0x10c09
kern  :debug : [   74.868662] [drm:intel_dump_pipe_config [i915]] planes on=
 this crtc
kern  :debug : [   74.869100] [drm:intel_dump_pipe_config [i915]] [PLANE:40=
:primary B] disabled, scaler_id =3D 0
kern  :debug : [   74.869613] [drm:intel_dump_pipe_config [i915]] [PLANE:43=
:sprite B] disabled, scaler_id =3D 0
kern  :debug : [   74.870128] [drm:intel_dump_pipe_config [i915]] [PLANE:48=
:cursor B] disabled, scaler_id =3D 0
user  :notice: [   74.870421] Preparing to unpack .../opt/deb/debconf_1.5.6=
6_all.deb ...
kern  :debug : [   74.870636] [drm:intel_dump_pipe_config [i915]] [CRTC:63:=
pipe C][setup_hw_state]

kern  :debug : [   74.871564] [drm:intel_dump_pipe_config [i915]] output_ty=
pes:  (0x0)
kern  :debug : [   74.871981] [drm:intel_dump_pipe_config [i915]] cpu_trans=
coder: C, pipe bpp: 0, dithering: 0
kern  :debug : [   74.872515] [drm:intel_dump_pipe_config [i915]] audio: 0,=
 infoframes: 0
kern  :debug : [   74.872943] [drm:intel_dump_pipe_config [i915]] requested=
 mode:
user  :notice: [   74.873073] Unpacking debconf (1.5.66) over (1.5.59) ...

kern  :debug : [   74.873318] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
kern  :debug : [   74.874231] [drm:intel_dump_pipe_config [i915]] adjusted =
mode:
kern  :debug : [   74.874611] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 0:"" 0 0 0 0 0 0 0 0 0 0 0x0 0x0
kern  :debug : [   74.875169] [drm:intel_dump_pipe_config [i915]] crtc timi=
ngs: 0 0 0 0 0 0 0 0 0, type: 0x0 flags: 0x0
kern  :debug : [   74.875720] [drm:intel_dump_pipe_config [i915]] port cloc=
k: 0, pipe src size: 0x0, pixel rate 0
kern  :debug : [   74.876297] [drm:intel_dump_pipe_config [i915]] pch pfit:=
 pos: 0x00000000, size: 0x00000000, disabled
kern  :debug : [   74.876847] [drm:intel_dump_pipe_config [i915]] ips: 0, d=
ouble wide: 0
kern  :debug : [   74.877283] [drm:intel_dump_pipe_config [i915]] dpll_hw_s=
tate: dpll: 0x0, dpll_md: 0x0, fp0: 0x0, fp1: 0x0
kern  :debug : [   74.877855] [drm:intel_dump_pipe_config [i915]] planes on=
 this crtc
kern  :debug : [   74.878253] [drm:intel_dump_pipe_config [i915]] [PLANE:52=
:primary C] disabled, scaler_id =3D 0
kern  :debug : [   74.878762] [drm:intel_dump_pipe_config [i915]] [PLANE:55=
:sprite C] disabled, scaler_id =3D 0
kern  :debug : [   74.879272] [drm:intel_dump_pipe_config [i915]] [PLANE:60=
:cursor C] disabled, scaler_id =3D 0
kern  :debug : [   74.879752] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (2)
kern  :debug : [   74.880079] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (2)
kern  :debug : [   74.880444] [drm:i9xx_get_initial_plane_config [i915]] pi=
pe A/primary A with fb: size=3D1366x768@32, offset=3D61000, pitch 5504, siz=
e 0x408000
kern  :debug : [   74.881187] [drm:i915_gem_object_create_stolen_for_preall=
ocated [i915]] creating preallocated stolen object: stolen_offset=3D0x00000=
00000061000, gtt_offset=3D0x0000000000061000, size=3D0x0000000000408000
kern  :debug : [   74.882197] [drm:intel_alloc_initial_plane_obj.isra.126 [=
i915]] initial plane fb obj 000000005efa24f9
kern  :debug : [   74.882756] [drm:drm_mode_object_get [drm]] OBJ ID: 81 (1)
kern  :debug : [   74.883118] [drm:intel_modeset_init [i915]] pipe A active=
 planes 0x1
kern  :debug : [   74.883532] [drm:i9xx_get_initial_plane_config [i915]] pi=
pe B/primary B with fb: size=3D1280x1024@32, offset=3D61000, pitch 5504, si=
ze 0x560000
kern  :debug : [   74.884260] [drm:i915_gem_object_create_stolen_for_preall=
ocated [i915]] creating preallocated stolen object: stolen_offset=3D0x00000=
00000061000, gtt_offset=3D0x0000000000061000, size=3D0x0000000000560000
kern  :debug : [   74.885295] [drm:i915_gem_object_create_stolen_for_preall=
ocated [i915]] failed to allocate stolen space
kern  :debug : [   74.885830] [drm:drm_mode_object_get [drm]] OBJ ID: 81 (2)
kern  :debug : [   74.886174] [drm:drm_mode_object_get [drm]] OBJ ID: 81 (3)
kern  :debug : [   74.886514] [drm:intel_modeset_init [i915]] pipe B active=
 planes 0x1
kern  :debug : [   74.886880] [drm:drm_atomic_state_init [drm]] Allocated a=
tomic state 00000000d8608f6d
kern  :debug : [   74.887441] [drm:drm_mode_object_get [drm]] OBJ ID: 79 (1)
kern  :debug : [   74.887768] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:39:pipe A] 00000000d1f22371 state to 00000000d8608f6d
kern  :debug : [   74.888362] [drm:drm_mode_object_get [drm]] OBJ ID: 80 (1)
kern  :debug : [   74.888685] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:51:pipe B] 00000000321d2bc6 state to 00000000d8608f6d
kern  :debug : [   74.889280] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:63:pipe C] 00000000b52b2b11 state to 00000000d8608f6d
kern  :debug : [   74.889867] [drm:drm_mode_object_get [drm]] OBJ ID: 81 (4)
kern  :debug : [   74.890193] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:28:primary A] 00000000de4526d0 state to 00000000d8608f6d
kern  :debug : [   74.890811] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:31:sprite A] 000000002915a471 state to 00000000d8608f6d
kern  :debug : [   74.891427] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:36:cursor A] 00000000d59b7014 state to 00000000d8608f6d
kern  :debug : [   74.892046] [drm:drm_mode_object_get [drm]] OBJ ID: 81 (5)
kern  :debug : [   74.892373] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:40:primary B] 00000000283fd1ad state to 00000000d8608f6d
kern  :debug : [   74.892988] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:43:sprite B] 00000000cc2aac2f state to 00000000d8608f6d
kern  :debug : [   74.893603] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:48:cursor B] 000000003b1337ea state to 00000000d8608f6d
kern  :debug : [   74.894232] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:52:primary C] 00000000aa8659ff state to 00000000d8608f6d
kern  :debug : [   74.894850] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:55:sprite C] 00000000898ac315 state to 00000000d8608f6d
kern  :debug : [   74.895469] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:60:cursor C] 000000004bc36e9e state to 00000000d8608f6d
kern  :debug : [   74.896092] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (3)
kern  :debug : [   74.896421] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (4)
kern  :debug : [   74.896753] [drm:drm_atomic_get_connector_state [drm]] Ad=
ded [CONNECTOR:64:LVDS-1] 00000000d596c2bb state to 00000000d8608f6d
kern  :debug : [   74.897406] [drm:drm_mode_object_get [drm]] OBJ ID: 70 (2)
kern  :debug : [   74.897725] [drm:drm_atomic_get_connector_state [drm]] Ad=
ded [CONNECTOR:70:VGA-1] 00000000e9b85ac3 state to 00000000d8608f6d
kern  :debug : [   74.898494] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (3)
kern  :info  : [   74.898503] intel_rapl: Found RAPL domain package
kern  :debug : [   74.898812] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (4)
kern  :info  : [   74.899074] intel_rapl: Found RAPL domain core
kern  :info  : [   74.899075] intel_rapl: Found RAPL domain uncore
kern  :debug : [   74.899918] [drm:drm_atomic_get_connector_state [drm]] Ad=
ded [CONNECTOR:73:HDMI-A-1] 0000000080b0b674 state to 00000000d8608f6d
kern  :debug : [   74.900608] [drm:drm_mode_object_get [drm]] OBJ ID: 78 (2)
kern  :debug : [   74.900945] [drm:drm_atomic_get_connector_state [drm]] Ad=
ded [CONNECTOR:78:DP-1] 00000000f5d1dab0 state to 00000000d8608f6d
kern  :debug : [   74.901576] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Updating routing for [CONNECTOR:64:LVDS-1]
kern  :debug : [   74.902153] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] [CONNECTOR:64:LVDS-1] keeps [ENCODER:65:LVDS], now on [CRTC:39:pi=
pe A]
kern  :debug : [   74.902848] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Updating routing for [CONNECTOR:70:VGA-1]
kern  :debug : [   74.903419] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Disabling [CONNECTOR:70:VGA-1]
kern  :debug : [   74.903911] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Updating routing for [CONNECTOR:73:HDMI-A-1]
user  :notice: [   74.903935] Preparing to unpack .../libtext-charwidth-per=
l_0.04-7.1_amd64.deb ...
kern  :debug : [   74.904487] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] [CONNECTOR:73:HDMI-A-1] keeps [ENCODER:72:HDMI B], now on [CRTC:5=
1:pipe B]
kern  :debug : [   74.904495] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Updating routing for [CONNECTOR:78:DP-1]
kern  :debug : [   74.904505] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Disabling [CONNECTOR:78:DP-1]

kern  :debug : [   74.905683] [drm:intel_plane_atomic_calc_changes [i915]] =
[CRTC:39:pipe A] has [PLANE:28:primary A] with fb 81
kern  :debug : [   74.907343] [drm:intel_plane_atomic_calc_changes [i915]] =
[PLANE:28:primary A] visible 1 -> 1, off 0, on 0, ms 0
kern  :debug : [   74.907915] [drm:drm_atomic_helper_check_plane_state [drm=
_kms_helper]] Plane must cover entire CRTC
user  :notice: [   74.908249] Unpacking libtext-charwidth-perl (0.04-7.1) o=
ver (0.04-7+b4) ...

kern  :debug : [   74.908444] [drm:drm_rect_debug_print [drm]] dst: 1280x76=
8+0+0
kern  :debug : [   74.909279] [drm:drm_rect_debug_print [drm]] clip: 1280x1=
024+0+0
kern  :debug : [   74.909653] [drm:drm_atomic_helper_check_planes [drm_kms_=
helper]] [PLANE:40:primary B] atomic driver check failed
kern  :warn  : [   74.910220] ------------[ cut here ]------------
kern  :warn  : [   74.910478] Could not determine valid watermarks for inhe=
rited state
kern  :warn  : [   74.910918] WARNING: CPU: 1 PID: 182 at drivers/gpu/drm/i=
915/intel_display.c:14584 intel_modeset_init+0x3be/0x1060 [i915]
kern  :warn  : [   74.911626] Modules linked in: intel_rapl x86_pkg_temp_th=
ermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul cr=
c32_pclmul crc32c_intel ghash_clmulni_intel wmi_bmof pcbc aesni_intel crypt=
o_simd cryptd glue_helper snd_hda_intel(+) pcspkr snd_hda_codec serio_raw a=
hci(+) snd_hda_core libahci bcma libata snd_hwdep i915(+) snd_pcm snd_timer=
 snd soundcore drm_kms_helper syscopyarea sysfillrect sysimgblt uvcvideo fb=
_sys_fops videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_commo=
n drm videodev shpchp ideapad_laptop wmi sparse_keymap rfkill video ip_tabl=
es
kern  :warn  : [   74.914451] CPU: 1 PID: 182 Comm: systemd-udevd Not taint=
ed 4.17.0-rc1 #1
kern  :warn  : [   74.914823] Hardware name: LENOVO IdeaPad U410    /Lenovo=
          , BIOS 65CN15WW 06/05/2012
kern  :warn  : [   74.915360] RIP: 0010:intel_modeset_init+0x3be/0x1060 [i9=
15]
kern  :warn  : [   74.915672] RSP: 0018:ffffc9000098baf0 EFLAGS: 00010282
kern  :warn  : [   74.915963] RAX: 0000000000000038 RBX: ffff88011a830000 R=
CX: 0000000000000006
kern  :warn  : [   74.916357] RDX: 0000000000000007 RSI: 0000000000000082 R=
DI: ffff88011f256910
kern  :warn  : [   74.916750] RBP: ffff88011bda0c00 R08: 0000000000000431 R=
09: 000000000000000a
kern  :warn  : [   74.917144] R10: ffffc9000098b988 R11: ffffffff82d4e10d R=
12: ffff88011b073c00
kern  :warn  : [   74.917536] R13: 00000000ffffffea R14: 0000000000000000 R=
15: ffff88011a830358
kern  :warn  : [   74.917928] FS:  00007f33ab3d38c0(0000) GS:ffff88011f2400=
00(0000) knlGS:0000000000000000
kern  :warn  : [   74.918383] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
kern  :warn  : [   74.918704] CR2: 00007f569824e028 CR3: 000000011bc24001 C=
R4: 00000000001606e0
kern  :warn  : [   74.919097] Call Trace:
user  :notice: [   74.919135] Preparing to unpack .../libtext-iconv-perl_1.=
7-5+b6_amd64.deb ...

kern  :warn  : [   74.919299]  i915_driver_load+0xa99/0xee0 [i915]
kern  :warn  : [   74.919995]  ? acpi_dev_found+0x5f/0x70
kern  :warn  : [   74.920215]  local_pci_probe+0x42/0xa0
kern  :warn  : [   74.920432]  ? _cond_resched+0x19/0x30
kern  :warn  : [   74.920649]  pci_device_probe+0x11d/0x180
kern  :warn  : [   74.920885]  driver_probe_device+0x30b/0x480
kern  :warn  : [   74.921134]  __driver_attach+0xb8/0xe0
kern  :warn  : [   74.921355]  ? driver_probe_device+0x480/0x480
kern  :warn  : [   74.921611]  bus_for_each_dev+0x65/0x90
kern  :warn  : [   74.921850]  bus_add_driver+0x161/0x260
kern  :warn  : [   74.922077]  ? 0xffffffffa038b000
kern  :warn  : [   74.922280]  driver_register+0x57/0xc0
kern  :warn  : [   74.922505]  ? 0xffffffffa038b000
user  :notice: [   74.922614] Unpacking libtext-iconv-perl (1.7-5+b6) over =
(1.7-5+b3) ...
kern  :warn  : [   74.922706]  do_one_initcall+0x36/0x1bb

kern  :warn  : [   74.923093]  ? _cond_resched+0x19/0x30
kern  :warn  : [   74.923100]  ? kmem_cache_alloc_trace+0x3e/0x1e0
kern  :warn  : [   74.923912]  do_init_module+0x5b/0x1f8
kern  :warn  : [   74.924125]  load_module+0x1465/0x1b50
kern  :warn  : [   74.924354]  ? kernel_read_file+0x165/0x180
kern  :warn  : [   74.924605]  ? __do_sys_finit_module+0xb7/0xd0
kern  :warn  : [   74.924856]  __do_sys_finit_module+0xb7/0xd0
kern  :warn  : [   74.925131]  do_syscall_64+0x5b/0x180
kern  :warn  : [   74.925357]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
kern  :warn  : [   74.925637] RIP: 0033:0x7f33aa24dd49
kern  :warn  : [   74.925838] RSP: 002b:00007fff7deb4c58 EFLAGS: 00000246 O=
RIG_RAX: 0000000000000139
kern  :warn  : [   74.926252] RAX: ffffffffffffffda RBX: 000055b9bb729710 R=
CX: 00007f33aa24dd49
kern  :warn  : [   74.926647] RDX: 0000000000000000 RSI: 00007f33aab6a0ed R=
DI: 0000000000000014
kern  :warn  : [   74.927045] RBP: 00007f33aab6a0ed R08: 0000000000000000 R=
09: 0000000000000000
kern  :warn  : [   74.927444] R10: 0000000000000014 R11: 0000000000000246 R=
12: 0000000000000000
kern  :warn  : [   74.927838] R13: 000055b9bb728120 R14: 0000000000020000 R=
15: 0000000000000000
kern  :warn  : [   74.928233] Code: 00 f7 c6 00 00 18 00 0f 84 d7 0a 00 00 =
85 c9 0f 94 c1 41 88 8c 24 8d 02 00 00 e9 f6 08 00 00 48 c7 c7 60 45 2f a0 =
e8 b2 d4 e0 e0 <0f> 0b f0 41 ff 0c 24 0f 88 7d 8e 04 00 75 08 4c 89 e7 e8 8=
b 39=20
kern  :warn  : [   74.929372] ---[ end trace 0b501c8bfa1b8d26 ]---
kern  :debug : [   74.929665] [drm:drm_atomic_state_default_clear [drm]] Cl=
earing atomic state 00000000d8608f6d
kern  :debug : [   74.930156] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (4)
kern  :debug : [   74.930512] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (3)
kern  :debug : [   74.930867] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 70 (2)
kern  :debug : [   74.931232] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (4)
kern  :debug : [   74.931587] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (3)
kern  :debug : [   74.931941] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 78 (2)
kern  :debug : [   74.932302] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 79 (2)
user  :notice: [   74.932435] Preparing to unpack .../perl-base_5.26.1-5_am=
d64.deb ...
kern  :debug : [   74.932656] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 80 (2)

kern  :debug : [   74.933458] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 81 (6)
kern  :debug : [   74.933810] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 81 (5)
kern  :debug : [   74.934172] [drm:__drm_atomic_state_free [drm]] Freeing a=
tomic state 00000000d8608f6d
user  :notice: [   74.934527] Unpacking perl-base (5.26.1-5) over (5.22.2-3=
) ...

kern  :debug : [   74.934679] [drm:i915_gem_init_ggtt [i915]] clearing unus=
ed GTT space: [1000, 61000]
kern  :debug : [   74.935487] [drm:i915_gem_init_ggtt [i915]] clearing unus=
ed GTT space: [469000, 80000000]
kern  :debug : [   74.938336] [drm:i915_ppgtt_create [i915]] Allocated pde =
space (2M) at GTT entry: 7fe00
kern  :debug : [   74.938802] [drm:i915_ppgtt_create [i915]] Adding PPGTT a=
t offset 7fe00000
kern  :debug : [   74.939219] [drm:i915_gem_contexts_init [i915]] logical c=
ontext support initialized
kern  :debug : [   74.939742] [drm:intel_engine_init_common [i915]] rcs0 hw=
s offset: 0x7fdfd000
kern  :debug : [   74.940185] [drm:intel_engine_create_scratch [i915]] rcs0=
 pipe control offset: 0x7fdfc000
kern  :debug : [   74.940690] [drm:intel_engine_init_common [i915]] bcs0 hw=
s offset: 0x7fdfb000
kern  :debug : [   74.941208] [drm:intel_engine_init_common [i915]] vcs0 hw=
s offset: 0x7fdfa000
kern  :debug : [   74.941639] [drm:intel_init_gt_powersave [i915]] Overcloc=
king supported, max: 1050MHz, overclock: 1050MHz
kern  :debug : [   74.942216] [drm:init_workarounds_ring [i915]] rcs0: Numb=
er of context specific w/a: 0
kern  :debug : [   74.942830] [drm:intel_fbdev_init [i915]] found possible =
fb from plane A
kern  :debug : [   74.943240] [drm:intel_fbdev_init [i915]] pipe C not acti=
ve or no fb, skipping
kern  :debug : [   74.943668] [drm:intel_fbdev_init [i915]] checking plane =
A for BIOS fb
kern  :debug : [   74.944082] [drm:intel_fbdev_init [i915]] pipe A area: 13=
66x768, bpp: 32, size: 4227072
kern  :debug : [   74.944562] [drm:intel_fbdev_init [i915]] fb big enough f=
or plane A (4227072 >=3D 4227072)
kern  :debug : [   74.945051] [drm:intel_fbdev_init [i915]] checking plane =
B for BIOS fb
kern  :debug : [   74.945444] [drm:intel_fbdev_init [i915]] pipe B area: 12=
80x1024, bpp: 32, size: 5636096
kern  :debug : [   74.945912] [drm:intel_fbdev_init [i915]] fb not big enou=
gh for plane B (5636096 vs 4227072)
kern  :debug : [   74.946405] [drm:intel_fbdev_init [i915]] BIOS fb not sui=
table for all pipes, not using
kern  :debug : [   74.946864] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (3)
kern  :debug : [   74.947185] [drm:drm_mode_object_get [drm]] OBJ ID: 70 (2)
kern  :debug : [   74.947497] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (3)
kern  :debug : [   74.947808] [drm:drm_mode_object_get [drm]] OBJ ID: 78 (2)
kern  :debug : [   74.948249] [drm:drm_minor_register [drm]]=20
kern  :debug : [   74.948495] [drm:drm_minor_register [drm]]=20
kern  :debug : [   74.948809] [drm:drm_minor_register [drm]] new minor regi=
stered 128
kern  :debug : [   74.949176] [drm:drm_minor_register [drm]]=20
kern  :debug : [   74.949470] [drm:drm_minor_register [drm]] new minor regi=
stered 0
kern  :debug : [   74.949860] [drm:drm_sysfs_connector_add [drm]] adding "L=
VDS-1" to sysfs
kern  :debug : [   74.950243] [drm:drm_sysfs_hotplug_event [drm]] generatin=
g hotplug event
kern  :debug : [   74.950703] [drm:intel_backlight_device_register [i915]] =
Connector LVDS-1 backlight sysfs interface registered
kern  :debug : [   74.951298] [drm:drm_sysfs_connector_add [drm]] adding "V=
GA-1" to sysfs
kern  :debug : [   74.951670] [drm:drm_sysfs_hotplug_event [drm]] generatin=
g hotplug event
kern  :debug : [   74.952100] [drm:drm_sysfs_connector_add [drm]] adding "H=
DMI-A-1" to sysfs
kern  :debug : [   74.952489] [drm:drm_sysfs_hotplug_event [drm]] generatin=
g hotplug event
kern  :debug : [   74.952898] [drm:drm_sysfs_connector_add [drm]] adding "D=
P-1" to sysfs
kern  :debug : [   74.953280] [drm:drm_sysfs_hotplug_event [drm]] generatin=
g hotplug event
kern  :debug : [   74.953723] [drm:intel_dp_connector_register [i915]] regi=
stering DPDDC-B bus for card0-DP-1
kern  :info  : [   74.954222] [drm] Initialized i915 1.6.0 20180308 for 000=
0:00:02.0 on minor 0
kern  :debug : [   74.954757] [drm:intel_opregion_register [i915]] 4 output=
s detected
kern  :info  : [   74.956828] ACPI: Video Device [GFX0] (multi-head: yes  r=
om: no  post: no)
kern  :info  : [   74.957405] input: Video Bus as /devices/LNXSYSTM:00/LNXS=
YBUS:00/PNP0A08:00/LNXVIDEO:00/input/input18
kern  :debug : [   74.958045] i915 device info: pciid=3D0x0166 rev=3D0x09 p=
latform=3DIVYBRIDGE gen=3D7
kern  :debug : [   74.958161] [drm:drm_setup_crtcs [drm_kms_helper]]=20
kern  :debug : [   74.958438] i915 device info: is_mobile: yes
kern  :debug : [   74.958720] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:64:LVDS-1]
kern  :debug : [   74.958950] i915 device info: is_lp: no
kern  :debug : [   74.959491] [drm:intel_lvds_detect [i915]] [CONNECTOR:64:=
LVDS-1]
kern  :debug : [   74.959658] i915 device info: is_alpha_support: no
kern  :debug : [   74.959994] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:64:LVDS-1] status updated from unknown to conn=
ected
kern  :debug : [   74.960262] i915 device info: has_64bit_reloc: no
kern  :debug : [   74.960265] i915 device info: has_aliasing_ppgtt: yes
kern  :debug : [   74.960966] [drm:drm_add_edid_modes.part.27 [drm]] ELD: n=
o CEA Extension found
kern  :debug : [   74.961217] i915 device info: has_csr: no
kern  :debug : [   74.961506] [drm:drm_add_display_info [drm]] non_desktop =
set to 0
kern  :debug : [   74.961893] i915 device info: has_ddi: no
kern  :debug : [   74.962138] [drm:drm_add_display_info [drm]] LVDS-1: Assi=
gning EDID-1.4 digital sink color depth as 6 bpc.
kern  :debug : [   74.962461] i915 device info: has_dp_mst: no
kern  :debug : [   74.962709] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:64:LVDS-1] probed modes :
kern  :debug : [   74.963218] i915 device info: has_reset_engine: no
kern  :debug : [   74.963221] i915 device info: has_fbc: yes
kern  :debug : [   74.963473] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 67:"1366x768" 60 74980 1366 1404 1426 1572 768 771 777 794 0x48 0xa
kern  :debug : [   74.964020] i915 device info: has_fpga_dbg: no
kern  :debug : [   74.964292] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:70:VGA-1]
kern  :debug : [   74.964517] i915 device info: has_full_ppgtt: yes
kern  :debug : [   74.965202] [drm:intel_crt_detect [i915]] [CONNECTOR:70:V=
GA-1] force=3D1
kern  :debug : [   74.965405] i915 device info: has_full_48bit_ppgtt: no
kern  :debug : [   74.965917] [drm:intel_crt_detect [i915]] trigger hotplug=
 detect cycle: adpa=3D0xf40000
kern  :debug : [   74.966149] i915 device info: has_gmch_display: no
kern  :debug : [   74.966151] i915 device info: has_guc: no
kern  :debug : [   74.966537] [drm:drm_sysfs_hotplug_event [drm]] generatin=
g hotplug event
kern  :debug : [   74.966800] i915 device info: has_guc_ct: no
kern  :debug : [   74.966802] i915 device info: has_hotplug: yes
kern  :debug : [   74.966804] i915 device info: has_l3_dpf: yes
kern  :debug : [   74.968874] i915 device info: has_llc: yes
kern  :debug : [   74.969145] i915 device info: has_logical_ring_contexts: =
no
kern  :debug : [   74.969489] i915 device info: has_logical_ring_elsq: no
kern  :debug : [   74.969783] i915 device info: has_logical_ring_preemption=
: no
kern  :debug : [   74.970129] i915 device info: has_overlay: no
kern  :debug : [   74.970384] i915 device info: has_pooled_eu: no
kern  :debug : [   74.970646] i915 device info: has_psr: no
kern  :debug : [   74.970890] i915 device info: has_rc6: yes
kern  :debug : [   74.971129] i915 device info: has_rc6p: yes
kern  :debug : [   74.971365] i915 device info: has_resource_streamer: no
kern  :debug : [   74.971656] i915 device info: has_runtime_pm: no
kern  :debug : [   74.971916] i915 device info: has_snoop: no
kern  :debug : [   74.972157] i915 device info: unfenced_needs_alignment: no
kern  :debug : [   74.972464] i915 device info: cursor_needs_physical: no
kern  :debug : [   74.972755] i915 device info: hws_needs_physical: no
kern  :debug : [   74.973038] i915 device info: overlay_needs_physical: no
kern  :debug : [   74.973336] i915 device info: supports_tv: no
kern  :debug : [   74.973581] i915 device info: has_ipc: no
kern  :debug : [   74.973808] i915 device info: slice mask: 0000
kern  :debug : [   74.974065] i915 device info: slice total: 0
kern  :debug : [   74.974306] i915 device info: subslice total: 0
kern  :debug : [   74.974562] i915 device info: slice0 0 subslices mask=3D0=
000
kern  :debug : [   74.974870] i915 device info: slice1 0 subslices mask=3D0=
000
kern  :debug : [   74.975056] [drm:intel_crt_detect [i915]] ironlake hotplu=
g adpa=3D0xf40000, result 0
kern  :debug : [   74.975187] i915 device info: slice2 0 subslices mask=3D0=
000
kern  :debug : [   74.975629] [drm:intel_crt_detect [i915]] CRT not detecte=
d via hotplug
kern  :debug : [   74.975900] i915 device info: slice3 0 subslices mask=3D0=
000
kern  :debug : [   74.976570] i915 device info: slice4 0 subslices mask=3D0=
000
kern  :debug : [   74.976877] i915 device info: slice5 0 subslices mask=3D0=
000
kern  :debug : [   74.977191] i915 device info: slice6 0 subslices mask=3D0=
000
kern  :debug : [   74.977497] i915 device info: EU total: 0
kern  :debug : [   74.977726] i915 device info: EU per subslice: 0
kern  :debug : [   74.977985] i915 device info: has slice power gating: no
kern  :debug : [   74.978303] i915 device info: has subslice power gating: =
no
kern  :debug : [   74.978630] i915 device info: has EU power gating: no
kern  :debug : [   74.978912] i915 device info: CS timestamp frequency: 125=
00 kHz
kern  :debug : [   74.979361] ahci 0000:00:1f.2: version 3.0
kern  :debug : [   74.979717] IOAPIC[0]: Set routing entry (2-19 -> 0xef ->=
 IRQ 19 Mode:1 Active:1 Dest:1)
kern  :info  : [   74.980262] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 =
ports 6 Gbps 0x0 impl SATA mode
kern  :info  : [   74.980706] ahci 0000:00:1f.2: flags: 64bit ncq pm led cl=
o pio slum part ems apst=20
kern  :info  : [   74.981911] scsi host0: ahci
kern  :info  : [   74.982258] scsi host1: ahci
kern  :info  : [   74.982537] scsi host2: ahci
kern  :info  : [   74.982816] scsi host3: ahci
kern  :info  : [   74.983110] scsi host4: ahci
kern  :info  : [   74.983391] scsi host5: ahci
kern  :info  : [   74.983621] ata1: DUMMY
kern  :info  : [   74.983764] ata2: DUMMY
kern  :info  : [   74.983908] ata3: DUMMY
kern  :info  : [   74.984056] ata4: DUMMY
kern  :info  : [   74.984198] ata5: DUMMY
kern  :info  : [   74.984342] ata6: DUMMY
kern  :debug : [   74.984664] IOAPIC[0]: Set routing entry (2-22 -> 0xef ->=
 IRQ 22 Mode:1 Active:1 Dest:1)
kern  :debug : [   75.029601] [drm:do_gmbus_xfer [i915]] GMBUS [i915 gmbus =
vga] timed out, falling back to bit banging on pin 2
kern  :debug : [   75.046052] [drm:drm_do_probe_ddc_edid [drm]] drm: skippi=
ng non-existent adapter i915 gmbus vga
kern  :debug : [   75.046575] [drm:intel_crt_get_edid [i915]] CRT GMBUS EDI=
D read failed, retry using GPIO bit-banging
kern  :debug : [   75.047141] [drm:intel_gmbus_force_bit [i915]] enabling b=
it-banging on i915 gmbus vga. force bit now 1
kern  :debug : [   75.063055] [drm:drm_do_probe_ddc_edid [drm]] drm: skippi=
ng non-existent adapter i915 gmbus vga
kern  :debug : [   75.063604] [drm:intel_gmbus_force_bit [i915]] disabling =
bit-banging on i915 gmbus vga. force bit now 0
kern  :debug : [   75.064175] [drm:intel_crt_detect_ddc [i915]] CRT not det=
ected via DDC:0x50 [no valid EDID found]
kern  :debug : [   75.064674] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:70:VGA-1] status updated from unknown to disco=
nnected
kern  :debug : [   75.065368] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:70:VGA-1] disconnected
kern  :debug : [   75.065912] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:73:HDMI-A-1]
kern  :debug : [   75.066456] [drm:intel_hdmi_detect [i915]] [CONNECTOR:73:=
HDMI-A-1]
kern  :debug : [   75.092613] [drm:do_gmbus_xfer [i915]] GMBUS [i915 gmbus =
dpb] NAK for addr: 0040 w(1)
kern  :debug : [   75.093083] [drm:do_gmbus_xfer [i915]] GMBUS [i915 gmbus =
dpb] NAK on first message, retry
kern  :debug : [   75.093727] [drm:do_gmbus_xfer [i915]] GMBUS [i915 gmbus =
dpb] NAK for addr: 0040 w(1)
kern  :debug : [   75.094169] [drm:drm_dp_dual_mode_detect [drm_kms_helper]=
] DP dual mode HDMI ID:  (err -6)
kern  :debug : [   75.094631] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:73:HDMI-A-1] status updated from unknown to co=
nnected
kern  :debug : [   75.095336] [drm:drm_add_display_info [drm]] non_desktop =
set to 0
kern  :debug : [   75.095684] [drm:drm_add_display_info [drm]] HDMI: DVI du=
al 0, max TMDS clock 0 kHz
kern  :debug : [   75.096128] [drm:drm_add_edid_modes.part.27 [drm]] ELD mo=
nitor Raritan CIM
kern  :debug : [   75.096521] [drm:drm_add_edid_modes.part.27 [drm]] HDMI: =
latency present 0 0, video latency 0 0, audio latency 0 0
kern  :debug : [   75.097101] [drm:drm_add_edid_modes.part.27 [drm]] ELD si=
ze 32, SAD count 0
kern  :debug : [   75.097497] [drm:drm_add_display_info [drm]] non_desktop =
set to 0
kern  :debug : [   75.097839] [drm:drm_add_display_info [drm]] HDMI: DVI du=
al 0, max TMDS clock 0 kHz
kern  :debug : [   75.098560] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:73:HDMI-A-1] probed modes :
kern  :debug : [   75.099139] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 83:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x48 =
0x5
kern  :debug : [   75.099810] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 95:"1280x1024" 75 135000 1280 1296 1440 1688 1024 1025 1028 1066 0x40 =
0x5
kern  :debug : [   75.100488] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 88:"1152x864" 75 108000 1152 1216 1344 1600 864 865 868 900 0x40 0x5
kern  :debug : [   75.101144] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 87:"1152x864" 60 81579 1152 1216 1336 1520 864 865 868 895 0x0 0x6
kern  :debug : [   75.101781] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 86:"1024x768" 85 94500 1024 1072 1168 1376 768 769 772 808 0x40 0x5
kern  :debug : [   75.102430] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 96:"1024x768" 75 78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
kern  :debug : [   75.103079] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 97:"1024x768" 70 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
kern  :debug : [   75.103722] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 98:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
kern  :debug : [   75.104373] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 85:"800x600" 85 56250 800 832 896 1048 600 601 604 631 0x40 0x5
kern  :debug : [   75.104998] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 99:"800x600" 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
kern  :debug : [   75.105630] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 100:"800x600" 72 50000 800 856 976 1040 600 637 643 666 0x40 0x5
kern  :debug : [   75.106265] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 89:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
kern  :debug : [   75.106888] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 90:"800x600" 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
kern  :debug : [   75.107519] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 84:"640x480" 85 36000 640 696 752 832 480 481 484 509 0x40 0xa
kern  :debug : [   75.108150] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 91:"640x480" 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
kern  :debug : [   75.108767] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 92:"640x480" 73 31500 640 664 704 832 480 489 492 520 0x40 0xa
kern  :debug : [   75.109395] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 101:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
kern  :debug : [   75.110036] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 93:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
kern  :debug : [   75.110653] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 94:"720x400" 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
kern  :debug : [   75.111282] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:78:DP-1]
kern  :debug : [   75.111799] [drm:intel_dp_detect [i915]] [CONNECTOR:78:DP=
-1]
kern  :debug : [   75.114635] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.117544] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.120460] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.123384] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.126299] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.129222] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.132154] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.135084] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.138007] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.140947] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.143910] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
user  :notice: [   75.145879] Preparing to unpack .../liblocale-gettext-per=
l_1.07-3+b3_amd64.deb ...

kern  :debug : [   75.146926] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
user  :notice: [   75.149649] Unpacking liblocale-gettext-perl (1.07-3+b3) =
over (1.07-3) ...

kern  :debug : [   75.149900] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.153075] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.155999] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.158943] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
user  :notice: [   75.160635] Selecting previously unselected package perl-=
modules-5.26.

kern  :debug : [   75.161945] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
user  :notice: [   75.163996] Preparing to unpack .../perl-modules-5.26_5.2=
6.1-5_all.deb ...

kern  :debug : [   75.164900] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
user  :notice: [   75.166529] Unpacking perl-modules-5.26 (5.26.1-5) ...

kern  :debug : [   75.167860] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.170778] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.173700] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.176616] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.179539] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.182444] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.185346] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.188256] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.191174] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.194091] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.197000] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.199915] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.202836] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.205749] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   75.206182] [drm:drm_dp_dpcd_access [drm_kms_helper]] Too=
 many retries, giving up. First error: -110
kern  :debug : [   75.206699] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:78:DP-1] status updated from unknown to discon=
nected
kern  :debug : [   75.207387] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:78:DP-1] disconnected
kern  :debug : [   75.207932] [drm:drm_setup_crtcs [drm_kms_helper]] connec=
tor 64 enabled? yes
kern  :debug : [   75.208344] [drm:drm_setup_crtcs [drm_kms_helper]] connec=
tor 70 enabled? no
kern  :debug : [   75.208734] [drm:drm_setup_crtcs [drm_kms_helper]] connec=
tor 73 enabled? yes
kern  :debug : [   75.209137] [drm:drm_setup_crtcs [drm_kms_helper]] connec=
tor 78 enabled? no
kern  :debug : [   75.209574] [drm:intel_fb_initial_config [i915]] Not usin=
g firmware configuration
kern  :debug : [   75.209991] [drm:drm_setup_crtcs [drm_kms_helper]] lookin=
g for cmdline mode on connector 64
kern  :debug : [   75.210457] [drm:drm_setup_crtcs [drm_kms_helper]] lookin=
g for preferred mode on connector 64 0
kern  :debug : [   75.210938] [drm:drm_setup_crtcs [drm_kms_helper]] found =
mode 1366x768
kern  :debug : [   75.211316] [drm:drm_setup_crtcs [drm_kms_helper]] lookin=
g for cmdline mode on connector 73
kern  :debug : [   75.211791] [drm:drm_setup_crtcs [drm_kms_helper]] lookin=
g for preferred mode on connector 73 0
kern  :debug : [   75.212287] [drm:drm_setup_crtcs [drm_kms_helper]] found =
mode 1280x1024
kern  :debug : [   75.212664] [drm:drm_setup_crtcs [drm_kms_helper]] pickin=
g CRTCs for 8192x8192 config
kern  :debug : [   75.213114] [drm:drm_setup_crtcs [drm_kms_helper]] desire=
d mode 1366x768 set on crtc 39 (0,0)
kern  :info  : [   75.213163] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.=
0 (ops i915_audio_component_bind_ops [i915])
kern  :debug : [   75.214175] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (3)
kern  :debug : [   75.214491] [drm:drm_setup_crtcs [drm_kms_helper]] desire=
d mode 1280x1024 set on crtc 51 (0,0)
kern  :debug : [   75.215037] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (3)
kern  :debug : [   75.215402] [drm:intelfb_create [i915]] no BIOS fb, alloc=
ating a new one
kern  :debug : [   75.216736] [drm:intelfb_create [i915]] allocated 1366x10=
24 fb: 0x00469000
kern  :info  : [   75.217222] fbcon: inteldrmfb (fb0) is primary device
kern  :debug : [   75.217287] [drm:drm_atomic_state_init [drm]] Allocated a=
tomic state 00000000052c8662
kern  :debug : [   75.217305] [drm:drm_mode_object_get [drm]] OBJ ID: 81 (4)
kern  :debug : [   75.217323] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:28:primary A] 000000004be2a966 state to 00000000052c8662
kern  :debug : [   75.217339] [drm:drm_mode_object_get [drm]] OBJ ID: 79 (1)
kern  :debug : [   75.217355] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:39:pipe A] 0000000023500782 state to 00000000052c8662
kern  :debug : [   75.217370] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:31:sprite A] 000000000a0c981f state to 00000000052c8662
kern  :debug : [   75.217384] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 000000000a0c981f to [NOCRTC]
kern  :debug : [   75.217397] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 000000000a0c981f
kern  :debug : [   75.217411] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:36:cursor A] 00000000071b7b92 state to 00000000052c8662
kern  :debug : [   75.217424] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000071b7b92 to [NOCRTC]
kern  :debug : [   75.217436] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000071b7b92
kern  :debug : [   75.217449] [drm:drm_mode_object_get [drm]] OBJ ID: 81 (5)
kern  :debug : [   75.217462] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:40:primary B] 000000002ffbb5f8 state to 00000000052c8662
kern  :debug : [   75.217477] [drm:drm_mode_object_get [drm]] OBJ ID: 80 (1)
kern  :debug : [   75.217490] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:51:pipe B] 000000000518a93a state to 00000000052c8662
kern  :debug : [   75.217504] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:43:sprite B] 00000000b76535a5 state to 00000000052c8662
kern  :debug : [   75.217516] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000b76535a5 to [NOCRTC]
kern  :debug : [   75.217529] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000b76535a5
kern  :debug : [   75.217543] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:48:cursor B] 00000000dee2c3f6 state to 00000000052c8662
kern  :debug : [   75.217556] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000dee2c3f6 to [NOCRTC]
kern  :debug : [   75.217569] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000dee2c3f6
kern  :debug : [   75.217582] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:52:primary C] 00000000fd309a3d state to 00000000052c8662
kern  :debug : [   75.217595] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:55:sprite C] 000000006763542c state to 00000000052c8662
kern  :debug : [   75.217607] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 000000006763542c to [NOCRTC]
kern  :debug : [   75.217618] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 000000006763542c
kern  :debug : [   75.217631] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:60:cursor C] 00000000110b81ec state to 00000000052c8662
kern  :debug : [   75.217644] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000110b81ec to [NOCRTC]
kern  :debug : [   75.217656] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000110b81ec
kern  :debug : [   75.217670] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 79 (2)
kern  :debug : [   75.217686] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[MODE:1366x768] for CRTC state 0000000023500782
kern  :debug : [   75.217699] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 000000004be2a966 to [CRTC:39:pipe A]
kern  :debug : [   75.217713] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
FB:104] for plane state 000000004be2a966
kern  :debug : [   75.217726] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
1)
kern  :debug : [   75.217738] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 81 (6)
kern  :debug : [   75.217752] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:39:pipe A] to 00000000052c8662
kern  :debug : [   75.217766] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (5)
kern  :debug : [   75.217779] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (6)
kern  :debug : [   75.217793] [drm:drm_atomic_get_connector_state [drm]] Ad=
ded [CONNECTOR:64:LVDS-1] 00000000a7b3228a state to 00000000052c8662
kern  :debug : [   75.217806] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (6)
kern  :debug : [   75.217819] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 00000000a7b3228a to [NOCRTC]
kern  :debug : [   75.217833] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (5)
kern  :debug : [   75.217846] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 00000000a7b3228a to [CRTC:39:pipe A]
kern  :debug : [   75.217859] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 80 (2)
kern  :debug : [   75.217874] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[MODE:1280x1024] for CRTC state 000000000518a93a
kern  :debug : [   75.217888] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 000000002ffbb5f8 to [CRTC:51:pipe B]
kern  :debug : [   75.217901] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
FB:104] for plane state 000000002ffbb5f8
kern  :debug : [   75.217913] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
2)
kern  :debug : [   75.217926] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 81 (5)
kern  :debug : [   75.217939] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:51:pipe B] to 00000000052c8662
kern  :debug : [   75.217953] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (5)
kern  :debug : [   75.217966] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (6)
kern  :debug : [   75.217981] [drm:drm_atomic_get_connector_state [drm]] Ad=
ded [CONNECTOR:73:HDMI-A-1] 00000000d680acda state to 00000000052c8662
kern  :debug : [   75.217994] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (6)
kern  :debug : [   75.218006] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 00000000d680acda to [NOCRTC]
kern  :debug : [   75.218033] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (5)
kern  :debug : [   75.218047] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 00000000d680acda to [CRTC:51:pipe B]
kern  :debug : [   75.218061] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:63:pipe C] 00000000abdf892e state to 00000000052c8662
kern  :debug : [   75.218074] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[NOMODE] for CRTC state 00000000abdf892e
kern  :debug : [   75.218087] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000fd309a3d to [NOCRTC]
kern  :debug : [   75.218100] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000fd309a3d
kern  :debug : [   75.218115] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:63:pipe C] to 00000000052c8662
kern  :debug : [   75.218127] [drm:drm_atomic_check_only [drm]] checking 00=
000000052c8662
kern  :debug : [   75.218141] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] [CRTC:39:pipe A] mode changed
kern  :debug : [   75.218151] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Updating routing for [CONNECTOR:64:LVDS-1]
kern  :debug : [   75.218160] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] [CONNECTOR:64:LVDS-1] keeps [ENCODER:65:LVDS], now on [CRTC:39:pi=
pe A]
kern  :debug : [   75.218169] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Updating routing for [CONNECTOR:73:HDMI-A-1]
kern  :debug : [   75.218177] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] [CONNECTOR:73:HDMI-A-1] keeps [ENCODER:72:HDMI B], now on [CRTC:5=
1:pipe B]
kern  :debug : [   75.218185] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] [CRTC:39:pipe A] needs all connectors, enable: y, active: y
kern  :debug : [   75.218200] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:39:pipe A] to 00000000052c8662
kern  :debug : [   75.218208] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] [CRTC:51:pipe B] needs all connectors, enable: y, active: y
kern  :debug : [   75.218222] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:51:pipe B] to 00000000052c8662
kern  :debug : [   75.218277] [drm:intel_modeset_pipe_config [i915]] [CONNE=
CTOR:64:LVDS-1] checking for sink bpp constrains
kern  :debug : [   75.218327] [drm:intel_modeset_pipe_config [i915]] clampi=
ng display bpp (was 36) to EDID reported max of 18
kern  :debug : [   75.218371] [drm:intel_modeset_pipe_config [i915]] checki=
ng fdi config on pipe A, lanes 1
kern  :debug : [   75.218414] [drm:intel_modeset_pipe_config [i915]] hw max=
 bpp: 36, pipe bpp: 18, dithering: 1
kern  :debug : [   75.218457] [drm:intel_dump_pipe_config [i915]] [CRTC:39:=
pipe A][modeset]
kern  :debug : [   75.218500] [drm:intel_dump_pipe_config [i915]] output_ty=
pes: LVDS (0x10)
kern  :debug : [   75.218543] [drm:intel_dump_pipe_config [i915]] cpu_trans=
coder: A, pipe bpp: 18, dithering: 1
kern  :debug : [   75.218585] [drm:intel_dump_pipe_config [i915]] fdi: lane=
s: 1; gmch_m: 2620740, gmch_n: 4194304, link_m: 145596, link_n: 524288, tu:=
 64
kern  :debug : [   75.218625] [drm:intel_dump_pipe_config [i915]] audio: 0,=
 infoframes: 0
kern  :debug : [   75.218666] [drm:intel_dump_pipe_config [i915]] requested=
 mode:
kern  :debug : [   75.218685] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 0:"1366x768" 60 74980 1366 1404 1426 1572 768 771 777 794 0x48 0xa
kern  :debug : [   75.218722] [drm:intel_dump_pipe_config [i915]] adjusted =
mode:
kern  :debug : [   75.218739] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 0:"1366x768" 60 74980 1366 1404 1426 1572 768 771 777 794 0x48 0xa
kern  :debug : [   75.218781] [drm:intel_dump_pipe_config [i915]] crtc timi=
ngs: 74980 1366 1404 1426 1572 768 771 777 794, type: 0x48 flags: 0xa
kern  :debug : [   75.218818] [drm:intel_dump_pipe_config [i915]] port cloc=
k: 74980, pipe src size: 1366x768, pixel rate 74980
kern  :debug : [   75.218856] [drm:intel_dump_pipe_config [i915]] pch pfit:=
 pos: 0x00000000, size: 0x00000000, disabled
kern  :debug : [   75.218892] [drm:intel_dump_pipe_config [i915]] ips: 0, d=
ouble wide: 0
kern  :debug : [   75.218928] [drm:intel_dump_pipe_config [i915]] dpll_hw_s=
tate: dpll: 0x88046004, dpll_md: 0x0, fp0: 0x10c07, fp1: 0x10c07
kern  :debug : [   75.218964] [drm:intel_dump_pipe_config [i915]] planes on=
 this crtc
kern  :debug : [   75.219003] [drm:intel_dump_pipe_config [i915]] [PLANE:28=
:primary A] FB:81, fb =3D 1366x768 format =3D XR24 little-endian (0x3432525=
8)
kern  :debug : [   75.219042] [drm:intel_dump_pipe_config [i915]] [PLANE:31=
:sprite A] disabled, scaler_id =3D 0
kern  :debug : [   75.219076] [drm:intel_dump_pipe_config [i915]] [PLANE:36=
:cursor A] disabled, scaler_id =3D 0
kern  :debug : [   75.219115] [drm:intel_modeset_pipe_config [i915]] [CONNE=
CTOR:73:HDMI-A-1] checking for sink bpp constrains
kern  :debug : [   75.219153] [drm:intel_modeset_pipe_config [i915]] clampi=
ng display bpp (was 36) to EDID reported max of 24
kern  :debug : [   75.219214] [drm:intel_hdmi_compute_config [i915]] pickin=
g bpc to 8 for HDMI output
kern  :debug : [   75.219254] [drm:intel_hdmi_compute_config [i915]] forcin=
g pipe bpp to 24 for HDMI
kern  :debug : [   75.219296] [drm:intel_modeset_pipe_config [i915]] checki=
ng fdi config on pipe B, lanes 2
kern  :debug : [   75.219333] [drm:intel_modeset_pipe_config [i915]] hw max=
 bpp: 36, pipe bpp: 24, dithering: 0
kern  :debug : [   75.219370] [drm:intel_dump_pipe_config [i915]] [CRTC:51:=
pipe B][modeset]
kern  :debug : [   75.219407] [drm:intel_dump_pipe_config [i915]] output_ty=
pes: HDMI (0x40)
kern  :debug : [   75.219443] [drm:intel_dump_pipe_config [i915]] cpu_trans=
coder: B, pipe bpp: 24, dithering: 0
kern  :debug : [   75.219477] [drm:intel_dump_pipe_config [i915]] fdi: lane=
s: 2; gmch_m: 5033164, gmch_n: 8388608, link_m: 209715, link_n: 524288, tu:=
 64
kern  :debug : [   75.219515] [drm:intel_dump_pipe_config [i915]] audio: 0,=
 infoframes: 1
kern  :debug : [   75.219548] [drm:intel_dump_pipe_config [i915]] requested=
 mode:
kern  :debug : [   75.219566] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 0:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x48 0=
x5
kern  :debug : [   75.219598] [drm:intel_dump_pipe_config [i915]] adjusted =
mode:
kern  :debug : [   75.219615] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 0:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x48 0=
x5
kern  :debug : [   75.219651] [drm:intel_dump_pipe_config [i915]] crtc timi=
ngs: 108000 1280 1328 1440 1688 1024 1025 1028 1066, type: 0x48 flags: 0x5
kern  :debug : [   75.219683] [drm:intel_dump_pipe_config [i915]] port cloc=
k: 108000, pipe src size: 1280x1024, pixel rate 108000
kern  :debug : [   75.219717] [drm:intel_dump_pipe_config [i915]] pch pfit:=
 pos: 0x00000000, size: 0x00000000, disabled
kern  :debug : [   75.219749] [drm:intel_dump_pipe_config [i915]] ips: 0, d=
ouble wide: 0
kern  :debug : [   75.219783] [drm:intel_dump_pipe_config [i915]] dpll_hw_s=
tate: dpll: 0xc4040004, dpll_md: 0x0, fp0: 0x10c09, fp1: 0x10c09
kern  :debug : [   75.219815] [drm:intel_dump_pipe_config [i915]] planes on=
 this crtc
kern  :debug : [   75.219849] [drm:intel_dump_pipe_config [i915]] [PLANE:40=
:primary B] FB:81, fb =3D 1366x768 format =3D XR24 little-endian (0x3432525=
8)
kern  :debug : [   75.219880] [drm:intel_dump_pipe_config [i915]] [PLANE:43=
:sprite B] disabled, scaler_id =3D 0
kern  :debug : [   75.219914] [drm:intel_dump_pipe_config [i915]] [PLANE:48=
:cursor B] disabled, scaler_id =3D 0
kern  :debug : [   75.219956] [drm:intel_plane_atomic_calc_changes [i915]] =
[CRTC:39:pipe A] has [PLANE:28:primary A] with fb 104
kern  :debug : [   75.219995] [drm:intel_plane_atomic_calc_changes [i915]] =
[PLANE:28:primary A] visible 1 -> 1, off 1, on 1, ms 1
kern  :debug : [   75.220033] [drm:intel_plane_atomic_calc_changes [i915]] =
[CRTC:51:pipe B] has [PLANE:40:primary B] with fb 104
kern  :debug : [   75.220074] [drm:intel_plane_atomic_calc_changes [i915]] =
[PLANE:40:primary B] visible 1 -> 1, off 1, on 1, ms 1
kern  :debug : [   75.220111] [drm:ironlake_crtc_compute_clock [i915]] usin=
g SSC reference clock of 120000 kHz
kern  :debug : [   75.220167] [drm:intel_find_shared_dpll [i915]] [CRTC:39:=
pipe A] allocated PCH DPLL A
kern  :debug : [   75.220206] [drm:intel_reference_shared_dpll [i915]] usin=
g PCH DPLL A for pipe A
kern  :debug : [   75.220262] [drm:intel_find_shared_dpll [i915]] [CRTC:51:=
pipe B] allocated PCH DPLL B
kern  :debug : [   75.220294] [drm:intel_reference_shared_dpll [i915]] usin=
g PCH DPLL B for pipe B
kern  :debug : [   75.220312] [drm:drm_atomic_commit [drm]] committing 0000=
0000052c8662
kern  :debug : [   75.220379] [drm:intel_panel_actually_set_backlight [i915=
]] set backlight PWM =3D 0
kern  :debug : [   75.220418] [drm:intel_disable_pipe [i915]] disabling pip=
e A
kern  :info  : [   75.227499] snd_hda_codec_conexant hdaudioC0D0: CX20590: =
BIOS auto-probing.
kern  :info  : [   75.227969] snd_hda_codec_conexant hdaudioC0D0: autoconfi=
g for CX20590: line_outs=3D1 (0x1f/0x0/0x0/0x0/0x0) type:speaker
kern  :info  : [   75.227972] snd_hda_codec_conexant hdaudioC0D0:    speake=
r_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
kern  :info  : [   75.227974] snd_hda_codec_conexant hdaudioC0D0:    hp_out=
s=3D1 (0x19/0x0/0x0/0x0/0x0)
kern  :info  : [   75.227976] snd_hda_codec_conexant hdaudioC0D0:    mono: =
mono_out=3D0x0
kern  :info  : [   75.227977] snd_hda_codec_conexant hdaudioC0D0:    inputs:
kern  :info  : [   75.227980] snd_hda_codec_conexant hdaudioC0D0:      Inte=
rnal Mic=3D0x23
kern  :info  : [   75.227982] snd_hda_codec_conexant hdaudioC0D0:      Mic=
=3D0x1a
kern  :info  : [   75.229071] snd_hda_codec_conexant hdaudioC0D0: Enable sy=
nc_write for stable communication
kern  :debug : [   75.236138] [drm:i915_audio_component_get_eld [i915]] Not=
 valid for port B
kern  :info  : [   75.236764] input: HDA Intel PCH Mic as /devices/pci0000:=
00/0000:00:1b.0/sound/card0/input19
kern  :info  : [   75.236849] input: HDA Intel PCH Headphone as /devices/pc=
i0000:00/0000:00:1b.0/sound/card0/input20
kern  :info  : [   75.236927] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devi=
ces/pci0000:00/0000:00:1b.0/sound/card0/input21
kern  :debug : [   75.252346] [drm:i915_audio_component_get_eld [i915]] Not=
 valid for port B
kern  :debug : [   75.489858] [drm:intel_disable_shared_dpll [i915]] disabl=
e PCH DPLL A (active 1, on? 1) for crtc 39
kern  :debug : [   75.489910] [drm:intel_disable_shared_dpll [i915]] disabl=
ing PCH DPLL A
kern  :debug : [   75.490172] [drm:intel_disable_pipe [i915]] disabling pip=
e B
kern  :debug : [   75.511131] [drm:intel_disable_shared_dpll [i915]] disabl=
e PCH DPLL B (active 2, on? 1) for crtc 51
kern  :debug : [   75.511178] [drm:intel_disable_shared_dpll [i915]] disabl=
ing PCH DPLL B
kern  :debug : [   75.511408] [drm:drm_calc_timestamping_constants [drm]] c=
rtc 39: hwmode: htotal 1572, vtotal 794, vdisplay 768
kern  :debug : [   75.511419] [drm:drm_atomic_helper_update_legacy_modeset_=
state [drm_kms_helper]] crtc 39: clock 74980 kHz framedur 16646679 linedur =
20965
kern  :debug : [   75.511432] [drm:drm_calc_timestamping_constants [drm]] c=
rtc 51: hwmode: htotal 1688, vtotal 1066, vdisplay 1024
kern  :debug : [   75.511440] [drm:drm_atomic_helper_update_legacy_modeset_=
state [drm_kms_helper]] crtc 51: clock 108000 kHz framedur 16661185 linedur=
 15629
kern  :debug : [   75.511483] [drm:intel_atomic_commit_tail [i915]] [ENCODE=
R:65:LVDS]
kern  :debug : [   75.511521] [drm:intel_atomic_commit_tail [i915]] [ENCODE=
R:71:CRT]
kern  :debug : [   75.511557] [drm:intel_atomic_commit_tail [i915]] [ENCODE=
R:72:HDMI B]
kern  :debug : [   75.511594] [drm:intel_atomic_commit_tail [i915]] [ENCODE=
R:77:DP B]
kern  :debug : [   75.511631] [drm:verify_single_dpll_state.isra.117 [i915]=
] PCH DPLL A
kern  :debug : [   75.511671] [drm:verify_single_dpll_state.isra.117 [i915]=
] PCH DPLL B
kern  :debug : [   75.511719] [drm:intel_prepare_shared_dpll [i915]] settin=
g up PCH DPLL A
kern  :debug : [   75.512308] [drm:intel_enable_pipe [i915]] enabling pipe A
kern  :debug : [   75.512503] [drm:ivb_manual_fdi_link_train [i915]] FDI_RX=
_IIR before link train 0x0
kern  :debug : [   75.512544] [drm:ivb_manual_fdi_link_train [i915]] FDI_RX=
_IIR 0x100
kern  :debug : [   75.512578] [drm:ivb_manual_fdi_link_train [i915]] FDI tr=
ain 1 done, level 0.
kern  :debug : [   75.512616] [drm:ivb_manual_fdi_link_train [i915]] FDI_RX=
_IIR 0x600
kern  :debug : [   75.512650] [drm:ivb_manual_fdi_link_train [i915]] FDI tr=
ain 2 done, level 0.
kern  :debug : [   75.512682] [drm:ironlake_pch_enable [i915]] FDI train do=
ne.
kern  :debug : [   75.512721] [drm:intel_enable_shared_dpll [i915]] enable =
PCH DPLL A (active 1, on? 0) for crtc 39
kern  :debug : [   75.512757] [drm:intel_enable_shared_dpll [i915]] enablin=
g PCH DPLL A
user  :notice: [   75.532104] Selecting previously unselected package mime-=
support.

user  :notice: [   75.535064] Preparing to unpack .../deb/mime-support_3.60=
_all.deb ...

user  :notice: [   75.536358] Unpacking mime-support (3.60) ...

user  :notice: [   75.550261] Selecting previously unselected package libgd=
bm-compat4:amd64.

user  :notice: [   75.554122] Preparing to unpack .../libgdbm-compat4_1.14.=
1-6_amd64.deb ...

user  :notice: [   75.556368] Unpacking libgdbm-compat4:amd64 (1.14.1-6) ...

user  :notice: [   75.570495] Selecting previously unselected package libpe=
rl5.26:amd64.

user  :notice: [   75.573621] Preparing to unpack .../libperl5.26_5.26.1-5_=
amd64.deb ...

user  :notice: [   75.576024] Unpacking libperl5.26:amd64 (5.26.1-5) ...

kern  :debug : [   75.947464] [drm:intel_panel_enable_backlight [i915]] pip=
e A
kern  :debug : [   75.947504] [drm:intel_panel_actually_set_backlight [i915=
]] set backlight PWM =3D 4882
kern  :debug : [   75.948031] [drm:drm_vblank_enable [drm]] enabling vblank=
 on crtc 0, ret: 0
kern  :debug : [   75.963166] [drm:intel_prepare_shared_dpll [i915]] settin=
g up PCH DPLL B
kern  :debug : [   75.963786] [drm:intel_enable_pipe [i915]] enabling pipe B
kern  :debug : [   75.963981] [drm:ivb_manual_fdi_link_train [i915]] FDI_RX=
_IIR before link train 0x0
kern  :debug : [   75.964020] [drm:ivb_manual_fdi_link_train [i915]] FDI_RX=
_IIR 0x100
kern  :debug : [   75.964059] [drm:ivb_manual_fdi_link_train [i915]] FDI tr=
ain 1 done, level 0.
kern  :debug : [   75.964094] [drm:ivb_manual_fdi_link_train [i915]] FDI_RX=
_IIR 0x600
kern  :debug : [   75.964128] [drm:ivb_manual_fdi_link_train [i915]] FDI tr=
ain 2 done, level 0.
kern  :debug : [   75.964156] [drm:ironlake_pch_enable [i915]] FDI train do=
ne.
kern  :debug : [   75.964190] [drm:intel_enable_shared_dpll [i915]] enable =
PCH DPLL B (active 2, on? 0) for crtc 51
kern  :debug : [   75.964219] [drm:intel_enable_shared_dpll [i915]] enablin=
g PCH DPLL B
kern  :debug : [   75.966118] [drm:drm_vblank_enable [drm]] enabling vblank=
 on crtc 1, ret: 0
kern  :debug : [   75.979754] [drm:drm_handle_vblank [drm]] vblank event on=
 30, current 30
kern  :debug : [   75.996408] [drm:vblank_disable_fn [drm]] disabling vblan=
k on crtc 0
kern  :debug : [   75.998965] [drm:drm_handle_vblank [drm]] vblank event on=
 4, current 4
kern  :debug : [   75.999072] [drm:verify_connector_state.isra.116 [i915]] =
[CONNECTOR:64:LVDS-1]
kern  :debug : [   75.999113] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 79 (1)
kern  :debug : [   75.999190] [drm:intel_atomic_commit_tail [i915]] [CRTC:3=
9:pipe A]
kern  :debug : [   75.999281] [drm:verify_single_dpll_state.isra.117 [i915]=
] PCH DPLL A
kern  :debug : [   75.999358] [drm:verify_connector_state.isra.116 [i915]] =
[CONNECTOR:73:HDMI-A-1]
kern  :debug : [   75.999386] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 80 (1)
kern  :debug : [   75.999452] [drm:intel_atomic_commit_tail [i915]] [CRTC:5=
1:pipe B]
kern  :debug : [   75.999532] [drm:verify_single_dpll_state.isra.117 [i915]=
] PCH DPLL B
kern  :debug : [   75.999577] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
3)
kern  :debug : [   75.999599] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 81 (4)
kern  :debug : [   75.999619] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
4)
kern  :debug : [   75.999640] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 81 (3)
kern  :debug : [   75.999663] [drm:drm_atomic_state_default_clear [drm]] Cl=
earing atomic state 00000000052c8662
kern  :debug : [   75.999682] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (6)
kern  :debug : [   75.999702] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (5)
kern  :debug : [   75.999721] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (6)
kern  :debug : [   75.999739] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (5)
kern  :debug : [   75.999761] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 81 (2)
kern  :debug : [   75.999781] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 81 (1)
kern  :debug : [   75.999806] [drm:__drm_atomic_state_free [drm]] Freeing a=
tomic state 00000000052c8662
kern  :info  : [   75.999857] Console: switching to colour frame buffer dev=
ice 160x48
kern  :debug : [   75.999905] [drm:drm_atomic_state_init [drm]] Allocated a=
tomic state 00000000052c8662
kern  :debug : [   75.999927] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
5)
kern  :debug : [   75.999949] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:28:primary A] 000000004c58e6d3 state to 00000000052c8662
kern  :debug : [   75.999970] [drm:drm_mode_object_get [drm]] OBJ ID: 105 (=
1)
kern  :debug : [   75.999991] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:39:pipe A] 000000007751338d state to 00000000052c8662
kern  :debug : [   76.000015] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:31:sprite A] 00000000bd638366 state to 00000000052c8662
kern  :debug : [   76.000042] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000bd638366 to [NOCRTC]
kern  :debug : [   76.000063] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000bd638366
kern  :debug : [   76.000084] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:36:cursor A] 00000000dead01af state to 00000000052c8662
kern  :debug : [   76.000103] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000dead01af to [NOCRTC]
kern  :debug : [   76.000122] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000dead01af
kern  :debug : [   76.000143] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
6)
kern  :debug : [   76.000162] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:40:primary B] 0000000023c7594a state to 00000000052c8662
kern  :debug : [   76.000182] [drm:drm_mode_object_get [drm]] OBJ ID: 106 (=
1)
kern  :debug : [   76.000202] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:51:pipe B] 0000000023af02c9 state to 00000000052c8662
kern  :debug : [   76.000223] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:43:sprite B] 00000000e1a33be9 state to 00000000052c8662
kern  :debug : [   76.000242] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000e1a33be9 to [NOCRTC]
kern  :debug : [   76.000260] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000e1a33be9
kern  :debug : [   76.000280] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:48:cursor B] 000000007bf987dc state to 00000000052c8662
kern  :debug : [   76.000299] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 000000007bf987dc to [NOCRTC]
kern  :debug : [   76.000318] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 000000007bf987dc
kern  :debug : [   76.000337] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:52:primary C] 00000000418a0e7a state to 00000000052c8662
kern  :debug : [   76.000358] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:55:sprite C] 00000000fecdbb6a state to 00000000052c8662
kern  :debug : [   76.000376] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000fecdbb6a to [NOCRTC]
kern  :debug : [   76.000394] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000fecdbb6a
kern  :debug : [   76.000415] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:60:cursor C] 00000000b572f1bf state to 00000000052c8662
kern  :debug : [   76.000433] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000b572f1bf to [NOCRTC]
kern  :debug : [   76.000451] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000b572f1bf
kern  :debug : [   76.000471] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 105 (2)
kern  :debug : [   76.000494] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[MODE:1366x768] for CRTC state 000000007751338d
kern  :debug : [   76.000513] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 000000004c58e6d3 to [CRTC:39:pipe A]
kern  :debug : [   76.000532] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
FB:104] for plane state 000000004c58e6d3
kern  :debug : [   76.000552] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
7)
kern  :debug : [   76.000571] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (8)
kern  :debug : [   76.000591] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:39:pipe A] to 00000000052c8662
kern  :debug : [   76.000612] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (5)
kern  :debug : [   76.000632] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (6)
kern  :debug : [   76.000653] [drm:drm_atomic_get_connector_state [drm]] Ad=
ded [CONNECTOR:64:LVDS-1] 00000000e3a718e4 state to 00000000052c8662
kern  :debug : [   76.000673] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (6)
kern  :debug : [   76.000692] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 00000000e3a718e4 to [NOCRTC]
kern  :debug : [   76.000711] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (5)
kern  :debug : [   76.000731] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 00000000e3a718e4 to [CRTC:39:pipe A]
kern  :debug : [   76.000751] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 106 (2)
kern  :debug : [   76.000773] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[MODE:1280x1024] for CRTC state 0000000023af02c9
kern  :debug : [   76.000792] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 0000000023c7594a to [CRTC:51:pipe B]
kern  :debug : [   76.000811] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
FB:104] for plane state 0000000023c7594a
kern  :debug : [   76.000829] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
7)
kern  :debug : [   76.000848] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (8)
kern  :debug : [   76.000867] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:51:pipe B] to 00000000052c8662
kern  :debug : [   76.000888] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (5)
kern  :debug : [   76.000907] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (6)
kern  :debug : [   76.000927] [drm:drm_atomic_get_connector_state [drm]] Ad=
ded [CONNECTOR:73:HDMI-A-1] 0000000016f939c5 state to 00000000052c8662
kern  :debug : [   76.000946] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (6)
kern  :debug : [   76.000965] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 0000000016f939c5 to [NOCRTC]
kern  :debug : [   76.000984] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (5)
kern  :debug : [   76.001003] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 0000000016f939c5 to [CRTC:51:pipe B]
kern  :debug : [   76.001030] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:63:pipe C] 000000008bd30e94 state to 00000000052c8662
kern  :debug : [   76.001048] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[NOMODE] for CRTC state 000000008bd30e94
kern  :debug : [   76.001065] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000418a0e7a to [NOCRTC]
kern  :debug : [   76.001082] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000418a0e7a
kern  :debug : [   76.001102] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:63:pipe C] to 00000000052c8662
kern  :debug : [   76.001122] [drm:drm_atomic_check_only [drm]] checking 00=
000000052c8662
kern  :debug : [   76.001145] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Updating routing for [CONNECTOR:64:LVDS-1]
kern  :debug : [   76.001159] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] [CONNECTOR:64:LVDS-1] keeps [ENCODER:65:LVDS], now on [CRTC:39:pi=
pe A]
kern  :debug : [   76.001171] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Updating routing for [CONNECTOR:73:HDMI-A-1]
kern  :debug : [   76.001183] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] [CONNECTOR:73:HDMI-A-1] keeps [ENCODER:72:HDMI B], now on [CRTC:5=
1:pipe B]
kern  :debug : [   76.001263] [drm:intel_plane_atomic_calc_changes [i915]] =
[CRTC:39:pipe A] has [PLANE:28:primary A] with fb 104
kern  :debug : [   76.001330] [drm:intel_plane_atomic_calc_changes [i915]] =
[PLANE:28:primary A] visible 1 -> 1, off 0, on 0, ms 0
kern  :debug : [   76.001396] [drm:intel_plane_atomic_calc_changes [i915]] =
[CRTC:51:pipe B] has [PLANE:40:primary B] with fb 104
kern  :debug : [   76.001456] [drm:intel_plane_atomic_calc_changes [i915]] =
[PLANE:40:primary B] visible 1 -> 1, off 0, on 0, ms 0
kern  :debug : [   76.001486] [drm:drm_atomic_commit [drm]] committing 0000=
0000052c8662
kern  :debug : [   76.001542] [drm:drm_vblank_enable [drm]] enabling vblank=
 on crtc 0, ret: 0
kern  :debug : [   76.013027] [drm:drm_handle_vblank [drm]] vblank event on=
 32, current 32
user  :notice: [   76.013465] Selecting previously unselected package libss=
l1.1:amd64.

kern  :debug : [   76.015601] [drm:drm_handle_vblank [drm]] vblank event on=
 5, current 5
kern  :debug : [   76.015636] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
7)
kern  :debug : [   76.015645] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (8)
kern  :debug : [   76.015654] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
7)
kern  :debug : [   76.015662] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (8)
kern  :debug : [   76.015673] [drm:drm_atomic_state_default_clear [drm]] Cl=
earing atomic state 00000000052c8662
kern  :debug : [   76.015682] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (6)
kern  :debug : [   76.015690] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (5)
kern  :debug : [   76.015698] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (6)
kern  :debug : [   76.015706] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (5)
kern  :debug : [   76.015715] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 105 (1)
kern  :debug : [   76.015730] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 106 (1)
kern  :debug : [   76.015748] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (7)
kern  :debug : [   76.015764] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (6)
kern  :debug : [   76.015779] [drm:__drm_atomic_state_free [drm]] Freeing a=
tomic state 00000000052c8662
user  :notice: [   76.016331] Preparing to unpack .../libssl1.1_1.1.0h-2_am=
d64.deb ...

user  :notice: [   76.018437] Unpacking libssl1.1:amd64 (1.1.0h-2) ...
kern  :info  : [   76.018463] i915 0000:00:02.0: fb0: inteldrmfb frame buff=
er device

kern  :debug : [   76.029647] [drm:vblank_disable_fn [drm]] disabling vblan=
k on crtc 0
user  :notice: [   76.172877] Selecting previously unselected package sysst=
at.
kern  :debug : [   76.172965] [drm:vblank_disable_fn [drm]] disabling vblan=
k on crtc 1

kern  :debug : [   76.177808] [drm:drm_fb_helper_hotplug_event.part.33 [drm=
_kms_helper]]=20
user  :notice: [   76.183405] Preparing to unpack .../deb/sysstat_11.6.1-1_=
amd64.deb ...
kern  :debug : [   76.185501] [drm:drm_setup_crtcs [drm_kms_helper]]=20

kern  :debug : [   76.192903] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:64:LVDS-1]
user  :notice: [   76.197678] Unpacking sysstat (11.6.1-1) ...
kern  :debug : [   76.200134] [drm:intel_lvds_detect [i915]] [CONNECTOR:64:=
LVDS-1]

kern  :debug : [   76.204749] [drm:drm_add_edid_modes.part.27 [drm]] ELD: n=
o CEA Extension found
user  :notice: [   76.242291] Preparing to unpack .../gawk_1%3a4.1.4+dfsg-1=
+b1_amd64.deb ...
kern  :debug : [   76.243156] [drm:drm_add_display_info [drm]] non_desktop =
set to 0

kern  :debug : [   76.247311] [drm:drm_add_display_info [drm]] LVDS-1: Assi=
gning EDID-1.4 digital sink color depth as 6 bpc.
user  :notice: [   76.251048] Unpacking gawk (1:4.1.4+dfsg-1+b1) over (1:4.=
1.1+dfsg-1) ...
kern  :debug : [   76.251333] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:64:LVDS-1] probed modes :

kern  :debug : [   76.254870] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 67:"1366x768" 60 74980 1366 1404 1426 1572 768 771 777 794 0x48 0xa
kern  :debug : [   76.254880] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:70:VGA-1]
kern  :debug : [   76.254913] [drm:intel_crt_detect [i915]] [CONNECTOR:70:V=
GA-1] force=3D1
kern  :debug : [   76.254942] [drm:intel_crt_detect [i915]] ironlake hotplu=
g adpa=3D0xf40000, result 0
user  :notice: [   76.321103] Setting up perl-base (5.26.1-5) ...
kern  :debug : [   76.321753] [drm:intel_crt_detect [i915]] CRT not detecte=
d via hotplug

user  :notice: [   76.325953] Setting up liblocale-gettext-perl (1.07-3+b3)=
 ...
kern  :debug : [   76.379064] [drm:do_gmbus_xfer [i915]] GMBUS [i915 gmbus =
vga] timed out, falling back to bit banging on pin 2

kern  :debug : [   76.396046] [drm:drm_do_probe_ddc_edid [drm]] drm: skippi=
ng non-existent adapter i915 gmbus vga
user  :notice: [   76.399371] Setting up perl-modules-5.26 (5.26.1-5) ...
kern  :debug : [   76.400507] [drm:intel_crt_get_edid [i915]] CRT GMBUS EDI=
D read failed, retry using GPIO bit-banging
kern  :debug : [   76.400536] [drm:intel_gmbus_force_bit [i915]] enabling b=
it-banging on i915 gmbus vga. force bit now 1

kern  :debug : [   76.419054] [drm:drm_do_probe_ddc_edid [drm]] drm: skippi=
ng non-existent adapter i915 gmbus vga
user  :notice: [   76.421208] Setting up mime-support (3.60) ...
kern  :debug : [   76.422401] [drm:intel_gmbus_force_bit [i915]] disabling =
bit-banging on i915 gmbus vga. force bit now 0
kern  :debug : [   76.422429] [drm:intel_crt_detect_ddc [i915]] CRT not det=
ected via DDC:0x50 [no valid EDID found]

kern  :debug : [   76.425785] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:70:VGA-1] disconnected
kern  :debug : [   76.425794] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:73:HDMI-A-1]
user  :notice: [   76.429569] Setting up debconf (1.5.66) ...
kern  :debug : [   76.431354] [drm:intel_hdmi_detect [i915]] [CONNECTOR:73:=
HDMI-A-1]

kern  :debug : [   76.461043] [drm:do_gmbus_xfer [i915]] GMBUS [i915 gmbus =
dpb] NAK for addr: 0040 w(1)
user  :notice: [   76.536859] Setting up libtext-charwidth-perl (0.04-7.1) =
=2E..
kern  :debug : [   76.538994] [drm:do_gmbus_xfer [i915]] GMBUS [i915 gmbus =
dpb] NAK on first message, retry

user  :notice: [   76.543438] Setting up libtext-iconv-perl (1.7-5+b6) ...
kern  :debug : [   76.545506] [drm:do_gmbus_xfer [i915]] GMBUS [i915 gmbus =
dpb] NAK for addr: 0040 w(1)

kern  :debug : [   76.549578] [drm:drm_dp_dual_mode_detect [drm_kms_helper]=
] DP dual mode HDMI ID:  (err -6)
user  :notice: [   76.553871] Setting up libssl1.1:amd64 (1.1.0h-2) ...
kern  :debug : [   76.555926] [drm:drm_add_display_info [drm]] non_desktop =
set to 0

kern  :debug : [   76.560235] [drm:drm_add_display_info [drm]] HDMI: DVI du=
al 0, max TMDS clock 0 kHz
kern  :debug : [   76.560250] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 82 (1)
kern  :debug : [   76.661525] [drm:drm_add_edid_modes.part.27 [drm]] ELD mo=
nitor Raritan CIM
kern  :debug : [   76.661540] [drm:drm_add_edid_modes.part.27 [drm]] HDMI: =
latency present 0 0, video latency 0 0, audio latency 0 0
kern  :debug : [   76.665176] [drm:drm_add_edid_modes.part.27 [drm]] ELD si=
ze 32, SAD count 0
kern  :debug : [   76.667144] [drm:drm_add_display_info [drm]] non_desktop =
set to 0
kern  :debug : [   76.667163] [drm:drm_add_display_info [drm]] HDMI: DVI du=
al 0, max TMDS clock 0 kHz
kern  :debug : [   76.671426] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:73:HDMI-A-1] probed modes :
kern  :debug : [   76.671440] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 83:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x48 =
0x5
kern  :debug : [   76.671452] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 95:"1280x1024" 75 135000 1280 1296 1440 1688 1024 1025 1028 1066 0x40 =
0x5
kern  :debug : [   76.671461] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 88:"1152x864" 75 108000 1152 1216 1344 1600 864 865 868 900 0x40 0x5
kern  :debug : [   76.671471] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 87:"1152x864" 60 81579 1152 1216 1336 1520 864 865 868 895 0x0 0x6
kern  :debug : [   76.671480] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 86:"1024x768" 85 94500 1024 1072 1168 1376 768 769 772 808 0x40 0x5
kern  :debug : [   76.671489] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 96:"1024x768" 75 78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
kern  :debug : [   76.671498] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 97:"1024x768" 70 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
kern  :debug : [   76.671507] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 98:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
kern  :debug : [   76.671516] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 85:"800x600" 85 56250 800 832 896 1048 600 601 604 631 0x40 0x5
kern  :debug : [   76.671524] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 99:"800x600" 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
kern  :debug : [   76.671533] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 100:"800x600" 72 50000 800 856 976 1040 600 637 643 666 0x40 0x5
kern  :debug : [   76.671542] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 89:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
kern  :debug : [   76.671551] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 90:"800x600" 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
kern  :debug : [   76.671559] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 84:"640x480" 85 36000 640 696 752 832 480 481 484 509 0x40 0xa
kern  :debug : [   76.671568] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 91:"640x480" 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
kern  :debug : [   76.671576] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 92:"640x480" 73 31500 640 664 704 832 480 489 492 520 0x40 0xa
kern  :debug : [   76.671585] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 101:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
kern  :debug : [   76.671594] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 93:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
kern  :debug : [   76.671602] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 94:"720x400" 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
kern  :debug : [   76.671609] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:78:DP-1]
kern  :debug : [   76.671642] [drm:intel_dp_detect [i915]] [CONNECTOR:78:DP=
-1]
kern  :debug : [   76.683645] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
user  :notice: [   76.695541] Setting up libgdbm-compat4:amd64 (1.14.1-6) .=
=2E.
kern  :debug : [   76.709752] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.721134] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.731051] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f

user  :notice: [   76.736466] Setting up libperl5.26:amd64 (5.26.1-5) ...

kern  :debug : [   76.737590] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
user  :notice: [   76.739957] Setting up sysstat (11.6.1-1) ...

kern  :debug : [   76.743982] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.748691] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.752918] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.757111] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.761278] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.765408] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.769528] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.773607] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.777652] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.781674] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.785672] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.789646] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.793585] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.797509] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.801414] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.805277] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.809097] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.812905] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.816682] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.820428] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.824150] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.827863] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.831562] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.835257] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.838916] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.842564] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.846190] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   76.847299] [drm:drm_dp_dpcd_access [drm_kms_helper]] Too=
 many retries, giving up. First error: -110
kern  :debug : [   76.848355] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:78:DP-1] disconnected
kern  :debug : [   76.849444] [drm:drm_setup_crtcs [drm_kms_helper]] connec=
tor 64 enabled? yes
kern  :debug : [   76.850434] [drm:drm_setup_crtcs [drm_kms_helper]] connec=
tor 70 enabled? no
kern  :debug : [   76.851641] [drm:drm_setup_crtcs [drm_kms_helper]] connec=
tor 73 enabled? yes
kern  :debug : [   76.852656] [drm:drm_setup_crtcs [drm_kms_helper]] connec=
tor 78 enabled? no
kern  :debug : [   76.853612] [drm:intel_fb_initial_config [i915]] Not usin=
g firmware configuration
kern  :debug : [   76.854765] [drm:drm_setup_crtcs [drm_kms_helper]] lookin=
g for cmdline mode on connector 64
kern  :debug : [   76.855994] [drm:drm_setup_crtcs [drm_kms_helper]] lookin=
g for preferred mode on connector 64 0
kern  :debug : [   76.857245] [drm:drm_setup_crtcs [drm_kms_helper]] found =
mode 1366x768
kern  :debug : [   76.858352] [drm:drm_setup_crtcs [drm_kms_helper]] lookin=
g for cmdline mode on connector 73
kern  :debug : [   76.859586] [drm:drm_setup_crtcs [drm_kms_helper]] lookin=
g for preferred mode on connector 73 0
kern  :debug : [   76.860704] [drm:drm_setup_crtcs [drm_kms_helper]] found =
mode 1280x1024
kern  :debug : [   76.861592] [drm:drm_setup_crtcs [drm_kms_helper]] pickin=
g CRTCs for 1366x1024 config
kern  :debug : [   76.862665] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (4)
kern  :debug : [   76.863557] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (4)
kern  :debug : [   76.864453] [drm:drm_setup_crtcs [drm_kms_helper]] desire=
d mode 1366x768 set on crtc 39 (0,0)
kern  :debug : [   76.865566] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (3)
kern  :debug : [   76.866394] [drm:drm_setup_crtcs [drm_kms_helper]] desire=
d mode 1280x1024 set on crtc 51 (0,0)
kern  :debug : [   76.867529] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (3)
kern  :debug : [   76.868390] [drm:drm_atomic_state_init [drm]] Allocated a=
tomic state 000000002052b977
kern  :debug : [   76.869531] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
5)
kern  :debug : [   76.870656] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:28:primary A] 000000006a3dfb7f state to 000000002052b977
kern  :debug : [   76.872115] [drm:drm_mode_object_get [drm]] OBJ ID: 79 (1)
kern  :debug : [   76.873317] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:39:pipe A] 0000000099ba2769 state to 000000002052b977
kern  :debug : [   76.874854] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:31:sprite A] 000000008c2daa3a state to 000000002052b977
kern  :debug : [   76.876448] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 000000008c2daa3a to [NOCRTC]
kern  :debug : [   76.877881] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 000000008c2daa3a
kern  :debug : [   76.879243] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:36:cursor A] 00000000b6a590bf state to 000000002052b977
kern  :debug : [   76.880599] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000b6a590bf to [NOCRTC]
kern  :debug : [   76.882190] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000b6a590bf
kern  :debug : [   76.883822] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
6)
kern  :debug : [   76.885195] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:40:primary B] 00000000d91b37cd state to 000000002052b977
kern  :debug : [   76.886705] [drm:drm_mode_object_get [drm]] OBJ ID: 80 (1)
kern  :debug : [   76.887876] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:51:pipe B] 00000000c4fe576b state to 000000002052b977
kern  :debug : [   76.889515] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:43:sprite B] 00000000c5c4d840 state to 000000002052b977
kern  :debug : [   76.891109] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000c5c4d840 to [NOCRTC]
kern  :debug : [   76.892576] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000c5c4d840
kern  :debug : [   76.894034] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:48:cursor B] 0000000059a9d6c7 state to 000000002052b977
kern  :debug : [   76.895649] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 0000000059a9d6c7 to [NOCRTC]
kern  :debug : [   76.897286] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 0000000059a9d6c7
kern  :debug : [   76.898895] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:52:primary C] 0000000081ec91a0 state to 000000002052b977
kern  :debug : [   76.900582] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:55:sprite C] 0000000019cc4f27 state to 000000002052b977
kern  :debug : [   76.902281] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 0000000019cc4f27 to [NOCRTC]
kern  :debug : [   76.904013] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 0000000019cc4f27
kern  :debug : [   76.905630] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:60:cursor C] 00000000e89293fe state to 000000002052b977
kern  :debug : [   76.907387] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000e89293fe to [NOCRTC]
kern  :debug : [   76.909084] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000e89293fe
kern  :debug : [   76.910984] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 79 (2)
kern  :debug : [   76.912668] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[MODE:1366x768] for CRTC state 0000000099ba2769
kern  :debug : [   76.914723] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 000000006a3dfb7f to [CRTC:39:pipe A]
kern  :debug : [   76.916697] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
FB:104] for plane state 000000006a3dfb7f
kern  :debug : [   76.918420] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
7)
kern  :debug : [   76.919979] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (8)
kern  :debug : [   76.921542] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:39:pipe A] to 000000002052b977
kern  :debug : [   76.923654] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (5)
kern  :debug : [   76.925566] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (6)
kern  :debug : [   76.927124] [drm:drm_atomic_get_connector_state [drm]] Ad=
ded [CONNECTOR:64:LVDS-1] 00000000a7052c13 state to 000000002052b977
kern  :debug : [   76.929015] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (6)
kern  :debug : [   76.930627] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 00000000a7052c13 to [NOCRTC]
kern  :debug : [   76.932453] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (5)
kern  :debug : [   76.934060] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 00000000a7052c13 to [CRTC:39:pipe A]
kern  :debug : [   76.936048] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 80 (2)
kern  :debug : [   76.937732] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[MODE:1280x1024] for CRTC state 00000000c4fe576b
kern  :debug : [   76.939603] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000d91b37cd to [CRTC:51:pipe B]
kern  :debug : [   76.941602] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
FB:104] for plane state 00000000d91b37cd
kern  :debug : [   76.943554] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
7)
kern  :debug : [   76.945212] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (8)
kern  :debug : [   76.946894] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:51:pipe B] to 000000002052b977
kern  :debug : [   76.948896] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (5)
kern  :debug : [   76.950557] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (6)
kern  :debug : [   76.952203] [drm:drm_atomic_get_connector_state [drm]] Ad=
ded [CONNECTOR:73:HDMI-A-1] 00000000c20ab1fe state to 000000002052b977
kern  :debug : [   76.954177] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (6)
kern  :debug : [   76.955855] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 00000000c20ab1fe to [NOCRTC]
kern  :debug : [   76.957738] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (5)
kern  :debug : [   76.959550] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 00000000c20ab1fe to [CRTC:51:pipe B]
kern  :debug : [   76.961695] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:63:pipe C] 000000000b5adf55 state to 000000002052b977
kern  :debug : [   76.963624] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[NOMODE] for CRTC state 000000000b5adf55
kern  :debug : [   76.965513] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 0000000081ec91a0 to [NOCRTC]
kern  :debug : [   76.967610] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 0000000081ec91a0
kern  :debug : [   76.969587] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:63:pipe C] to 000000002052b977
kern  :debug : [   76.971990] [drm:drm_atomic_check_only [drm]] checking 00=
0000002052b977
kern  :debug : [   76.974006] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Updating routing for [CONNECTOR:64:LVDS-1]
kern  :debug : [   76.976012] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] [CONNECTOR:64:LVDS-1] keeps [ENCODER:65:LVDS], now on [CRTC:39:pi=
pe A]
kern  :debug : [   76.978140] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Updating routing for [CONNECTOR:73:HDMI-A-1]
kern  :debug : [   76.980393] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] [CONNECTOR:73:HDMI-A-1] keeps [ENCODER:72:HDMI B], now on [CRTC:5=
1:pipe B]
kern  :debug : [   76.983000] [drm:intel_plane_atomic_calc_changes [i915]] =
[CRTC:39:pipe A] has [PLANE:28:primary A] with fb 104
kern  :debug : [   76.985399] [drm:intel_plane_atomic_calc_changes [i915]] =
[PLANE:28:primary A] visible 1 -> 1, off 0, on 0, ms 0
kern  :debug : [   76.987776] [drm:intel_plane_atomic_calc_changes [i915]] =
[CRTC:51:pipe B] has [PLANE:40:primary B] with fb 104
kern  :debug : [   76.990144] [drm:intel_plane_atomic_calc_changes [i915]] =
[PLANE:40:primary B] visible 1 -> 1, off 0, on 0, ms 0
kern  :debug : [   76.992368] [drm:drm_atomic_commit [drm]] committing 0000=
00002052b977
kern  :debug : [   76.994410] [drm:drm_vblank_enable [drm]] enabling vblank=
 on crtc 0, ret: 0
kern  :debug : [   76.996139] [drm:drm_vblank_enable [drm]] enabling vblank=
 on crtc 1, ret: 0
kern  :debug : [   76.998602] [drm:drm_handle_vblank [drm]] vblank event on=
 64, current 64
kern  :debug : [   77.010705] [drm:drm_handle_vblank [drm]] vblank event on=
 92, current 92
kern  :debug : [   77.012349] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
7)
kern  :debug : [   77.013945] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (8)
kern  :debug : [   77.015258] [drm:vblank_disable_fn [drm]] disabling vblan=
k on crtc 1
kern  :debug : [   77.015544] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
7)
kern  :debug : [   77.018665] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (8)
kern  :debug : [   77.020239] [drm:drm_atomic_state_default_clear [drm]] Cl=
earing atomic state 000000002052b977
kern  :debug : [   77.021959] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (6)
kern  :debug : [   77.023521] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (5)
kern  :debug : [   77.025065] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (6)
kern  :debug : [   77.026605] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (5)
kern  :debug : [   77.027330] [drm:vblank_disable_fn [drm]] disabling vblan=
k on crtc 0
kern  :debug : [   77.028109] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 79 (1)
kern  :debug : [   77.031076] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 80 (1)
kern  :debug : [   77.032527] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (7)
kern  :debug : [   77.033962] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (6)
kern  :debug : [   77.035371] [drm:__drm_atomic_state_free [drm]] Freeing a=
tomic state 000000002052b977
kern  :debug : [   77.036869] [drm:drm_sysfs_hotplug_event [drm]] generatin=
g hotplug event
kern  :debug : [   77.038330] [drm:drm_fb_helper_hotplug_event.part.33 [drm=
_kms_helper]]=20
kern  :debug : [   77.040156] [drm:drm_setup_crtcs [drm_kms_helper]]=20
kern  :debug : [   77.041468] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:64:LVDS-1]
kern  :debug : [   77.043045] [drm:intel_lvds_detect [i915]] [CONNECTOR:64:=
LVDS-1]
kern  :debug : [   77.044425] [drm:drm_add_edid_modes.part.27 [drm]] ELD: n=
o CEA Extension found
kern  :debug : [   77.045857] [drm:drm_add_display_info [drm]] non_desktop =
set to 0
kern  :debug : [   77.047238] [drm:drm_add_display_info [drm]] LVDS-1: Assi=
gning EDID-1.4 digital sink color depth as 6 bpc.
kern  :debug : [   77.048821] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:64:LVDS-1] probed modes :
kern  :debug : [   77.050411] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 67:"1366x768" 60 74980 1366 1404 1426 1572 768 771 777 794 0x48 0xa
kern  :debug : [   77.052086] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:70:VGA-1]
kern  :debug : [   77.053632] [drm:intel_crt_detect [i915]] [CONNECTOR:70:V=
GA-1] force=3D1
kern  :debug : [   77.055049] [drm:intel_crt_detect [i915]] ironlake hotplu=
g adpa=3D0xf40000, result 0
kern  :debug : [   77.056507] [drm:intel_crt_detect [i915]] CRT not detecte=
d via hotplug
kern  :debug : [   77.111212] [drm:do_gmbus_xfer [i915]] GMBUS [i915 gmbus =
vga] timed out, falling back to bit banging on pin 2
kern  :debug : [   77.128048] [drm:drm_do_probe_ddc_edid [drm]] drm: skippi=
ng non-existent adapter i915 gmbus vga
kern  :debug : [   77.129589] [drm:intel_crt_get_edid [i915]] CRT GMBUS EDI=
D read failed, retry using GPIO bit-banging
kern  :debug : [   77.131141] [drm:intel_gmbus_force_bit [i915]] enabling b=
it-banging on i915 gmbus vga. force bit now 1
kern  :debug : [   77.148045] [drm:drm_do_probe_ddc_edid [drm]] drm: skippi=
ng non-existent adapter i915 gmbus vga
kern  :debug : [   77.149566] [drm:intel_gmbus_force_bit [i915]] disabling =
bit-banging on i915 gmbus vga. force bit now 0
kern  :debug : [   77.151129] [drm:intel_crt_detect_ddc [i915]] CRT not det=
ected via DDC:0x50 [no valid EDID found]
kern  :debug : [   77.152639] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:70:VGA-1] disconnected
kern  :debug : [   77.154203] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:73:HDMI-A-1]
kern  :debug : [   77.155710] [drm:intel_hdmi_detect [i915]] [CONNECTOR:73:=
HDMI-A-1]
kern  :debug : [   77.183297] [drm:do_gmbus_xfer [i915]] GMBUS [i915 gmbus =
dpb] NAK for addr: 0040 w(1)
kern  :debug : [   77.184880] [drm:do_gmbus_xfer [i915]] GMBUS [i915 gmbus =
dpb] NAK on first message, retry
kern  :debug : [   77.186654] [drm:do_gmbus_xfer [i915]] GMBUS [i915 gmbus =
dpb] NAK for addr: 0040 w(1)
kern  :debug : [   77.188637] [drm:drm_dp_dual_mode_detect [drm_kms_helper]=
] DP dual mode HDMI ID:  (err -6)
kern  :debug : [   77.190305] [drm:drm_add_display_info [drm]] non_desktop =
set to 0
kern  :debug : [   77.191660] [drm:drm_add_display_info [drm]] HDMI: DVI du=
al 0, max TMDS clock 0 kHz
kern  :debug : [   77.193085] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 81 (1)
kern  :debug : [   77.194925] [drm:drm_add_edid_modes.part.27 [drm]] ELD mo=
nitor Raritan CIM
kern  :debug : [   77.196550] [drm:drm_add_edid_modes.part.27 [drm]] HDMI: =
latency present 0 0, video latency 0 0, audio latency 0 0
kern  :debug : [   77.198657] [drm:drm_add_edid_modes.part.27 [drm]] ELD si=
ze 32, SAD count 0
kern  :debug : [   77.200612] [drm:drm_add_display_info [drm]] non_desktop =
set to 0
kern  :debug : [   77.202355] [drm:drm_add_display_info [drm]] HDMI: DVI du=
al 0, max TMDS clock 0 kHz
kern  :debug : [   77.204130] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:73:HDMI-A-1] probed modes :
kern  :debug : [   77.205749] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 83:"1280x1024" 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x48 =
0x5
kern  :debug : [   77.207584] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 95:"1280x1024" 75 135000 1280 1296 1440 1688 1024 1025 1028 1066 0x40 =
0x5
kern  :debug : [   77.209322] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 88:"1152x864" 75 108000 1152 1216 1344 1600 864 865 868 900 0x40 0x5
kern  :debug : [   77.211050] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 87:"1152x864" 60 81579 1152 1216 1336 1520 864 865 868 895 0x0 0x6
kern  :debug : [   77.212782] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 86:"1024x768" 85 94500 1024 1072 1168 1376 768 769 772 808 0x40 0x5
kern  :debug : [   77.214526] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 96:"1024x768" 75 78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
kern  :debug : [   77.216267] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 97:"1024x768" 70 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
kern  :debug : [   77.218020] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 98:"1024x768" 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
kern  :debug : [   77.219778] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 85:"800x600" 85 56250 800 832 896 1048 600 601 604 631 0x40 0x5
kern  :debug : [   77.221963] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 99:"800x600" 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
kern  :debug : [   77.224173] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 100:"800x600" 72 50000 800 856 976 1040 600 637 643 666 0x40 0x5
kern  :debug : [   77.226013] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 89:"800x600" 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
kern  :debug : [   77.227770] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 90:"800x600" 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
kern  :debug : [   77.229523] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 84:"640x480" 85 36000 640 696 752 832 480 481 484 509 0x40 0xa
kern  :debug : [   77.231262] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 91:"640x480" 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
kern  :debug : [   77.232985] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 92:"640x480" 73 31500 640 664 704 832 480 489 492 520 0x40 0xa
kern  :debug : [   77.234704] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 101:"640x480" 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
kern  :debug : [   77.236477] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 93:"640x480" 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
kern  :debug : [   77.238191] [drm:drm_mode_debug_printmodeline [drm]] Mode=
line 94:"720x400" 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
kern  :debug : [   77.239890] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:78:DP-1]
kern  :debug : [   77.241474] [drm:intel_dp_detect [i915]] [CONNECTOR:78:DP=
-1]
kern  :debug : [   77.245356] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.249672] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.253967] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.258272] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.262649] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.266982] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.273560] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.277824] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.282034] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.286243] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.290386] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.294486] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.298706] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.302965] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.306909] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.310847] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
user  :notice: [   77.312207] Setting up gawk (1:4.1.4+dfsg-1+b1) ...

kern  :debug : [   77.316134] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
user  :notice: [   77.316734] Processing triggers for libc-bin (2.23-5) ...

kern  :debug : [   77.321646] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
user  :notice: [   77.322493] Processing triggers for systemd (231-5) ...

kern  :debug : [   77.327034] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.330956] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.334811] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.338614] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.342408] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.346168] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.349904] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.353606] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.357297] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.360978] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.364659] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.368303] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.371933] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.375539] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch time=
out status 0x7145003f
kern  :debug : [   77.376643] [drm:drm_dp_dpcd_access [drm_kms_helper]] Too=
 many retries, giving up. First error: -110
kern  :debug : [   77.377689] [drm:drm_helper_probe_single_connector_modes =
[drm_kms_helper]] [CONNECTOR:78:DP-1] disconnected
kern  :debug : [   77.378755] [drm:drm_setup_crtcs [drm_kms_helper]] connec=
tor 64 enabled? yes
kern  :debug : [   77.379683] [drm:drm_setup_crtcs [drm_kms_helper]] connec=
tor 70 enabled? no
kern  :debug : [   77.380603] [drm:drm_setup_crtcs [drm_kms_helper]] connec=
tor 73 enabled? yes
kern  :debug : [   77.381511] [drm:drm_setup_crtcs [drm_kms_helper]] connec=
tor 78 enabled? no
kern  :debug : [   77.382416] [drm:intel_fb_initial_config [i915]] Not usin=
g firmware configuration
kern  :debug : [   77.383361] [drm:drm_setup_crtcs [drm_kms_helper]] lookin=
g for cmdline mode on connector 64
kern  :debug : [   77.384322] [drm:drm_setup_crtcs [drm_kms_helper]] lookin=
g for preferred mode on connector 64 0
kern  :debug : [   77.385289] [drm:drm_setup_crtcs [drm_kms_helper]] found =
mode 1366x768
kern  :debug : [   77.386134] [drm:drm_setup_crtcs [drm_kms_helper]] lookin=
g for cmdline mode on connector 73
kern  :debug : [   77.387096] [drm:drm_setup_crtcs [drm_kms_helper]] lookin=
g for preferred mode on connector 73 0
kern  :debug : [   77.388085] [drm:drm_setup_crtcs [drm_kms_helper]] found =
mode 1280x1024
kern  :debug : [   77.388957] [drm:drm_setup_crtcs [drm_kms_helper]] pickin=
g CRTCs for 1366x1024 config
kern  :debug : [   77.390039] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (4)
kern  :debug : [   77.390917] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (4)
kern  :debug : [   77.391835] [drm:drm_setup_crtcs [drm_kms_helper]] desire=
d mode 1366x768 set on crtc 39 (0,0)
kern  :debug : [   77.392881] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (3)
kern  :debug : [   77.393769] [drm:drm_setup_crtcs [drm_kms_helper]] desire=
d mode 1280x1024 set on crtc 51 (0,0)
kern  :debug : [   77.394860] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (3)
kern  :debug : [   77.395805] [drm:drm_atomic_state_init [drm]] Allocated a=
tomic state 00000000f5c8a399
kern  :debug : [   77.396893] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
5)
kern  :debug : [   77.397880] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:28:primary A] 000000000f6da752 state to 00000000f5c8a399
kern  :debug : [   77.399208] [drm:drm_mode_object_get [drm]] OBJ ID: 103 (=
1)
kern  :debug : [   77.400247] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:39:pipe A] 000000008bd30e94 state to 00000000f5c8a399
kern  :debug : [   77.401583] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:31:sprite A] 00000000ab1eb42d state to 00000000f5c8a399
kern  :debug : [   77.402944] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000ab1eb42d to [NOCRTC]
kern  :debug : [   77.404224] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000ab1eb42d
kern  :debug : [   77.405495] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:36:cursor A] 0000000019ee9c1a state to 00000000f5c8a399
kern  :debug : [   77.406891] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 0000000019ee9c1a to [NOCRTC]
kern  :debug : [   77.408187] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 0000000019ee9c1a
kern  :debug : [   77.409461] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
6)
kern  :debug : [   77.410561] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:40:primary B] 000000004616ad85 state to 00000000f5c8a399
kern  :debug : [   77.411978] [drm:drm_mode_object_get [drm]] OBJ ID: 105 (=
1)
kern  :debug : [   77.413107] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:51:pipe B] 00000000ac933a84 state to 00000000f5c8a399
kern  :debug : [   77.414544] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:43:sprite B] 0000000049c2fa84 state to 00000000f5c8a399
kern  :debug : [   77.416020] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 0000000049c2fa84 to [NOCRTC]
kern  :debug : [   77.417408] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 0000000049c2fa84
kern  :debug : [   77.418800] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:48:cursor B] 00000000466bbf39 state to 00000000f5c8a399
kern  :debug : [   77.420332] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000466bbf39 to [NOCRTC]
kern  :debug : [   77.421790] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000466bbf39
kern  :debug : [   77.423246] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:52:primary C] 00000000969c0a4d state to 00000000f5c8a399
kern  :debug : [   77.424850] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:55:sprite C] 0000000081502855 state to 00000000f5c8a399
kern  :debug : [   77.426456] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 0000000081502855 to [NOCRTC]
kern  :debug : [   77.428037] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 0000000081502855
kern  :debug : [   77.429584] [drm:drm_atomic_get_plane_state [drm]] Added =
[PLANE:60:cursor C] 00000000f4a19c9d state to 00000000f5c8a399
kern  :debug : [   77.431284] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000f4a19c9d to [NOCRTC]
kern  :debug : [   77.432885] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000f4a19c9d
kern  :debug : [   77.434469] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 103 (2)
kern  :debug : [   77.435904] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[MODE:1366x768] for CRTC state 000000008bd30e94
kern  :debug : [   77.437525] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 000000000f6da752 to [CRTC:39:pipe A]
kern  :debug : [   77.439173] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
FB:104] for plane state 000000000f6da752
kern  :debug : [   77.440794] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
7)
kern  :debug : [   77.442250] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (8)
kern  :debug : [   77.443728] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:39:pipe A] to 00000000f5c8a399
kern  :debug : [   77.445529] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (5)
kern  :debug : [   77.446999] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (6)
kern  :debug : [   77.448458] [drm:drm_atomic_get_connector_state [drm]] Ad=
ded [CONNECTOR:64:LVDS-1] 0000000016f939c5 state to 00000000f5c8a399
kern  :debug : [   77.450258] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (6)
kern  :debug : [   77.451786] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 0000000016f939c5 to [NOCRTC]
kern  :debug : [   77.453529] [drm:drm_mode_object_get [drm]] OBJ ID: 64 (5)
kern  :debug : [   77.455047] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 0000000016f939c5 to [CRTC:39:pipe A]
kern  :debug : [   77.456851] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 105 (2)
kern  :debug : [   77.458440] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[MODE:1280x1024] for CRTC state 00000000ac933a84
kern  :debug : [   77.460230] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 000000004616ad85 to [CRTC:51:pipe B]
kern  :debug : [   77.462067] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
FB:104] for plane state 000000004616ad85
kern  :debug : [   77.463811] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
7)
kern  :debug : [   77.465362] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (8)
kern  :debug : [   77.466943] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:51:pipe B] to 00000000f5c8a399
kern  :debug : [   77.468846] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (5)
kern  :debug : [   77.470455] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (6)
kern  :debug : [   77.472020] [drm:drm_atomic_get_connector_state [drm]] Ad=
ded [CONNECTOR:73:HDMI-A-1] 00000000e3a718e4 state to 00000000f5c8a399
kern  :debug : [   77.473918] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (6)
kern  :debug : [   77.475513] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 00000000e3a718e4 to [NOCRTC]
kern  :debug : [   77.477325] [drm:drm_mode_object_get [drm]] OBJ ID: 73 (5)
kern  :debug : [   77.478906] [drm:drm_atomic_set_crtc_for_connector [drm]]=
 Link connector state 00000000e3a718e4 to [CRTC:51:pipe B]
kern  :debug : [   77.480755] [drm:drm_atomic_get_crtc_state [drm]] Added [=
CRTC:63:pipe C] 00000000973c3c07 state to 00000000f5c8a399
kern  :debug : [   77.482619] [drm:drm_atomic_set_mode_for_crtc [drm]] Set =
[NOMODE] for CRTC state 00000000973c3c07
kern  :debug : [   77.484405] [drm:drm_atomic_set_crtc_for_plane [drm]] Lin=
k plane state 00000000969c0a4d to [NOCRTC]
kern  :debug : [   77.486203] [drm:drm_atomic_set_fb_for_plane [drm]] Set [=
NOFB] for plane state 00000000969c0a4d
kern  :debug : [   77.487952] [drm:drm_atomic_add_affected_connectors [drm]=
] Adding all current connectors for [CRTC:63:pipe C] to 00000000f5c8a399
kern  :debug : [   77.489869] [drm:drm_atomic_check_only [drm]] checking 00=
000000f5c8a399
kern  :debug : [   77.491521] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Updating routing for [CONNECTOR:64:LVDS-1]
kern  :debug : [   77.493349] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] [CONNECTOR:64:LVDS-1] keeps [ENCODER:65:LVDS], now on [CRTC:39:pi=
pe A]
kern  :debug : [   77.495310] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] Updating routing for [CONNECTOR:73:HDMI-A-1]
kern  :debug : [   77.497153] [drm:drm_atomic_helper_check_modeset [drm_kms=
_helper]] [CONNECTOR:73:HDMI-A-1] keeps [ENCODER:72:HDMI B], now on [CRTC:5=
1:pipe B]
kern  :debug : [   77.499159] [drm:intel_plane_atomic_calc_changes [i915]] =
[CRTC:39:pipe A] has [PLANE:28:primary A] with fb 104
kern  :debug : [   77.501001] [drm:intel_plane_atomic_calc_changes [i915]] =
[PLANE:28:primary A] visible 1 -> 1, off 0, on 0, ms 0
kern  :debug : [   77.502837] [drm:intel_plane_atomic_calc_changes [i915]] =
[CRTC:51:pipe B] has [PLANE:40:primary B] with fb 104
kern  :debug : [   77.504674] [drm:intel_plane_atomic_calc_changes [i915]] =
[PLANE:40:primary B] visible 1 -> 1, off 0, on 0, ms 0
kern  :debug : [   77.506532] [drm:drm_atomic_commit [drm]] committing 0000=
0000f5c8a399
kern  :debug : [   77.508194] [drm:drm_vblank_enable [drm]] enabling vblank=
 on crtc 0, ret: 0
kern  :debug : [   77.509868] [drm:drm_vblank_enable [drm]] enabling vblank=
 on crtc 1, ret: 0
kern  :debug : [   77.515111] [drm:drm_handle_vblank [drm]] vblank event on=
 95, current 95
kern  :debug : [   77.526300] [drm:drm_handle_vblank [drm]] vblank event on=
 123, current 123
kern  :debug : [   77.528949] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
7)
kern  :debug : [   77.530446] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (8)
kern  :debug : [   77.531788] [drm:vblank_disable_fn [drm]] disabling vblan=
k on crtc 1
kern  :debug : [   77.532651] [drm:drm_mode_object_get [drm]] OBJ ID: 104 (=
7)
kern  :debug : [   77.536957] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (8)
kern  :debug : [   77.539130] [drm:drm_atomic_state_default_clear [drm]] Cl=
earing atomic state 00000000f5c8a399
kern  :debug : [   77.541461] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (6)
kern  :debug : [   77.542828] [drm:vblank_disable_fn [drm]] disabling vblan=
k on crtc 0
kern  :debug : [   77.542970] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 64 (5)
kern  :debug : [   77.545985] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (6)
kern  :debug : [   77.547488] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 73 (5)
kern  :debug : [   77.548918] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 103 (1)
kern  :debug : [   77.550323] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 105 (1)
kern  :debug : [   77.551697] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (7)
kern  :debug : [   77.553050] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID=
: 104 (6)
kern  :debug : [   77.554447] [drm:__drm_atomic_state_free [drm]] Freeing a=
tomic state 00000000f5c8a399
user  :notice: [   83.441488] 19 Apr 16:31:45 ntpdate[594]: step time serve=
r 192.168.1.1 offset -17482.198480 sec

kern  :info  : [   83.458672] netpoll: netconsole: local port 6665
kern  :info  : [   83.459989] netpoll: netconsole: local IPv4 address 0.0.0=
=2E0
kern  :info  : [   83.461868] netpoll: netconsole: interface 'eth0'
kern  :info  : [   83.464822] netpoll: netconsole: remote port 6674
kern  :info  : [   83.466087] netpoll: netconsole: remote IPv4 address 192.=
168.1.1
kern  :info  : [   83.467417] netpoll: netconsole: remote ethernet address =
ff:ff:ff:ff:ff:ff
kern  :info  : [   83.468768] netpoll: netconsole: local IP 192.168.1.206
kern  :info  : [   83.495249] console [netcon0] enabled
kern  :info  : [   83.496371] netconsole: network logging started
user  :notice: [   83.498889] /lkp/lkp/src/bin/run-lkp

user  :notice: [   83.536160] RESULT_ROOT=3D/result/netperf/ipv4-300s-200%-=
cs-localhost-SCTP_STREAM-performance/lkp-u410/debian-x86_64-2016-08-31.cgz/=
x86_64-rhel-7.2/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/4

user  :notice: [   83.548821] job=3D/lkp/scheduled/lkp-u410/netperf-ipv4-30=
0s-200%-cs-localhost-SCTP_STREAM-performance-debian-x86_64-2016-08-31.cgz-6=
0cc43fc888428bb2f18f08997432d426a243338-20180419-37334-dtcoce-0.yaml

user  :notice: [   83.554134] mount.nfs: try 1 time...

user  :notice: [   83.566340] run-job /lkp/scheduled/lkp-u410/netperf-ipv4-=
300s-200%-cs-localhost-SCTP_STREAM-performance-debian-x86_64-2016-08-31.cgz=
-60cc43fc888428bb2f18f08997432d426a243338-20180419-37334-dtcoce-0.yaml

user  :notice: [   83.608962] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin=
/lkp-jobfile-append-var?job_file=3D/lkp/scheduled/lkp-u410/netperf-ipv4-300=
s-200%25-cs-localhost-SCTP_STREAM-performance-debian-x86_64-2016-08-31.cgz-=
60cc43fc888428bb2f18f08997432d426a243338-20180419-37334-dtcoce-0.yaml&job_s=
tate=3Drunning -o /dev/null

user  :notice: [   83.840331] microcode current_version: 0x1f, target_versi=
on: 0x1f

user  :notice: [   83.847105] 2018-04-19 16:31:45=20

user  :notice: [   83.850850] for cpu_dir in /sys/devices/system/cpu/cpu[0-=
9]*

user  :notice: [   83.853240] do

user  :notice: [   83.856257] 	online_file=3D"$cpu_dir"/online

user  :notice: [   83.862041] 	[ -f "$online_file" ] && [ "$(cat "$online_f=
ile")" -eq 0 ] && continue


user  :notice: [   83.868695] 	file=3D"$cpu_dir"/cpufreq/scaling_governor

user  :notice: [   83.872380] 	[ -f "$file" ] && echo "performance" > "$fil=
e"

user  :notice: [   83.874777] done


user  :notice: [   83.930831] 2018-04-19 16:31:45 netserver -4

user  :notice: [   83.939927] Starting netserver with host 'IN(6)ADDR_ANY' =
port '12865' and family AF_INET

kern  :info  : [   83.983144] capability: warning: `turbostat' uses 32-bit =
capabilities (legacy support in use)

user  :notice: [   84.981749] 2018-04-19 16:31:46 modprobe sctp

kern  :info  : [   84.990344] sctp: Hash tables configured (bind 256/256)
user  :notice: [   86.000750] 2018-04-19 16:31:47 netperf -4 -t SCTP_STREAM=
 -c -C -l 300  -H 127.0.0.1 &

user  :notice: [   86.008430] 2018-04-19 16:31:47 netperf -4 -t SCTP_STREAM=
 -c -C -l 300  -H 127.0.0.1 &

user  :notice: [   86.017914] 2018-04-19 16:31:47 netperf -4 -t SCTP_STREAM=
 -c -C -l 300  -H 127.0.0.1 &

user  :notice: [   86.026117] 2018-04-19 16:31:47 netperf -4 -t SCTP_STREAM=
 -c -C -l 300  -H 127.0.0.1 &

user  :notice: [   86.033564] 2018-04-19 16:31:47 netperf -4 -t SCTP_STREAM=
 -c -C -l 300  -H 127.0.0.1 &

user  :notice: [   86.041407] 2018-04-19 16:31:47 netperf -4 -t SCTP_STREAM=
 -c -C -l 300  -H 127.0.0.1 &

user  :notice: [   86.047894] 2018-04-19 16:31:47 netperf -4 -t SCTP_STREAM=
 -c -C -l 300  -H 127.0.0.1 &

user  :notice: [   86.053942] 2018-04-19 16:31:47 netperf -4 -t SCTP_STREAM=
 -c -C -l 300  -H 127.0.0.1 &

user  :notice: [   86.057801] 2018-04-19 16:31:47 wait

user  :notice: [  143.948898] IPMI BMC is not supported on this machine, sk=
ip bmc-watchdog setup!

kern  :notice: [  189.576935] random: crng init done
kern  :info  : [  234.585094] perf: interrupt took too long (2927 > 2500), =
lowering kernel.perf_event_max_sample_rate to 68000
kern  :info  : [  234.656114] perf: interrupt took too long (3703 > 3658), =
lowering kernel.perf_event_max_sample_rate to 54000
kern  :info  : [  234.702118] perf: interrupt took too long (4810 > 4628), =
lowering kernel.perf_event_max_sample_rate to 41000
kern  :info  : [  234.746098] perf: interrupt took too long (6105 > 6012), =
lowering kernel.perf_event_max_sample_rate to 32000
kern  :info  : [  234.777109] perf: interrupt took too long (7666 > 7631), =
lowering kernel.perf_event_max_sample_rate to 26000
kern  :info  : [  234.871113] perf: interrupt took too long (9679 > 9582), =
lowering kernel.perf_event_max_sample_rate to 20000
kern  :info  : [  234.982090] perf: interrupt took too long (12368 > 12098)=
, lowering kernel.perf_event_max_sample_rate to 16000
kern  :info  : [  235.138093] perf: interrupt took too long (15468 > 15460)=
, lowering kernel.perf_event_max_sample_rate to 12000
kern  :info  : [  235.363094] perf: interrupt took too long (19520 > 19335)=
, lowering kernel.perf_event_max_sample_rate to 10000
kern  :info  : [  235.809096] perf: interrupt took too long (24600 > 24400)=
, lowering kernel.perf_event_max_sample_rate to 8000
user  :notice: [  386.155674] SCTP STREAM TEST from 0.0.0.0 (0.0.0.0) port =
0 AF_INET to 127.0.0.1 () port 0 AF_INET : demo

user  :notice: [  386.160721] Recv   Send    Send                          =
Utilization       Service Demand

user  :notice: [  386.165605] Socket Socket  Message  Elapsed              =
Send     Recv     Send    Recv

user  :notice: [  386.170853] Size   Size    Size     Time     Throughput  =
local    remote   local   remote

user  :notice: [  386.175848] bytes  bytes   bytes    secs.    10^6bits/s  =
% S      % S      us/KB   us/KB


user  :notice: [  386.182294] 212992 212992 212992    300.14        4.10   =
5.06     5.06     404.255  404.246

user  :notice: [  386.187722] SCTP STREAM TEST from 0.0.0.0 (0.0.0.0) port =
0 AF_INET to 127.0.0.1 () port 0 AF_INET : demo

user  :notice: [  386.192972] Recv   Send    Send                          =
Utilization       Service Demand

user  :notice: [  386.197929] Socket Socket  Message  Elapsed              =
Send     Recv     Send    Recv

user  :notice: [  386.202882] Size   Size    Size     Time     Throughput  =
local    remote   local   remote

user  :notice: [  386.207824] bytes  bytes   bytes    secs.    10^6bits/s  =
% S      % S      us/KB   us/KB


user  :notice: [  386.213824] 212992 212992 212992    300.14        4.10   =
5.05     5.05     404.100  404.100

user  :notice: [  386.219947] SCTP STREAM TEST from 0.0.0.0 (0.0.0.0) port =
0 AF_INET to 127.0.0.1 () port 0 AF_INET : demo

user  :notice: [  386.225311] Recv   Send    Send                          =
Utilization       Service Demand

user  :notice: [  386.230083] Socket Socket  Message  Elapsed              =
Send     Recv     Send    Recv

user  :notice: [  386.234768] Size   Size    Size     Time     Throughput  =
local    remote   local   remote

user  :notice: [  386.239457] bytes  bytes   bytes    secs.    10^6bits/s  =
% S      % S      us/KB   us/KB


user  :notice: [  386.245262] 212992 212992 212992    300.14        4.10   =
5.05     5.05     403.906  403.906

user  :notice: [  386.250550] SCTP STREAM TEST from 0.0.0.0 (0.0.0.0) port =
0 AF_INET to 127.0.0.1 () port 0 AF_INET : demo

user  :notice: [  386.255445] Recv   Send    Send                          =
Utilization       Service Demand

user  :notice: [  386.260243] Socket Socket  Message  Elapsed              =
Send     Recv     Send    Recv

user  :notice: [  386.265081] Size   Size    Size     Time     Throughput  =
local    remote   local   remote

user  :notice: [  386.269913] bytes  bytes   bytes    secs.    10^6bits/s  =
% S      % S      us/KB   us/KB


user  :notice: [  386.275930] 212992 212992 212992    300.14        4.10   =
5.05     5.05     403.978  403.978

user  :notice: [  386.281307] SCTP STREAM TEST from 0.0.0.0 (0.0.0.0) port =
0 AF_INET to 127.0.0.1 () port 0 AF_INET : demo

user  :notice: [  386.286292] Recv   Send    Send                          =
Utilization       Service Demand

user  :notice: [  386.291143] Socket Socket  Message  Elapsed              =
Send     Recv     Send    Recv

user  :notice: [  386.296017] Size   Size    Size     Time     Throughput  =
local    remote   local   remote

user  :notice: [  386.300856] bytes  bytes   bytes    secs.    10^6bits/s  =
% S      % S      us/KB   us/KB


user  :notice: [  386.306883] 212992 212992 212992    300.14        4.10   =
5.05     5.05     403.708  403.708

user  :notice: [  386.313860] SCTP STREAM TEST from 0.0.0.0 (0.0.0.0) port =
0 AF_INET to 127.0.0.1 () port 0 AF_INET : demo

user  :notice: [  386.319203] Recv   Send    Send                          =
Utilization       Service Demand

user  :notice: [  386.324176] Socket Socket  Message  Elapsed              =
Send     Recv     Send    Recv

user  :notice: [  386.329090] Size   Size    Size     Time     Throughput  =
local    remote   local   remote

user  :notice: [  386.333955] bytes  bytes   bytes    secs.    10^6bits/s  =
% S      % S      us/KB   us/KB


user  :notice: [  386.339927] 212992 212992 212992    300.20        4.10   =
5.06     5.06     404.671  404.671

user  :notice: [  386.345275] SCTP STREAM TEST from 0.0.0.0 (0.0.0.0) port =
0 AF_INET to 127.0.0.1 () port 0 AF_INET : demo

user  :notice: [  386.350285] Recv   Send    Send                          =
Utilization       Service Demand

user  :notice: [  386.355126] Socket Socket  Message  Elapsed              =
Send     Recv     Send    Recv

user  :notice: [  386.360013] Size   Size    Size     Time     Throughput  =
local    remote   local   remote

user  :notice: [  386.364869] bytes  bytes   bytes    secs.    10^6bits/s  =
% S      % S      us/KB   us/KB


user  :notice: [  386.370854] 212992 212992 212992    300.20        4.10   =
5.06     5.06     404.667  404.667

user  :notice: [  386.376188] SCTP STREAM TEST from 0.0.0.0 (0.0.0.0) port =
0 AF_INET to 127.0.0.1 () port 0 AF_INET : demo

user  :notice: [  386.381175] Recv   Send    Send                          =
Utilization       Service Demand

user  :notice: [  386.386009] Socket Socket  Message  Elapsed              =
Send     Recv     Send    Recv

user  :notice: [  386.390892] Size   Size    Size     Time     Throughput  =
local    remote   local   remote

user  :notice: [  386.395776] bytes  bytes   bytes    secs.    10^6bits/s  =
% S      % S      us/KB   us/KB


user  :notice: [  386.401770] 212992 212992 212992    300.17        4.10   =
5.05     5.05     404.115  404.115

user  :notice: [  386.414688] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin=
/lkp-jobfile-append-var?job_file=3D/lkp/scheduled/lkp-u410/netperf-ipv4-300=
s-200%25-cs-localhost-SCTP_STREAM-performance-debian-x86_64-2016-08-31.cgz-=
60cc43fc888428bb2f18f08997432d426a243338-20180419-37334-dtcoce-0.yaml&job_s=
tate=3Dpost_run -o /dev/null

user  :notice: [  387.495714] kill 693 vmstat --timestamp -n 10=20


--j4a75sbkumscrd46--
