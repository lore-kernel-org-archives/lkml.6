Date: Thu, 29 Mar 2018 09:26:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.31
Message-ID: <20180329072603.GA2748@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.31 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-iio                |    2=20
 Makefile                                               |   11 +
 arch/arm64/mm/mmu.c                                    |   10 +
 arch/h8300/include/asm/byteorder.h                     |    1=20
 arch/mips/lantiq/Kconfig                               |    2=20
 arch/mips/lantiq/xway/sysctrl.c                        |    6 -
 arch/mips/ralink/mt7621.c                              |   42 +++----
 arch/mips/ralink/reset.c                               |    7 -
 arch/x86/Makefile                                      |    9 +
 arch/x86/boot/compressed/misc.c                        |    4=20
 arch/x86/entry/entry_64.S                              |    2=20
 arch/x86/entry/vsyscall/vsyscall_64.c                  |    2=20
 arch/x86/events/intel/core.c                           |    2=20
 arch/x86/events/intel/uncore_snbep.c                   |   33 +++--
 arch/x86/include/asm/vmx.h                             |    1=20
 arch/x86/kernel/idt.c                                  |    2=20
 arch/x86/kernel/traps.c                                |   15 +-
 arch/x86/kvm/vmx.c                                     |    9 +
 arch/x86/mm/pgtable.c                                  |   48 ++++++++
 arch/x86/net/bpf_jit_comp.c                            |    3=20
 arch/x86/platform/efi/efi_64.c                         |    2=20
 drivers/acpi/acpi_watchdog.c                           |    4=20
 drivers/acpi/numa.c                                    |   10 +
 drivers/ata/ahci.c                                     |    4=20
 drivers/ata/libata-core.c                              |   26 +++-
 drivers/ata/libata-scsi.c                              |   10 +
 drivers/bluetooth/btusb.c                              |    8 -
 drivers/clk/bcm/clk-bcm2835.c                          |   12 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c                   |    6 -
 drivers/gpu/drm/drm_framebuffer.c                      |    7 +
 drivers/gpu/drm/drm_syncobj.c                          |   81 +++++--------
 drivers/gpu/drm/radeon/radeon_connectors.c             |   31 ++---
 drivers/gpu/drm/udl/udl_fb.c                           |    9 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                    |   13 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                    |    1=20
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                    |   39 +++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                    |   13 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c                   |    5=20
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                   |    5=20
 drivers/hv/ring_buffer.c                               |   52 +++++---
 drivers/iio/accel/st_accel_core.c                      |    2=20
 drivers/iio/adc/meson_saradc.c                         |    4=20
 drivers/iio/chemical/ccs811.c                          |    3=20
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c           |    2=20
 drivers/iio/pressure/st_pressure_core.c                |    2=20
 drivers/infiniband/hw/mlx5/mr.c                        |   12 +-
 drivers/mmc/core/block.c                               |   19 +++
 drivers/mmc/core/card.h                                |    1=20
 drivers/mmc/core/quirks.h                              |    6 +
 drivers/mmc/host/dw_mmc-exynos.c                       |    8 +
 drivers/mmc/host/dw_mmc.c                              |   15 +-
 drivers/mtd/mtdchar.c                                  |    4=20
 drivers/mtd/nand/fsl_ifc_nand.c                        |   32 ++---
 drivers/net/can/cc770/cc770.c                          |  100 ++++++++++--=
