Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE84ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F8C2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F8C2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbeITC7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:59:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732688AbeITC7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:59:22 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A763E104F;
        Wed, 19 Sep 2018 21:19:11 +0000 (UTC)
Date:   Wed, 19 Sep 2018 23:19:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.71
Message-ID: <20180919211909.GA9566@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.71 kernel.

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

 Documentation/networking/ip-sysctl.txt              |   13=20
 Makefile                                            |    2=20
 arch/arc/configs/axs101_defconfig                   |    1=20
 arch/arc/configs/axs103_defconfig                   |    1=20
 arch/arc/configs/axs103_smp_defconfig               |    1=20
 arch/mips/cavium-octeon/octeon-platform.c           |    2=20
 arch/mips/generic/init.c                            |    1=20
 arch/mips/include/asm/io.h                          |    8=20
 arch/mips/kernel/vdso.c                             |   20=20
 arch/mips/mm/c-r4k.c                                |    6=20
 arch/powerpc/platforms/powernv/npu-dma.c            |    5=20
 arch/s390/kvm/vsie.c                                |    3=20
 arch/x86/kernel/cpu/microcode/amd.c                 |   24=20
 arch/x86/kernel/cpu/microcode/intel.c               |   17=20
 arch/x86/kvm/vmx.c                                  |    4=20
 arch/x86/mm/fault.c                                 |    2=20
 block/bfq-cgroup.c                                  |    4=20
 block/blk-mq-tag.c                                  |    8=20
 block/partitions/aix.c                              |   13=20
 crypto/Makefile                                     |    2=20
 drivers/android/binder_alloc.c                      |   42 +
 drivers/ata/libahci.c                               |   20=20
 drivers/block/nbd.c                                 |    3=20
 drivers/block/pktcdvd.c                             |    4=20
 drivers/bluetooth/Kconfig                           |    1=20
 drivers/char/tpm/tpm-interface.c                    |   50 +
 drivers/char/tpm/tpm.h                              |   12=20
 drivers/char/tpm/tpm2-space.c                       |   16=20
 drivers/char/tpm/tpm_crb.c                          |  101 ---
 drivers/char/tpm/tpm_i2c_infineon.c                 |    8=20
 drivers/char/tpm/tpm_tis_spi.c                      |    9=20
 drivers/firmware/google/vpd.c                       |    5=20
 drivers/gpio/gpio-ml-ioh.c                          |    3=20
 drivers/gpio/gpio-tegra.c                           |    2=20
 drivers/gpu/drm/i915/i915_reg.h                     |    1=20
 drivers/gpu/drm/i915/intel_ddi.c                    |    4=20
 drivers/gpu/ipu-v3/ipu-common.c                     |    2=20
 drivers/hv/hv.c                                     |   14=20
 drivers/i2c/busses/i2c-aspeed.c                     |    2=20
 drivers/i2c/busses/i2c-i801.c                       |    7=20
 drivers/i2c/busses/i2c-xiic.c                       |    4=20
 drivers/infiniband/core/cma.c                       |   13=20
 drivers/input/touchscreen/atmel_mxt_ts.c            |    7=20
 drivers/iommu/ipmmu-vmsa.c                          |    9=20
 drivers/macintosh/via-pmu.c                         |    9=20
 drivers/md/dm-cache-target.c                        |   19=20
 drivers/md/raid5.c                                  |    6=20
 drivers/media/dvb-frontends/helene.c                |    5=20
 drivers/media/platform/davinci/vpif_display.c       |   24=20
 drivers/media/platform/qcom/camss-8x16/camss-csid.c |   16=20
 drivers/media/platform/s5p-mfc/s5p_mfc.c            |   23=20
 drivers/media/usb/dvb-usb/dw2102.c                  |   19=20
 drivers/mfd/ti_am335x_tscadc.c                      |    3=20
 drivers/misc/mic/scif/scif_api.c                    |   20=20
 drivers/misc/ti-st/st_kim.c                         |    4=20
 drivers/mtd/ubi/wl.c                                |    8=20
 drivers/net/ethernet/marvell/mvneta.c               |    1=20
 drivers/net/phy/mdio-mux-bcm-iproc.c                |   20=20
 drivers/net/tun.c                                   |   21=20
 drivers/net/wireless/ath/ath10k/mac.c               |    7=20
 drivers/net/wireless/ath/ath10k/wmi-tlv.c           |    5=20
 drivers/net/wireless/ath/ath10k/wmi-tlv.h           |    5=20
 drivers/net/wireless/ath/ath9k/hw.c                 |    7=20
 drivers/net/wireless/ath/ath9k/xmit.c               |    3=20
 drivers/net/wireless/ti/wlcore/rx.c                 |    8=20
 drivers/pci/switch/switchtec.c                      |    4=20
 drivers/pinctrl/freescale/pinctrl-imx.c             |    2=20
 drivers/pinctrl/pinctrl-amd.c                       |    3=20
 drivers/rpmsg/rpmsg_core.c                          |    7=20
 drivers/scsi/3w-9xxx.c                              |    6=20
 drivers/scsi/3w-sas.c                               |    3=20
 drivers/scsi/3w-xxxx.c                              |    2=20
 drivers/scsi/lpfc/lpfc.h                            |    2=20
 drivers/target/target_core_transport.c              |    5=20
 drivers/tty/rocket.c                                |    2=20
 drivers/uio/uio.c                                   |    3=20
 fs/autofs4/autofs_i.h                               |    4=20
 fs/autofs4/inode.c                                  |    1=20
 fs/btrfs/ioctl.c                                    |   19=20
 fs/cifs/inode.c                                     |    2=20
 fs/cifs/smb2ops.c                                   |   35 -
 fs/cifs/smb2pdu.c                                   |    3=20
 fs/f2fs/f2fs.h                                      |    7=20
 fs/f2fs/file.c                                      |    2=20
 fs/f2fs/gc.c                                        |    8=20
 fs/f2fs/inline.c                                    |   22=20
 fs/f2fs/node.c                                      |    4=20
 fs/f2fs/segment.h                                   |    3=20
 fs/f2fs/super.c                                     |   21=20
 fs/f2fs/sysfs.c                                     |   10=20
 fs/nfs/callback_proc.c                              |    4=20
 fs/nfs/callback_xdr.c                               |   11=20
 include/linux/mm_types.h                            |    2=20
 include/linux/mm_types_task.h                       |    2=20
 include/linux/rhashtable.h                          |    8=20
 include/linux/skbuff.h                              |   50 +
 include/linux/tpm.h                                 |    2=20
 include/linux/vm_event_item.h                       |    1=20
 include/linux/vmacache.h                            |    5=20
 include/net/inet_frag.h                             |  135 ++--
 include/net/ip.h                                    |    1=20
 include/net/ipv6.h                                  |   26=20
 include/uapi/linux/ethtool.h                        |    4=20
 include/uapi/linux/snmp.h                           |    1=20
 kernel/cpu.c                                        |   11=20
 kernel/time/timer.c                                 |   29 -
 lib/rhashtable.c                                    |    2=20
 mm/debug.c                                          |    4=20
 mm/vmacache.c                                       |   38 -
 net/bluetooth/hidp/core.c                           |    2=20
 net/core/skbuff.c                                   |   31 -
 net/dcb/dcbnl.c                                     |   11=20
 net/ieee802154/6lowpan/6lowpan_i.h                  |   26=20
 net/ieee802154/6lowpan/reassembly.c                 |  153 ++---
 net/ipv4/inet_fragment.c                            |  378 ++-----------
 net/ipv4/ip_fragment.c                              |  578 +++++++++++----=
