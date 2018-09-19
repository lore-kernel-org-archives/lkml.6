Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025DFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCB62150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCB62150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbeITC7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:59:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60690 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732760AbeITC7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:59:06 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BD5211047;
        Wed, 19 Sep 2018 21:18:49 +0000 (UTC)
Date:   Wed, 19 Sep 2018 23:18:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.9
Message-ID: <20180919211847.GA9401@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.9 kernel.

All users of the 4.18 kernel series must upgrade.

The updated 4.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                          |    2=
=20
 arch/arc/boot/dts/axs10x_mb.dtsi                                  |    7=
=20
 arch/arc/boot/dts/hsdk.dts                                        |    7=
=20
 arch/arc/configs/axs101_defconfig                                 |    1=
=20
 arch/arc/configs/axs103_defconfig                                 |    1=
=20
 arch/arc/configs/axs103_smp_defconfig                             |    1=
=20
 arch/arm64/kvm/hyp/switch.c                                       |    9 -
 arch/mips/boot/dts/mscc/ocelot.dtsi                               |    2=
=20
 arch/mips/cavium-octeon/octeon-platform.c                         |    2=
=20
 arch/mips/generic/init.c                                          |    1=
=20
 arch/mips/include/asm/io.h                                        |    8 -
 arch/mips/kernel/vdso.c                                           |   20 ++
 arch/mips/mm/c-r4k.c                                              |    6=
=20
 arch/powerpc/include/asm/book3s/64/pgalloc.h                      |   23 +=
+-
 arch/powerpc/kvm/book3s_64_mmu_radix.c                            |    6=
=20
 arch/powerpc/platforms/4xx/msi.c                                  |   51 +=
+++--
 arch/powerpc/platforms/powernv/npu-dma.c                          |    5=
=20
 arch/powerpc/platforms/pseries/setup.c                            |   25 +=
+-
 arch/s390/kvm/vsie.c                                              |    3=
=20
 arch/x86/include/asm/kdebug.h                                     |   12 +
 arch/x86/include/asm/kvm_host.h                                   |   16 +-
 arch/x86/kernel/apic/vector.c                                     |    2=
=20
 arch/x86/kernel/cpu/microcode/amd.c                               |   24 +=
+-
 arch/x86/kernel/cpu/microcode/intel.c                             |   17 +-
 arch/x86/kernel/dumpstack.c                                       |   11 -
 arch/x86/kernel/process_32.c                                      |    4=
=20
 arch/x86/kernel/process_64.c                                      |   12 +
 arch/x86/kvm/mmu.c                                                |   21 ++
 arch/x86/kvm/svm.c                                                |    4=
=20
 arch/x86/kvm/vmx.c                                                |    4=
=20
 arch/x86/kvm/x86.c                                                |   10 +
 arch/x86/mm/fault.c                                               |    2=
=20
 block/bfq-cgroup.c                                                |    4=
=20
 block/blk-core.c                                                  |    5=
=20
 block/blk-mq-tag.c                                                |    8 -
 block/partitions/aix.c                                            |   13 +
 drivers/acpi/acpi_lpss.c                                          |    2=
=20
 drivers/android/binder_alloc.c                                    |   43 +=
+++-
 drivers/ata/libahci.c                                             |   20 +-
 drivers/base/memory.c                                             |   20 +-
 drivers/block/nbd.c                                               |    3=
=20
 drivers/block/pktcdvd.c                                           |    4=
=20
 drivers/bluetooth/Kconfig                                         |    1=
=20
 drivers/char/tpm/tpm_i2c_infineon.c                               |    8 -
 drivers/char/tpm/tpm_tis_spi.c                                    |    9 +
 drivers/clk/clk-scmi.c                                            |    5=
=20
 drivers/dax/pmem.c                                                |   12 +
 drivers/firmware/google/vpd.c                                     |    5=
=20
 drivers/gpio/gpio-ml-ioh.c                                        |    3=
=20
 drivers/gpio/gpio-pxa.c                                           |   35 +=
++-
 drivers/gpio/gpio-tegra.c                                         |    2=
=20
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c                     |   38 +=
++--
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h                      |    2=
=20
 drivers/gpu/ipu-v3/ipu-common.c                                   |    2=
=20
 drivers/hid/hid-ids.h                                             |    1=
=20
 drivers/hid/hid-input.c                                           |    5=
