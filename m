Date: Sat, 17 Feb 2018 14:26:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.4
Message-ID: <20180217132602.GA20276@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.4 kernel.

All users of the 4.15 kernel series must upgrade.

The updated 4.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.15.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/arm64/silicon-errata.txt                        |    2=20
 Documentation/devicetree/bindings/media/cec-gpio.txt          |    6=20
 Makefile                                                      |    5=20
 arch/alpha/include/asm/futex.h                                |    8=20
 arch/alpha/kernel/osf_sys.c                                   |    4=20
 arch/alpha/kernel/pci_impl.h                                  |    3=20
 arch/alpha/kernel/process.c                                   |    3=20
 arch/alpha/kernel/traps.c                                     |   13=20
 arch/arm/crypto/crc32-ce-glue.c                               |    2=20
 arch/arm/include/asm/kvm_host.h                               |    6=20
 arch/arm/include/asm/kvm_mmu.h                                |   10=20
 arch/arm/include/asm/kvm_psci.h                               |   27=20
 arch/arm/kvm/handle_exit.c                                    |   17=20
 arch/arm64/Kconfig                                            |   46=20
 arch/arm64/boot/dts/marvell/armada-7040-db.dts                |    6=20
 arch/arm64/boot/dts/marvell/armada-8040-db.dts                |    7=20
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts             |    6=20
 arch/arm64/crypto/crc32-ce-glue.c                             |    2=20
 arch/arm64/include/asm/asm-uaccess.h                          |   36=20
 arch/arm64/include/asm/assembler.h                            |   54=20
 arch/arm64/include/asm/barrier.h                              |   22=20
 arch/arm64/include/asm/cpucaps.h                              |    5=20
 arch/arm64/include/asm/cputype.h                              |    9=20
 arch/arm64/include/asm/efi.h                                  |   12=20
 arch/arm64/include/asm/fixmap.h                               |    5=20
 arch/arm64/include/asm/futex.h                                |    9=20
 arch/arm64/include/asm/kvm_asm.h                              |    2=20
 arch/arm64/include/asm/kvm_host.h                             |    5=20
 arch/arm64/include/asm/kvm_mmu.h                              |   38=20
 arch/arm64/include/asm/kvm_psci.h                             |   27=20
 arch/arm64/include/asm/mmu.h                                  |   48=20
 arch/arm64/include/asm/mmu_context.h                          |   12=20
 arch/arm64/include/asm/pgtable-hwdef.h                        |    1=20
 arch/arm64/include/asm/pgtable-prot.h                         |   35=20
 arch/arm64/include/asm/pgtable.h                              |    1=20
 arch/arm64/include/asm/proc-fns.h                             |    6=20
 arch/arm64/include/asm/processor.h                            |    3=20
 arch/arm64/include/asm/sysreg.h                               |    2=20
 arch/arm64/include/asm/tlbflush.h                             |   16=20
 arch/arm64/include/asm/uaccess.h                              |  181 +
 arch/arm64/kernel/Makefile                                    |    4=20
 arch/arm64/kernel/arm64ksyms.c                                |    4=20
 arch/arm64/kernel/asm-offsets.c                               |    6=20
 arch/arm64/kernel/bpi.S                                       |   83=20
 arch/arm64/kernel/cpu-reset.S                                 |    2=20
 arch/arm64/kernel/cpu_errata.c                                |  239 ++
 arch/arm64/kernel/cpufeature.c                                |  138 +
 arch/arm64/kernel/entry.S                                     |  228 +-
 arch/arm64/kernel/head.S                                      |    2=20
 arch/arm64/kernel/process.c                                   |   12=20
 arch/arm64/kernel/sleep.S                                     |    2=20
 arch/arm64/kernel/vmlinux.lds.S                               |   22=20
 arch/arm64/kvm/handle_exit.c                                  |   14=20
 arch/arm64/kvm/hyp/entry.S                                    |   12=20
 arch/arm64/kvm/hyp/hyp-entry.S                                |   20=20
 arch/arm64/kvm/hyp/switch.c                                   |   13=20
 arch/arm64/lib/clear_user.S                                   |   10=20
 arch/arm64/lib/copy_from_user.S                               |    4=20
 arch/arm64/lib/copy_in_user.S                                 |    9=20
 arch/arm64/lib/copy_to_user.S                                 |    4=20
 arch/arm64/mm/cache.S                                         |    4=20
 arch/arm64/mm/context.c                                       |   48=20
 arch/arm64/mm/fault.c                                         |   36=20
 arch/arm64/mm/mmu.c                                           |   35=20
 arch/arm64/mm/proc.S                                          |  224 ++
 arch/arm64/xen/hypercall.S                                    |    4=20
 arch/mn10300/mm/misalignment.c                                |    2=20
 arch/openrisc/kernel/traps.c                                  |   10=20
 arch/powerpc/crypto/crc32c-vpmsum_glue.c                      |    1=20
 arch/powerpc/kvm/Kconfig                                      |    2=20
 arch/powerpc/kvm/book3s_hv.c                                  |   16=20
 arch/powerpc/kvm/book3s_hv_rmhandlers.S                       |   40=20
 arch/s390/crypto/crc32-vx.c                                   |    3=20
 arch/sh/kernel/traps_32.c                                     |    3=20
 arch/sparc/crypto/crc32c_glue.c                               |    1=20
 arch/x86/crypto/crc32-pclmul_glue.c                           |    1=20
 arch/x86/crypto/crc32c-intel_glue.c                           |    1=20
 arch/x86/crypto/poly1305_glue.c                               |    1=20
 arch/x86/crypto/sha512-mb/sha512_mb_mgr_init_avx2.c           |   10=20
 arch/x86/kvm/vmx.c                                            |    6=20
 arch/x86/kvm/x86.h                                            |    1=20
 arch/xtensa/include/asm/futex.h                               |   23=20
 block/blk-core.c                                              |    9=20
 crypto/ahash.c                                                |   33=20
 crypto/algif_hash.c                                           |   52=20
 crypto/crc32_generic.c                                        |    1=20
 crypto/crc32c_generic.c                                       |    1=20
 crypto/cryptd.c                                               |   10=20
 crypto/mcryptd.c                                              |   10=20
 crypto/poly1305_generic.c                                     |   17=20
 crypto/shash.c                                                |   25=20
 drivers/acpi/nfit/core.c                                      |    3=20
 drivers/acpi/sbshc.c                                          |    4=20
 drivers/ata/ahci.c                                            |   37=20
 drivers/block/pktcdvd.c                                       |   12=20
 drivers/bluetooth/btsdio.c                                    |    9=20
 drivers/bluetooth/btusb.c                                     |   20=20
 drivers/char/ipmi/ipmi_dmi.c                                  |    5=20
 drivers/clocksource/timer-stm32.c                             |    7=20
 drivers/cpufreq/cpufreq-dt-platdev.c                          |    8=20
 drivers/crypto/bfin_crc.c                                     |    3=20
 drivers/crypto/caam/ctrl.c                                    |    8=20
 drivers/crypto/stm32/stm32_crc32.c                            |    2=20
 drivers/crypto/talitos.c                                      |    4=20
 drivers/dma/dmatest.c                                         |    2=20
 drivers/edac/octeon_edac-lmc.c                                |    1=20
 drivers/firmware/psci.c                                       |   57=20
 drivers/gpu/drm/i915/i915_pci.c                               |   94=20
 drivers/gpu/drm/i915/intel_dp.c                               |    6=20
 drivers/hid/hid-core.c                                        |   12=20
 drivers/media/dvb-core/dvb_frontend.c                         |    4=20
 drivers/media/dvb-frontends/ascot2e.c                         |    4=20
 drivers/media/dvb-frontends/cxd2841er.c                       |    4=20
 drivers/media/dvb-frontends/helene.c                          |    4=20
 drivers/media/dvb-frontends/horus3a.c                         |    4=20
 drivers/media/dvb-frontends/itd1000.c                         |    5=20
 drivers/media/dvb-frontends/mt312.c                           |    5=20
 drivers/media/dvb-frontends/stb0899_drv.c                     |    3=20
 drivers/media/dvb-frontends/stb6100.c                         |    6=20
 drivers/media/dvb-frontends/stv0367.c                         |    4=20
 drivers/media/dvb-frontends/stv090x.c                         |    4=20
 drivers/media/dvb-frontends/stv6110x.c                        |    4=20
 drivers/media/dvb-frontends/ts2020.c                          |    4=20
 drivers/media/dvb-frontends/zl10039.c                         |    4=20
 drivers/media/platform/vivid/vivid-core.h                     |    1=20
 drivers/media/platform/vivid/vivid-ctrls.c                    |   35=20
 drivers/media/usb/dvb-usb-v2/lmedm04.c                        |   39=20
 drivers/media/usb/dvb-usb/cxusb.c                             |    2=20
 drivers/media/usb/dvb-usb/dib0700_devices.c                   |    1=20
 drivers/media/usb/hdpvr/hdpvr-core.c                          |   26=20
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c                 | 1032 +++++=
-----
 drivers/media/v4l2-core/v4l2-ioctl.c                          |  145 -
 drivers/mtd/nand/brcmnand/brcmnand.c                          |   13=20
 drivers/mtd/nand/nand_base.c                                  |    5=20
 drivers/mtd/nand/sunxi_nand.c                                 |    8=20
 drivers/mtd/ubi/block.c                                       |   42=20
 drivers/mtd/ubi/vmt.c                                         |   15=20
 drivers/mtd/ubi/wl.c                                          |   77=20
 drivers/perf/arm_spe_pmu.c                                    |    9=20
 drivers/pinctrl/intel/pinctrl-intel.c                         |   23=20
 drivers/pinctrl/pinctrl-mcp23s08.c                            |    8=20
 drivers/pinctrl/pinctrl-sx150x.c                              |   40=20
 drivers/scsi/cxlflash/main.c                                  |    1=20
 drivers/scsi/hosts.c                                          |    6=20
 drivers/scsi/lpfc/lpfc_init.c                                 |   84=20
 drivers/scsi/scsi_error.c                                     |   18=20
 drivers/scsi/scsi_lib.c                                       |   39=20
 drivers/ssb/Kconfig                                           |    2=20
 drivers/staging/lustre/lnet/libcfs/linux/linux-crypto-adler.c |    1=20
 drivers/watchdog/Kconfig                                      |    2=20
 drivers/watchdog/gpio_wdt.c                                   |    3=20
 drivers/watchdog/imx2_wdt.c                                   |   20=20
 fs/afs/addr_list.c                                            |   13=20
 fs/afs/rotate.c                                               |   20=20
 fs/afs/server_list.c                                          |    3=20
 fs/afs/vlclient.c                                             |   10=20
 fs/afs/volume.c                                               |   47=20
 fs/btrfs/inode.c                                              |   11=20
 fs/btrfs/raid56.c                                             |   11=20
 fs/cifs/cifsencrypt.c                                         |    3=20
 fs/cifs/connect.c                                             |    6=20
 fs/cifs/file.c                                                |   26=20
 fs/cifs/misc.c                                                |   14=20
 fs/cifs/smb2pdu.c                                             |    3=20
 fs/devpts/inode.c                                             |    4=20
 fs/kernfs/file.c                                              |    2=20
 fs/nfs/direct.c                                               |    4=20
 fs/nfs/filelayout/filelayout.c                                |    4=20
 fs/nfs/io.c                                                   |    2=20
 fs/nfs/nfs4idmap.c                                            |    6=20
 fs/nfs/nfs4xdr.c                                              |   64=20
 fs/nfs/pnfs.c                                                 |    4=20
 fs/nfs/write.c                                                |    2=20
 fs/nfsd/nfs4state.c                                           |    1=20
 fs/overlayfs/inode.c                                          |   39=20
 fs/overlayfs/readdir.c                                        |   17=20
 fs/overlayfs/super.c                                          |   38=20
 fs/overlayfs/util.c                                           |    4=20
 fs/pipe.c                                                     |   15=20
 fs/proc/kcore.c                                               |   18=20
 fs/ubifs/dir.c                                                |   10=20
 include/crypto/hash.h                                         |   34=20
 include/crypto/internal/hash.h                                |    2=20
 include/crypto/poly1305.h                                     |    2=20
 include/kvm/arm_psci.h                                        |   51=20
 include/linux/arm-smccc.h                                     |  165 +
 include/linux/crypto.h                                        |    8=20
 include/linux/mtd/map.h                                       |  130 -
 include/linux/nfs4.h                                          |   12=20
 include/linux/psci.h                                          |   14=20
 include/scsi/scsi_host.h                                      |    2=20
 include/uapi/linux/psci.h                                     |    3=20
 kernel/async.c                                                |   20=20
 kernel/irq/autoprobe.c                                        |    2=20
 kernel/irq/chip.c                                             |    6=20
 kernel/irq/internals.h                                        |    2=20
 kernel/rcu/update.c                                           |    2=20
 kernel/relay.c                                                |    1=20
 kernel/sched/rt.c                                             |   24=20
 kernel/sched/sched.h                                          |    2=20
 kernel/sched/topology.c                                       |   13=20
 kernel/trace/ftrace.c                                         |    1=20
 lib/Kconfig.debug                                             |    2=20
 lib/Kconfig.kasan                                             |   11=20
 lib/ubsan.c                                                   |   50=20
 lib/ubsan.h                                                   |   14=20
 scripts/Makefile.kasan                                        |    5=20
 scripts/Makefile.lib                                          |    2=20
 sound/soc/intel/skylake/skl-nhlt.c                            |    3=20
 sound/soc/rockchip/rockchip_i2s.c                             |    6=20
 sound/soc/soc-acpi.c                                          |    8=20
 sound/soc/soc-compress.c                                      |    8=20
 tools/objtool/check.c                                         |   41=20
 tools/objtool/check.h                                         |    1=20
 virt/kvm/arm/arm.c                                            |   11=20
 virt/kvm/arm/psci.c                                           |  143 +
 216 files changed, 3789 insertions(+), 1623 deletions(-)

