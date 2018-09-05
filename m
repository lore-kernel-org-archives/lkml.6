Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4520C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFAA2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFAA2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeIESy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:54:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbeIESy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:54:27 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 06FAA1162;
        Wed,  5 Sep 2018 14:23:59 +0000 (UTC)
Date:   Wed, 5 Sep 2018 16:23:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.68
Message-ID: <20180905142357.GA9137@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.68 kernel.

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

 Makefile                                                  |    6=20
 arch/Kconfig                                              |    3=20
 arch/arc/Kconfig                                          |    3=20
 arch/arc/include/asm/cache.h                              |    4=20
 arch/arc/include/asm/delay.h                              |    3=20
 arch/arc/mm/cache.c                                       |    7 -
 arch/arc/plat-eznps/include/plat/ctop.h                   |   10 +
 arch/arc/plat-eznps/mtm.c                                 |    6=20
 arch/arm/probes/kprobes/core.c                            |    4=20
 arch/arm/probes/kprobes/test-core.c                       |    1=20
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                  |    2=20
 arch/arm64/kernel/probes/kprobes.c                        |    2=20
 arch/arm64/mm/init.c                                      |    6=20
 arch/mips/Makefile                                        |   12 -
 arch/mips/bcm47xx/setup.c                                 |    6=20
 arch/mips/include/asm/mipsregs.h                          |    3=20
 arch/mips/include/asm/processor.h                         |   15 ++
 arch/mips/kernel/ptrace.c                                 |    2=20
 arch/mips/kernel/ptrace32.c                               |    2=20
 arch/mips/lib/multi3.c                                    |    6=20
 arch/powerpc/net/bpf_jit_comp64.c                         |   29 ----
 arch/s390/include/asm/qdio.h                              |    1=20
 arch/s390/mm/fault.c                                      |    2=20
 arch/s390/mm/page-states.c                                |    2=20
 arch/s390/net/bpf_jit_comp.c                              |    2=20
 arch/s390/numa/numa.c                                     |   16 --
 arch/s390/pci/pci.c                                       |    2=20
 arch/sparc/include/asm/Kbuild                             |    1=20
 arch/sparc/kernel/time_64.c                               |    2=20
 arch/x86/Kconfig                                          |    1=20
 arch/x86/boot/compressed/Makefile                         |    8 -
 arch/x86/entry/vdso/Makefile                              |    6=20
 arch/x86/events/amd/ibs.c                                 |    6=20
 arch/x86/events/core.c                                    |    2=20
 arch/x86/include/asm/irqflags.h                           |    3=20
 arch/x86/include/asm/processor.h                          |    6=20
 arch/x86/include/asm/tlbflush.h                           |   40 +++++
 arch/x86/include/asm/vgtod.h                              |    2=20
 arch/x86/kernel/cpu/bugs.c                                |   50 ++++++-
 arch/x86/kernel/cpu/common.c                              |    1=20
 arch/x86/kernel/cpu/intel.c                               |    3=20
 arch/x86/kernel/dumpstack.c                               |    4=20
 arch/x86/kernel/process_64.c                              |    1=20
 arch/x86/kvm/svm.c                                        |    8 -
 arch/x86/kvm/vmx.c                                        |   18 +-
 arch/x86/lib/usercopy.c                                   |    5=20
 arch/x86/mm/init.c                                        |    4=20
 arch/x86/mm/mmap.c                                        |    2=20
 arch/x86/mm/tlb.c                                         |    7 +
 drivers/base/power/clock_ops.c                            |    2=20
 drivers/block/nbd.c                                       |   96 +++++++++=