=20
 drivers/hid/hid-multitouch.c                                      |   19 ++
 drivers/hid/i2c-hid/i2c-hid.c                                     |    2=
=20
 drivers/hv/hv.c                                                   |   14 +
 drivers/i2c/busses/i2c-aspeed.c                                   |    2=
=20
 drivers/i2c/busses/i2c-i801.c                                     |    7=
=20
 drivers/i2c/busses/i2c-xiic.c                                     |    4=
=20
 drivers/infiniband/core/cma.c                                     |   13 +
 drivers/infiniband/hw/hns/hns_roce_hem.c                          |    3=
=20
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                        |   12 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h                        |    6=
=20
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c                    |    1=
=20
 drivers/input/touchscreen/atmel_mxt_ts.c                          |    7=
=20
 drivers/iommu/arm-smmu-v3.c                                       |   22 +=
+-
 drivers/iommu/ipmmu-vmsa.c                                        |    9 -
 drivers/macintosh/via-pmu.c                                       |    9 -
 drivers/md/dm-cache-target.c                                      |   19 ++
 drivers/md/raid5.c                                                |    6=
=20
 drivers/media/dvb-frontends/helene.c                              |    5=
=20
 drivers/media/platform/davinci/vpif_display.c                     |   24 +=
+-
 drivers/media/platform/qcom/camss-8x16/camss-csid.c               |   16 +-
 drivers/media/platform/rcar-vin/rcar-csi2.c                       |   20 +-
 drivers/media/platform/s5p-mfc/s5p_mfc.c                          |   23 +=
--
 drivers/media/usb/dvb-usb/dw2102.c                                |   19 +-
 drivers/media/usb/em28xx/em28xx-cards.c                           |    4=
=20
 drivers/media/usb/em28xx/em28xx-core.c                            |    4=
=20
 drivers/media/usb/em28xx/em28xx-dvb.c                             |    4=
=20
 drivers/memory/ti-aemif.c                                         |    2=
=20
 drivers/mfd/rave-sp.c                                             |    7=
=20
 drivers/mfd/ti_am335x_tscadc.c                                    |    3=
=20
 drivers/misc/mic/scif/scif_api.c                                  |   20 +-
 drivers/misc/ti-st/st_kim.c                                       |    4=
=20
 drivers/mtd/nand/raw/nand_base.c                                  |   44 +=
++---
 drivers/net/ethernet/marvell/mvneta.c                             |    1=
=20
 drivers/net/phy/mdio-mux-bcm-iproc.c                              |   20 ++
 drivers/net/wireless/ath/ath10k/mac.c                             |    7=
=20
 drivers/net/wireless/ath/ath10k/wmi-tlv.c                         |    5=
=20
 drivers/net/wireless/ath/ath10k/wmi-tlv.h                         |    5=
=20
 drivers/net/wireless/ath/ath9k/hw.c                               |    7=
=20
 drivers/net/wireless/ath/ath9k/xmit.c                             |    3=
=20
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                     |    4=
=20
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                   |   24 +=
--
 drivers/net/wireless/ti/wlcore/rx.c                               |    8 -
 drivers/pci/controller/pcie-mobiveil.c                            |    4=
=20
 drivers/pci/switch/switchtec.c                                    |    4=
=20
 drivers/pinctrl/berlin/berlin.c                                   |   14 +
 drivers/pinctrl/freescale/pinctrl-imx.c                           |    2=
=20
 drivers/pinctrl/pinctrl-amd.c                                     |    3=
=20
 drivers/regulator/tps65217-regulator.c                            |    2=
=20
 drivers/rpmsg/rpmsg_core.c                                        |    7=
=20
 drivers/scsi/3w-9xxx.c                                            |    6=
=20
 drivers/scsi/3w-sas.c                                             |    3=
=20
 drivers/scsi/3w-xxxx.c                                            |    2=
=20
 drivers/scsi/lpfc/lpfc.h                                          |    2=
=20
 drivers/scsi/lpfc/lpfc_nvme.c                                     |   22 +=
--
 drivers/scsi/qla2xxx/qla_init.c                                   |    9 -
 drivers/scsi/qla2xxx/qla_target.c                                 |    3=
=20
 drivers/scsi/qla2xxx/qla_tmpl.c                                   |    9 +
 drivers/target/target_core_transport.c                            |    5=