-----
 net/ipv4/proc.c                                     |    7=20
 net/ipv4/tcp_fastopen.c                             |    8=20
 net/ipv4/tcp_input.c                                |   33 -
 net/ipv6/netfilter/nf_conntrack_reasm.c             |  105 +--
 net/ipv6/proc.c                                     |    5=20
 net/ipv6/reassembly.c                               |  217 +++----
 net/sched/sch_netem.c                               |   14=20
 sound/pci/hda/hda_codec.c                           |    3=20
 tools/perf/builtin-c2c.c                            |    3=20
 tools/perf/perf.h                                   |    2=20
 tools/perf/util/evsel.c                             |   14=20
 tools/testing/nvdimm/pmem-dax.c                     |   12=20
 tools/testing/selftests/bpf/test_verifier.c         |    6=20
 129 files changed, 1472 insertions(+), 1361 deletions(-)

Alexey Brodkin (1):
      ARC: [plat-axs*]: Enable SWAP

Anton Vasilyev (7):
      media: davinci: vpif_display: Mix memory leak on probe error path
      media: dw2102: Fix memleak on sequence of probes
      misc: ti-st: Fix memory leak in the error path of probe()
      firmware: vpd: Fix section enabled flag on vpd_section_destroy
      tty: rocket: Fix possible buffer overwrite on register_PCI
      scsi: 3ware: fix return 0 on the error path of probe
      gpio: ml-ioh: Fix buffer underwrite on probe error path