-----
 drivers/net/can/cc770/cc770.h                          |    2=20
 drivers/net/can/ifi_canfd/ifi_canfd.c                  |   75 +++++++-----
 drivers/net/can/peak_canfd/peak_canfd.c                |   25 +---
 drivers/net/can/peak_canfd/peak_pciefd_main.c          |    8 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |   24 +---
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |    3=20
 drivers/nvdimm/blk.c                                   |    3=20
 drivers/nvdimm/btt.c                                   |    3=20
 drivers/pci/quirks.c                                   |    2=20
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c           |   56 ++++++++-
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c         |   14 ++
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c              |   28 ++++
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c              |    7 +
 drivers/pinctrl/samsung/pinctrl-samsung.c              |   61 ++++++----
 drivers/pinctrl/samsung/pinctrl-samsung.h              |   40 ++++--
 drivers/staging/android/ion/ion_cma_heap.c             |   17 ++
 drivers/staging/lustre/lustre/ptlrpc/sec.c             |    2=20
 drivers/tty/vt/vt.c                                    |    8 -
 drivers/usb/host/xhci-hub.c                            |    5=20
 drivers/usb/host/xhci.c                                |   34 +----
 drivers/usb/host/xhci.h                                |    3=20
 drivers/watchdog/wdat_wdt.c                            |    2=20
 fs/hugetlbfs/inode.c                                   |   17 ++
 fs/ncpfs/ncplib_kernel.c                               |    4=20
 fs/nfsd/nfs4state.c                                    |   62 +++++++---
 include/asm-generic/pgtable.h                          |   10 +
 include/drm/drm_syncobj.h                              |    5=20
 include/linux/fsl_ifc.h                                |    6 -
 include/linux/memblock.h                               |    1=20
 include/trace/events/mmc.h                             |    4=20
 include/uapi/linux/usb/audio.h                         |    4=20
 kernel/bpf/syscall.c                                   |    2=20
 kernel/cgroup/cgroup.c                                 |   10 +
 kernel/events/core.c                                   |    4=20
 kernel/time/posix-timers.c                             |   11 +
 kernel/trace/trace_kprobe.c                            |    4=20
 kernel/trace/trace_probe.c                             |    8 -
 kernel/trace/trace_probe.h                             |    2=20
 lib/ioremap.c                                          |    6 -
 mm/huge_memory.c                                       |    4=20
 mm/hugetlb.c                                           |    7 +
 mm/khugepaged.c                                        |    7 +
 mm/memblock.c                                          |   28 ----
 mm/page_alloc.c                                        |   13 --
 mm/shmem.c                                             |   31 +++--
 mm/vmscan.c                                            |   31 ++---
 sound/drivers/aloop.c                                  |   17 ++
 sound/pci/hda/hda_intel.c                              |    5=20
 sound/pci/hda/patch_realtek.c                          |   20 +++
 tools/perf/builtin-stat.c                              |    2=20
 tools/testing/selftests/x86/protection_keys.c          |   10 -
 tools/testing/selftests/x86/ptrace_syscall.c           |    8 +
 106 files changed, 978 insertions(+), 546 deletions(-)

Adrian Hunter (1):
      mmc: core: Fix tracepoint print of blk_addr and blksz

Andrey Ryabinin (1):
      mm/vmscan: wake up flushers for legacy cgroups too

Andri Yngvason (3):
      can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack
      can: cc770: Fix queue stall & dropped RTR reply
      can: cc770: Fix use after free in cc770_tx_interrupt()

Andy Lutomirski (2):
      x86/entry/64: Don't use IST entry for #BP stack
      selftests/x86/ptrace_syscall: Fix for yet more glibc interference

Arend Van Spriel (1):
      brcmfmac: fix P2P_DEVICE ethernet address generation

Arnd Bergmann (1):
      h8300: remove extraneous __BIG_ENDIAN definition

Bastian Stender (1):
      mmc: block: fix updating ext_csd caches on ioctl call

Boris Brezillon (2):
      clk: bcm2835: Fix ana->maskX definitions
      clk: bcm2835: Protect sections updating shared registers

Boris Ostrovsky (1):
      x86/vsyscall/64: Use proper accessor to update P4D entry

Chen-Yu Tsai (1):
      clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops

Chenbo Feng (1):
      bpf: skip unnecessary capability check

Chris Wilson (1):
      drm/syncobj: Stop reusing the same struct file for all syncobj -> fd

Dan Carpenter (3):
      iio: adc: meson-saradc: unlock on error in meson_sar_adc_lock()
      staging: ncpfs: memory corruption in ncp_read_kernel()
      perf/x86/intel: Don't accidentally clear high bits in bdw_limit_perio=
d()

Dan Williams (1):
      acpi, numa: fix pxm to online numa node associations

Daniel Borkmann (2):
      kbuild: disable clang's default use of -fmerge-all-constants
      bpf, x64: increase number of passes

