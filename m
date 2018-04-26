Date: Thu, 26 Apr 2018 14:58:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.37
Message-ID: <20180426125824.GA15013@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.37 kernel.

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

 Documentation/device-mapper/thin-provisioning.txt                |    8=20
 Documentation/virtual/kvm/api.txt                                |    1=20
 Makefile                                                         |    2=20
 arch/arm64/include/asm/spinlock.h                                |    4=20
 arch/mips/boot/compressed/Makefile                               |    6=20
 arch/mips/generic/irq.c                                          |   18=20
 arch/mips/txx9/rbtx4939/setup.c                                  |    4=20
 arch/powerpc/include/asm/book3s/64/pgalloc.h                     |   10=20
 arch/powerpc/include/uapi/asm/kvm.h                              |    2=20
 arch/powerpc/kernel/traps.c                                      |    2=20
 arch/powerpc/kvm/book3s_64_mmu_hv.c                              |    8=20
 arch/powerpc/kvm/book3s_hv.c                                     |    8=20
 arch/powerpc/kvm/powerpc.c                                       |    2=20
 arch/powerpc/mm/numa.c                                           |   78=20
 arch/powerpc/platforms/powernv/opal-imc.c                        |    6=20
 arch/s390/include/asm/eadm.h                                     |    2=20
 arch/s390/kvm/kvm-s390.c                                         |    4=20
 arch/s390/kvm/vsie.c                                             |   50=20
 arch/sparc/include/asm/pgtable_64.h                              |    2=20
 arch/sparc/mm/tlb.c                                              |   23=20
 arch/x86/hyperv/hv_init.c                                        |    9=20
 arch/x86/hyperv/mmu.c                                            |   12=20
 arch/x86/include/asm/i8259.h                                     |    5=20
 arch/x86/kernel/acpi/boot.c                                      |    4=20
 arch/x86/kernel/apic/x2apic_uv_x.c                               |   15=20
 arch/x86/kernel/dumpstack.c                                      |    2=20
 arch/x86/kernel/tsc.c                                            |   20=20
 arch/x86/kvm/mmu.c                                               |    2=20
 arch/x86/kvm/vmx.c                                               |   16=20
 arch/x86/kvm/x86.c                                               |   10=20
 arch/x86/mm/init_64.c                                            |    3=20
 arch/x86/power/hibernate_32.c                                    |    2=20
 arch/x86/power/hibernate_64.c                                    |    2=20
 block/bio.c                                                      |    2=20
 block/blk-core.c                                                 |    2=20
 block/blk-merge.c                                                |   29=20
 block/blk-mq-debugfs.c                                           |    6=20
 block/blk-mq.c                                                   |   22=20
 drivers/acpi/acpi_lpss.c                                         |    2=20
 drivers/acpi/bus.c                                               |    6=20
 drivers/acpi/ec.c                                                |    6=20
 drivers/acpi/processor_perflib.c                                 |    2=20
 drivers/acpi/scan.c                                              |   20=20
 drivers/base/power/domain.c                                      |   76=20
 drivers/base/power/wakeirq.c                                     |    6=20
 drivers/char/ipmi/ipmi_powernv.c                                 |    5=20
 drivers/clocksource/timer-imx-tpm.c                              |    2=20
 drivers/cpufreq/intel_pstate.c                                   |    5=20
 drivers/crypto/Kconfig                                           |    1=20
 drivers/firewire/ohci.c                                          |    8=20
 drivers/firmware/dmi_scan.c                                      |   22=20
 drivers/gpu/drm/drm_dp_dual_mode_helper.c                        |   39=20
 drivers/gpu/drm/i915/gvt/kvmgt.c                                 |    2=20
 drivers/gpu/drm/i915/i915_drv.h                                  |    6=20
 drivers/gpu/drm/i915/i915_gem_execbuffer.c                       |    2=20
 drivers/gpu/drm/i915/intel_audio.c                               |    2=20
 drivers/gpu/drm/i915/intel_cdclk.c                               |   22=20
 drivers/gpu/drm/i915/intel_pm.c                                  |    6=20
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/gf100.fuc3.h         |  746 ++=
+----
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/gk208.fuc5.h         |  802 ++=
+----
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/gt215.fuc3.h         | 1006 ++=
+++-----
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/memx.fuc             |   30=20
 drivers/gpu/drm/vc4/vc4_bo.c                                     |    2=20
 drivers/gpu/drm/vc4/vc4_validate_shaders.c                       |    1=20
 drivers/hid/hid-roccat-kovaplus.c                                |    2=20
 drivers/infiniband/core/cma.c                                    |    8=20
 drivers/infiniband/core/cq.c                                     |   30=20
 drivers/infiniband/core/uverbs_ioctl.c                           |   19=20
 drivers/infiniband/hw/hfi1/chip.c                                |   18=20
 drivers/infiniband/hw/hfi1/file_ops.c                            |    4=20
 drivers/infiniband/hw/hfi1/hfi.h                                 |    1=20
 drivers/infiniband/hw/hfi1/init.c                                |    4=20
 drivers/infiniband/hw/i40iw/i40iw_puda.c                         |    3=20
 drivers/infiniband/hw/i40iw/i40iw_puda.h                         |    1=20
 drivers/infiniband/hw/i40iw/i40iw_verbs.c                        |    2=20
 drivers/infiniband/hw/mlx5/qp.c                                  |    8=20
 drivers/infiniband/ulp/ipoib/ipoib_main.c                        |    3=20
 drivers/input/mouse/psmouse-base.c                               |   34=20
 drivers/input/mouse/synaptics.c                                  |   10=20
 drivers/input/touchscreen/stmfts.c                               |   11=20
 drivers/iommu/exynos-iommu.c                                     |    7=20
 drivers/iommu/intel-iommu.c                                      |    3=20
 drivers/irqchip/irq-gic-v3-its-pci-msi.c                         |    2=20
 drivers/irqchip/irq-gic-v3-its-platform-msi.c                    |    2=20
 drivers/irqchip/irq-gic-v3-its.c                                 |    2=20
 drivers/irqchip/irq-gic-v3.c                                     |    2=20
 drivers/md/bcache/alloc.c                                        |    4=20
 drivers/md/bcache/bcache.h                                       |    2=20
 drivers/md/bcache/btree.c                                        |    9=20
 drivers/md/bcache/super.c                                        |   23=20
 drivers/md/bcache/sysfs.c                                        |   11=20
 drivers/md/bcache/writeback.c                                    |    7=20
 drivers/md/dm-mpath.c                                            |   14=20
 drivers/net/ethernet/freescale/gianfar.c                         |    9=20
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c                  |   14=20
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                   |   18=20
 drivers/net/ethernet/intel/i40e/i40e_main.c                      |    3=20
 drivers/net/ethernet/intel/i40evf/i40evf.h                       |    1=20
 drivers/net/ethernet/intel/i40evf/i40evf_main.c                  |    9=20
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c              |   35=20
 drivers/net/ethernet/intel/igb/igb_main.c                        |   42=20
 drivers/net/ethernet/intel/igb/igb_ptp.c                         |    9=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                    |    8=20
 drivers/net/ethernet/netronome/nfp/nfp_main.c                    |    1=20
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c              |    6=20
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                |    6=20
 drivers/net/wireless/mac80211_hwsim.c                            |   11=20
 drivers/net/xen-netfront.c                                       |   46=20
 drivers/ntb/ntb_transport.c                                      |    3=20
 drivers/pci/quirks.c                                             |    2=20
 drivers/platform/x86/dell-laptop.c                               |   24=20
 drivers/platform/x86/thinkpad_acpi.c                             |   10=20
 drivers/scsi/arm/fas216.c                                        |    2=20
 drivers/scsi/qla2xxx/qla_init.c                                  |    4=20
 drivers/scsi/scsi_devinfo.c                                      |    7=20
 drivers/spi/spi-armada-3700.c                                    |    5=20
 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c           |    2=20
 drivers/tty/serial/8250/8250_exar.c                              |   34=20
 drivers/tty/serial/8250/8250_port.c                              |   26=20
 drivers/usb/musb/musb_core.c                                     |    7=20
 drivers/watchdog/sp5100_tco.h                                    |    2=20
 drivers/xen/grant-table.c                                        |    4=20
 fs/btrfs/ctree.c                                                 |   12=20
 fs/btrfs/disk-io.c                                               |    6=20
 fs/btrfs/file.c                                                  |    9=20
 fs/btrfs/inode.c                                                 |   37=20
 fs/btrfs/raid56.c                                                |   55=20
 fs/btrfs/volumes.c                                               |    9=20
 fs/cifs/cifssmb.c                                                |    4=20
 fs/cifs/dir.c                                                    |    9=20
 fs/dax.c                                                         |    2=20
 fs/f2fs/gc.c                                                     |    7=20
 fs/jffs2/fs.c                                                    |    1=20
 fs/nfs/nfs4proc.c                                                |   12=20
 fs/nfs/nfs4state.c                                               |    5=20
 fs/nfs/nfs4sysctl.c                                              |    2=20
 fs/ocfs2/acl.c                                                   |    6=20
 fs/ocfs2/journal.c                                               |   23=20
 fs/ocfs2/super.c                                                 |    5=20
 fs/ocfs2/xattr.c                                                 |    2=20
 fs/proc/base.c                                                   |   29=20
 fs/proc/kcore.c                                                  |    4=20
 fs/ubifs/tnc.c                                                   |   21=20
 include/asm-generic/pgtable.h                                    |   15=20
 include/linux/cpumask.h                                          |    2=20
 include/linux/etherdevice.h                                      |    2=20
 include/linux/kcore.h                                            |    1=20
 include/linux/netfilter/x_tables.h                               |    3=20
 include/linux/pci.h                                              |    7=20
 include/linux/property.h                                         |   10=20
 include/linux/suspend.h                                          |    2=20
 include/rdma/ib_verbs.h                                          |   23=20
 include/trace/events/timer.h                                     |   20=20
 kernel/bpf/sockmap.c                                             |   19=20
 kernel/events/callchain.c                                        |   21=20
 kernel/events/core.c                                             |    4=20
 kernel/locking/qspinlock.c                                       |    8=20
 kernel/power/power.h                                             |    3=20
 kernel/time/alarmtimer.c                                         |   34=20
 lib/test_bpf.c                                                   |   31=20
 mm/fadvise.c                                                     |   10=20
 mm/khugepaged.c                                                  |   12=20
 mm/mempolicy.c                                                   |   33=20
 mm/vmscan.c                                                      |   14=20
 net/bridge/netfilter/ebtables.c                                  |   10=20
 net/ipv4/netfilter/arp_tables.c                                  |   12=20
 net/ipv4/netfilter/ip_tables.c                                   |   10=20
 net/ipv4/tcp_nv.c                                                |    2=20
 net/ipv6/netfilter/ip6_tables.c                                  |   12=20
 net/ipv6/netfilter/nf_conntrack_reasm.c                          |   16=20
 net/netfilter/x_tables.c                                         |   51=20
 net/netfilter/xt_IDLETIMER.c                                     |    1=20
 net/netfilter/xt_LED.c                                           |    1=20
 net/netfilter/xt_limit.c                                         |    3=20
 net/netfilter/xt_nfacct.c                                        |    1=20
 net/netfilter/xt_statistic.c                                     |    1=20
 net/openvswitch/conntrack.c                                      |   34=20
 net/rds/ib.c                                                     |    3=20
 net/rxrpc/conn_event.c                                           |    1=20
 net/rxrpc/rxkad.c                                                |   92=20
 net/sunrpc/xprtrdma/backchannel.c                                |   12=20
 net/sunrpc/xprtrdma/svc_rdma_rw.c                                |   12=20
 net/sunrpc/xprtrdma/verbs.c                                      |   32=20
 net/sunrpc/xprtrdma/xprt_rdma.h                                  |    2=20
 net/sunrpc/xprtsock.c                                            |    4=20
 samples/bpf/Makefile                                             |    5=20
 scripts/kconfig/expr.c                                           |    2=20
 scripts/kconfig/menu.c                                           |    1=20
 scripts/kconfig/zconf.y                                          |   33=20
 sound/pci/hda/Kconfig                                            |    1=20
 sound/pci/hda/patch_realtek.c                                    |    5=20
 sound/soc/au1x/ac97c.c                                           |    6=20
 sound/soc/rockchip/rk3399_gru_sound.c                            |   19=20
 tools/lib/bpf/Makefile                                           |    2=20
 tools/lib/bpf/libbpf.c                                           |   26=20
 tools/lib/traceevent/event-parse.c                               |   17=20
 tools/lib/traceevent/parse-filter.c                              |   10=20
 tools/perf/arch/x86/util/header.c                                |    2=20
 tools/perf/builtin-c2c.c                                         |    5=20
 tools/perf/builtin-record.c                                      |    3=20
 tools/perf/builtin-report.c                                      |    5=20
 tools/perf/builtin-script.c                                      |    5=20
 tools/perf/perf.h                                                |    1=20
 tools/perf/tests/dwarf-unwind.c                                  |    1=20
 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh             |   21=20
 tools/perf/util/callchain.c                                      |   10=20
 tools/perf/util/callchain.h                                      |    2=20
 tools/perf/util/evsel.c                                          |   21=20
 tools/perf/util/unwind-libunwind-local.c                         |    9=20
 tools/testing/selftests/bpf/test_maps.c                          |   16=20
 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc |    6=20
 tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc |    4=20
 tools/testing/selftests/net/reuseport_bpf.c                      |   21=20
 virt/kvm/kvm_main.c                                              |    7=20
 214 files changed, 2981 insertions(+), 1957 deletions(-)

