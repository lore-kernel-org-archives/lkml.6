Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E2DC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DF120652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DF120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJDWq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:46:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeJDWq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:46:27 -0400
Received: from localhost (unknown [104.132.1.111])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2F87A481;
        Thu,  4 Oct 2018 15:52:32 +0000 (UTC)
Date:   Thu, 4 Oct 2018 08:52:31 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.74
Message-ID: <20181004155231.GA7673@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.74 kernel.

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

 Documentation/hwmon/ina2xx                                       |    2=20
 Makefile                                                         |    2=20
 arch/arm/boot/dts/dra7.dtsi                                      |    4=20
 arch/arm/boot/dts/imx7d.dtsi                                     |   12=20
 arch/arm/boot/dts/ls1021a.dtsi                                   |    1=20
 arch/arm/boot/dts/mt7623.dtsi                                    |    3=20
 arch/arm/boot/dts/omap4-droid4-xt894.dts                         |    2=20
 arch/arm/mach-mvebu/pmsu.c                                       |    6=20
 arch/arm/mach-omap2/omap_hwmod_reset.c                           |   12=20
 arch/arm64/include/asm/kvm_emulate.h                             |    5=20
 arch/arm64/kvm/guest.c                                           |   55 ++
 arch/mips/boot/Makefile                                          |    6=20
 arch/powerpc/kernel/machine_kexec.c                              |    7=20
 arch/powerpc/platforms/powernv/pci-ioda.c                        |    2=20
 arch/s390/kernel/sysinfo.c                                       |    4=20
 arch/s390/mm/extmem.c                                            |    4=20
 arch/s390/mm/pgalloc.c                                           |    2=20
 arch/x86/entry/entry_64.S                                        |    4=20
 arch/x86/events/intel/lbr.c                                      |   32 +
 arch/x86/events/perf_event.h                                     |    1=20
 arch/x86/include/asm/fixmap.h                                    |   10=20
 arch/x86/include/asm/pgtable_64.h                                |    3=20
 arch/x86/kernel/head64.c                                         |    4=20
 arch/x86/kernel/head_64.S                                        |   16=20
 arch/x86/kernel/tsc_msr.c                                        |    1=20
 arch/x86/mm/numa_emulation.c                                     |    2=20
 arch/x86/mm/pgtable.c                                            |    9=20
 arch/x86/mm/pti.c                                                |    2=20
 arch/x86/xen/mmu_pv.c                                            |    8=20
 crypto/ablkcipher.c                                              |    2=20
 crypto/blkcipher.c                                               |    1=20
 drivers/ata/pata_ftide010.c                                      |   27 -
 drivers/block/floppy.c                                           |    3=20
 drivers/bluetooth/btusb.c                                        |    1=20
 drivers/crypto/cavium/nitrox/nitrox_dev.h                        |    3=20
 drivers/crypto/cavium/nitrox/nitrox_lib.c                        |    1=20
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c                     |   57 +--
 drivers/edac/edac_mc_sysfs.c                                     |    6=20
 drivers/edac/i7core_edac.c                                       |   22 -
 drivers/gpio/gpio-menz127.c                                      |    4=20
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                            |   11=20
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                              |    4=20
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                              |    3=20
 drivers/gpu/drm/i915/i915_gem.c                                  |    3=20
 drivers/gpu/drm/i915/i915_vma.c                                  |    4=20
 drivers/gpu/drm/sun4i/sun4i_drv.c                                |    3=20
 drivers/hid/hid-ntrig.c                                          |    2=20
 drivers/hwmon/adt7475.c                                          |   14=20
 drivers/hwmon/ina2xx.c                                           |   13=20
 drivers/hwtracing/intel_th/core.c                                |    3=20
 drivers/i2c/busses/i2c-i801.c                                    |    9=20
 drivers/iio/accel/adxl345_core.c                                 |   21 -
 drivers/iio/adc/ina2xx-adc.c                                     |   17=20
 drivers/iio/counter/104-quad-8.c                                 |    2=20
 drivers/infiniband/core/rw.c                                     |    2=20
 drivers/infiniband/core/uverbs_main.c                            |    1=20
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                         |    4=20
 drivers/infiniband/hw/hfi1/pio.c                                 |    9=20
 drivers/infiniband/hw/hfi1/user_sdma.c                           |    2=20
 drivers/infiniband/hw/hfi1/verbs.c                               |    8=20
 drivers/infiniband/hw/i40iw/i40iw_verbs.c                        |    2=20
 drivers/infiniband/hw/mlx4/qp.c                                  |    2=20
 drivers/infiniband/ulp/srp/ib_srp.c                              |    6=20
 drivers/input/misc/xen-kbdfront.c                                |    8=20
 drivers/input/mouse/elantech.c                                   |    2=20
 drivers/iommu/amd_iommu.c                                        |    2=20
 drivers/iommu/msm_iommu.c                                        |   16=20
 drivers/md/md-cluster.c                                          |   19 -
 drivers/media/i2c/soc_camera/ov772x.c                            |    2=20
 drivers/media/platform/exynos4-is/fimc-isp-video.c               |   11=20
 drivers/media/platform/fsl-viu.c                                 |   38 +-
 drivers/media/platform/omap3isp/isp.c                            |    2=20
 drivers/media/platform/s3c-camif/camif-capture.c                 |    2=20
 drivers/media/usb/tm6000/tm6000-dvb.c                            |    5=20
 drivers/media/usb/uvc/uvc_video.c                                |   24 -
 drivers/media/v4l2-core/v4l2-event.c                             |   38 +-
 drivers/media/v4l2-core/v4l2-fh.c                                |    2=20
 drivers/misc/sram.c                                              |   13=20
 drivers/misc/tsl2550.c                                           |    2=20
 drivers/misc/vmw_vmci/vmci_queue_pair.c                          |    4=20
 drivers/mtd/nand/atmel/nand-controller.c                         |    7=20
 drivers/net/ethernet/hisilicon/hns/hnae.h                        |    6=20
 drivers/net/ethernet/hisilicon/hns/hns_enet.c                    |    2=20
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c                 |    7=20
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                        |  187 ++=
++++++--
 drivers/net/ethernet/qlogic/qed/qed_mcp.h                        |   27 -
 drivers/net/ethernet/qlogic/qed/qed_reg_addr.h                   |    2=20
 drivers/net/phy/xilinx_gmii2rgmii.c                              |   10=20
 drivers/net/wireless/ath/ath10k/htt_rx.c                         |    5=20
 drivers/net/wireless/ath/ath10k/mac.c                            |    1=20
 drivers/net/wireless/ath/ath10k/sdio.c                           |    9=20
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c |    2=20
 drivers/net/wireless/rndis_wlan.c                                |    2=20
 drivers/net/wireless/ti/wlcore/cmd.c                             |    6=20
 drivers/nvme/target/fcloop.c                                     |    3=20
 drivers/power/reset/vexpress-poweroff.c                          |   12=20
 drivers/power/supply/axp288_charger.c                            |    2=20
 drivers/power/supply/power_supply_core.c                         |   11=20
 drivers/regulator/core.c                                         |    2=20
 drivers/s390/block/dasd.c                                        |    1=20
 drivers/s390/block/scm_blk.c                                     |    1=20
 drivers/scsi/bnx2i/bnx2i_hwi.c                                   |    2=20
 drivers/scsi/ibmvscsi/ibmvscsi.c                                 |    4=20
 drivers/scsi/megaraid/megaraid_sas_base.c                        |    3=20
 drivers/spi/spi-rspi.c                                           |   34 +
 drivers/spi/spi-sh-msiof.c                                       |   28 +
 drivers/spi/spi-tegra20-slink.c                                  |   31 +
 drivers/staging/android/ashmem.c                                 |    6=20
 drivers/staging/media/imx/imx-ic-prpencvf.c                      |    1=20
 drivers/staging/media/imx/imx-media-csi.c                        |    1=20
 drivers/staging/rts5208/sd.c                                     |    2=20
 drivers/target/iscsi/iscsi_target_tpg.c                          |    3=20
 drivers/target/target_core_device.c                              |   22 -
 drivers/thermal/of-thermal.c                                     |    7=20
 drivers/tty/serial/8250/serial_cs.c                              |    6=20
 drivers/tty/serial/cpm_uart/cpm_uart_core.c                      |   10=20
 drivers/tty/serial/fsl_lpuart.c                                  |    3=20
 drivers/tty/serial/imx.c                                         |    8=20
 drivers/tty/serial/sh-sci.c                                      |    2=20
 drivers/usb/class/cdc-wdm.c                                      |    2=20
 drivers/usb/core/devio.c                                         |   24 +
 drivers/usb/core/driver.c                                        |   28 -
 drivers/usb/core/usb.c                                           |    2=20
 drivers/usb/musb/musb_dsps.c                                     |   12=20
 drivers/usb/serial/kobil_sct.c                                   |   12=20
 drivers/usb/wusbcore/security.c                                  |    2=20
 drivers/uwb/hwa-rc.c                                             |    1=20
 fs/iomap.c                                                       |   21 -
 fs/isofs/inode.c                                                 |    7=20
 fs/locks.c                                                       |    7=20
 fs/nfsd/nfs4proc.c                                               |    1=20
 fs/overlayfs/inode.c                                             |   62 ++-
 include/linux/arm-smccc.h                                        |   38 +-
 include/linux/platform_data/ina2xx.h                             |    2=20
 include/linux/posix-timers.h                                     |    4=20
 include/linux/power_supply.h                                     |    1=20
 include/linux/slub_def.h                                         |    3=20
 include/media/v4l2-fh.h                                          |    4=20
 kernel/bpf/sockmap.c                                             |    3=20
 kernel/module.c                                                  |    6=20
 kernel/time/alarmtimer.c                                         |    7=20
 kernel/time/posix-cpu-timers.c                                   |    2=20
 kernel/time/posix-timers.c                                       |   33 +
 kernel/time/posix-timers.h                                       |    2=20
 lib/klist.c                                                      |   10=20
 mm/slub.c                                                        |    6=20
 net/6lowpan/iphc.c                                               |    1=20
 net/tls/tls_main.c                                               |    9=20
 sound/aoa/core/gpio-feature.c                                    |    4=20
 sound/pci/hda/hda_intel.c                                        |    3=20
 sound/soc/soc-dapm.c                                             |    7=20
 151 files changed, 1079 insertions(+), 408 deletions(-)