Arnd Bergmann (1):
      crypto: aes-generic - fix aes-generic regression on powerpc

Arun Parameswaran (1):
      net: phy: Fix the register offsets in Broadcom iProc mdio mux driver

BingJing Chang (1):
      md/raid5: fix data corruption of replacements after originals dropped

Chao Yu (6):
      f2fs: fix to active page in lru list for read path
      f2fs: try grabbing node page lock aggressively in sync scenario
      f2fs: fix to skip GC if type in SSA and SIT is inconsistent
      f2fs: fix to do sanity check with reserved blkaddr of inline inode
      f2fs: fix to wait on page writeback before updating page
      f2fs: fix to do sanity check with {sit,nat}_ver_bitmap_bytesize

Christophe Leroy (1):
      perf tools: Allow overriding MAX_NR_CPUS at compile time

Dan Carpenter (5):
      misc: mic: SCIF Fix scif_get_new_port() error handling
      uio: potential double frees if __uio_register_device() fails
      pinctrl: imx: off by one in imx_pinconf_group_dbg_show()
      f2fs: Fix uninitialized return in f2fs_ioc_shutdown()
      ipv4: frags: precedence bug in ip_expire()

Daniel Kurtz (1):
      pinctrl/amd: only handle irq if it is pending and unmasked

Dmitry Osipenko (1):
      gpio: tegra: Move driver registration to subsys_init level

Eric Dumazet (22):
      inet: frags: change inet_frags_init_net() return value
      inet: frags: add a pointer to struct netns_frags
      inet: frags: refactor ipfrag_init()
      inet: frags: refactor ipv6_frag_init()
      inet: frags: refactor lowpan_net_frag_init()
      ipv6: export ip6 fragments sysctl to unprivileged users
      rhashtable: add schedule points
      inet: frags: use rhashtables for reassembly units
      inet: frags: remove some helpers
      inet: frags: get rif of inet_frag_evicting()
      inet: frags: remove inet_frag_maybe_warn_overflow()
      inet: frags: break the 2GB limit for frags storage
      inet: frags: do not clone skb in ip_expire()
      ipv6: frags: rewrite ip6_expire_frag_queue()
      rhashtable: reorganize struct rhashtable layout
      inet: frags: reorganize struct netns_frags
      inet: frags: get rid of ipfrag_skb_cb/FRAG_CB
      inet: frags: fix ip6frag_low_thresh boundary
      net: speed up skb_rbtree_purge()
      net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends
      net: add rb_to_skb() and other rb tree helpers
      net: sk_buff rbnode reorg

Felipe Balbi (1):
      i2c: i801: fix DNV's SMBCTRL register offset

Felix Fietkau (2):
      ath9k: report tx status on EOSP
      ath9k_hw: fix channel maximum power level test

Filipe Manana (1):
      Btrfs: fix data corruption when deduplicating between different files

Filippo Sironi (1):
      x86/microcode: Update the new microcode revision unconditionally

Finn Thain (1):
      macintosh/via-pmu: Add missing mmio accessors

Florian Fainelli (1):
      ethtool: Remove trailing semicolon for static inline

