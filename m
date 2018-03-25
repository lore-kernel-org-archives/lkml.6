Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825519-1521968548-2-5786637806547881124
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521968545; b=U/cH/8/y03PBRj5EEvt8oY/8DfsMD0R/3nDDfkxqLsJTltl
    xfOxYmxTOLCvCUEd+SJADty2caQkOoGQx+l0472MnK/1wpJVREP0BDPAn/Z5a3i0
    C90Ego0i0T4pW77v6O0hJ/AyHyhhJidDWsRoWscU1FWHcEB0Hmxi73FyhaWrl+2L
    zlzWUbbmAWqjKgLsM8V5GumdgsTCYz70HN0u2UHBIh2/DEoisLrJgBfBdtaM32uC
    OY6xRV70G6poYBJG0mPtzZrqsWIthJHMVqwLeiWF9RfsJwW52KKteeT65+PmK9tp
    OM+1a9+WNuFg8qeuHwRkSX2Nf7WIOHr4IsLh78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521968545; bh=aBlVGyQc61/UQjh1keWX44nB6MzeOBTq+CfYskrwsRg=; b=d
    9OR42BVQyx3I2EP5JsHSutU0pkGE/Fc83CK5Ykm3pvFSgaISTy9+1R1DgYYg7sN2
    S1iL07ui1wkjbfDypvXSyMZnHpL4ZQKaRxJqO/9e+t5iRONgWuvf+k+SQ08bhL3I
    wm7KskzhmoaXEv7OfD1pfLOsRXunazb4PtBNJkrC3Szi8Rv27ahOs6AY1EKLjEPw
    2PqZqsPiKhZHbuyS1HdWxkRs+83PwDkWz1lILHoDhufvZkvSsKiBhCoNIMuKCtus
    Feqt5t8VTj3MFRxgu9iYNMXGy0mwmmedK+uS13BR6zO0rLMqulBysc82hXgVPd81
    5NcfN7wTHAnwsjlxAXSqw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeCYJBG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Mar 2018 05:01:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42348 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbeCYJAt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Mar 2018 05:00:49 -0400