++---
 drivers/cdrom/cdrom.c                                     |    2=20
 drivers/char/tpm/tpm-interface.c                          |    2=20
 drivers/clk/rockchip/clk-rk3399.c                         |    2=20
 drivers/crypto/vmx/aes_ctr.c                              |   31 ++--
 drivers/gpio/gpiolib-acpi.c                               |   56 ++++++++
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c              |   12 +
 drivers/gpu/drm/imx/imx-ldb.c                             |    9 -
 drivers/gpu/drm/udl/udl_drv.h                             |    2=20
 drivers/gpu/drm/udl/udl_fb.c                              |   17 +-
 drivers/gpu/drm/udl/udl_main.c                            |   35 ++---
 drivers/gpu/drm/udl/udl_transfer.c                        |   39 ++---
 drivers/hwmon/nct6775.c                                   |    2=20
 drivers/i2c/busses/i2c-davinci.c                          |    8 -
 drivers/i2c/i2c-core-base.c                               |    2=20
 drivers/i2c/i2c-mux.c                                     |    4=20
 drivers/iommu/arm-smmu.c                                  |   16 +-
 drivers/misc/mei/main.c                                   |    1=20
 drivers/net/can/m_can/m_can.c                             |    7 -
 drivers/net/can/mscan/mpc5xxx_can.c                       |    5=20
 drivers/net/ethernet/3com/Kconfig                         |    2=20
 drivers/net/ethernet/amd/Kconfig                          |    4=20
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c           |    1=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c       |   13 +
 drivers/net/ethernet/cirrus/Kconfig                       |    1=20
 drivers/net/ethernet/cisco/enic/enic_main.c               |   80 ++++-----=
--
 drivers/net/ethernet/huawei/hinic/hinic_main.c            |    1=20
 drivers/net/ethernet/netronome/nfp/flower/main.c          |    4=20
 drivers/net/ethernet/qlogic/qed/qed_l2.c                  |   15 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.h                  |    2=20
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                 |   13 +
 drivers/net/ethernet/qlogic/qed/qed_sriov.c               |    2=20
 drivers/net/ethernet/qlogic/qed/qed_vf.c                  |    4=20
 drivers/net/ethernet/qlogic/qed/qed_vf.h                  |    7 -
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c         |    1=20
 drivers/net/usb/qmi_wwan.c                                |    2=20
 drivers/net/wan/lmc/lmc_main.c                            |    2=20
 drivers/net/wireless/broadcom/b43/leds.c                  |    2=20
 drivers/net/wireless/broadcom/b43legacy/leds.c            |    2=20
 drivers/nvme/host/pci.c                                   |    8 +
 drivers/pinctrl/freescale/pinctrl-imx1-core.c             |    2=20
 drivers/platform/x86/ideapad-laptop.c                     |    4=20
 drivers/power/supply/generic-adc-battery.c                |   25 ++-
 drivers/s390/cio/qdio_main.c                              |    5=20
 drivers/scsi/fcoe/fcoe_ctlr.c                             |    6=20
 drivers/scsi/libfc/fc_rport.c                             |    1=20
 drivers/scsi/libiscsi.c                                   |   12 -
 drivers/scsi/mpt3sas/mpt3sas_transport.c                  |    5=20
 drivers/scsi/scsi_sysfs.c                                 |   20 ++
 drivers/scsi/vmw_pvscsi.c                                 |   11 +
 drivers/staging/media/omap4iss/iss_video.c                |    3=20
 drivers/target/iscsi/cxgbit/cxgbit_target.c               |   16 +-
 drivers/target/iscsi/iscsi_target_login.c                 |   35 +++--
 drivers/usb/gadget/function/f_uac2.c                      |   24 +--
 drivers/usb/gadget/function/u_audio.c                     |   88 ++++-----=