Aaron Sierra (1):
      tty: serial: exar: Relocate sleep wake-up handling

Alan Brady (1):
      i40evf: ignore link up if not running

Alex Estrin (2):
      IB/hfi1: Fix for potential refcount leak in hfi1_open_file()
      IB/ipoib: Fix for potential no-carrier state

Alex Williamson (1):
      PCI: Add function 1 DMA alias quirk for Marvell 9128

Alexey Dobriyan (1):
      proc: fix /proc/*/map_files lookup

Anand Jain (1):
      btrfs: fail mount when sb flag is not in BTRFS_SUPER_FLAG_SUPP

Andi Shyti (1):
      Input: stmfts - set IRQ_NOAUTOEN to the irq flag

Andreas Kemnade (1):
      usb: musb: fix enumeration after resume

Andy Shevchenko (1):
      device property: Define type of PROPERTY_ENRTY_*() macros

Andy Spencer (1):
      gianfar: prevent integer wrapping in the rx handler

Aneesh Kumar K.V (1):
      powerpc/mm/hash64: Zero PGD pages on allocation

Anna-Maria Gleixner (1):
      tracing/hrtimer: Fix tracing bugs by taking all clock bases and modes=
 into account

Anson Huang (1):
      clocksource/imx-tpm: Correct -ETIME return condition check

Arnaldo Carvalho de Melo (2):
      perf unwind: Do not look just at the global callchain_param.record_mo=
de
      perf callchain: Fix attr.sample_max_stack setting

Arnd Bergmann (4):
      scsi: fas216: fix sense buffer initialization
      x86/power: Fix swsusp_arch_resume prototype
      x86/dumpstack: Avoid uninitlized variable
      cifs: silence compiler warnings showing up with gcc-8.0.0

Avinash Dayanand (1):
      i40evf: Don't schedule reset_task when device is being removed

Benjamin Beichler (1):
      mac80211_hwsim: fix use-after-free bug in hwsim_exit_net

Chen Yu (2):
      ACPI: processor_perflib: Do not send _PPC change notification if not =
ready
      cpufreq: intel_pstate: Enable HWP during system resume on CPU0

Christian Borntraeger (1):
      KVM: s390: use created_vcpus in more places

Chuck Lever (2):
      xprtrdma: Fix backchannel allocation of extra rpcrdma_reps
      svcrdma: Fix Read chunk round-up

Coly Li (1):
      bcache: properly set task state in bch_writeback_thread()

Corentin LABBE (1):
      crypto: artpec6 - remove select on non-existing CRYPTO_SHA384

Corinna Vinschen (1):
      igb: Allow to remove administratively set MAC on VFs

Dan Carpenter (2):
      ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()
      HID: roccat: prevent an out of bounds read in kovaplus_profile_activa=
ted()

Daniel Borkmann (1):
      bpf: fix rlimit in reuseport net selftest

Daniel Hua (1):
      igb: Clear TXSTMP when ptp_tx_work() is timeout

Daniel J Blueman (1):
      drm/vc4: Fix memory leak during BO teardown

David Herrmann (1):
      platform/x86: thinkpad_acpi: suppress warning about palm detection

David Hildenbrand (1):
      KVM: s390: vsie: use READ_ONCE to access some SCB fields

David Howells (1):
      rxrpc: Don't put crypto buffers on the stack

David Sterba (1):
      btrfs: fix unaligned access in readdir

Dmitry Torokhov (1):
      Input: psmouse - fix Synaptics detection when protocol is disabled

Dmitry Vyukov (1):
      netfilter: x_tables: fix pointer leaks to userspace

Don Hiatt (1):
      IB/core: Map iWarp AH type to undefined in rdma_ah_find_type

Dou Liyang (1):
      x86/acpi: Prevent X2APIC id 0xffffffff from being accounted

Ed Swierk (1):
      openvswitch: Remove padding from packet before L3+ conntrack processi=
ng

Emil Tantilov (1):
      ixgbe: don't set RXDCTL.RLPML for 82599

Eryu Guan (1):
      blk-mq-debugfs: don't allow write on attributes with seq_operations s=
et

Florian Westphal (5):
      netfilter: x_tables: cap allocations at 512 mbyte
      netfilter: x_tables: add counters allocation wrapper
      netfilter: compat: prepare xt_compat_init_offsets to return errors
      netfilter: compat: reject huge allocation requests
      netfilter: x_tables: limit allocation requests for blob rule heads

Gaurav K Singh (1):
      drm/i915/audio: Fix audio detection issue on GLK

Geert Uytterhoeven (1):
      ubifs: Fix uninitialized variable in search_dh_cookie()

Gerd Hoffmann (1):
      drm/i915/gvt: throw error on unhandled vfio ioctls

Goldwyn Rodrigues (1):
      block: Set BIO_TRACE_COMPLETION on new bio during split

Greg Kroah-Hartman (1):
      Linux 4.14.37

Guanglei Li (1):
      RDS: IB: Fix null pointer issue

Guenter Roeck (1):
      watchdog: sp5100_tco: Fix watchdog disable bit

Gustavo A. R. Silva (1):
      tcp_nv: fix potential integer overflow in tcpnv_acked

Hans de Goede (4):
      ACPI / LPSS: Do not instiate platform_dev for devs without MMIO resou=
rces
      platform/x86: dell-laptop: Filter out spurious keyboard backlight cha=
nge events
      ACPI / bus: Do not call _STA on battery devices with unmet dependenci=
es
      ACPI / scan: Use acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE=
 devs

Hector Martin (1):
      firewire-ohci: work around oversized DMA reads on JMicron controllers

Imre Deak (2):
      drm/i915: Fix LSPCON TMDS output buffer enabling from low-power state
      drm/i915/bxt, glk: Increase PCODE timeouts during CDCLK freq changing

Jacob Keller (2):
      i40e: program fragmented IPv4 filter input set
      i40e: fix reported mask for ntuple filters

Jake Daryll Obina (1):
      jffs2: Fix use-after-free bug in jffs2_iget()'s error handling path

James Hogan (1):
      MIPS: Fix clean of vmlinuz.{32,ecoff,bin,srec}

Jan Chochol (1):
      nfs: Do not convert nfs_idmap_cache_timeout to jiffies

Jan H. Sch=F6nherr (1):
      fs/dax.c: release PMD lock even when there is no PMD support in DAX

Jason Gunthorpe (1):
      RDMA/uverbs: Use an unambiguous errno for method not supported

Jean Delvare (1):
      firmware: dmi_scan: Fix handling of empty DMI strings

Jeffy Chen (1):
      ASoC: rockchip: Use dummy_dai for rt5514 dsp dailink

Jens Axboe (1):
      blk-mq: fix discard merge with scheduler attached

Jesper Dangaard Brouer (2):
      libbpf: Makefile set specified permission mode
      tools/libbpf: handle issues with bpf ELF objects containing .eh_frames

Jia Zhang (1):
      vfs/proc/kcore, x86/mm/kcore: Fix SMAP fault when dumping vsyscall us=
er page

Jiri Olsa (4):
      perf record: Fix period option handling
      perf evsel: Fix period/freq terms setup
      perf: Fix sample_max_stack maximum check
      perf: Return proper values for user stack errors

John Fastabend (1):
      bpf: sockmap, fix leaking maps with attached but not detached progs

KarimAllah Ahmed (1):
      kvm: Map PFN-type memory regions as writable (if possible)

Karol Herbst (1):
      drm/nouveau/pmu/fuc: don't use movw directly anymore

Kirill A. Shutemov (1):
      asm-generic: provide generic_pmdp_establish()

Leon Romanovsky (2):
      RDMA/mlx5: Avoid memory leak in case of XRCD dealloc failure
      RDMA/mlx5: Fix NULL dereference while accessing XRC_TGT QPs

Liu Bo (4):
      Btrfs: set plug for fsync
      Btrfs: fix scrub to repair raid6 corruption
      Btrfs: fix unexpected EEXIST from btrfs_get_extent
      Btrfs: raid56: fix race between merge_bio and rbio_orig_end_io

Logan Gunthorpe (1):
      ntb_transport: Fix bug with max_mw_size parameter

Mark Salter (1):
      irqchip/gic-v3: Change pr_debug message to pr_devel

Martin Blumenstingl (2):
      net: stmmac: dwmac-meson8b: fix setting the RGMII TX clock on Meson8b
      net: stmmac: dwmac-meson8b: propagate rate changes to the parent clock

Masami Hiramatsu (1):
      selftest: ftrace: Fix to pick text symbols for kprobes

Mathieu Malaterre (1):
      net: Extra '_get' in declaration of arch_get_platform_mac_address

Matt Redfearn (2):
      MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS
      MIPS: Generic: Support GIC in EIC mode

Max Gurtovoy (1):
      RDMA/core: Reduce poll batch for direct cq polling

Maxime Chevallier (1):
      spi: a3700: Clear DATA_OUT when performing a read

Mel Gorman (1):
      mm: pin address_space before dereferencing it while isolating an LRU =
page

Merlijn Wajer (2):
      usb: musb: call pm_runtime_{get,put}_sync before reading vbus registe=
rs
      usb: musb: Fix external abort in musb_remove on omap2430

Michael Bringmann (2):
      powerpc/numa: Use ibm,max-associativity-domains to discover possible =
nodes
      powerpc/numa: Ensure nodes initialized for hotplug

Michael J. Ruhl (1):
      IB/hfi1: Re-order IRQ cleanup to address driver cleanup race

Michael Kelley (1):
      cpumask: Make for_each_cpu_wrap() available on UP as well

Micka=EBl Sala=FCn (1):
      samples/bpf: Partially fixes the bpf.o build

Ming Lei (2):
      dm mpath: return DM_MAPIO_REQUEUE on blk-mq rq allocation failure
      blk-mq: turn WARN_ON in __blk_mq_run_hw_queue into printk

Mustafa Ismail (1):
      i40iw: Free IEQ resources

NeilBrown (1):
      NFSv4: always set NFS_LOCK_LOST when a lock is lost.

Ngai-Mint Kwan (1):
      fm10k: fix "failed to kill vid" message for VF

Nicholas Piggin (2):
      powerpc: System reset avoid interleaving oops using die synchronisati=
on
      powerpc/powernv: IMC fix out of bounds memory access at shutdown

Niklas Cassel (2):
      PCI: Add dummy pci_irqd_intx_xlate() for CONFIG_PCI=3Dn build
      net: stmmac: discard disabled flags in interrupt status register

Nikolay Borisov (1):
      btrfs: Fix out of bounds access in btrfs_search_slot

Nitin Gupta (1):
      sparc64: update pmdp_invalidate() to return old pmd value

Paolo Bonzini (1):
      kvm: x86: fix KVM_XEN_HVM_CONFIG ioctl

Parav Pandit (2):
      RDMA/core: Clarify rdma_ah_find_type
      RDMA/cma: Check existence of netdevice during port validation

Paul Mackerras (2):
      KVM: PPC: Book3S HV: Enable migration of decrementer register
      KVM: PPC: Book3S HV: Fix handling of secondary HPTEG in HPT resizing =
code

Peter Hutterer (1):
      Input: synaptics - reset the ABS_X/Y fuzz after initializing MT axes

Peter Xu (1):
      iommu/vt-d: Use domain instead of cache fetching

Peter Zijlstra (1):
      x86/tsc: Allow TSC calibration without PIT

Prashant Bhole (1):
      bpf: test_maps: cleanup sockmaps when test ends

Rafael J. Wysocki (1):
      ACPI / EC: Restore polling during noirq suspend/resume phases

Robin Murphy (1):
      iommu/exynos: Don't unconditionally steal bus ops

Ross Lagerwall (2):
      xen-netfront: Fix race between device setup and open
      xen/grant-table: Use put_page instead of free_page

Sagi Grimberg (1):
      IB/cq: Don't force IB_POLL_DIRECT poll context for ib_process_cq_dire=
ct

Sean Christopherson (1):
      Revert "KVM: X86: Fix SMRAM accessing even if VM is shutdown"

Sebastian Ott (1):
      s390/eadm: fix CONFIG_BLOCK include dependency

Sheng Yong (1):
      f2fs: avoid hungtask when GC encrypted block if io_bits is set

Shiraz Saleem (1):
      i40iw: Zero-out consumer key on allocate stag for FMR

Stephen Boyd (1):
      irqchip/gic-v3: Ignore disabled ITS nodes

Steve French (1):
      cifs: do not allow creating sockets except with SMB1 posix exensions

Steven Rostedt (VMware) (3):
      tools lib traceevent: Simplify pointer print logic and fix %pF
      tools lib traceevent: Fix get_field_str() for dynamic strings
      selftests/ftrace: Add some missing glob checks

Subash Abhinov Kasiviswanathan (2):
      netfilter: ipv6: nf_defrag: Pass on packets to stack per RFC2460
      netfilter: ipv6: nf_defrag: Kill frag queue on RFC2460 failure

Takashi Iwai (1):
      ALSA: hda - Use IS_REACHABLE() for dependency on input

Tang Junhui (3):
      bcache: fix for allocator and register thread race
      bcache: fix for data collapse after re-attaching an attached device
      bcache: return attach error when no cache set exist

Thomas Gleixner (1):
      alarmtimer: Init nanosleep alarm timer on stack

Thomas Richter (2):
      perf record: Fix failed memory allocation for get_cpuid_str
      perf test: Fix test trace+probe_libc_inet_pton.sh for s390x

Tony Lindgren (1):
      PM / wakeirq: Fix unbalanced IRQ enable for wakeirq

Trond Myklebust (1):
      SUNRPC: Don't call __UDPX_INC_STATS() from a preemptible context

Ulf Hansson (1):
      PM / domains: Fix up domain-idle-states OF parsing

Ulf Magnusson (3):
      kconfig: Don't leak main menus during parsing
      kconfig: Fix automatic menu creation mem leak
      kconfig: Fix expr_free() E_NOT leak

Vitaly Kuznetsov (3):
      x86/hyperv: Stop suppressing X86_FEATURE_PCID
      x86/hyperv: Check for required priviliges in hyperv_init()
      x86/kvm/vmx: do not use vm-exit instruction length for fast MMIO when=
 running nested

Wei Yongjun (2):
      ipmi/powernv: Fix error return code in ipmi_powernv_probe()
      nfp: fix error return code in nfp_pci_probe()

Will Deacon (2):
      arm64: spinlock: Fix theoretical trylock() A-B-A with LSE atomics
      locking/qspinlock: Ensure node->count is updated before initialising =
node

Xiaoming Gao (1):
      x86/tsc: Prevent 32bit truncation in calc_hpet_ref()

Xidong Wang (1):
      drm/i915: Do no use kfree() to free a kmem_cache_alloc() return value

Xose Vazquez Perez (1):
      scsi: devinfo: fix format of the device list

Yang Shi (1):
      mm: thp: use down_read_trylock() in khugepaged to avoid long block

Yisheng Xie (2):
      mm/mempolicy: fix the check of nodemask from user
      mm/mempolicy: add nodes_empty check in SYSC_migrate_pages

Yonghong Song (1):
      bpf: fix selftests/bpf test_kmod.sh failure when CONFIG_BPF_JIT_ALWAY=
S_ON=3Dy

himanshu.madhani@cavium.com (1):
      scsi: qla2xxx: Fix warning in qla2x00_async_iocb_timeout()

mike.travis@hpe.com (1):
      x86/platform/UV: Fix GAM Range Table entries less than 1GB

mulhern (1):
      dm thin: fix documentation relative to low water mark threshold

piaojun (3):
      ocfs2: return -EROFS to mount.ocfs2 if inode block is invalid
      ocfs2/acl: use 'ip_xattr_sem' to protect getting extended attribute
      ocfs2: return error when we attempt to access a dirty bh in jbd2

shidao.ytt (1):
      mm/fadvise: discard partial page if endbyte is also EOF

weiyongjun (A) (1):
      mac80211_hwsim: fix possible memory leak in hwsim_new_radio_nl()


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrhzO8ACgkQONu9yGCS
aT6UOxAAx7fodqJLpPEczJDNO4WAVs5ksSlgkK4Q2UUmYOQ0laJXvBCQU3R5Bg0u
qhkQFuFVyVdsqL80RNaWYE/tj70Lzuiq+pe8b8Lvm9kBzAuAL7ZjH46c5J9RmSWH
yNmykdSaXCEcfE+oG/cNjbVKKKd6VGrnbWgw9J1+mDQI34dgnFf+fh9KyPhGcPYr
LveyEh5zIHf1N7KxLOONOmjQJpTtYkuWokxANyLFc7y7mZIxpQfy8IU3iR5AbOQY
Ujz9DtZpy3hqhZGgNRWOYXovJF16K1FZqhHExzLY2wa4NtW1Vj45V0InfoV34pC9
oqvUYKJw5bPj1nnr/ODkAe7l2bDZuzLPS08u3RrsQDBho1NdVGkW3xZZXKiFkZRo
jz73DZfpQlp35slrLmtEWoqoBySfTz/xT8CXBsJ5J8AyJD7KYfOI075SLOsbqo+f
vRt4HN67OkYtBf+Wm9HfxfG8lMt9+HyjsLjyB5ewOl8zvvhs8nqpZdt4Hk40Z2R6
Xec5mzj5suDwPeYESJR2p6QGukdencaDUmngcALGRWrNTrZq453OOcOYJb5L4trG
pFEVh7fxooxqucESAzt77Tf6ID2DEUHMSCBY6vwomMeOspXOx0r8xCF1RQrlnlru
6F1C0FS01UTIqAmPNGn/+bW1xJbSql7nVcVyrILv3ULrf6cz+lM=
=xRlG
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