Daniel Stone (1):
      drm: Reject getfb for multi-plane framebuffers

Daniel Vacek (1):
      Revert "mm: page_alloc: skip over regions of invalid pfns where possi=
ble"

Dave Hansen (1):
      x86/pkeys/selftests: Rename 'si_pkey' to 'siginfo_pkey'

Dirk Behme (1):
      mmc: core: Disable HPI for certain Micron (Numonyx) eMMC cards

Eric Biggers (3):
      libata: fix length validation of ATAPI-relayed SCSI commands
      libata: remove WARN() for DMA or PIO command without data
      libata: don't try to pass through NCQ commands to non-NCQ devices

Evgeniy Didin (2):
      mmc: dw_mmc: Fix the DTO/CTO timeout overflow calculation for 32-bit =
systems
      mmc: dw_mmc: fix falling from idmac to PIO mode when dw_mci_reset occ=
urs

Greg Kroah-Hartman (2):
      drm: udl: Properly check framebuffer mmap offsets
      Linux 4.14.31

H.J. Lu (2):
      x86/build/64: Force the linker to use 2MB page size
      x86/boot/64: Verify alignment of the LOAD segment

Hans de Goede (7):
      PCI: Add function 1 DMA alias quirk for Highpoint RocketRAID 644L
      ahci: Add PCI-id for the Highpoint Rocketraid 644L card
      Bluetooth: btusb: Remove Yoga 920 from the btusb_needs_reset_resume_t=
able
      libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
      libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
      libata: Make Crucial BX100 500GB LPM quirk apply to all firmware vers=
ions
      libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 versi=
on

Ilya Pronin (1):
      perf stat: Fix CVS output format for non-supported counters

Jaehoon Chung (1):
      mmc: dw_mmc: exynos: fix the suspend/resume issue for exynos5433

Jagdish Gediya (3):
      mtd: nand: fsl_ifc: Fix nand waitfunc return value
      mtd: nand: fsl_ifc: Fix eccstat array overflow for IFC ver >=3D 2.0.0
      mtd: nand: fsl_ifc: Read ECCSTAT0 and ECCSTAT1 registers for IFC 2.0

Jeff Layton (1):
      nfsd: remove blocked locks on client teardown

Ju Hyung Park (1):
      libata: Enable queued TRIM for Samsung SSD 860

Kai-Heng Feng (2):
      Bluetooth: btusb: Add Dell OptiPlex 3060 to btusb_needs_reset_resume_=
table
      libata: disable LPM for Crucial BX100 SSD 500GB drive

Kailang Yang (2):
      ALSA: hda/realtek - Fix speaker no sound after system resume
      ALSA: hda/realtek - Fix Dell headset Mic can't record

Kan Liang (2):
      perf/x86/intel/uncore: Fix Skylake UPI event format
      perf/x86/intel/uncore: Fix multi-domain PCI CHA enumeration bug on Sk=
ylake servers

Kirill A. Shutemov (3):
      mm/khugepaged.c: convert VM_BUG_ON() to collapse fail
      mm/thp: do not wait for lock_page() in deferred_split_scan()
      mm/shmem: do not wait for lock_page() in shmem_unused_huge_shrink()

Kirill Marinushkin (1):
      ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit

Krzysztof Kozlowski (1):
      pinctrl: samsung: Validate alias coming from DT

Larry Finger (1):
      rtlwifi: rtl8723be: Fix loss of signal

Leon Romanovsky (1):
      RDMA/mlx5: Fix crash while accessing garbage pointer and freed memory

Liam Mark (1):
      staging: android: ion: Zero CMA allocated memory

Linus Torvalds (2):
      tty: vt: fix up tabstops properly
      kvm/x86: fix icebp instruction handling

Linus Walleij (1):
      iio: ABI: Fix name of timestamp sysfs file

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: fix endianness in st_lsm6dsx_read_oneshot()

Lu Baolu (2):
      usb: xhci: Disable slot even when virt-dev is null
      usb: xhci: Fix potential memory leak in xhci_disable_slot()

Marek Vasut (2):
      can: ifi: Repair the error handling
      can: ifi: Check core revision upon probe

Masami Hiramatsu (1):
      tracing: probeevent: Fix to support minus offset from symbol