Aaron Ma (1):
      Input: elantech - enable middle button of touchpad on ThinkPad P72

Akinobu Mita (4):
      iio: adc: ina2xx: avoid kthread_stop() with stale task_struct
      iio: accel: adxl345: convert address field usage in iio_chan_spec
      media: s3c-camif: ignore -ENOIOCTLCMD from v4l2_subdev_call for s_pow=
er
      media: soc_camera: ov772x: correct setting of banding filter

Alagu Sankar (2):
      ath10k: sdio: use same endpoint id for all packets in a bundle
      ath10k: sdio: set skb len for all rx packets

Alan Stern (3):
      USB: fix error handling in usb_driver_claim_interface()
      USB: handle NULL config in usb_find_alt_setting()
      USB: remove LPM management from usb_driver_claim_interface()

Alexander Shishkin (1):
      intel_th: Fix device removal logic

Alexey Dobriyan (1):
      slub: make ->cpu_partial unsigned int

Alexey Kardashevskiy (1):
      powerpc/powernv/ioda2: Reduce upper limit for DMA window size

Alexey Khoroshilov (1):
      media: fsl-viu: fix error handling in viu_of_probe()

Alistair Strachan (1):
      staging: android: ashmem: Fix mmap size validation

Amir Goldstein (1):
      ovl: hash non-dir by lower inode for fsnotify