Date: Sun, 25 Mar 2018 11:00:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.90
Message-ID: <20180325090046.GA31879@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.90 kernel.

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

 Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt |  =
 30 ---
 Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt     |  =
 30 +++
 Documentation/devicetree/bindings/mfd/axp20x.txt                       |  =
  3=20
 Makefile                                                               |  =
  2=20
 arch/alpha/kernel/console.c                                            |  =
  1=20
 arch/arm/boot/dts/aspeed-ast2500-evb.dts                               |  =
  2=20
 arch/arm/kernel/ftrace.c                                               |  =
 11 -
 arch/arm/mach-omap2/clockdomains7xx_data.c                             |  =
  2=20
 arch/ia64/kernel/module.c                                              |  =
  4=20
 arch/powerpc/include/asm/cputable.h                                    |  =
  3=20
 arch/powerpc/kvm/book3s_64_mmu_host.c                                  |  =
  5=20
 arch/powerpc/kvm/book3s_pr.c                                           |  =
  6=20
 arch/x86/boot/compressed/kaslr.c                                       |  =
 11 +
 arch/x86/kernel/i8259.c                                                |  =
  1=20
 arch/x86/kernel/smp.c                                                  |  =
  3=20
 arch/x86/xen/smp.c                                                     |  =
 49 +++--
 block/blk-mq.c                                                         |  =
  4=20
 drivers/acpi/pmic/intel_pmic_xpower.c                                  |  =
 50 ++---
 drivers/acpi/power.c                                                   |  =
 10 +
 drivers/acpi/processor_driver.c                                        |  =
 10 +
 drivers/acpi/processor_throttling.c                                    |  =
 62 ++++--
 drivers/acpi/sleep.c                                                   |  =
  1=20
 drivers/acpi/sleep.h                                                   |  =
  1=20
 drivers/block/mtip32xx/mtip32xx.c                                      |  =
 36 ++--
 drivers/bluetooth/btqcomsmd.c                                          |  =
  3=20
 drivers/bluetooth/hci_ldisc.c                                          |  =
 11 -
 drivers/bluetooth/hci_qca.c                                            |  =
  3=20
 drivers/char/ipmi/ipmi_watchdog.c                                      |  =
  8=20
 drivers/char/tpm/tpm-interface.c                                       |  =
  5=20
 drivers/char/tpm/tpm2-cmd.c                                            |  =
  6=20
 drivers/clk/bcm/clk-ns2.c                                              |  =
  2=20
 drivers/clk/clk-axi-clkgen.c                                           |  =
 29 ++-
 drivers/clk/clk-si5351.c                                               |  =
  2=20
 drivers/clk/clk.c                                                      |  =
 32 ++-
 drivers/cpufreq/sh-cpufreq.c                                           |  =
 45 +++--
 drivers/dma/ti-dma-crossbar.c                                          |  =
 10 +
 drivers/dma/xilinx/zynqmp_dma.c                                        |  =
  3=20
 drivers/gpio/gpio-wcove.c                                              |  =
  8=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                             |  =
  7=20
 drivers/gpu/drm/msm/msm_gem.c                                          |  =
 14 +
 drivers/gpu/drm/nouveau/nouveau_display.c                              |  =
  2=20
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c                |  =
  3=20
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c                               |  =
  5=20
 drivers/gpu/drm/tilcdc/tilcdc_regs.h                                   |  =
  2=20
 drivers/hsi/clients/ssi_protocol.c                                     |  =
  5=20
 drivers/hwtracing/coresight/coresight-tpiu.c                           |  =
 13 +
 drivers/i2c/busses/i2c-scmi.c                                          |  =
  4=20
 drivers/iio/accel/st_accel_core.c                                      |  =
  7=20
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c                 |  =
  4=20
 drivers/iio/pressure/st_pressure_core.c                                |  =
  8=20
 drivers/infiniband/core/cma.c                                          |  =
  5=20
 drivers/infiniband/core/iwpm_util.c                                    |  =
  1=20
 drivers/infiniband/core/ucma.c                                         |  =
  8=20
 drivers/infiniband/core/umem.c                                         |  =
  2=20
 drivers/infiniband/core/uverbs_cmd.c                                   |  =
 13 +
 drivers/infiniband/hw/hfi1/chip.c                                      |  =
 86 +++++----
 drivers/infiniband/hw/hfi1/hfi.h                                       |  =
  7=20
 drivers/infiniband/hw/hfi1/init.c                                      |  =
  2=20
 drivers/infiniband/hw/mlx4/main.c                                      |  =
  6=20
 drivers/infiniband/hw/mlx5/cq.c                                        |  =
 19 +-
 drivers/infiniband/hw/mlx5/main.c                                      |  =
  5=20
 drivers/infiniband/hw/mlx5/qp.c                                        |  =
 24 +-
 drivers/infiniband/hw/mlx5/srq.c                                       |  =
 15 +
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c                            |  =
  2=20
 drivers/infiniband/sw/rdmavt/ah.c                                      |  =
  2=20
 drivers/infiniband/sw/rxe/rxe_resp.c                                   |  =
  2=20
 drivers/infiniband/ulp/ipoib/ipoib_ib.c                                |  =
 13 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c                              |  =
 16 +
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c                         |  =
 11 -
 drivers/infiniband/ulp/isert/ib_isert.c                                |  =
  7=20
 drivers/infiniband/ulp/isert/ib_isert.h                                |  =
  1=20
 drivers/input/misc/twl4030-pwrbutton.c                                 |  =
  2=20
 drivers/input/touchscreen/ar1021_i2c.c                                 |  =
  2=20
 drivers/iommu/intel-svm.c                                              |  =
  9 -
 drivers/iommu/omap-iommu.c                                             |  =
 21 ++
 drivers/irqchip/irq-mips-gic.c                                         |  =
 12 -
 drivers/leds/led-core.c                                                |  =
  3=20
 drivers/md/raid10.c                                                    |  =
  6=20
 drivers/media/dvb-core/dvb_ca_en50221.c                                |  =
 23 ++
 drivers/media/dvb-frontends/si2168.c                                   |  =
  3=20
 drivers/media/pci/bt8xx/bt878.c                                        |  =
  3=20
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c                  |  =
  4=20
 drivers/mfd/palmas.c                                                   |  =
 14 +
 drivers/mmc/core/core.c                                                |  =
  8=20
 drivers/mmc/host/omap_hsmmc.c                                          |  =
  4=20
 drivers/mmc/host/sdhci-of-esdhc.c                                      |  =
 14 +
 drivers/net/bonding/bond_main.c                                        |  =
  3=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                        |  =
  1=20
 drivers/net/ethernet/freescale/ucc_geth.c                              |  =
  8=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c                     |  =
  2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c                      |  =
  2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c                      |  =
  2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c                    |  =
  2=20
 drivers/net/ethernet/ibm/ibmvnic.c                                     |  =
 18 ++
 drivers/net/ethernet/intel/e1000e/netdev.c                             |  =
  6=20
 drivers/net/ethernet/intel/ixgbevf/ethtool.c                           |  =
  2=20
 drivers/net/ethernet/qlogic/qed/qed_vf.c                               |  =
  2=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c               |  =
  2=20
 drivers/net/hyperv/netvsc.c                                            |  =
 16 +
 drivers/net/usb/qmi_wwan.c                                             |  =
  4=20
 drivers/net/vxlan.c                                                    |  =
 10 -
 drivers/net/wan/pc300too.c                                             |  =
  1=20
 drivers/net/wireless/ath/ath10k/debug.c                                |  =
 16 +
 drivers/net/wireless/ath/ath10k/mac.c                                  |  =
  2=20
 drivers/net/wireless/ath/regd.c                                        |  =
 19 +-
 drivers/net/wireless/intel/iwlwifi/iwl-a000.c                          |  =
  6=20
 drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.c                    |  =
 10 -
 drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.h                    |  =
 25 ++
 drivers/net/wireless/marvell/libertas/if_spi.c                         |  =
  5=20
 drivers/net/wireless/marvell/mwifiex/main.c                            |  =
  4=20
 drivers/net/wireless/mediatek/mt7601u/mcu.c                            |  =
 10 -
 drivers/net/wireless/realtek/rtlwifi/pci.c                             |  =
  7=20
 drivers/net/wireless/rndis_wlan.c                                      |  =
  4=20
 drivers/pinctrl/core.c                                                 |  =
 24 +-
 drivers/pinctrl/pinctrl-rockchip.c                                     |  =
  8=20
 drivers/platform/chrome/cros_ec_proto.c                                |  =
  8=20
 drivers/platform/chrome/cros_ec_sysfs.c                                |  =
  2=20
 drivers/platform/x86/asus-nb-wmi.c                                     |  =
 22 ++
 drivers/platform/x86/asus-wmi.c                                        |  =
 12 +
 drivers/platform/x86/asus-wmi.h                                        |  =
  1=20
 drivers/platform/x86/intel-vbtn.c                                      |  =
  4=20
 drivers/power/supply/bq24190_charger.c                                 |  =
 10 +
 drivers/power/supply/isp1704_charger.c                                 |  =
  4=20
 drivers/power/supply/pda_power.c                                       |  =
 49 +++--
 drivers/ptp/ptp_clock.c                                                |  =
 18 --
 drivers/regulator/anatop-regulator.c                                   |  =
  5=20
 drivers/rtc/rtc-cmos.c                                                 |  =
 17 +
 drivers/rtc/rtc-ds1374.c                                               |  =
 10 -
 drivers/scsi/lpfc/lpfc_init.c                                          |  =
  6=20
 drivers/scsi/lpfc/lpfc_sli.c                                           |  =
  3=20
 drivers/scsi/mac_esp.c                                                 |  =
 33 ++-
 drivers/scsi/virtio_scsi.c                                             |  =
 24 ++
 drivers/soc/fsl/qe/qe.c                                                |  =
 13 +
 drivers/spi/spi-dw-mmio.c                                              |  =
  2=20
 drivers/staging/android/ashmem.c                                       |  =
  8=20
 drivers/staging/unisys/visorhba/visorhba_main.c                        |  =
  8=20
 drivers/staging/wilc1000/linux_mon.c                                   |  =
  2=20
 drivers/target/target_core_file.c                                      |  =
 23 +-
 drivers/tty/serial/8250/8250_dw.c                                      |  =
  3=20
 drivers/tty/tty_io.c                                                   |  =
  2=20
 drivers/usb/gadget/function/f_hid.c                                    |  =
 89 +++++++---
 drivers/video/console/vgacon.c                                         |  =
 34 ++-
 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c       |  =
  3=20
 drivers/video/fbdev/sm501fb.c                                          |  =
  1=20
 drivers/video/fbdev/udlfb.c                                            |  =
 14 +
 drivers/watchdog/watchdog_dev.c                                        |  =
  6=20
 fs/btrfs/file.c                                                        |  =
  4=20
 fs/btrfs/inode.c                                                       |  =
  6=20
 fs/btrfs/send.c                                                        |  =
 23 ++
 fs/btrfs/volumes.c                                                     |  =
 12 +
 fs/cifs/netmisc.c                                                      |  =
  6=20
 fs/cifs/sess.c                                                         |  =
 22 +-
 fs/cifs/smb2pdu.c                                                      |  =
 15 -
 fs/jbd2/journal.c                                                      |  =
 15 +
 fs/nfs/pagelist.c                                                      |  =
  6=20
 fs/nfs/pnfs.c                                                          |  =
 18 +-
 fs/nfsd/nfs4proc.c                                                     |  =
  6=20
 fs/nfsd/vfs.c                                                          |  =
 24 ++
 fs/orangefs/waitqueue.c                                                |  =
  9 -
 include/acpi/actbl2.h                                                  |  =
  9 +
 include/linux/mlx5/driver.h                                            |  =
  4=20
 include/linux/posix-clock.h                                            |  =
 10 -
 include/soc/fsl/qe/qe.h                                                |  =
  1=20
 kernel/irq/manage.c                                                    |  =
  4=20
 kernel/time/posix-clock.c                                              |  =
 34 ++-
 mm/memory-failure.c                                                    |  =
  8=20
 mm/vmscan.c                                                            |  =
  6=20
 mm/vmstat.c                                                            |  =
 20 +-
 net/ipv4/tcp_input.c                                                   |  =
 16 +
 net/ipv6/ip6_vti.c                                                     |  =
 20 ++
 net/ipv6/ndisc.c                                                       |  =
  2=20
 net/mac80211/cfg.c                                                     |  =
 30 +--
 net/mac80211/ibss.c                                                    |  =
  6=20
 net/mac80211/ieee80211_i.h                                             |  =
 36 ++--
 net/mac80211/mesh.c                                                    |  =
 29 ++-
 net/mac80211/mesh_plink.c                                              |  =
 37 ++--
 net/mac80211/mlme.c                                                    |  =
 14 +
 net/mac80211/rate.c                                                    |  =
  4=20
 net/mac80211/sta_info.c                                                |  =
 13 +
 net/mac80211/status.c                                                  |  =
  1=20
 net/mac80211/tdls.c                                                    |  =
 29 ++-
 net/mac80211/tx.c                                                      |  =
  5=20
 net/mac80211/util.c                                                    |  =
  6=20
 net/netfilter/ipvs/ip_vs_ctl.c                                         |  =
 22 +-
 net/netfilter/nf_conntrack_helper.c                                    |  =
 26 ++
 net/netfilter/nft_dynset.c                                             |  =
  5=20
 net/netfilter/x_tables.c                                               |  =
  4=20
 net/netfilter/xt_CT.c                                                  |  =
 11 +
 net/openvswitch/conntrack.c                                            |  =
 30 +++
 net/sunrpc/xprtrdma/verbs.c                                            |  =
  1=20
 net/tipc/node.c                                                        |  =
  2=20
 sound/pci/hda/patch_realtek.c                                          |  =
 12 +
 sound/soc/intel/atom/sst/sst_acpi.c                                    |  =
 16 +
 sound/soc/intel/skylake/skl.c                                          |  =
  2=20
 sound/soc/sh/rcar/cmd.c                                                |  =
  3=20
 tools/perf/tests/kmod-path.c                                           |  =
  2=20
 tools/testing/nvdimm/test/nfit.c                                       |  =
 10 +
 197 files changed, 1639 insertions(+), 627 deletions(-)