---
 drivers/usb/gadget/udc/r8a66597-udc.c                     |    6=20
 drivers/usb/phy/phy-fsl-usb.c                             |    4=20
 fs/btrfs/disk-io.c                                        |   10 -
 fs/btrfs/extent-tree.c                                    |    2=20
 fs/btrfs/inode.c                                          |   26 ---
 fs/btrfs/super.c                                          |    1=20
 fs/cachefiles/namei.c                                     |    1=20
 fs/cachefiles/rdwr.c                                      |   17 +-
 fs/cifs/cifs_debug.c                                      |   30 +++-
 fs/cifs/cifsfs.c                                          |   18 +-
 fs/cifs/inode.c                                           |    2=20
 fs/cifs/link.c                                            |    4=20
 fs/cifs/sess.c                                            |    6=20
 fs/cifs/smb2inode.c                                       |    2=20
 fs/cifs/smb2ops.c                                         |   36 ++++-
 fs/cifs/smb2pdu.c                                         |    8 +
 fs/cifs/smb2pdu.h                                         |   11 +
 fs/ext4/mmp.c                                             |    7 -
 fs/ext4/namei.c                                           |    1=20
 fs/ext4/super.c                                           |    2=20
 fs/ext4/sysfs.c                                           |   13 +
 fs/ext4/xattr.c                                           |    2=20
 fs/fscache/operation.c                                    |    6=20
 fs/fuse/dev.c                                             |   39 ++++-
 fs/fuse/dir.c                                             |   10 -
 fs/fuse/file.c                                            |    1=20
 fs/fuse/fuse_i.h                                          |    5=20
 fs/fuse/inode.c                                           |   37 +++--
 fs/squashfs/file.c                                        |   50 ++++---
 fs/squashfs/file_cache.c                                  |    4=20
 fs/squashfs/file_direct.c                                 |   24 +--
 fs/squashfs/squashfs.h                                    |    3=20
 fs/sysfs/file.c                                           |   44 ++++++
 include/linux/printk.h                                    |    4=20
 include/linux/rtmutex.h                                   |    7 +
 include/linux/sysfs.h                                     |   14 ++
 ipc/sem.c                                                 |    2=20
 kernel/kprobes.c                                          |    4=20
 kernel/locking/rtmutex.c                                  |   29 +++-
 kernel/printk/internal.h                                  |    9 +
 kernel/printk/printk.c                                    |   57 +++++---
 kernel/printk/printk_safe.c                               |   58 +++++---
 kernel/sched/rt.c                                         |    2=20
 kernel/stop_machine.c                                     |   43 +++---
 kernel/trace/trace.c                                      |    4=20
 kernel/watchdog.c                                         |    4=20
 kernel/watchdog_hld.c                                     |    2=20
 kernel/workqueue.c                                        |    2=20
 lib/nmi_backtrace.c                                       |    3=20
 mm/memcontrol.c                                           |   15 +-
 mm/memory.c                                               |   33 +++-
 mm/zswap.c                                                |    9 +
 net/caif/caif_dev.c                                       |    4=20
 net/core/lwt_bpf.c                                        |    2=20
 net/ipv6/esp6.c                                           |    4=20
 net/ipv6/ip6_vti.c                                        |   11 -
 net/mac80211/util.c                                       |    3=20
 net/netfilter/nf_tables_api.c                             |   59 +++++---
 net/netfilter/nft_set_hash.c                              |    1=20
 net/wireless/nl80211.c                                    |    1=20
 net/xfrm/xfrm_policy.c                                    |    3=20
 net/xfrm/xfrm_user.c                                      |   10 -
 scripts/gcc-plugins/gcc-common.h                          |    4=20
 scripts/gcc-plugins/latent_entropy_plugin.c               |   17 --
 scripts/gcc-plugins/randomize_layout_plugin.c             |   75 +++-------
 scripts/gcc-plugins/structleak_plugin.c                   |   19 +-
 sound/soc/sirf/sirf-usp.c                                 |    7 -
 sound/soc/soc-pcm.c                                       |    8 +
 sound/soc/zte/zx-tdm.c                                    |    4=20
 tools/power/x86/turbostat/turbostat.c                     |    8 -
 tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc |   28 ++++
 tools/usb/ffs-test.c                                      |   19 ++
 virt/kvm/arm/mmu.c                                        |   42 ++++--
 178 files changed, 1396 insertions(+), 776 deletions(-)