Florian Westphal (1):
      ipv6: defrag: drop non-last frags smaller than min mtu

Gaurav Kohli (1):
      timers: Clear timer_base::must_forward_clk with timer_base::lock held

Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Fix allocation in atomic context

Greg Kroah-Hartman (1):
      Linux 4.14.71

Gustavo A. R. Silva (1):
      switchtec: Fix Spectre v1 vulnerability

Huaisheng Ye (1):
      tools/testing/nvdimm: kaddr and pfn can be NULL to ->direct_access()

Ian Kent (1):
      autofs: fix autofs_sbi() does not check super block type

Jae Hyun Yoo (1):
      i2c: aspeed: Add an explicit type casting for *get_clk_reg_val

James Smart (1):
      scsi: lpfc: Correct MDS diag and nvmet configuration

Jani Nikula (1):
      drm/i915: set DP Main Stream Attribute for color range on DDI platfor=
ms

Jason Wang (2):
      tun: fix use after free for ptr_ring
      tuntap: fix use after free during release

Jens Axboe (1):
      nbd: don't allow invalid blocksize settings

Jinbum Park (1):
      pktcdvd: Fix possible Spectre-v1 for pkt_devs

Jiri Olsa (1):
      perf c2c report: Fix crash for empty browser

Joerg Roedel (1):
      x86/mm: Remove in_nmi() warning from vmalloc_fault()

Johan Hedberg (1):
      Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV

John Pittman (1):
      dm cache: only allow a single io_mode cache feature to be requested

Kan Liang (1):
      perf evlist: Fix error out while applying initial delay and LBR

Katsuhiro Suzuki (1):
      media: helene: fix xtal frequency setting at power on

Kees Cook (1):
      inet: frags: Convert timers to use timer_setup()

Konstantin Khlebnikov (1):
      block: bfq: swap puts in bfqg_and_blkg_put

Linus Torvalds (1):
      mm: get rid of vmacache_flush_all() entirely

Linus Walleij (1):
      tpm_tis_spi: Pass the SPI IRQ down to the driver

Loic Poulain (1):
      wlcore: Set rx_status boottime_ns field on rx

Marcel Holtmann (1):
      Bluetooth: hidp: Fix handling of strncpy for hid->name information

Mauricio Faria de Oliveira (2):
      partitions/aix: append null character to print data from disk
      partitions/aix: fix usage of uninitialized lv_info and lvname structu=
res

Michael Kelley (1):
      Drivers: hv: vmbus: Cleanup synic memory free path

Mike Christie (1):
      scsi: target: fix __transport_register_session locking

Minchan Kim (1):
      android: binder: fix the race mmap and alloc_new_buf_locked

Ming Lei (1):
      blk-mq: fix updating tags depth

Neeraj Upadhyay (1):
      cpu/hotplug: Adjust misplaced smb() in cpuhp_thread_fun()

Nicholas Mc Guire (2):
      MIPS: Octeon: add missing of_node_put()
      MIPS: generic: fix missing of_node_put()

Nick Dyer (1):
      Input: atmel_mxt_ts - only use first T9 instance

Olga Kornievskaia (1):
      NFSv4.0 fix client reference leak in callback

Parav Pandit (1):
      RDMA/cma: Do not ignore net namespace for unbound cm_id

Paul Burton (3):
      MIPS: VDSO: Match data page cache colouring when D$ aliases
      MIPS: Fix ISA virt/bus conversion for non-zero PHYS_OFFSET
      MIPS: WARN_ON invalid DMA cache maintenance, not BUG_ON

Peter Oskolkov (4):
      ip: discard IPv4 datagrams with overlapping segments.
      net: modify skb_rbtree_purge to return the truesize of all purged skb=
s.
      ip: add helpers to process in-order fragments faster.
      ip: process in-order fragments efficiently

Peter Rosin (1):
      tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Petr Machata (1):
      net: dcb: For wild-card lookups, use priority -1, not 0

Philipp Zabel (1):
      gpu: ipu-v3: default to id 0 on missing OF alias