Abel Vesa (1):
      ARM: 8668/1: ftrace: Fix dynamic ftrace with DEBUG_RODATA and !FRAME_=
POINTER

Adam Borowski (1):
      btrfs: fix a bogus warning when converting only data or metadata

Alexey Kardashevskiy (1):
      KVM: PPC: Book3S PR: Exit KVM on failed mapping

Alexey Khoroshilov (1):
      sm501fb: don't return zero on failure path in sm501fb_start()

Alexey Kodanev (1):
      ip6_vti: adjust vti mtu according to mtu of lower device

Anton Vasilyev (1):
      RDMA/ocrdma: Fix permissions for OCRDMA_RESET_STATS

Arnd Bergmann (1):
      cros_ec: fix nul-termination for firmware build info

Artemy Kovalyov (1):
      IB/umem: Fix use of npages/nmap fields

Balaji Pothunoori (1):
      ath10k: handling qos at STA side based on AP WMM enable/disable

Baoquan He (1):
      x86/KASLR: Fix kexec kernel boot crash when KASLR randomization fails

Benjamin Coddington (2):
      NFS: Fix missing pg_cleanup after nfs_pageio_cond_complete()
      nfsd4: permit layoutget of executable-only files

Bernd Faust (1):
      e1000e: fix timing for 82579 Gigabit Ethernet controller