Andreas Gruenbacher (1):
      iomap: complete partial direct I/O writes synchronously

Andy Shevchenko (1):
      x86/tsc: Add missing header to tsc_msr.c

Andy Whitcroft (1):
      floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl

Anson Huang (1):
      thermal: of-thermal: disable passive polling when thermal zone is dis=
abled

Anton Vasilyev (1):
      uwb: hwa-rc: fix memory leak at probe

Bart Van Assche (4):
      scsi: target/iscsi: Make iscsit_ta_authentication() respect the outpu=
t buffer size
      scsi: klist: Make it safe to use klists in atomic context
      scsi: target: Avoid that EXTENDED COPY commands trigger lock inversion
      IB/srp: Avoid that sg_reset -d ${srp_device} triggers an infinite loop

Ben Greear (1):
      ath10k: protect ath10k_htt_rx_ring_free with rx_ring.lock

Benjamin Tissoires (1):
      power: remove possible deadlock when unregistering power_supply

Bin Liu (1):
      usb: musb: dsps: do not disable CPPI41 irq in driver teardown

Bo Chen (2):
      e1000: check on netif_running() before calling e1000_up()
      e1000: ensure to free old tx/rx rings in set_ringparam()

Brandon Maier (2):
      net: phy: xgmiitorgmii: Check read_status results
      net: phy: xgmiitorgmii: Check phy_driver ready before accessing

