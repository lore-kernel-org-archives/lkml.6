Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19658C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AA520652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AA520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeJDWqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:46:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51752 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeJDWqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:46:01 -0400
Received: from localhost (unknown [104.132.1.111])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90E44486;
        Thu,  4 Oct 2018 15:52:07 +0000 (UTC)
Date:   Thu, 4 Oct 2018 08:52:06 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.131
Message-ID: <20181004155206.GA7559@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.131 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/hwmon/ina2xx                         |    2=20
 Makefile                                           |    2=20
 arch/arm/boot/dts/dra7.dtsi                        |    4=20
 arch/arm/mach-mvebu/pmsu.c                         |    6 -
 arch/arm/mach-omap2/omap_hwmod_reset.c             |   12 +-
 arch/arm64/include/asm/kvm_emulate.h               |    5 +
 arch/arm64/kvm/guest.c                             |   55 +++++++++++-
 arch/powerpc/kernel/machine_kexec.c                |    7 +
 arch/powerpc/platforms/powernv/pci-ioda.c          |    2=20
 arch/s390/mm/extmem.c                              |    4=20
 arch/s390/mm/pgalloc.c                             |    2=20
 arch/x86/entry/entry_64.S                          |    4=20
 arch/x86/events/intel/lbr.c                        |   32 +++++--
 arch/x86/events/perf_event.h                       |    1=20
 arch/x86/kernel/tsc_msr.c                          |    1=20
 arch/x86/mm/numa_emulation.c                       |    2=20
 crypto/ablkcipher.c                                |    2=20
 crypto/blkcipher.c                                 |    1=20
 drivers/block/floppy.c                             |    3=20
 drivers/bluetooth/btusb.c                          |    1=20
 drivers/edac/edac_mc_sysfs.c                       |    6 -
 drivers/edac/i7core_edac.c                         |   22 +++-
 drivers/gpio/gpio-menz127.c                        |    4=20
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   11 ++
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |    4=20
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |    3=20
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |    3=20
 drivers/hid/hid-ntrig.c                            |    2=20
 drivers/hwmon/adt7475.c                            |   14 +--
 drivers/hwmon/ina2xx.c                             |   13 ++
 drivers/i2c/busses/i2c-i801.c                      |    9 +
 drivers/infiniband/core/rw.c                       |    2=20
 drivers/infiniband/hw/hfi1/pio.c                   |    9 +
 drivers/infiniband/hw/hfi1/user_sdma.c             |    2=20
 drivers/infiniband/hw/hfi1/verbs.c                 |    8 +
 drivers/infiniband/ulp/srp/ib_srp.c                |    6 -
 drivers/input/mouse/elantech.c                     |    2=20
 drivers/iommu/amd_iommu.c                          |    2=20
 drivers/md/md-cluster.c                            |   19 ++--
 drivers/media/i2c/soc_camera/ov772x.c              |    2=20
 drivers/media/platform/exynos4-is/fimc-isp-video.c |   11 +-
 drivers/media/platform/fsl-viu.c                   |   38 +++++---
 drivers/media/platform/omap3isp/isp.c              |    2=20
 drivers/media/platform/s3c-camif/camif-capture.c   |    2=20
 drivers/media/usb/tm6000/tm6000-dvb.c              |    5 +
 drivers/media/usb/uvc/uvc_video.c                  |   24 +++--
 drivers/media/v4l2-core/v4l2-event.c               |   38 ++++----
 drivers/media/v4l2-core/v4l2-fh.c                  |    2=20
 drivers/misc/tsl2550.c                             |    2=20
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |    4=20
 drivers/net/ethernet/hisilicon/hns/hnae.h          |    6 -
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |    2=20
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |    7 -
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          |   96 ++++++++++++++++=
+----
 drivers/net/ethernet/qlogic/qed/qed_reg_addr.h     |    1=20
 drivers/net/phy/xilinx_gmii2rgmii.c                |   10 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |    5 -
 drivers/net/wireless/rndis_wlan.c                  |    2=20
 drivers/net/wireless/ti/wlcore/cmd.c               |    6 +
 drivers/power/reset/vexpress-poweroff.c            |   12 +-
 drivers/power/supply/power_supply_core.c           |   11 +-
 drivers/regulator/core.c                           |    2=20
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |    2=20
 drivers/scsi/ibmvscsi/ibmvscsi.c                   |    4=20
 drivers/scsi/megaraid/megaraid_sas_base.c          |    3=20
 drivers/spi/spi-rspi.c                             |   34 ++++++-
 drivers/spi/spi-sh-msiof.c                         |   28 +++++-
 drivers/spi/spi-tegra20-slink.c                    |   31 +++++-
 drivers/staging/android/ashmem.c                   |    6 +
 drivers/staging/rts5208/sd.c                       |    2=20
 drivers/target/iscsi/iscsi_target_auth.c           |   15 ---
 drivers/target/iscsi/iscsi_target_tpg.c            |    3=20
 drivers/thermal/of-thermal.c                       |    7 +
 drivers/tty/serial/8250/serial_cs.c                |    6 -
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |   10 +-
 drivers/tty/serial/fsl_lpuart.c                    |    3=20
 drivers/tty/serial/imx.c                           |    8 +
 drivers/usb/class/cdc-wdm.c                        |    2=20
 drivers/usb/core/devio.c                           |   24 ++++-
 drivers/usb/core/driver.c                          |   28 +++---
 drivers/usb/core/usb.c                             |    2=20
 drivers/usb/serial/kobil_sct.c                     |   12 ++
 drivers/usb/wusbcore/security.c                    |    2=20
 drivers/uwb/hwa-rc.c                               |    1=20
 fs/ext4/xattr.c                                    |    5 +
 fs/nfsd/nfs4proc.c                                 |    1=20
 include/linux/arm-smccc.h                          |   38 +++++---
 include/linux/platform_data/ina2xx.h               |    2=20
 include/linux/power_supply.h                       |    1=20
 include/linux/slub_def.h                           |    3=20
 include/media/v4l2-fh.h                            |    4=20
 kernel/module.c                                    |    6 +
 kernel/time/alarmtimer.c                           |    3=20
 lib/klist.c                                        |   10 +-
 mm/slub.c                                          |    6 -
 net/6lowpan/iphc.c                                 |    1=20
 sound/aoa/core/gpio-feature.c                      |    4=20
 sound/pci/hda/hda_intel.c                          |    3=20
 sound/soc/soc-dapm.c                               |    7 +
 99 files changed, 669 insertions(+), 237 deletions(-)