Bharat Kumar Reddy Gooty (1):
      clk: ns2: Correct SDIO bits

Bharat Potnuri (1):
      iser-target: avoid reinitializing rdma contexts for isert commands

Bjorn Helgaas (1):
      vgacon: Set VGA struct resource types

Bj=F8rn Mork (1):
      qmi_wwan: set FLAG_SEND_ZLP to avoid network initiated disconnect

Boris Pismenny (2):
      IB/mlx5: Fix integer overflows in mlx5_ib_create_srq
      IB/mlx5: Fix out-of-bounds read in create_raw_packet_qp_rq

Brian King (1):
      ibmvnic: Disable irq prior to close

Brian Norris (2):
      mwifiex: don't leak 'chan_stats' on reset
      pinctrl: rockchip: enable clock when reading pin direction register

Christophe JAILLET (1):
      media: bt8xx: Fix err 'bt878_probe()'

Christophe Leroy (1):
      net: ethernet: ucc_geth: fix MEM_PART_MURAM mode

Chuck Lever (1):
      xprtrdma: Cancel refresh worker during buffer shutdown

Chunming Zhou (1):
      drm/amdgpu: fix gpu reset crash

Colin Ian King (1):
      iio: hid-sensor: fix return of -EINVAL on invalid values in ret or va=