Alberto Panizzo (1):
      clk: rockchip: fix clk_i2sout parent selection bits on rk3399

Aleksander Morgado (1):
      qmi_wwan: fix interface number for DW5821e production firmware

Alexander Sverdlin (1):
      i2c: davinci: Avoid zero value of CLKH

Alexander Usyskin (1):
      mei: don't update offset in write

Andi Kleen (2):
      x86/spectre: Add missing family 6 check to microcode check
      x86/speculation/l1tf: Increase l1tf memory limit for Nehalem+

Andrey Ryabinin (1):
      fuse: Don't access pipe->buffers without pipe_lock()

Andy Lutomirski (2):
      x86/vdso: Fix vDSO build if a retpoline is emitted
      x86/nmi: Fix NMI uaccess race against CR3 switching

Arnd Bergmann (1):
      ext4: sysfs: print ext4_super_block fields as little-endian

Bart Van Assche (3):
      scsi: mpt3sas: Fix _transport_smp_handler() error path
      scsi: sysfs: Introduce sysfs_{un,}break_active_protection()
      scsi: core: Avoid that SCSI device removal through sysfs triggers a d=
eadlock

Benjamin Tissoires (1):
      gpiolib-acpi: make sure we trigger edge events at least once on boot

Bernd Edlinger (1):
      nl80211: Add a missing break in parse_station_flags

Calvin Walton (1):
      tools/power turbostat: Read extended processor family from CPUID

Claudio Imbrenda (1):
      s390/kvm: fix deadlock when killed by oom

Colin Ian King (1):
      drivers: net: lmc: fix case value for target abort error

Dan Carpenter (2):
      pinctrl: freescale: off by one in imx1_pinconf_group_dbg_show()
      PM / clk: signedness bug in of_pm_clk_add_clks()

Daniel Borkmann (1):
      bpf, ppc64: fix unexpected r0=3D0 exit path inside bpf_xadd

Davidlohr Bueso (1):
      ipc/sem.c: prevent queue.status tearing in semop

Eric Sandeen (1):
      ext4: reset error code in ext4_find_entry in fallback

Ethan Lien (1):
      btrfs: use correct compare function of dirty_metadata_bytes

Eugeniu Rosca (3):
      usb: gadget: f_uac2: fix error handling in afunc_bind (again)
      usb: gadget: u_audio: fix pcm/card naming in g_audio_setup()
      usb: gadget: f_uac2: fix endianness of 'struct cntrl_*_lay3'

Eugeniy Paltsev (1):
      ARC: dma [non-IOC] setup SMP_CACHE_BYTES and cache_line_size

Eyal Birger (1):
      vti6: fix PMTU caching and reporting on xmit

Faiz Abbas (1):
      can: m_can: Move accessing of message ram to after clocks are enabled

Florian Westphal (4):
      xfrm: free skb if nlsk pointer is NULL
      netfilter: nf_tables: fix memory leaks on chain rename
      netfilter: nf_tables: don't allow to rename to already-pending name
      atl1c: reserve min skb headroom

Gerald Schaefer (1):
      s390/mm: fix addressing exception after suspend/resume

Govindarajulu Varadarajan (2):
      enic: handle mtu change for vf properly
      enic: do not call enic_change_mtu in enic_probe

Greg Hackmann (1):
      arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()

Greg Kroah-Hartman (1):
      Linux 4.14.68

Guenter Roeck (1):
      media: staging: omap4iss: Include asm/cacheflush.h after generic incl=
udes

Gustavo A. R. Silva (2):
      ASoC: sirf: Fix potential NULL pointer dereference
      hwmon: (nct6775) Fix potential Spectre v1

H. Nikolaus Schaller (2):
      power: generic-adc-battery: fix out-of-bounds write when copying chan=
nel properties
      power: generic-adc-battery: check for duplicate properties copied fro=