Amir Goldstein (5):
      ovl: force r/o mount when index dir creation fails
      ovl: fix failure to fsync lower dir
      ovl: take mnt_want_write() for work/index dir setup
      ovl: take mnt_want_write() for removing impure xattr
      ovl: hash directory inodes for fsnotify

Andrew Morton (1):
      lib/ubsan.c: s/missaligned/misaligned/

Andrew-sh Cheng (1):
      cpufreq: mediatek: add mediatek related projects into blacklist

Andrey Konovalov (1):
      kasan: don't emit builtin calls when sanitization is off

Andrey Ryabinin (1):
      lib/ubsan: add type mismatch handler for new GCC/Clang

Arnd Bergmann (4):
      mtd: cfi: convert inline functions to macros
      kasan: rework Kconfig settings
      media: dvb-frontends: fix i2c access helpers for KASAN
      alpha: osf_sys.c: fix put_tv32 regression

Arvind Yadav (1):
      media: hdpvr: Fix an error handling path in hdpvr_probe()

Aurelien Aptel (1):
      CIFS: zero sensitive data when freeing

Bart Van Assche (3):
      pktcdvd: Fix pkt_setup_dev() error path
      pktcdvd: Fix a recently introduced NULL pointer dereference
      scsi: core: Ensure that the SCSI error handler gets woken up