lue

Dan Carpenter (7):
      HSI: ssi_protocol: double free in ssip_pn_xmit()
      ASoC: Intel: Skylake: Uninitialized variable in probe_codec()
      mmc: host: omap_hsmmc: checking for NULL instead of IS_ERR()
      netfilter: x_tables: unlock on error in xt_find_table_lock()
      IB/rdmavt: restore IRQs on error path in rvt_create_ah()
      qed: Unlock on error in qed_vf_pf_acquire()
      cifs: small underflow in cnvrtDosUnixTm()

Dan Williams (1):
      tools/testing/nvdimm: fix nfit_test shutdown crash

Daniel Drake (1):
      mmc: avoid removing non-removable hosts during suspend

David Ahern (1):
      net: ipv6: send unsolicited NA on admin up

David Gibson (1):
      scsi: virtio_scsi: Always try to read VPD pages

David Rientjes (1):
      mm, vmstat: suppress pcp stats for unpopulated zones in zoneinfo

Dean Jenkins (2):
      Bluetooth: hci_ldisc: Add protocol check to hci_uart_dequeue()
      Bluetooth: hci_ldisc: Add protocol check to hci_uart_tx_wakeup()

Deepa Dinamani (1):
      time: Change posix clocks ops interfaces to use timespec64

Dmitry Monakhov (1):
      tcm_fileio: Prevent information leak for short reads

Dmitry Torokhov (1):
      Input: ar1021_i2c - fix too long name in driver's device table

Dong Aisheng (1):
      regulator: anatop: set default voltage selector for pcie

Edgar Cherkasov (1):
      i2c: i2c-scmi: add a MS HID

Emil Tantilov (1):
      ixgbevf: fix size of queue stats length

Emmanuel Grumbach (2):
      iwlwifi: split the handler and the wake parts of the notification inf=
ra
      mac80211: don't parse encrypted management frames in ieee80211_frame_=
acked

Erez Shitrit (1):
      IB/ipoib: Avoid memory leak if the SA returns a different DGID

Eric Dumazet (1):
      tcp: remove poll() flakes with FastOpen