m iio channels

Hailong Liu (1):
      sched/rt: Restore rt_runtime after disabling RT_RUNTIME_SHARE

Huacai Chen (1):
      MIPS: Change definition of cpu_relax() for Loongson-3

Hugh Dickins (1):
      mm: delete historical BUG from zap_pmd_range()

Huibin Hong (1):
      arm64: dts: rockchip: corrected uart1 clock-names for rk3328

Jann Horn (1):
      x86/entry/64: Wipe KASAN stack shadow before rewind_stack_do_exit()

Jerome Brunet (1):
      ASoC: dpcm: don't merge format from invalid codec dai

Jia-Ju Bai (2):
      usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context bugs =
in init_controller()
      usb: gadget: r8a66597: Fix a possible sleep-in-atomic-context bugs in=
 r8a66597_queue()

Jim Gill (1):
      scsi: vmw_pvscsi: Return DID_RESET for status SAM_STAT_COMMAND_TERMIN=
ATED

Johannes Thumshirn (3):
      scsi: fcoe: fix use-after-free in fcoe_ctlr_els_send
      scsi: fcoe: drop frames in ELS LOGO error path
      scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO

John Hurley (1):
      nfp: flower: fix port metadata conversion bug

Josef Bacik (4):
      nbd: don't requeue the same request twice.
      nbd: handle unexpected replies better
      btrfs: don't leak ret from do_chunk_alloc
      Btrfs: fix btrfs_write_inode vs delayed iput deadlock

Josh Poimboeuf (1):
      x86/kvm/vmx: Remove duplicate l1d flush definitions

Joshua Frkuska (1):
      usb: gadget: u_audio: update hw_ptr in iso_complete after data copied

Julian Wiedmann (1):
      s390/qdio: reset old sbal_state flags

Kees Cook (2):
      x86/boot: Fix if_changed build flip/flop bug
      gcc-plugins: Use dynamic initializers

Kiran Kumar Modukuri (3):
      fscache: Allow cancelled operations to be enqueued
      cachefiles: Fix refcounting bug in backing-file read monitoring
      cachefiles: Wait rather than BUG'ing on "Unexpected object collision"

Kirill Tkhai (2):
      memcg: remove memcg_cgroup::id from IDR on mem_cgroup_css_alloc() fai=
lure
      fuse: Add missed unlock_page() to fuse_readpages_fill()

Len Brown (1):
      tools/power turbostat: fix -S on UP systems

Li Wang (1):
      zswap: re-check zswap_is_full() after do zswap_shrink()

Linus Torvalds (1):
      squashfs metadata 2: electric boogaloo

Lucas Stach (2):
      drm/imx: imx-ldb: disable LDB on driver bind
      drm/imx: imx-ldb: check if channel is enabled before printing warning

Maciej W. Rozycki (1):
      MIPS: Correct the 64-bit DSP accumulator register size

Martin Schwidefsky (2):
      s390: fix br_r1_trampoline for machines without exrl
      s390/numa: move initial setup of node_to_cpumask_map

Masami Hiramatsu (4):
      selftests/ftrace: Add snapshot and tracing_on test case
      kprobes/arm64: Fix %p uses in error messages
      kprobes/arm: Fix %p uses in error messages
      kprobes: Make list and blacklist root user read only

Michael Buesch (2):
      b43legacy/leds: Ensure NUL-termination of LED name string
      b43/leds: Ensure NUL-termination of LED name string

Michal Wnukowski (1):
      nvme-pci: add a memory barrier to nvme_dbbuf_update_and_check_event

Mike Christie (1):
      iscsi target: fix session creation failure handling

Miklos Szeredi (5):
      fuse: fix initial parallel dirops
      fuse: fix double request_end()
      fuse: fix unlocked access to processing queue
      fuse: umount should wait for all requests
      fuse: Fix oops at process_init_reply()