Bradley Bolen (1):
      ubi: block: Fix locking for idr_alloc/idr_remove

Catalin Marinas (1):
      arm64: kpti: Fix the interaction between ASID switching and software =
PAN

Charles Keepax (1):
      ASoC: compress: Correct handling of copy callback

Clay McClure (1):
      ubi: Fix race condition between ubi volume creation and udev

Daniel Lezcano (1):
      clocksource/drivers/stm32: Fix kernel panic with multiple timers

Daniel Mentz (1):
      media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic

Daniel N Pettersson (1):
      cifs: Fix autonegotiate security settings mismatch

David Howells (4):
      afs: Add missing afs_put_cell()
      afs: Need to clear responded flag in addr cursor
      afs: Fix missing cursor clearance
      afs: Fix server list handling

Dmitry Mastykin (1):
      pinctrl: mcp23s08: fix irq setup order

Eric Biggers (13):
      ubifs: free the encrypted symlink target
      NFS: reject request for id_legacy key without auxdata
      crypto: hash - introduce crypto_hash_alg_has_setkey()
      crypto: cryptd - pass through absence of ->setkey()
      crypto: mcryptd - pass through absence of ->setkey()
      crypto: poly1305 - remove ->setkey() method
      crypto: hash - annotate algorithms taking optional key
      crypto: hash - prevent using keyed hashes without setting key
      crypto: sha512-mb - initialize pending lengths correctly
      kernel/relay.c: revert "kernel/relay.c: fix potential memory leak"
      pipe: actually allow root to exceed the pipe buffer limits
      pipe: fix off-by-one error when checking buffer limits
      devpts: fix error handling in devpts_mntget()