Pierre Morel (1):
      KVM: s390: vsie: copy wrapping keys to right place

Prarit Bhargava (1):
      x86/microcode: Make sure boot_cpu_data.microcode is up-to-date

Randy Dunlap (1):
      f2fs: fix defined but not used build warnings

Reza Arbab (1):
      powerpc/powernv: Fix concurrency issue with npu->mmio_atsd_usage

Roman Gushchin (1):
      selftests/bpf: fix a typo in map in map test

Sean Christopherson (1):
      KVM: VMX: Do not allow reexecute_instruction() when skipping MMIO ins=
tr

Shubhrajyoti Datta (1):
      i2c: xiic: Make the start and the byte count write atomic

Srinivas Kandagatla (1):
      rpmsg: core: add support to power domains for devices

Srinivas Pandruvada (2):
      ata: libahci: Allow reconfigure of DEVSLP register
      ata: libahci: Correct setting of DEVSLP register

Steve French (2):
      SMB3: Backup intent flag missing for directory opens with backupuid m=
ounts
      smb3: check for and properly advertise directory lease support

Surabhi Vishnoi (1):
      ath10k: disable bundle mgmt tx completion event support

Sven Eckelmann (1):
      ath10k: prevent active scans on potential unusable channels

Sylwester Nawrocki (1):
      media: s5p-mfc: Fix buffer look up in s5p_mfc_handle_frame_{new, copy=
_time} functions

Taehee Yoo (1):
      ip: frags: fix crash in ip_do_fragment()

Takashi Iwai (1):
      ALSA: hda - Fix cancel_work_sync() stall from jackpoll work

Thomas Gleixner (1):
      cpu/hotplug: Prevent state corruption on error rollback

Todor Tomov (1):
      media: camss: csid: Configure data type and decode format properly

Tomas Winkler (1):
      tpm: separate cmd_ready/go_idle from runtime_pm

Trond Myklebust (1):
      NFSv4.1: Fix a potential layoutget/layoutrecall deadlock

Wei Yongjun (1):
      mtd: ubi: wl: Fix error return code in ubi_wl_init()

Yelena Krivosheev (1):
      net: mvneta: fix mtu change on port without link

Yunlong Song (1):
      f2fs: do not set free of current section

Zumeng Chen (1):
      mfd: ti_am335x_tscadc: Fix struct clk memory leak


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluivU0ACgkQONu9yGCS
aT56Fg//dwhW+3a9qrv1hqJ6KsIDGrDdQeYTR4SOgFJ6NIzJC+HPIjjMTHTGqnBN
vxrxhSVwC2IyPZAGflXh+n8CBAd7wXUBZ9wmFCe58vRjUkaNkZILHuqxOVMqw0l4
FUq0xi8G8BfU++XID13a4+grF576//wXiIyCMMoYxbafG28lJvo+XGz5gd+xJ0z1
pX2VaUKa+ZDND57lVGdsYIMICCHyHZqKYa1Kh144WbyUxuo+qeTzEbEwa7W04iyp
YyadXcwSt8e71bRDeMaEdxb/1dabQ1+3SV9HQranVoeaSGQX1m/9vHf9C2x8TqeZ
SnvdwyVqtzyw6uBLU1QlOWH7ZKQFgi48HPlU1kAkjCepkkog2EhCRqnxZYEG1ENQ
Ws1NRU/73vNPPslDaqse7OnYnKgVcY9UtU6MdrNURKKMEXHMGKInI8ceyqAzR6B6
ky2wxdXGyza2A3rkpvsACmkznbSIxwZ/Th1H5HzDRk9ju2UGQ9Hn20qzkwNgpr+6
W8bTxU3MNfj2i1J8PlcyXxjhOmhpTv0CYcSNjzN3BeKpIW+8htXWVWKanhKYE3Dr
1fCw903ufMtiILk6zyKQg0NJuxiYj71F0CgWH6KPxISUBvEOhIYsgcADQDnpR3Ai
H25UXTS70YGhDw4qaG9ImJkX1Itpn4//whz21cDWS0efTPhmWXo=
=L/kb
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