Mikulas Patocka (4):
      udl-kms: change down_interruptible to down
      udl-kms: handle allocation failure
      udl-kms: fix crash due to uninitialized memory
      udl-kms: avoid division

Nicholas Mc Guire (2):
      can: mpc5xxx_can: check of_iomap return before use
      cifs: check kmalloc before use

Nicholas Piggin (1):
      mm: move tlb_table_flush to tlb_flush_mmu_free

Nick Desaulniers (1):
      x86/irqflags: Mark native_restore_fl extern inline

Ofer Levi (1):
      ARC: [plat-eznps] Add missing struct nps_host_reg_aux_dpc

Paul Burton (2):
      MIPS: Always use -march=3D<arch>, not -<arch> shortcuts
      MIPS: lib: Provide MIPS64r6 __multi3() for GCC < 7

Paulo Flabiano Smorigo (1):
      crypto: vmx - Use skcipher for ctr fallback

Peter Rosin (2):
      locking/rtmutex: Allow specifying a subclass for nested locking
      i2c/mux, locking/core: Annotate the nested rt_mutex usage

Peter Senna Tschudin (1):
      tools: usb: ffs-test: Fix build on big endian systems

Peter Zijlstra (2):
      stop_machine: Reflow cpu_stop_queue_two_works()
      mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE

Petr Mladek (3):
      printk: Split the code for storing a message into the log buffer
      printk: Create helper function to queue deferred console handling
      printk/nmi: Prevent deadlock when accessing the main log buffer in NMI

Phillip Lougher (1):
      Squashfs: Compute expected length from inode size rather than block l=
ength

Prasad Sodagudi (1):
      stop_machine: Atomically queue and wake stopper threads

Punit Agrawal (2):
      KVM: arm/arm64: Skip updating PMD entry if no change
      KVM: arm/arm64: Skip updating PTE entry if no change

Rafa=C5=82 Mi=C5=82ecki (1):
      Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum"

Randy Dunlap (6):
      usb/phy: fix PPC64 build errors in phy-fsl-usb.c
      net: prevent ISA drivers from building on PPC32
      arc: [plat-eznps] fix data type errors in platform headers
      arc: [plat-eznps] fix printk warning in arc/plat-eznps/mtm.c
      arc: fix build errors in arc/include/asm/delay.h
      arc: fix type warnings in arc/mm/cache.c

Rian Hunter (1):
      x86/process: Re-export start_thread()

Ricardo Schwarzmeier (1):
      tpm: Return the actual size when receiving an unsupported command

Samuel Neves (1):
      x86/vdso: Fix lsl operand order

Scott Bauer (1):
      cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status

Sean Christopherson (1):
      KVM: vmx: use local variable for current_vmptr when emulating VMPTRST

Sean Paul (1):
      drm/bridge: adv7511: Reset registers on hotplug

Sebastian Ott (1):
      s390/pci: fix out of bounds access during irq setup

Shubhrajyoti Datta (1):
      net: axienet: Fix double deregister of mdio

Steve French (5):
      cifs: add missing debug entries for kconfig options
      smb3: enumerating snapshots was leaving part of the data off end
      smb3: Do not send SMB3 SET_INFO if nothing changed
      smb3: don't request leases in symlink creation and query
      smb3: fill in statfs fsid and correct namelen

Steven Rostedt (VMware) (1):
      sparc/time: Add missing __init to init_tick_ops()

Sudarsana Reddy Kalluru (4):
      qed: Fix link flap issue due to mismatching EEE capabilities.
      qed: Fix possible race for the link state value.
      qed: Correct Multicast API to reflect existence of 256 approximate bu=
ckets.
      bnx2x: Fix invalid memory access in rss hash config path.

Taehee Yoo (2):
      netfilter: nft_set_hash: add rcu_barrier() in the nft_rhash_destroy()
      bpf: use GFP_ATOMIC instead of GFP_KERNEL in bpf_parse_prog()