Aaron Ma (1):
      Input: elantech - enable middle button of touchpad on ThinkPad P72

Akinobu Mita (2):
      media: s3c-camif: ignore -ENOIOCTLCMD from v4l2_subdev_call for s_pow=
er
      media: soc_camera: ov772x: correct setting of banding filter

Alan Stern (3):
      USB: fix error handling in usb_driver_claim_interface()
      USB: handle NULL config in usb_find_alt_setting()
      USB: remove LPM management from usb_driver_claim_interface()

Alexey Dobriyan (1):
      slub: make ->cpu_partial unsigned int

Alexey Kardashevskiy (1):
      powerpc/powernv/ioda2: Reduce upper limit for DMA window size

Alexey Khoroshilov (1):
      media: fsl-viu: fix error handling in viu_of_probe()

Alistair Strachan (1):
      staging: android: ashmem: Fix mmap size validation

Andy Shevchenko (1):
      x86/tsc: Add missing header to tsc_msr.c

Andy Whitcroft (1):
      floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl

Anson Huang (1):
      thermal: of-thermal: disable passive polling when thermal zone is dis=
abled

Anton Vasilyev (1):
      uwb: hwa-rc: fix memory leak at probe

Bart Van Assche (3):
      scsi: target/iscsi: Make iscsit_ta_authentication() respect the outpu=
t buffer size
      scsi: klist: Make it safe to use klists in atomic context
      IB/srp: Avoid that sg_reset -d ${srp_device} triggers an infinite loop

Ben Greear (1):
      ath10k: protect ath10k_htt_rx_ring_free with rx_ring.lock

Benjamin Tissoires (1):
      power: remove possible deadlock when unregistering power_supply

Bo Chen (2):
      e1000: check on netif_running() before calling e1000_up()
      e1000: ensure to free old tx/rx rings in set_ringparam()

Brandon Maier (2):
      net: phy: xgmiitorgmii: Check read_status results
      net: phy: xgmiitorgmii: Check phy_driver ready before accessing

Breno Leitao (1):
      scsi: ibmvscsi: Improve strings handling

Christophe Leroy (1):
      serial: cpm_uart: return immediately from console poll

Colin Ian King (1):
      staging: rts5208: fix missing error check on call to rtsx_write_regis=
ter

Dan Carpenter (4):
      vmci: type promotion bug in qp_host_get_user_memory()
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

Ethan Tuttle (1):
      ARM: mvebu: declare asm symbols as character arrays in pmsu.c

Gaku Inami (1):
      spi: sh-msiof: Fix invalid SPI use during system suspend