Breno Leitao (1):
      scsi: ibmvscsi: Improve strings handling

Chris Wilson (1):
      drm/i915: Remove vma from object on destroy, not close

Christophe Leroy (1):
      serial: cpm_uart: return immediately from console poll

Colin Ian King (1):
      staging: rts5208: fix missing error check on call to rtsx_write_regis=
ter

Dan Carpenter (5):
      vmci: type promotion bug in qp_host_get_user_memory()
      RDMA/bnxt_re: Fix a couple off by one bugs
      IB/core: type promotion bug in rdma_rw_init_one_mr()
      rndis_wlan: potential buffer overflow in rndis_wlan_auth_indication()
      hwmon: (adt7475) Make adt7475_read_word() return errors

Dan Williams (1):
      x86/numa_emulation: Fix emulated-to-physical node mapping

Dave Gerlach (1):
      ARM: hwmod: RTC: Don't assume lock/unlock will be called with irq ena=
bled

Dave Martin (1):
      arm64: KVM: Tighten guest core register access from userspace

Eric Sandeen (1):
      isofs: reject hardware sector size > 2048 bytes

Ethan Tuttle (1):
      ARM: mvebu: declare asm symbols as character arrays in pmsu.c

Feng Tang (1):
      x86/mm: Expand static page table for fixmap space

Gaku Inami (1):
      spi: sh-msiof: Fix invalid SPI use during system suspend

Geert Uytterhoeven (3):
      serial: sh-sci: Stop RX FIFO timer during port shutdown
      spi: rspi: Fix invalid SPI use during system suspend
      spi: rspi: Fix interrupted DMA transfers

Greg Kroah-Hartman (1):
      Linux 4.14.74

Guoqing Jiang (1):
      md-cluster: clear another node's suspend_area after the copy is finis=
hed

Hans de Goede (1):
      power: supply: axp288_charger: Fix initial constant_charge_current va=
lue

Hari Bathini (1):
      powerpc/kdump: Handle crashkernel memory reservation failure

Heiko Carstens (1):
      s390/sysinfo: add missing #ifdef CONFIG_PROC_FS

Hiromitsu Yamasaki (1):
      spi: sh-msiof: Fix handling of write value for SISTR register

Huazhong Tan (2):
      net: hns: fix length and page_offset overflow when CONFIG_ARM64_64K_P=
AGES
      net: hns: fix skb->truesize underestimation

Ira Weiny (1):
      IB/hfi1: Fix SL array bounds check

J. Bruce Fields (1):
      nfsd: fix corrupted reply to badly ordered compound

James Smart (1):
      nvme-fcloop: Fix dropped LS's to removed target port

Jan Beulich (1):
      x86/entry/64: Add two more instruction suffixes

Javier Martinez Canillas (1):
      media: omap3isp: zero-initialize the isp cam_xclk{a,b} initial data