Eric W. Biederman (3):
      signal/openrisc: Fix do_unaligned_access to send the proper signal
      signal/sh: Ensure si_signo is initialized in do_divide_error
      mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user=
 copy

Greg Kroah-Hartman (2):
      ACPI: sbshc: remove raw pointer from printk() message
      Linux 4.15.4

Hans Verkuil (14):
      media: v4l2-ioctl.c: use check_fmt for enum/g/s/try_fmt
      media: v4l2-ioctl.c: don't copy back the result for -ENOTTY
      media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
      media: v4l2-compat-ioctl32.c: fix the indentation
      media: v4l2-compat-ioctl32.c: move 'helper' functions to __get/put_v4=
l2_format32
      media: v4l2-compat-ioctl32.c: avoid sizeof(type)
      media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
      media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer
      media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32
      media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
      media: v4l2-compat-ioctl32.c: don't copy back the result for certain =
errors
      media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
      media: dt-bindings/media/cec-gpio.txt: mention the CEC/HPD max voltag=
es
      media: vivid: fix module load error when enabling fb and no_error_inj=
=3D1

Hans de Goede (5):
      ahci: Annotate PCI ids for mobile Intel chipsets as such
      ahci: Add PCI ids for Intel Bay Trail, Cherry Trail and Apollo Lake A=