Geert Uytterhoeven (2):
      spi: rspi: Fix invalid SPI use during system suspend
      spi: rspi: Fix interrupted DMA transfers

Greg Kroah-Hartman (1):
      Linux 4.9.131

Guoqing Jiang (1):
      md-cluster: clear another node's suspend_area after the copy is finis=
hed

Hari Bathini (1):
      powerpc/kdump: Handle crashkernel memory reservation failure

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

Johan Hovold (3):
      USB: serial: kobil_sct: fix modem-status error handling
      EDAC, i7core: Fix memleaks and use-after-free on probe and remove
      EDAC: Fix memleak in module init error path

Julia Lawall (1):
      usb: wusbcore: security: cast sizeof to int for comparison

Kai-Heng Feng (1):
      ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for AMD Raven Ridge

Kan Liang (1):
      perf/x86/intel/lbr: Fix incomplete LBR call stack

Kevin Hilman (1):
      ARM: dts: dra7: fix DCAN node addresses

Liam Girdwood (1):
      ASoC: dapm: Fix potential DAI widget pointer deref when linking DAIs

Lothar Felten (1):
      hwmon: (ina2xx) fix sysfs shunt resistor read access

Marc Zyngier (3):
      arm/arm64: smccc-1.1: Make return values unsigned long
      arm/arm64: smccc-1.1: Handle function result as parameters
      arm64: KVM: Sanitize PSTATE.M when being set from userspace

Marcel Ziswiler (1):
      spi: tegra20-slink: explicitly enable/disable clock

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

Oliver Neukum (2):
      USB: usbdevfs: sanitize flags more
      USB: usbdevfs: restore warning for nonsensical flags

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

Stafford Horne (1):
      crypto: skcipher - Fix -Wstringop-truncation warnings

Stefan Agner (1):
      tty: serial: lpuart: avoid leaking struct tty_struct

Sudeep Holla (1):
      power: vexpress: fix corruption in notifier registration

Sylwester Nawrocki (1):
      media: exynos4-is: Prevent NULL pointer dereference in __isp_video_tr=
y_fmt()

Theodore Ts'o (1):
      ext4: never move the system.data xattr out of the inode body

Thomas Gleixner (1):
      alarmtimer: Prevent overflow for relative nanosleep

Tomer Tayar (2):
      qed: Wait for ready indication before rereading the shmem
      qed: Wait for MCP halt and resume commands to take place

Tony Lindgren (1):
      wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()

Uwe Kleine-K=F6nig (1):
      serial: imx: restore handshaking irq for imx1

Vasily Gorbik (2):
      s390/mm: correct allocate_pgste proc_handler callback
      s390/extmem: fix gcc 8 stringop-overflow warning

Vincent Pelletier (1):
      scsi: target: iscsi: Use bin2hex instead of a re-implementation

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


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlu2NyMACgkQONu9yGCS
aT4M4xAAiNOK7DTzwulUpWQvDXzK2MqcLa5VVgOXKp2GscF1OvQMDQ38Uaj4Ja1c
1EU99ePhrp1xvoDwiAnB1b8xUrn1jSEz1j5NhHpfFSvudt5oxRVHRsMDrDeBPhrW
LQRwYbAhesT6MDywvM5JSWOYLk4SxAY6jB/7V4T0iWLtCIZXgVBUxyj1B8O3q4YQ
75ej0IiBw9IBmwlkJPWN+d4anZJZcEzxAmRgiOeYo2eAA8nNBBDzIpl40sKaropw
xsBvRwe8mHYZEsM9mo+9FQFhKGnd4SAS7Gb2vmPUC+L3c9fV/Cavb6db7YmfFO2f
RPrpb5rv1p3M9spw/WwDu5CVezOocapZq+sUcq2fyspz4jNAHtotRQqfC6zspZXj
VYMP3aostSnTDisLLrCQWIwxx5DZgXF2IPaHQJ++rYdfmA7Yr5RRV0KJr8R0/EXP
eOTB2xOKa7keSV5LlZhVWF189WgZFWwvpROWV+hU/7Q1lmEUuFxHbARqtlPnuhkz
ZoBHpryQs/Xftlo/rutxmerMfDNGhqhLrBnsqaYSj65YInf2cvXrrgAM0THZ4W61
f3WBtOyrEzMcIdR5exPppsXZ8JO8AdUTJ3myNGdDsD1Sn54EkJ1Lo4IymrQ49U1W
Jrf8GgWgIqhzDrL0qBSno8egcBhdQI9TOX+IpVg8hVXMitrbtwY=
=LrU6
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