Takashi Iwai (2):
      platform/x86: ideapad-laptop: Apply no_hw_rfkill to Y20-15IKBM, too
      ASoC: zte: Fix incorrect PCM format bit usages

Theodore Ts'o (2):
      ext4: clear mmp sequence number when remounting read-only
      ext4: check for NUL characters in extended attribute's name

Thomas Gleixner (2):
      perf/x86/amd/ibs: Don't access non-started event
      KVM: x86: SVM: Call x86_spec_ctrl_set_guest/host() with interrupts di=
sabled

Thomas Petazzoni (1):
      sparc: use asm-generic version of msi.h

Tommi Rantala (1):
      xfrm: fix missing dst_release() after policy blocking lbcast and mult=
icast

Valdis Kletnieks (1):
      gcc-plugins: Add include required by GCC release 8

Varun Prakash (2):
      scsi: target: iscsi: cxgbit: fix max iso npdu calculation
      scsi: libiscsi: fix possible NULL pointer dereference in case of TMF

Vincent Whitchurch (1):
      watchdog: Mark watchdog touch functions as notrace

Vivek Gautam (1):
      iommu/arm-smmu: Error out only if not enough context interrupts

Vladimir Zapolskiy (3):
      usb: gadget: u_audio: remove caching of stream buffer parameters
      usb: gadget: u_audio: remove cached period bytes value
      usb: gadget: u_audio: protect stream runtime fields with stream spinl=
ock

Vlastimil Babka (3):
      x86/speculation/l1tf: Fix overflow in l1tf_pfn_limit() on 32bit
      x86/speculation/l1tf: Fix off-by-one error when warning that system h=
as too much RAM
      x86/speculation/l1tf: Suggest what to do on systems with too much RAM

YueHaibing (1):
      net: caif: Add a missing rcu_read_unlock() in caif_flow_cb

Zhen Lei (1):
      esp6: fix memleak on error path in esp6_input

dann frazier (1):
      hinic: Link the logical network device to the pci device in sysfs

jie@chenjie6@huwei.com (1):
      mm/memory.c: check return value of ioremap_prot

mpubbise@codeaurora.org (1):
      mac80211: add stations tied to AP_VLANs during hw reconfig


--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluP5v0ACgkQONu9yGCS
aT6xjBAAw9Z5vnxKgdlhxZUvfGGnkJjDkMXjEmhm7R16m4iGzQBhuwRonL6hUOea
DKM0skjaaYWKF14kEWp/8qSUDmlbw8jRQC318od/GPfEqgoucs6uTAjFqnLyG24f
tLERdGf1p2yeiZgWZY+bdecAVOIoCFTEVof27ZWVAyc+angHgSK9hD2N7fl/InFY
foZhLrfFsA2S818JLt0DcFftJgWHUCahv+fFe0NJOazmbI1/VzeUaaCxNsGqVEGX
ga+CnOLaqhxW01NR164SwoE3Lrdz6JuLMLy3u/WBeJdS4OtHNQlc32Y2fzDt7Gyx
BZztWaHE+PiybIUPv7xXPWcNKSQpl0MAiPh6s+r/sJlKDJeLUqwjBxe/8JhdFLcO
mIbbriX8KunyKsrQrpTb/JWfKnLlvCF5MARUxE1RIec5/K8f8hNFK/atcWXWXZKU
cv+ljoP6dAlMqd8fNK7k5frTEfDBJYNqfLNYHcSU+2ByjPqw1mZC/SnAcGWNJYY1
3+08kHaA4ENLe54mqQPCIfDwjwKcBls6bhQ0xWAdrguVMPGFjeROf+xzGcO674cX
WHC/Ol1OdVOh4pw+wpIJGCvv7q8qSGu8T0/Hv+2f3LWoszErfC0Fb9hg5jUhhdel
KAAdlbqnTuu6s40avcPvaPM3MXy4yxkUwgjZO1kDxNQ2eTDAqaM=
=z64i
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