=20
 drivers/target/target_core_user.c                                 |   73 +=
++++-----
 drivers/thermal/rcar_thermal.c                                    |    2=
=20
 drivers/thermal/thermal_hwmon.c                                   |    1=
=20
 drivers/tty/rocket.c                                              |    2=
=20
 drivers/uio/uio.c                                                 |   19 --
 fs/autofs/autofs_i.h                                              |    4=
=20
 fs/autofs/inode.c                                                 |    1=
=20
 fs/btrfs/extent-tree.c                                            |   17 +-
 fs/btrfs/ioctl.c                                                  |   19 ++
 fs/cifs/connect.c                                                 |    2=
=20
 fs/cifs/inode.c                                                   |    2=
=20
 fs/cifs/smb2ops.c                                                 |   35 +=
++-
 fs/cifs/smb2pdu.c                                                 |    3=
=20
 fs/f2fs/f2fs.h                                                    |   15 +-
 fs/f2fs/file.c                                                    |    2=
=20
 fs/f2fs/gc.c                                                      |    8 -
 fs/f2fs/inline.c                                                  |   22 +=
++
 fs/f2fs/inode.c                                                   |   19 ++
 fs/f2fs/node.c                                                    |   46 +=
+++--
 fs/f2fs/recovery.c                                                |    4=
=20
 fs/f2fs/segment.c                                                 |   20 ++
 fs/f2fs/segment.h                                                 |    3=
=20
 fs/f2fs/super.c                                                   |   25 +=
+-
 fs/f2fs/sysfs.c                                                   |   16 +-
 fs/nfs/callback_proc.c                                            |    4=
=20
 fs/nfs/callback_xdr.c                                             |   11 +
 fs/nfs/nfs4client.c                                               |    6=
=20
 include/linux/hid.h                                               |    1=
=20
 include/linux/mm_types.h                                          |    2=
=20
 include/linux/mm_types_task.h                                     |    2=
=20
 include/linux/mtd/rawnand.h                                       |   16 +-
 include/linux/vm_event_item.h                                     |    1=
=20
 include/linux/vmacache.h                                          |    5=
=20
 include/uapi/linux/ethtool.h                                      |    4=
=20
 kernel/cpu.c                                                      |   11 -
 kernel/time/clocksource.c                                         |   40 +=
+++-
 kernel/time/timer.c                                               |   29 +=
+-
 mm/debug.c                                                        |    4=
=20
 mm/memory_hotplug.c                                               |    3=
=20
 mm/page_alloc.c                                                   |    4=
=20
 mm/vmacache.c                                                     |   38 -=
----
 net/bluetooth/hidp/core.c                                         |    2=
=20
 net/dcb/dcbnl.c                                                   |   11 -
 net/mac80211/rx.c                                                 |    1=
=20
 sound/pci/hda/hda_codec.c                                         |    3=
=20
 sound/pci/hda/patch_realtek.c                                     |    1=
=20
 sound/soc/soc-pcm.c                                               |    5=
=20
 tools/perf/Makefile.config                                        |    4=
=20
 tools/perf/builtin-c2c.c                                          |    3=
=20
 tools/perf/perf.h                                                 |    2=
=20
 tools/perf/util/evsel.c                                           |   14 +
 tools/testing/nvdimm/pmem-dax.c                                   |   12 +
 tools/testing/selftests/bpf/test_verifier.c                       |    6=
=20
 tools/testing/selftests/tc-testing/tc-tests/actions/connmark.json |   24 +=
--
 tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json   |    3=
=20
 virt/kvm/arm/mmu.c                                                |    9 +
 170 files changed, 1166 insertions(+), 579 deletions(-)

AceLan Kao (1):
      HID: i2c-hid: Fix flooded incomplete report after S3 on Rayd touchscr=
een

Akshu Agrawal (1):
      ASoC: soc-pcm: Use delay set in component pointer function

Alexandru Gagniuc (1):
      ALSA: hda/realtek - Add mute LED quirk for HP Spectre x360

Alexey Brodkin (2):
      ARC: [plat-axs*/plat-hsdk]: Allow U-Boot to pass MAC-address to the k=
ernel
      ARC: [plat-axs*]: Enable SWAP

Amit Daniel Kachhap (1):
      clk: scmi: Fix the rounding of clock rate

Andrey Smirnov (1):
      mfd: rave-sp: Initialize flow control and parity of the port