HCI
      HID: quirks: Fix keyboard + touchpad on Toshiba Click Mini not working
      Bluetooth: btsdio: Do not bind to non-removable BCM43341
      Bluetooth: btusb: Restore QCA Rome suspend/resume fix with a "rewritt=
en" version

Heiko Carstens (1):
      fs/proc/kcore.c: use probe_kernel_read() instead of memcpy()

Horia Geant=C4=83 (1):
      crypto: caam - fix endless loop when DECO acquire fails

Imre Deak (1):
      drm/i915: Avoid PPS HW/SW state mismatch due to rounding

Ivan Vecera (1):
      kernfs: fix regression in kernfs_fop_write caused by wrong type

J. Bruce Fields (1):
      NFS: commit direct writes even if they fail partially

James Hogan (1):
      EDAC, octeon: Fix an uninitialized variable warning

James Morse (2):
      arm64: cpufeature: __this_cpu_has_cap() shouldn't stop early
      KVM: arm/arm64: Handle CPU_PM_ENTER_FAILED

James Smart (1):
      scsi: lpfc: Fix crash after bad bar setup on driver attachment

Jayachandran C (3):
      arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs
      arm64: Turn on KPTI only on CPUs that need it
      arm64: Branch predictor hardening for Cavium ThunderX2

John Garry (1):
      ipmi: use dynamic memory for DMI driver override

John Keeping (1):
      ASoC: rockchip: i2s: fix playback after runtime resume

Kai-Heng Feng (1):
      Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"

Kamal Dasu (1):
      mtd: nand: brcmnand: Disable prefetch by default

LEROY Christophe (1):
      crypto: talitos - fix Kernel Oops on hashing an empty file

Lionel Landwerlin (1):
      Revert "drm/i915: mark all device info struct with __initconst"

Liran Alon (2):
      KVM: nVMX: Fix races when sending nested PI while dest enters/leaves =
L2
      KVM: nVMX: Fix bug of injecting L2 exception into L1

Liu Bo (1):
      Btrfs: raid56: iterate raid56 internal bio with bio_for_each_segment_=
all

Malcolm Priestley (2):
      media: dvb-usb-v2: lmedm04: Improve logic checking of warm start
      media: dvb-usb-v2: lmedm04: move ts2020 attach to dm04_lme2510_tuner

Marc Zyngier (21):
      arm64: Force KPTI to be disabled on Cavium ThunderX
      arm64: Move post_ttbr_update_workaround to C code
      arm64: Move BP hardening to check_and_switch_context
      arm64: KVM: Use per-CPU vector when BP hardening is enabled
      arm64: KVM: Increment PC after handling an SMC trap
      arm/arm64: KVM: Consolidate the PSCI include files
      arm/arm64: KVM: Add PSCI_VERSION helper
      arm/arm64: KVM: Add smccc accessors to PSCI code
      arm/arm64: KVM: Implement PSCI 1.0 support
      arm/arm64: KVM: Advertise SMCCC v1.1
      arm64: KVM: Make PSCI_VERSION a fast path
      arm/arm64: KVM: Turn kvm_psci_version into a static inline
      arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support
      arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
      firmware/psci: Expose PSCI conduit
      firmware/psci: Expose SMCCC version through psci_ops
      arm/arm64: smccc: Make function identifiers an unsigned quantity
      arm/arm64: smccc: Implement SMCCC v1.1 inline primitive
      arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support
      arm64: Kill PSCI_GET_VERSION as a variant-2 workaround
      arm: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls

Martin Kaiser (1):
      watchdog: imx2_wdt: restore previous timeout after suspend+resume

Matt Redfearn (1):
      watchdog: indydog: Add dependency on SGI_HAS_INDYDOG

Matthew Wilcox (1):
      cifs: Fix missing put_xid in cifs_file_strict_mmap

Mauro Carvalho Chehab (3):
      media: dvb_frontend: be sure to init dvb_frontend_handle_ioctl() retu=
rn code
      media: ts2020: avoid integer overflows on 32 bit machines
      media: cxusb, dib0700: ignore XC2028_I2C_FLUSH

Max Filippov (1):
      xtensa: fix futex_atomic_cmpxchg_inatomic

Michael Cree (1):
      alpha: Fix mixed up args in EXC macro in futex operations

Mika Westerberg (2):
      ahci: Add Intel Cannon Lake PCH-H PCI ID
      pinctrl: intel: Initialize GPIO properly when used through irqchip

Mikulas Patocka (3):
      alpha: fix crash if pthread_create races with signal delivery
      alpha: fix reboot on Avanti platform
      alpha: fix formating of stack content

Ming Lei (1):
      blk-mq: quiesce queue before freeing queue

Miquel Raynal (2):
      mtd: nand: Fix nand_do_read_oob() return value
      mtd: nand: sunxi: Fix ECC strength choice

Nikolay Borisov (1):
      btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker

Paul E. McKenney (1):
      rcu: Export init_rcu_head() and destroy_rcu_head() to GPL modules

Paul Mackerras (2):
      KVM: PPC: Book3S HV: Make sure we don't re-enter guest without XIVE l=
oaded
      KVM: PPC: Book3S HV: Drop locks before reading guest memory

Peter Rosin (3):
      pinctrl: sx150x: Unregister the pinctrl on release
      pinctrl: sx150x: Register pinctrl before adding the gpiochip
      pinctrl: sx150x: Add a static gpio/pinctrl pin range mapping

Peter Zijlstra (1):
      objtool: Fix switch-table detection

Pierre-Louis Bossart (1):
      ASoC: acpi: fix machine driver selection based on quirk

Rasmus Villemoes (2):
      watchdog: gpio_wdt: set WDOG_HW_RUNNING in gpio_wdt_stop
      kernel/async.c: revert "async: simplify lowest_in_progress()"

Robin Murphy (3):
      arm64: Implement array_index_mask_nospec()
      arm64: Make USER_DS an inclusive limit
      arm64: Use pointer masking to limit uaccess speculation

Sascha Hauer (1):
      ubi: fastmap: Erase outdated anchor PEBs during attach

Scott Mayhew (1):
      nfs/pnfs: fix nfs_direct_req ref leak when i/o falls back to the mds

Shanker Donthineni (1):
      arm64: Implement branch predictor hardening for Falkor

Stephen Boyd (1):
      arm64: cpu_errata: Add Kryo to Falkor 1003 errata

Steven Rostedt (VMware) (3):
      sched/rt: Use container_of() to get root domain in rto_push_irq_work_=
func()
      sched/rt: Up the root domain ref count when passing it around via IPIs
      ftrace: Remove incorrect setting of glob search field

Suzuki K Poulose (2):
      arm64: capabilities: Handle duplicate entries for a capability
      arm64: Run enable method for errata work arounds on late CPUs

Sven Joachim (1):
      ssb: Do not disable PCI host on non-Mips

Takashi Iwai (1):
      ASoC: skl: Fix kernel warning due to zero NHTL entry

Thomas Gleixner (1):
      genirq: Make legacy autoprobing work again

Tigran Mkrtchyan (1):
      nfs41: do not return ENOMEM on LAYOUTUNAVAILABLE

Toshi Kani (1):
      acpi, nfit: fix register dimm error handling

Trond Myklebust (4):
      NFS: Add a cond_resched() to nfs_commit_release_pages()
      NFS: Fix nfsstat breakage due to LOOKUPP
      NFS: Fix a race between mmap() and O_DIRECT
      nfsd: Detect unhashed stids in nfsd4_verify_open_stid()

Ulf Magnusson (1):
      KVM: PPC: Book3S PR: Fix broken select due to misspelling

Uma Krishnan (1):
      scsi: cxlflash: Reset command ioasc