Feras Daoud (2):
      IB/ipoib: Fix deadlock between ipoib_stop and mcast join flow
      IB/ipoib: Update broadcast object if PKey value was changed in index 0

Filipe Manana (3):
      Btrfs: fix incorrect space accounting after failure to insert inline =
extent
      Btrfs: send, fix file hole not being preserved due to inline extent
      Btrfs: fix extent map leak during fallocate error path

Finn Thain (1):
      scsi: mac_esp: Replace bogus memory barrier with spinlock

Florian Fainelli (1):
      pinctrl: Really force states during suspend/resume

Gao Feng (1):
      netfilter: xt_CT: fix refcnt leak on error path

Geert Uytterhoeven (1):
      RDMA/iwpm: Fix uninitialized error code in iwpm_send_mapinfo()

Greg Kroah-Hartman (1):
      Linux 4.9.90

Guenter Roeck (1):
      watchdog: Fix potential kref imbalance when opening watchdog

Guoqing Jiang (1):
      md/raid10: wait up frozen array in handle_write_completed

Gustavo A. R. Silva (1):
      media: c8sectpfe: fix potential NULL pointer dereference in c8sectpfe=
_timer_interrupt

H. Nikolaus Schaller (1):
      omapdrm: panel: fix compatible vendor string for td028ttec1

Hans de Goede (6):
      x86: i8259: export legacy_pic symbol
      rtc: cmos: Do not assume irq 8 for rtc when there are no legacy irqs
      genirq: Use irqd_get_trigger_type to compare the trigger type for sha=
red IRQs
      ACPI / PMIC: xpower: Fix power_table addresses
      power: supply: bq24190_charger: Add disable-reset device-property
      ACPI / power: Delay turning off unused power resources after suspend

Jacek Anaszewski (2):
      Revert "led: core: Fix brightness setting when setting delay_off=3D0"
      led: core: Clear LED_BLINK_SW flag in led_blink_set()

James Smart (2):
      Fix driver usage of 128B WQEs when WQ_CREATE is V1.
      Fix Express lane queue creation.

Jan Kara (1):
      jbd2: Fix lockdep splat with generic/270 test

Jarno Rajahalme (1):
      openvswitch: Delete conntrack entry clashing with an expectation.

Jasmin J (1):
      media/dvb-core: Race condition when writing to CAM

Jeremy Boone (1):
      tpm: fix potential buffer overruns caused by bit glitches on the bus

Jerome Brunet (1):
      clk: migrate the count of orphaned clocks at init

Jerry Snitselaar (1):
      iommu/vt-d: clean up pr_irq if request_threaded_irq fails

Jiri Benc (1):
      vxlan: correctly handle ipv6.disable module parameter

Joel Stanley (1):
      ARM: dts: aspeed-evb: Add unit name to memory node

Johannes Thumshirn (1):
      IB/rxe: Don't clamp residual length to mtu

Johannes Weiner (1):
      mm: fix check for reclaimable pages in PF_MEMALLOC reclaim throttling

K. Y. Srinivasan (1):
      netvsc: Deal with rescinded channels correctly

Kedareswara rao Appana (1):
      dmaengine: zynqmp_dma: Fix race condition in the probe

Keerthy (1):
      mfd: palmas: Reset the POWERHOLD mux during power off

Kim Phillips (1):
      perf tests kmod-path: Don't fail if compressed modules aren't support=
ed

Kishon Vijay Abraham I (1):
      ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to =
SW_WKUP

Krzysztof Opasiak (1):
      usb: gadget: f_hid: fix: Move IN request allocation to set_alt()

Kuninori Morimoto (1):
      ASoC: rsnd: check src mod pointer for rsnd_mod_id()

Kuppuswamy Sathyanarayanan (2):
      gpio: gpio-wcove: fix irq pending status bit width
      gpio: gpio-wcove: fix GPIO IRQ status mask

Lars-Peter Clausen (1):
      clk: axi-clkgen: Correctly handle nocount bit in recalc_rate()

Leon Romanovsky (2):
      RDMA/ucma: Fix access to non-initialized CM_ID object
      RDMA/ucma: Don't allow join attempts for unsupported AF family

Liad Kaufman (1):
      iwlwifi: a000: fix memory offsets and lengths

Liam Breck (1):
      power: supply: bq24190_charger: Limit over/under voltage fault logging