Mathias Kresin (3):
      MIPS: lantiq: Fix Danube USB clock
      MIPS: lantiq: Enable AHB Bus for USB
      MIPS: lantiq: ase: Enable MFD_SYSCON

Michael Kelley (1):
      Drivers: hv: vmbus: Fix ring buffer signaling

Michael Nosthoff (1):
      iio: st_pressure: st_accel: pass correct platform data to init

Michel D=E4nzer (1):
      drm/radeon: Don't turn off DP sink when disconnected

Mike Kravetz (1):
      hugetlbfs: check for pgoff value overflow

Nadav Amit (1):
      staging: lustre: ptlrpc: kfree used instead of kvfree

NeilBrown (2):
      MIPS: ralink: Remove ralink_halt()
      MIPS: ralink: Fix booting on MT7621

OuYang ZhiZhong (1):
      mtdchar: fix usage of mtd_ooblayout_ecc()

Richard Lai (1):
      iio: chemical: ccs811: Corrected firmware boot/application mode trans=
ition

Song Liu (1):
      perf/core: Fix ctx_event_type in ctx_resched()

Stephane Grosjean (2):
      can: peak/pcie_fd: fix echo_skb is occupied! bug
      can: peak/pcie_fd: remove useless code when interface starts

Takashi Iwai (6):
      ALSA: aloop: Sync stale timer before release
      ALSA: aloop: Fix access to not-yet-ready substream via cable
      ALSA: hda - Force polling mode on CFL for fixing codec communication
      ALSA: hda/realtek - Always immediately update mute LED with pin VREF
      Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174
      ACPI / watchdog: Fix off-by-one error at resource assignment

Tejun Heo (1):
      cgroup: fix rule checking for threaded mode switching

Tetsuo Handa (1):
      lockdep: fix fs_reclaim warning

Thomas Gleixner (1):
      posix-timers: Protect posix clock array access against speculation

Thomas Hellstrom (2):
      drm/vmwgfx: Fix black screen and device errors when running without f=
bdev
      drm/vmwgfx: Fix a destoy-while-held mutex problem.

Toshi Kani (2):
      mm/vmalloc: add interfaces to free unmapped page table
      x86/mm: implement free pmd/pte page interfaces

Vishal Verma (1):
      libnvdimm, {btt, blk}: do integrity setup before add_disk()

Waiman Long (1):
      x86/efi: Free efi_pgd with free_pages()


--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlq8lQoACgkQONu9yGCS
aT4HmQ//bCc6Qeg+AwG2jYdPb77UkskmF8vX4izQv015HmVh3ym3837kIEdB8/YQ
S142n3j6ZOuq4rxLYr6GfD9TNaLH0aABxUeJn3f+AOuBHJmBh3Rq33m3BgKrI8I5
9sk42iAfknd+/QJNrjlkaKcL5sBD/MGLXsQJMd3WYK9ZVunen+GBMIclDWe5xDnd
vb3PA4FHCvfhhXMeNccLFBpoYpiU8DZ0PeDragAY7NlJ37sWXcFpQ4MzSra+Jfdx
6eUER1+LGbAaam9nOBd0OlZHxJP8D7e8XL1uKMMwUBfkwHN/FAUTz4RgdMboVNAV
XV/wyo9QTh0X2inAwtOMjbvsyJTurb7y0vdA6CyqkKTBrEkxdabnTzp0oRx45IQ3
GLZialTkyupK5x6UEtejyb9q11bk24mMnfUxwyfRr2UzhZ36SgBmB5FXFG4xO0OV
k45wK+8xNy14ufTg0glMueW5+9Gox7/j4od8sHxbu1r6P4KE9AhDyetleRD7ON2R
fP8I7O77gPSsLRKf4L0NJF+JOiilE7LAeUFqOfturD4bj6mbty2QTZvc0Yp0kBZF
D95I0eoktgOB9E/LqvpPGZJJpuUeGvUHHOc/X1iRdj+17lXFwhK/9QMF95lvdvGy
PmgT87VyOxnhOykHv9QygxkDAfPLaXqnzBWlhw6QkurJo9PkXRw=
=BgSU
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