Will Deacon (41):
      arm64: mm: Use non-global mappings for kernel space
      arm64: mm: Temporarily disable ARM64_SW_TTBR0_PAN
      arm64: mm: Move ASID from TTBR0 to TTBR1
      arm64: mm: Remove pre_ttbr0_update_workaround for Falkor erratum #E10=
03
      arm64: mm: Rename post_ttbr0_update_workaround
      arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN
      arm64: mm: Allocate ASIDs in pairs
      arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
      arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
      arm64: entry: Add exception trampoline page for exceptions from EL0
      arm64: mm: Map entry trampoline into trampoline and kernel page tables
      arm64: entry: Explicitly pass exception level to kernel_ventry macro
      arm64: entry: Hook up entry trampoline to exception vectors
      arm64: erratum: Work around Falkor erratum #E1003 in trampoline code
      arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tas=
ks
      arm64: entry: Add fake CPU feature for unmapping the kernel at EL0
      arm64: kaslr: Put kernel vectors address in separate data page
      arm64: use RET instruction for exiting the trampoline
      arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
      arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
      arm64: Take into account ID_AA64PFR0_EL1.CSV3
      arm64: mm: Introduce TTBR_ASID_MASK for getting at the ASID in the TT=
BR
      arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0=
()
      arm64: mm: Permit transitioning from Global to Non-Global without BBM
      arm64: kpti: Add ->enable callback to remap swapper using nG mappings
      arm64: entry: Reword comment about post_ttbr_update_workaround
      arm64: idmap: Use "awx" flags for .idmap.text .pushsection directives
      perf: arm_spe: Fail device probe when arm64_kernel_unmapped_at_el0()
      arm64: barrier: Add CSDB macros to control data-value prediction
      arm64: entry: Ensure branch through syscall table is bounded under sp=
eculation
      arm64: uaccess: Prevent speculative use of the current addr_limit
      arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}=
_user
      arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user
      arm64: futex: Mask __user pointers prior to dereference
      arm64: cpufeature: Pass capability structure to ->enable callback
      drivers/firmware: Expose psci_get_version through psci_ops structure
      arm64: Add skeleton to harden the branch predictor against aliasing a=
ttacks
      arm64: entry: Apply BP hardening for high-priority synchronous except=
ions
      arm64: entry: Apply BP hardening for suspicious interrupts from EL0
      arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75
      arm64: Implement branch predictor hardening for affected Cortex-A CPUs

Yan Markman (1):
      arm64: dts: marvell: add Ethernet aliases

Yang Shunyong (1):
      dmaengine: dmatest: fix container_of member in dmatest_callback


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqILWoACgkQONu9yGCS
aT7a8g//c0reFFdvHspl8CHaJInUoWgbEX656d2303qLFaITT9cTZaCuyt4K8QKI
Wv8F0GUdrnZYKfXCa89yBBBXVcae4jxjVbQaxuLYDQnXAOmCLyrUpFEzD+Ao2VPz
E+aD3Az78BFlbTHIwDA3c1cMKeHMNejZsSGhnV1Fs0Pehj2dYdvB7SY6hdgZUOIq
eMqAj7ERoxyxAtu0d0/sXaEmZVjUPggOf3s/tFEx9TshLSXSsOMq2EkYAeoc/lbT
+9bKrbZ5SmqWw55U4GhwoCk6mkvAQCczlmTyDhEA7WydmgJdsPa19wUGvjsJ+FXE
gL5hZ8lb0zApreWgtSvFavLDG+4oznyffr6i+z1t6ddLd+rw9U6SZtQZJzWc4oV+
N6Vjo+hUKnE10GVEwE2Go15iAYdJ6MTE0kL1SdTnCZ97zbF8YHQAqK3ShCcJbHUD
LOmgxC5d41eO9H/7vb8n5Y0bFUgJfP4Gfry2VzSvmfIqTIsw0en9eMWU28PhBpPD
JUjkNqFM4Er/GHOqCePvYPYy2/x4C4xVJyVHAhV/MhsDIztGsjGwh3ZAnb+BQOZ1
XwsfhF39UR7ZUh8U12pV9obz3Ca4JhVoHATc3kLeNYJ/06r4fnsixqSKJ8BqYCkU
LKte7sLLEmX2LzkVqqAYLkVEv6Fx/jq9YZFwUDf9EpOxlKlgV0M=
=IcFJ
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