Liping Zhang (2):
      netfilter: nf_ct_helper: permit cthelpers with different names via nf=
netlink
      netfilter: nft_dynset: continue to next expr if _OP_ADD succeeded

Logan Gunthorpe (1):
      drm/tilcdc: ensure nonatomic iowrite64 is not used

Loic Poulain (2):
      Bluetooth: hci_qca: Avoid setup failure on missing rampatch
      Bluetooth: btqcomsmd: Fix skb double free corruption

Lv Zheng (1):
      ACPICA: iasl: Fix IORT SMMU GSI disassembling

Maarten Maathuis (1):
      platform/x86: intel-vbtn: add volume up and down

Mahesh Bandewar (1):
      bonding: handle link transition from FAIL to UP correctly

Maksim Salau (1):
      video: fbdev: udlfb: Fix buffer on stack

Maor Gottlieb (4):
      IB/mlx4: Take write semaphore when changing the vma struct
      IB/mlx4: Change vma from shared to private
      IB/mlx5: Take write semaphore when changing the vma struct
      IB/mlx5: Change vma from shared to private

Marek Vasut (1):
      spi: dw: Disable clock after unregistering the host

Mario Kleiner (1):
      drm/nouveau/kms: Increase max retries in scanout position queries.

Martin Brandenburg (1):
      orangefs: do not wait for timeout if umounting

Michael Mera (1):
      ath10k: fix out of bounds access to local buffer

Michael Trimarchi (1):
      power: supply: pda_power: move from timer to delayed_work

Mikhail Paulyshka (1):
      ALSA: hda - Fix headset microphone detection for ASUS N551 and N751

Ming Lei (1):
      mtip32xx: use runtime tag to initialize command header

Mohammed Shafi Shajakhan (2):
      ath: Fix updating radar flags for coutry code India
      mac80211: Fix possible sband related NULL pointer de-reference

Moni Shoua (1):
      IB/mlx5: Set correct SL in completion for RoCE

Moritz Fischer (2):
      rtc: ds1374: wdt: Fix issue with timeout scaling from secs to wdt tic=
ks
      rtc: ds1374: wdt: Fix stop/start ioctl always returning -EINVAL

Naoya Horiguchi (1):
      mm: hwpoison: call shake_page() after try_to_unmap() for mlocked page

NeilBrown (1):
      NFS: don't try to cross a mountpount when there isn't one there.

Nicholas Piggin (1):
      powerpc/64s: Remove SAO feature from Power9 DD1

Oleksij Rempel (1):
      platform/x86: asus-wmi: try to set als by default

Pan Bian (8):
      tipc: check return value of nlmsg_new
      wan: pc300too: abort path on failure
      qlcnic: fix unchecked return value
      mt7601u: check return value of alloc_skb
      libertas: check return value of alloc_workqueue
      rndis_wlan: add return value validation
      staging: wilc1000: fix unchecked return value
      power: supply: isp1704: Fix unchecked return value of devm_kzalloc

Paolo Abeni (1):
      ipvs: explicitly forbid ipv6 service/dest creation if ipv6 mod is dis=
abled

Parav Pandit (1):
      RDMA/cma: Use correct size when writing netlink stats

Paul Burton (1):
      irqchip/mips-gic: Separate IPI reservation & usage tracking

Pavel Shilovsky (1):
      CIFS: Enable encryption during session setup phase

Peter Ujfalusi (1):
      drm/omap: DMM: Check for DMM readiness after successful transaction c=
ommit

Peter Zijlstra (1):
      block/mq: Cure cpu hotplug lock inversion

Pierre-Louis Bossart (1):
      ASoC: Intel: Atom: update Thinkpad 10 quirk

Prakash Kamliya (1):
      drm/msm: fix leak in failed get_pages

Rask Ingemann Lambertsen (1):
      dt-bindings: mfd: axp20x: Add "xpowers,master-mode" property for AXP8=
06 PMICs

Robert Lippert (1):
      ipmi/watchdog: fix wdog hang on panic waiting for ipmi response

Robert Walker (1):
      coresight: Fix disabling of CoreSight TPIU

Ron Economos (1):
      media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart

Sahara (1):
      pty: cancel pty slave port buf's work in tty_release

Sameer Wadgaonkar (1):
      staging: unisys: visorhba: fix s-Par to boot with option CONFIG_VMAP_=