Jernej Skrabec (1):
      drm/sun4i: Fix releasing node when enumerating enpoints

Jessica Yu (1):
      module: exclude SHN_UNDEF symbols from kallsyms api

Jian-Hong Pan (1):
      Bluetooth: Add a new Realtek 8723DE ID 0bda:b009

Johan Hovold (4):
      misc: sram: enable clock before registering regions
      USB: serial: kobil_sct: fix modem-status error handling
      EDAC, i7core: Fix memleaks and use-after-free on probe and remove
      EDAC: Fix memleak in module init error path

John Fastabend (2):
      tls: possible hang when do_tcp_sendpages hits sndbuf is full case
      bpf: sockmap: write_space events need to be passed to TCP handler

Julia Lawall (1):
      usb: wusbcore: security: cast sizeof to int for comparison

Kai-Heng Feng (1):
      ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for AMD Raven Ridge

Kan Liang (1):
      perf/x86/intel/lbr: Fix incomplete LBR call stack

Kevin Hilman (1):
      ARM: dts: dra7: fix DCAN node addresses

Konstantin Khorenko (1):
      fs/lock: skip lock owner pid translation in case we are in init_pid_ns

Leon Romanovsky (1):
      RDMA/i40w: Hold read semaphore while looking after VMA

Leonard Crestez (1):
      Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"

Liam Girdwood (1):
      ASoC: dapm: Fix potential DAI widget pointer deref when linking DAIs

Linus Walleij (1):
      ata: ftide010: Add a quirk for SQ201

Lothar Felten (1):
      hwmon: (ina2xx) fix sysfs shunt resistor read access

Marc Zyngier (3):
      arm/arm64: smccc-1.1: Make return values unsigned long
      arm/arm64: smccc-1.1: Handle function result as parameters
      arm64: KVM: Sanitize PSTATE.M when being set from userspace

Marcel Ziswiler (1):
      spi: tegra20-slink: explicitly enable/disable clock

Masahiro Yamada (1):
      MIPS: boot: fix build rule of vmlinux.its.S

Matt Ranostay (1):
      tsl2550: fix lux1_input error in low light

Michael J. Ruhl (2):
      IB/hfi1: Invalid user input can result in crash
      IB/hfi1: Fix context recovery when PBC has an UnsupportedVL

Michael Scott (1):
      6lowpan: iphc: reset mac_header after decompress to fix panic

Mika Westerberg (1):
      i2c: i801: Allow ACPI AML access I/O ports not reserved for SMBus

Nadav Amit (1):
      gpio: Fix wrong rounding in gpio-menz127

Nicholas Mc Guire (1):
      ALSA: snd-aoa: add of_node_put() in error path

Niklas Cassel (2):
      iommu/msm: Don't call iommu_device_{,un}link from atomic context
      ath10k: transmit queued frames after processing rx packets

Oleksandr Andrushchenko (1):
      Input: xen-kbdfront - fix multi-touch XenStore node's locations

Oliver Neukum (2):
      USB: usbdevfs: sanitize flags more
      USB: usbdevfs: restore warning for nonsensical flags

Peter Rosin (1):
      mtd: rawnand: atmel: add module param to avoid using dma

Peter Seiderer (1):
      media: staging/imx: fill vb2_v4l2_buffer field entry

Randy Dunlap (1):
      x86/pti: Fix section mismatch warning/error

Rex Zhu (2):
      drm/amdgpu: Enable/disable gfx PG feature in rlc safe mode
      drm/amdgpu: Update power state at the end of smu hw_init.

Sakari Ailus (1):
      media: v4l: event: Prevent freeing event subscriptions while accessed

Sebastian Andrzej Siewior (1):
      Revert "usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_ou=
tstanding_interrupt()"

Shivasharan S (1):
      scsi: megaraid_sas: Update controller info during resume

Srikanth Jampala (1):
      crypto: cavium/nitrox - fix for command corruption in queue full case=
 with backlog submissions.

Stafford Horne (1):
      crypto: skcipher - Fix -Wstringop-truncation warnings