Aneesh Kumar K.V (1):
      mm/hugetlb: filter out hugetlb pages if HUGEPAGE migration is not sup=
ported.

Anthony Koo (1):
      drm/amd/display: Prevent PSR from being enabled if initialization fai=
ls

Anton Vasilyev (8):
      media: davinci: vpif_display: Mix memory leak on probe error path
      media: dw2102: Fix memleak on sequence of probes
      misc: ti-st: Fix memory leak in the error path of probe()
      firmware: vpd: Fix section enabled flag on vpd_section_destroy
      tty: rocket: Fix possible buffer overwrite on register_PCI
      scsi: 3ware: fix return 0 on the error path of probe
      regulator: tps65217: Fix NULL pointer dereference on probe
      gpio: ml-ioh: Fix buffer underwrite on probe error path

Arun Parameswaran (1):
      net: phy: Fix the register offsets in Broadcom iProc mdio mux driver

Bartosz Golaszewski (1):
      memory: ti-aemif: fix a potential NULL-pointer dereference

Benjamin Tissoires (2):
      HID: multitouch: fix Elan panels with 2 input modes declaration
      HID: core: fix grouping by application

BingJing Chang (1):
      md/raid5: fix data corruption of replacements after originals dropped

Brad Love (2):
      media: em28xx: Fix dual transport stream operation
      media: em28xx: Fix DualHD disconnect oops

Calum Mackay (1):
      nfs: Referrals not inheriting proto setting from parent

Chao Yu (10):
      f2fs: fix to active page in lru list for read path
      f2fs: fix to detect looped node chain correctly
      f2fs: try grabbing node page lock aggressively in sync scenario
      f2fs: fix to skip GC if type in SSA and SIT is inconsistent
      f2fs: fix to do sanity check with reserved blkaddr of inline inode
      f2fs: fix to wait on page writeback before updating page
      f2fs: fix to do sanity check with secs_per_zone
      f2fs: fix to do sanity check with {sit,nat}_ver_bitmap_bytesize
      f2fs: fix to propagate return value of scan_nat_page()
      f2fs: fix to do sanity check with extra_attr feature

Christophe Leroy (1):
      perf tools: Allow overriding MAX_NR_CPUS at compile time

Dan Carpenter (4):
      misc: mic: SCIF Fix scif_get_new_port() error handling
      uio: potential double frees if __uio_register_device() fails
      pinctrl: imx: off by one in imx_pinconf_group_dbg_show()
      f2fs: Fix uninitialized return in f2fs_ioc_shutdown()

Daniel Kurtz (1):
      pinctrl/amd: only handle irq if it is pending and unmasked

Daniel Mack (1):
      gpio: pxa: disable pinctrl calls for PXA3xx

Daniel Rosenberg (1):
      f2fs: Keep alloc_valid_block_count in sync

Denis Drozdov (1):
      IB/IPoIB: Set ah valid flag in multicast send flow

Dmitry Osipenko (1):
      gpio: tegra: Move driver registration to subsys_init level

Emmanuel Grumbach (2):
      mac80211: don't update the PM state of a peer upon a multicast frame
      iwlwifi: pcie: don't access periphery registers when not available

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

Gaurav Kohli (1):
      timers: Clear timer_base::must_forward_clk with timer_base::lock held

Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Fix allocation in atomic context

Greg Kroah-Hartman (1):
      Linux 4.18.9

Guenter Roeck (1):
      powerpc/4xx: Fix error return path in ppc4xx_msi_probe()

Gustavo A. R. Silva (1):
      switchtec: Fix Spectre v1 vulnerability

Huaisheng Ye (1):
      tools/testing/nvdimm: kaddr and pfn can be NULL to ->direct_access()

Ian Kent (1):
      autofs: fix autofs_sbi() does not check super block type

Jae Hyun Yoo (1):
      i2c: aspeed: Add an explicit type casting for *get_clk_reg_val

Jaegeuk Kim (1):
      f2fs: avoid potential deadlock in f2fs_sbi_store

James Smart (2):
      scsi: lpfc: Correct MDS diag and nvmet configuration
      scsi: lpfc: Fix driver crash when re-registering NVME rports.

Jann Horn (1):
      x86/process: Don't mix user/kernel regs in 64bit __show_regs()

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