STACK set to y

Santeri Toivonen (1):
      platform/x86: asus-nb-wmi: Add wapf4 quirk for the X302UA

Scott Wood (1):
      bnx2x: Align RX buffers

Sebastian Reichel (1):
      Input: twl4030-pwrbutton - use correct device for irq request

Sergei Trofimovich (1):
      ia64: fix module loading for gcc-5.4

Sergej Sawazki (1):
      clk: si5351: Rename internal plls to avoid name collisions

Shaohua Li (1):
      md/raid10: skip spare disk as 'first' disk

Shawn Nematbakhsh (1):
      platform/chrome: Use proper protocol transfer function

Shrirang Bagul (1):
      iio: st_pressure: st_accel: Initialise sensor platform data properly

Stefan Potyra (1):
      serial: 8250_dw: Disable clock on error

Stephen Boyd (1):
      clk: Don't touch hardware when reparenting during registration

Steve French (1):
      SMB3: Validate negotiate request must always be signed

Suman Anna (1):
      iommu/omap: Register driver before setting IOMMU ops

Tadeusz Struk (1):
      IB/hfi1: Fix softlockup issue

Thomas Gleixner (3):
      ACPI/processor: Fix error handling in __acpi_processor_start()
      ACPI/processor: Replace racy task affinity logic
      cpufreq/sh: Replace racy task affinity logic

Tiantian Feng (1):
      x86/reboot: Turn off KVM when halting a CPU

Timmy Li (1):
      net: hns: fix ethtool_get_strings overflow in hns driver

Trond Myklebust (2):
      pNFS: Fix use after free issues in pnfs_do_read()
      pNFS: Fix a deadlock when coalescing writes and returning the layout

Tsang-Shian Lin (1):
      rtlwifi: rtl_pci: Fix the bug when inactiveps is enabled.

Valentin Longchamp (1):
      soc/fsl/qe: round brg_freq to 1kHz granularity

Vignesh R (1):
      dmaengine: ti-dma-crossbar: Fix event mapping for TPCC_EVT_MUX_60_63

Vitaly Kuznetsov (1):
      x86/xen: split xen_smp_prepare_boot_cpu()

Vlad Tsyrklevich (1):
      infiniband/uverbs: Fix integer overflows

Yisheng Xie (1):
      staging: android: ashmem: Fix possible deadlock in ashmem_ioctl

yangbo lu (1):
      mmc: sdhci-of-esdhc: limit SD clock for ls1012a/ls1046a


--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlq3ZT0ACgkQONu9yGCS
aT62fQ/+LFyTdjr6+//xca2JTH6B4M6k6KeNhFDs93VXQxE3Atws/71e2vC3V2fD
uRU4fMw/pnq4znVSnqRmhu6i13Xf9xw3g4HlLR7qkSwVnF5JUrXKXPPXf6UwcAqe
WosDuLFlvBRSUHXldzpT17GvKBAZHC+PWtst+Iz6u5RvT62Ke05sVcsvQmlrdDbB
kMXgknyrHPpT1nQg4iQo5u9IIakWXxPb/xIWn8rsmR0ij+LVmcnrorN7BOHhInm+
vkQAEY5V9n2tlvFnM9lN/aYdiCMhG6xJSCqrwrZiCQYBHmvS8eCf7TNv9NfjUdkC
9/rih9SlMkXDEIhv6GC10vhySpQ6hkxhq3oPVyMaii39QAgzwT5UCBIpdRYOZ3eq
nR126jhZ5iXRH7IL7l15QFWXBY15m2JqMxk0wJGx9AlcyRff1D5bU10jo342WR1G
fYcsi8Zc1BC/w5ivWwvfpK0rRf+waXNec21vEKalYDpR+T7GZWXXVD9EdRl5b7SN
XX1TwjBCOTuOzxnsU+CYYyNtM64RTa7ZxYpjSTn+Jzv3xI2EtVnk+qRANYkSg8nr
LUYS/QQmLnzsRRCqMSZi920nvcFwg934ibZEEy8LcSmTE91qRXDKw9/pNQ/Z5vVj
9wCQZkRhmUWpeFxoLR3Z8JOWCk1WIg2osgYrXSz2GqrGDK6ezB0=
=OH+y
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