Stefan Agner (2):
      brcmsmac: fix wrap around in conversion from constant to s16
      tty: serial: lpuart: avoid leaking struct tty_struct

Steve Wise (1):
      RDMA/uverbs: Atomically flush and mark closed the comp event queue

Sudeep Holla (1):
      power: vexpress: fix corruption in notifier registration

Sylwester Nawrocki (1):
      media: exynos4-is: Prevent NULL pointer dereference in __isp_video_tr=
y_fmt()

Tarick Bedeir (1):
      IB/mlx4: Test port number before querying type.

Thomas Gleixner (3):
      alarmtimer: Prevent overflow for relative nanosleep
      posix-timers: Make forward callback return s64
      posix-timers: Sanitize overrun handling

Tomer Tayar (4):
      qed: Wait for ready indication before rereading the shmem
      qed: Wait for MCP halt and resume commands to take place
      qed: Prevent a possible deadlock during driver load and unload
      qed: Avoid sending mailbox commands when MFW is not responsive

Tony Lindgren (2):
      wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()
      ARM: dts: omap4-droid4: Fix emmc errors seen on some devices

Uwe Kleine-K=F6nig (1):
      serial: imx: restore handshaking irq for imx1

Vasily Gorbik (4):
      s390/mm: correct allocate_pgste proc_handler callback
      s390/dasd: correct numa_node in dasd_alloc_queue
      s390/scm_blk: correct numa_node in scm_blk_dev_setup
      s390/extmem: fix gcc 8 stringop-overflow warning

Viresh Kumar (2):
      ARM: dts: ls1021a: Add missing cooling device properties for CPUs
      arm: dts: mediatek: Add missing cooling device properties for CPUs

William Breathitt Gray (1):
      iio: 104-quad-8: Fix off-by-one error in register selection

Yu Zhao (1):
      regulator: fix crash caused by null driver data

Zhen Lei (1):
      iommu/amd: make sure TLB to be flushed before IOVA freed

Zhouyang Jia (4):
      drivers/tty: add error handling for pcmcia_loop_config
      media: tm6000: add error handling for dvb_register_adapter
      HID: hid-ntrig: add error handling for sysfs_create_group
      scsi: bnx2i: add error handling for ioremap_nocache

ming_qian (1):
      media: uvcvideo: Support realtek's UVC 1.5 device


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlu2Nz8ACgkQONu9yGCS
aT65lBAArloHGMosaGZzMvYcdETT9XJS6J57KZ9yNphAg6VaoWGlDMxQ79ytUTQk
cirTJgZzgF65RKSXK+r/HXj2ZeLrDjoshmPICAlRfTzEMasBaU3aylpf9W+IWaum
B26rKxGrD/HhzlBhBR5LWGjBk2k4Elg+S3LQGPtfr4yeGUC+55a3DPoC0U7wNmXn
gcWqWMke07ZwVcXeQHm+eePYY3H7hpfCW6mimda9gpkCRckeJiinayypU8zix77N
nUYgiGrt2498XuXEV3CDD4dKjVClGhuFOUCO97asd4+yn2+O9v0N9tvlf9wWkzy/
rRr8bRruTnJKyXB+gWJ0dCRxlZ6nuGJaRs4qBb7yYA2CPAatgwSxWEdvdJmDoC5A
2O+Vev+sNmvkgNDemd4zG+c2A2oZ5P36Wjv9AmTzX+3pGcBkVYGt16xidfGKSjrb
QEnnJxDS3oO5S+XnEn0sf4kieprTx4ifwZbwNur863Qz19RXgj0HwKXK4Of3Xl/H
PXHg1Szqwp5cVUEP6CeKMKfoO+lLpCgW1XJzyRpfUOtAROp3pcS4zBzM5q4P2TW5
3LOShtJSOUb8zZBtfVrud9qoZ9uiAlLDfxtn5dhOvhakvaD/rncM9vUYHoCA2gIN
b9jyLukguzYNgm0igf3ZpnXVY/5MHnP07q0HMHXvwcapbMvblxY=
=aFPV
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