Konstantin Khlebnikov (1):
      block: bfq: swap puts in bfqg_and_blkg_put

Lijun Ou (2):
      RDMA/hns: Add illegal hop_num judgement
      RDMA/hns: Update the data type of immediate data

Linus Torvalds (1):
      mm: get rid of vmacache_flush_all() entirely

Linus Walleij (1):
      tpm_tis_spi: Pass the SPI IRQ down to the driver

Loic Poulain (1):
      wlcore: Set rx_status boottime_ns field on rx

Lorenzo Pieralisi (2):
      PCI: mobiveil: Add missing ../pci.h include
      PCI: mobiveil: Fix struct mobiveil_pcie.pcie_reg_base address type

Lu Fengqi (1):
      btrfs: fix qgroup_free wrong num_bytes in btrfs_subvolume_reserve_met=
adata

Marc Zyngier (3):
      arm64: KVM: Only force FPEXC32_EL2.EN if trapping FPSIMD
      KVM: arm/arm64: Clean dcache to PoC when changing PTE due to CoW
      thermal_hwmon: Sanitize attribute name passed to hwmon

Marcel Holtmann (1):
      Bluetooth: hidp: Fix handling of strncpy for hid->name information

Mauricio Faria de Oliveira (2):
      partitions/aix: append null character to print data from disk
      partitions/aix: fix usage of uninitialized lv_info and lvname structu=
res

Michael Ellerman (1):
      powerpc/mm: Don't report PUDs as memory leaks when using kmemleak

Michael Kelley (1):
      Drivers: hv: vmbus: Cleanup synic memory free path

Mike Christie (2):
      scsi: target: fix __transport_register_session locking
      scsi: tcmu: do not set max_blocks if data_bitmap has been setup

Mikhail Zaslonko (1):
      memory_hotplug: fix kernel_panic on offline page processing

Mikulas Patocka (1):
      block: don't warn when doing fsync on read-only devices

Minchan Kim (1):
      android: binder: fix the race mmap and alloc_new_buf_locked

Ming Lei (1):
      blk-mq: fix updating tags depth

Miquel Raynal (1):
      mtd: rawnand: make subop helpers return unsigned values

Neeraj Upadhyay (1):
      cpu/hotplug: Adjust misplaced smb() in cpuhp_thread_fun()

Nicholas Mc Guire (2):
      MIPS: Octeon: add missing of_node_put()
      MIPS: generic: fix missing of_node_put()

Nick Dyer (1):
      Input: atmel_mxt_ts - only use first T9 instance

Niklas S=F6derlund (1):
      media: rcar-csi2: update stream start for V3M

Olga Kornievskaia (1):
      NFSv4.0 fix client reference leak in callback

Parav Pandit (1):
      RDMA/cma: Do not ignore net namespace for unbound cm_id

Paul Burton (3):
      MIPS: VDSO: Match data page cache colouring when D$ aliases
      MIPS: Fix ISA virt/bus conversion for non-zero PHYS_OFFSET
      MIPS: WARN_ON invalid DMA cache maintenance, not BUG_ON

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Use correct pagesize in kvm_unmap_radix()

Peter Rosin (1):
      tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Peter Zijlstra (1):
      clocksource: Revert "Remove kthread"

Petr Machata (1):
      net: dcb: For wild-card lookups, use priority -1, not 0

Philipp Zabel (1):
      gpu: ipu-v3: default to id 0 on missing OF alias

Pierre Morel (1):
      KVM: s390: vsie: copy wrapping keys to right place

Prarit Bhargava (1):
      x86/microcode: Make sure boot_cpu_data.microcode is up-to-date

Quentin Schulz (1):
      MIPS: mscc: ocelot: fix length of memory address space for MIIM

Quinn Tran (3):
      scsi: qla2xxx: Fix unintended Logout
      scsi: qla2xxx: Fix session state stuck in Get Port DB
      scsi: qla2xxx: Silent erroneous message

Randy Dunlap (1):
      f2fs: fix defined but not used build warnings

Reza Arbab (1):
      powerpc/powernv: Fix concurrency issue with npu->mmio_atsd_usage

Robert Schlabbach (1):
      media: em28xx: explicitly disable TS packet filter

Roman Gushchin (1):
      selftests/bpf: fix a typo in map in map test

Sam Bobroff (1):
      powerpc/pseries: fix EEH recovery of some IOV devices

