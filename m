Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825519-1521968470-2-16348877020147560654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521968469; b=mxyXqlBW0pgkc2ZL9S1A2DMwJ2qZaT7DHr1QjeH8M8HQlks
    pnv97T1nw3d+/6e2FaWCiYvkL+cajpm3FGR/dllVN+Kt63O7yjEjQYWMzprIekX4
    J2hMWD7j9MzojnInGou/IMYr//mpHm5p0GAA5ctAzmYHHjhBY0cyzNxCBI6ySdMP
    Bw46JEDC4L4SLif5VTiZd28K8GzcxTphDesmcGcad/ap1IIQ327ed43ArL42SFBa
    2ZPLDkhn6RKwS1gCnjafD3BhKCbcmvssu9yRQfmaQC3kJPk/pM3BiD+cPRySd4E3
    JUM6T3QRbpSOMRgpHuuuN08b27F08Pko6QaJbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521968469; bh=dKEfq55KA4lEu8hGF/R1r1GjI1SLihzapoO5q9WyaaA=; b=U
    1lfScLeptq+UI+GACo28ZXzwHVotUV1iGHOnudIxsxSH8Y9oOL8FIV6WdsUBb9JZ
    LAkFkKsAfIZYsFU+6uWNyK4P3rH8FxSuE6lFELBwMYxMGfR9nfiCbZJMkxvL+Ro7
    yIath/lHOtGT5Ai9MNm1IoasFnxHC7lh+S4LmZ+xQI2P3oPy5UfCMRcKBdmhHvcf
    iOgu5SPrTOP6zGCAGdLAqrF+msnEY6dT/M5PDMN4StMPeqt4RZwWdy0zmmHeV0Qp
    KS+TZg6e0BitCFeVup4/5tuZh08FqKIb8qofaDZAqXwWCvYqrk44B4BLfQaoZ39a
    Kx68DCTHSEqZvYqJsmUZQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S1752040AbeCYJAU (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Mar 2018 05:00:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41510 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbeCYJAP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Mar 2018 05:00:15 -0400
Date: Sun, 25 Mar 2018 11:00:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.124
Message-ID: <20180325090012.GA31790@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.124 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                 |    2=20
 arch/alpha/kernel/console.c                              |    1=20
 arch/arm/kernel/ftrace.c                                 |   11 +-
 arch/arm/mach-omap2/clockdomains7xx_data.c               |    2=20
 arch/ia64/kernel/module.c                                |    4=20
 arch/powerpc/kvm/book3s_64_mmu_host.c                    |    5 -
 arch/powerpc/kvm/book3s_pr.c                             |    6 +
 arch/x86/kernel/i8259.c                                  |    1=20
 drivers/acpi/pmic/intel_pmic_xpower.c                    |   50 ++++++----=
--
 drivers/acpi/processor_driver.c                          |   10 ++
 drivers/acpi/processor_throttling.c                      |   62 ++++++++--=
-----
 drivers/block/mtip32xx/mtip32xx.c                        |   36 +++++---
 drivers/bluetooth/hci_qca.c                              |    3=20
 drivers/char/ipmi/ipmi_watchdog.c                        |    8 -
 drivers/char/tpm/tpm-interface.c                         |    5 +
 drivers/char/tpm/tpm2-cmd.c                              |    6 +
 drivers/char/tpm/tpm_tis.c                               |    5 -
 drivers/clk/bcm/clk-ns2.c                                |    2=20
 drivers/clk/clk-si5351.c                                 |    2=20
 drivers/cpufreq/sh-cpufreq.c                             |   45 ++++++----
 drivers/dma/ti-dma-crossbar.c                            |   10 ++
 drivers/gpu/drm/msm/msm_gem.c                            |   14 ++-
 drivers/gpu/drm/nouveau/nouveau_display.c                |    2=20
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c                 |    5 +
 drivers/hsi/clients/ssi_protocol.c                       |    5 -
 drivers/hwtracing/coresight/coresight-tpiu.c             |   13 ++-
 drivers/i2c/busses/i2c-scmi.c                            |    4=20
 drivers/iio/accel/st_accel_core.c                        |    7 -
 drivers/iio/pressure/st_pressure_core.c                  |    8 -
 drivers/infiniband/core/cma.c                            |    5 -
 drivers/infiniband/core/iwpm_util.c                      |    1=20
 drivers/infiniband/core/umem.c                           |    2=20
 drivers/infiniband/core/uverbs_cmd.c                     |   13 ++-
 drivers/infiniband/hw/mlx4/main.c                        |    6 -
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c              |    2=20
 drivers/infiniband/ulp/ipoib/ipoib_ib.c                  |   13 +++
 drivers/infiniband/ulp/ipoib/ipoib_main.c                |   16 +++
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c           |   11 +-
 drivers/input/misc/twl4030-pwrbutton.c                   |    2=20
 drivers/input/touchscreen/ar1021_i2c.c                   |    2=20
 drivers/iommu/intel-svm.c                                |    9 +-
 drivers/iommu/omap-iommu.c                               |   21 ++++-
 drivers/md/raid10.c                                      |    6 +
 drivers/media/dvb-core/dvb_ca_en50221.c                  |   23 +++++
 drivers/media/dvb-frontends/si2168.c                     |    3=20
 drivers/media/pci/bt8xx/bt878.c                          |    3=20
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c    |    4=20
 drivers/mfd/palmas.c                                     |   14 +++
 drivers/mmc/core/core.c                                  |    8 +
 drivers/mmc/host/omap_hsmmc.c                            |    4=20
 drivers/mmc/host/sdhci-of-esdhc.c                        |   14 +++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c          |    1=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c       |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c        |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c        |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c      |    2=20
 drivers/net/ethernet/intel/e1000e/netdev.c               |    6 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c |    2=20
 drivers/net/wan/pc300too.c                               |    1=20
 drivers/net/wireless/ath/regd.c                          |   19 ++--
 drivers/net/wireless/mediatek/mt7601u/mcu.c              |   10 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c               |    7 +
 drivers/net/wireless/rndis_wlan.c                        |    4=20
 drivers/pinctrl/core.c                                   |   24 ++++-
 drivers/platform/chrome/cros_ec_proto.c                  |    8 +
 drivers/platform/chrome/cros_ec_sysfs.c                  |    2=20
 drivers/platform/x86/asus-nb-wmi.c                       |    9 ++
 drivers/power/pda_power.c                                |   49 ++++++-----
 drivers/ptp/ptp_clock.c                                  |   18 +---
 drivers/regulator/anatop-regulator.c                     |    5 +
 drivers/rtc/rtc-cmos.c                                   |   17 +++-
 drivers/rtc/rtc-ds1374.c                                 |   10 +-
 drivers/scsi/lpfc/lpfc_sli.c                             |    3=20
 drivers/scsi/mac_esp.c                                   |   33 +++++--
 drivers/scsi/virtio_scsi.c                               |   24 +++++
 drivers/spi/spi-dw-mmio.c                                |    2=20
 drivers/staging/android/ashmem.c                         |    8 -
 drivers/staging/unisys/visorhba/visorhba_main.c          |    8 +
 drivers/staging/wilc1000/linux_mon.c                     |    2=20
 drivers/target/target_core_file.c                        |   23 ++++-
 drivers/tty/tty_io.c                                     |    2=20
 drivers/video/console/vgacon.c                           |   34 ++++++--
 drivers/video/fbdev/sm501fb.c                            |    1=20
 drivers/video/fbdev/udlfb.c                              |   14 ++-
 fs/btrfs/send.c                                          |   23 +++++
 fs/cifs/netmisc.c                                        |    6 -
 fs/cifs/sess.c                                           |   22 ++---
 fs/cifs/smb2pdu.c                                        |   11 --
 fs/nfs/pagelist.c                                        |    6 -
 fs/nfsd/nfs4proc.c                                       |    6 -
 fs/nfsd/vfs.c                                            |   24 ++++-
 include/linux/posix-clock.h                              |   10 +-
 kernel/irq/manage.c                                      |    4=20
 kernel/time/posix-clock.c                                |   34 +++++---
 net/ipv4/tcp_input.c                                     |   16 ++-
 net/ipv6/ip6_vti.c                                       |   20 ++++
 net/ipv6/ndisc.c                                         |    2=20
 net/mac80211/status.c                                    |    1=20
 net/netfilter/xt_CT.c                                    |   11 ++
 net/openvswitch/conntrack.c                              |   30 +++++++
 sound/pci/hda/patch_realtek.c                            |   12 ++
 sound/soc/intel/skylake/skl.c                            |    2=20
 tools/perf/tests/kmod-path.c                             |    2=20
 103 files changed, 810 insertions(+), 302 deletions(-)

Abel Vesa (1):
      ARM: 8668/1: ftrace: Fix dynamic ftrace with DEBUG_RODATA and !FRAME_=
POINTER

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

Benjamin Coddington (2):
      NFS: Fix missing pg_cleanup after nfs_pageio_cond_complete()
      nfsd4: permit layoutget of executable-only files

Bernd Faust (1):
      e1000e: fix timing for 82579 Gigabit Ethernet controller

Bharat Kumar Reddy Gooty (1):
      clk: ns2: Correct SDIO bits

Bjorn Helgaas (1):
      vgacon: Set VGA struct resource types

Christophe JAILLET (1):
      media: bt8xx: Fix err 'bt878_probe()'

Dan Carpenter (4):
      HSI: ssi_protocol: double free in ssip_pn_xmit()
      ASoC: Intel: Skylake: Uninitialized variable in probe_codec()
      mmc: host: omap_hsmmc: checking for NULL instead of IS_ERR()
      cifs: small underflow in cnvrtDosUnixTm()

Daniel Drake (1):
      mmc: avoid removing non-removable hosts during suspend

David Ahern (1):
      net: ipv6: send unsolicited NA on admin up

David Gibson (1):
      scsi: virtio_scsi: Always try to read VPD pages

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

Emmanuel Grumbach (1):
      mac80211: don't parse encrypted management frames in ieee80211_frame_=
acked

Erez Shitrit (1):
      IB/ipoib: Avoid memory leak if the SA returns a different DGID

Eric Dumazet (1):
      tcp: remove poll() flakes with FastOpen

Feras Daoud (2):
      IB/ipoib: Fix deadlock between ipoib_stop and mcast join flow
      IB/ipoib: Update broadcast object if PKey value was changed in index 0

Filipe Manana (1):
      Btrfs: send, fix file hole not being preserved due to inline extent

Finn Thain (1):
      scsi: mac_esp: Replace bogus memory barrier with spinlock

Florian Fainelli (1):
      pinctrl: Really force states during suspend/resume

Gao Feng (1):
      netfilter: xt_CT: fix refcnt leak on error path

Geert Uytterhoeven (1):
      RDMA/iwpm: Fix uninitialized error code in iwpm_send_mapinfo()

Greg Kroah-Hartman (1):
      Linux 4.4.124

Guoqing Jiang (1):
      md/raid10: wait up frozen array in handle_write_completed

Gustavo A. R. Silva (1):
      media: c8sectpfe: fix potential NULL pointer dereference in c8sectpfe=
_timer_interrupt

Hans de Goede (4):
      x86: i8259: export legacy_pic symbol
      rtc: cmos: Do not assume irq 8 for rtc when there are no legacy irqs
      genirq: Use irqd_get_trigger_type to compare the trigger type for sha=
red IRQs
      ACPI / PMIC: xpower: Fix power_table addresses

James Smart (1):
      Fix driver usage of 128B WQEs when WQ_CREATE is V1.

Jarno Rajahalme (1):
      openvswitch: Delete conntrack entry clashing with an expectation.

Jasmin J (1):
      media/dvb-core: Race condition when writing to CAM

Jeremy Boone (2):
      tpm: fix potential buffer overruns caused by bit glitches on the bus
      tpm_tis: fix potential buffer overruns caused by bit glitches on the =
bus

Jerry Snitselaar (1):
      iommu/vt-d: clean up pr_irq if request_threaded_irq fails

Keerthy (1):
      mfd: palmas: Reset the POWERHOLD mux during power off

Kim Phillips (1):
      perf tests kmod-path: Don't fail if compressed modules aren't support=
ed

Kishon Vijay Abraham I (1):
      ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to =
SW_WKUP

Leon Romanovsky (1):
      RDMA/ucma: Fix access to non-initialized CM_ID object

Loic Poulain (1):
      Bluetooth: hci_qca: Avoid setup failure on missing rampatch

Maksim Salau (1):
      video: fbdev: udlfb: Fix buffer on stack

Maor Gottlieb (2):
      IB/mlx4: Take write semaphore when changing the vma struct
      IB/mlx4: Change vma from shared to private

Marek Vasut (1):
      spi: dw: Disable clock after unregistering the host

Mario Kleiner (1):
      drm/nouveau/kms: Increase max retries in scanout position queries.

Michael Trimarchi (1):
      power: supply: pda_power: move from timer to delayed_work

Mikhail Paulyshka (1):
      ALSA: hda - Fix headset microphone detection for ASUS N551 and N751

Ming Lei (1):
      mtip32xx: use runtime tag to initialize command header

Mohammed Shafi Shajakhan (1):
      ath: Fix updating radar flags for coutry code India

Moritz Fischer (2):
      rtc: ds1374: wdt: Fix issue with timeout scaling from secs to wdt tic=
ks
      rtc: ds1374: wdt: Fix stop/start ioctl always returning -EINVAL

NeilBrown (1):
      NFS: don't try to cross a mountpount when there isn't one there.

Pan Bian (5):
      wan: pc300too: abort path on failure
      qlcnic: fix unchecked return value
      mt7601u: check return value of alloc_skb
      rndis_wlan: add return value validation
      staging: wilc1000: fix unchecked return value

Parav Pandit (1):
      RDMA/cma: Use correct size when writing netlink stats

Pavel Shilovsky (1):
      CIFS: Enable encryption during session setup phase

Peter Ujfalusi (1):
      drm/omap: DMM: Check for DMM readiness after successful transaction c=
ommit

Prakash Kamliya (1):
      drm/msm: fix leak in failed get_pages

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

Steve French (1):
      SMB3: Validate negotiate request must always be signed

Suman Anna (1):
      iommu/omap: Register driver before setting IOMMU ops

Thomas Gleixner (3):
      ACPI/processor: Fix error handling in __acpi_processor_start()
      ACPI/processor: Replace racy task affinity logic
      cpufreq/sh: Replace racy task affinity logic

Timmy Li (1):
      net: hns: fix ethtool_get_strings overflow in hns driver

Tsang-Shian Lin (1):
      rtlwifi: rtl_pci: Fix the bug when inactiveps is enabled.

Vignesh R (1):
      dmaengine: ti-dma-crossbar: Fix event mapping for TPCC_EVT_MUX_60_63

Vlad Tsyrklevich (1):
      infiniband/uverbs: Fix integer overflows

Yisheng Xie (1):
      staging: android: ashmem: Fix possible deadlock in ashmem_ioctl

yangbo lu (1):
      mmc: sdhci-of-esdhc: limit SD clock for ls1012a/ls1046a


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlq3ZRwACgkQONu9yGCS
aT6GPBAAtg/5R+elTv5ky+CdM/E8QlP3mqPQHbyLyhP9u4p69Eis9fFPUpAAGxZr
HbPR9WaQJmEqlv+wFoHxnOVgi2mjbCN8oFzBdj9ZHAJV2lbHObAQD/xgQ8KrYJJH
PA4MgZQK/geKipRY3GpBRjnXIlHW7l2fh4HM29JMAzizDHXrezuxHUJONRyioE/d
uj4JaQRm7vP8sXvWXWrVdxFzwtNYccZRiyxaPhy7aM5qs3zpN3N51iiIbr8vLM3l
MGtXvQ7SvcIRMC2rzFQx3Z8xVC2YR0mr4j9xtPiNNIliXsKW8lqx4t0mJzmI/K1O
lS0+B2ljTN9Titz3w4s88jiT/bbMCphAHh1xNv8gqtErbRkgGAANIclE1TAh94Vh
rvMpoMs1X0ydf70uW4xFJxal6CgPSUgjqP6buKTiCoShsbi2Bb1nNgisrYU8/gtI
+4Yb9ZunKrBC0b6FcRdQBDcalgAKjtycYXWIuZnnTmi02BVR0XtzRyXgTHEWQBLQ
6TTevUAuFdU/mNXdixkR6W8tgspQ0XAnqmC18QogYHm0lDE1oCe+k9SOu4OUPwGl
4AoUApeokdzRpMt5It4b4hVKImKsV1uDK6VEAjHwJAmklNbVUFz2WOWKFTibFR+W
JzFan5sYJL8+EmVaMIWkgfSkjOM4+hdI5Fqs6uFCpD0X2uWc3Zk=
=CVup
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