Sean Christopherson (6):
      KVM: x86: SVM: Set EMULTYPE_NO_REEXECUTE for RSM emulation
      KVM: VMX: Do not allow reexecute_instruction() when skipping MMIO ins=
tr
      KVM: x86: Invert emulation re-execute behavior to make it opt-in
      KVM: x86: Merge EMULTYPE_RETRY and EMULTYPE_ALLOW_REEXECUTE
      KVM: x86: Default to not allowing emulation retry in kvm_mmu_page_fau=
lt
      KVM: x86: Do not re-{try,execute} after failed emulation in L2

Shubhrajyoti Datta (1):
      i2c: xiic: Make the start and the byte count write atomic

Simon Horman (1):
      thermal: rcar_thermal: avoid NULL dereference in absence of IRQ resou=
rces

Srinivas Kandagatla (1):
      rpmsg: core: add support to power domains for devices

Srinivas Pandruvada (2):
      ata: libahci: Allow reconfigure of DEVSLP register
      ata: libahci: Correct setting of DEVSLP register

Stefan Agner (1):
      HID: input: fix leaking custom input node name

Stefan Hajnoczi (1):
      device-dax: avoid hang on error before devm_memremap_pages()

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

Takashi Iwai (1):
      ALSA: hda - Fix cancel_work_sync() stall from jackpoll work

Thomas Gleixner (2):
      cpu/hotplug: Prevent state corruption on error rollback
      x86/apic/vector: Make error return value negative

Thomas Richter (1):
      perf build: Fix installation directory for eBPF

Thomas Werschlein (1):
      cifs: connect to servername instead of IP for IPC$ share

Todor Tomov (1):
      media: camss: csid: Configure data type and decode format properly

Trond Myklebust (1):
      NFSv4.1: Fix a potential layoutget/layoutrecall deadlock

Vlad Buslov (2):
      tc-testing: flush gact actions on test teardown
      tc-testing: remove duplicate spaces in connmark match patterns

Will Deacon (1):
      iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump=
 kernel

Xiubo Li (1):
      uio: fix possible circular locking dependency

Yelena Krivosheev (1):
      net: mvneta: fix mtu change on port without link

YueHaibing (1):
      pinctrl: berlin: fix 'pctrl->functions' allocation in berlin_pinctrl_=
build_state

Yunlong Song (2):
      f2fs: do not set free of current section
      f2fs: issue discard align to section in LFS mode

Zhang Rui (1):
      ACPI / LPSS: Force LPSS quirks on boot

Zumeng Chen (1):
      mfd: ti_am335x_tscadc: Fix struct clk memory leak


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluivTQACgkQONu9yGCS
aT6c6BAA1u2X2f3uZUBde87nk/eLNfR4WeJ58fmnZ8dhl48oA1TKy/PtSm47RFTi
dSD5HwP/2UuSQNA8OalERCVg5VsTx3BTUOggZjw1doIyrHpeL7p71QELKGyVM68/
ENsZm8FW7kcGWyuEygA2clzGa+oSybM0Jp14KkYKjFliDTkHsaPijivuhVwWsY6p
7LfWb8oWFXZ4wCTBm+eiII2LxLS3iceutijPizlvVzWvfCcAwbOrgGcfz3pJXTk5
jU0sCgOCkeCP1IJMUpr+3U44GC8NriJcjJPyRNRnbUE/nwQsuszhqtrcirWlfu4g
St+brQkBdIYVzZxld8fxiGt+QXexBwkUHIhilODF1AV0w/D0BK+1+9iN7OQaUgnT
fLl9fEhD6Vn6zMO9EyB5npBZJcN1F7j61BpJXCNdriaI6DoAH9SrWS7GTvPCoBi5
Rux4MEqsvV8cW8bPlWlgYta3hW2bOksiZXL+8h/3oxQ8CND823tDx6E/Mqrk9hqd
1GAQVmyoNEjW0XeO2dpO7I0YcnqYFWWoNnx5uPbK17cWFZVQzlylKR4Ajv2O8GEq
1kzCcN5GZRvAh4rOpDwNsEvUfXWSudrcbnMt9v/tvO8TOlNIhcPViruRDuZmSuZ8
hGFyeOAVINURuBY3+GUswuaeGcU8nwNe2U5SArq/malGW/1Gu7o=
=NWb/
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
