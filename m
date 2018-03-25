Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1839065-1521968538-2-16300340933611686052
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
    t=1521968537; b=Yx/PKyzEwgORjkPtyz0jjPz0fckTulqNy8eR1u4nv53uZN8
    A6hTCIx3JffzumdcqKoIKhoJy+Z7OeTEvlEMNd52OzLn7/omLj0dn1wPTVQfeo76
    /IPpWiIddsLiAZXHPdSTXDedEWMq7GLNStTdp8oEPyRj4Vnqcwp94Gbmn8pQIrLi
    ynwMMbXClSgn70GKdvPnjKwaynvOTtGSVKvVus+rKo+BhPqeSlkiEW2ovo11csdX
    9l1rIQ+3hkD7edNiw5039rKPMrTq0ZBYYcdJzE1z4QHEr0CP8Rjb5IWdE3PYWzW0
    X5d4UqZPK6j1Sp0jTjejYZ5d6VEs81MXbIkMF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521968537; bh=fSz4u18GUegJWCrhcmdig9bQK2BFzxtTxNuxrldHFMU=; b=E
    6OJi1DF4yUqtxn3CGcNHrZRwnxgawFhub8VlPASJqMVVXGGmdxUJDbgvh72kwgSe
    b/vJrCCfSbeN6wfkGw60xnQwrWg11MWMsKbOcq3OZCOwFffw0ElqQLCTi5DmRj79
    N99oikDpdVzjJZki3jATS3+pADsRYWPxGRg4h28rdEFru4vVgjjR2u1DxP+/O4uQ
    4TUpJYzBDi0ZI/xOW9IK9th3Rp84WBqQa6NmJUC7R/t4cMWFIbAJECYYo/U0e7oO
    KMxpE0ZxDSIN5yK38uhNh5QcMZ/YqSy67tf/nhW+TeBNurF7Iix8esxjts2mbQHh
    e24ajYwIr9sL1F8Jzk9Hw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1752006AbeCYJBq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Mar 2018 05:01:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42586 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeCYJBo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Mar 2018 05:01:44 -0400
Date: Sun, 25 Mar 2018 11:01:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.13
Message-ID: <20180325090141.GA32075@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.13 kernel.

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

 Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt   |=
   30 ----
 Documentation/devicetree/bindings/display/panel/toshiba,lt089ac29000.txt |=
    2=20
 Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt       |=
   30 ++++
 Makefile                                                                 |=
    2=20
 arch/alpha/kernel/console.c                                              |=
    1=20
 arch/arm/boot/dts/aspeed-ast2500-evb.dts                                 |=
    2=20
 drivers/bluetooth/btqcomsmd.c                                            |=
    3=20
 drivers/bluetooth/hci_qca.c                                              |=
    3=20
 drivers/char/hw_random/core.c                                            |=
    4=20
 drivers/char/mem.c                                                       |=
   27 +++
 drivers/clk/at91/pmc.c                                                   |=
   24 ++-
 drivers/clk/clk-axi-clkgen.c                                             |=
   29 +++-
 drivers/clk/clk-si5351.c                                                 |=
    2=20
 drivers/clk/clk.c                                                        |=
   64 +++++++--
 drivers/cpufreq/longhaul.c                                               |=
    2=20
 drivers/crypto/axis/artpec6_crypto.c                                     |=
    5=20
 drivers/dma/ti-dma-crossbar.c                                            |=
   10 +
 drivers/dma/xilinx/zynqmp_dma.c                                          |=
    3=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                                 |=
    1=20
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c                                   |=
   27 ++-
 drivers/gpu/drm/msm/msm_gem.c                                            |=
   14 +
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c                  |=
    3=20
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c                                 |=
    5=20
 drivers/gpu/drm/tilcdc/tilcdc_regs.h                                     |=
    2=20
 drivers/hwtracing/coresight/coresight-tpiu.c                             |=
   13 +
 drivers/infiniband/core/cma.c                                            |=
   17 +-
 drivers/infiniband/core/iwpm_util.c                                      |=
    1=20
 drivers/infiniband/core/ucma.c                                           |=
    8 -
 drivers/infiniband/core/umem.c                                           |=
    2=20
 drivers/infiniband/hw/mlx5/qp.c                                          |=
   23 ++-
 drivers/infiniband/hw/mlx5/srq.c                                         |=
   15 +-
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c                              |=
    2=20
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c                             |=
    4=20
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c                            |=
    4=20
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c                          |=
    4=20
 drivers/infiniband/ulp/ipoib/ipoib_main.c                                |=
   23 ++-
 drivers/infiniband/ulp/isert/ib_isert.c                                  |=
    7=20
 drivers/infiniband/ulp/isert/ib_isert.h                                  |=
    1=20
 drivers/iommu/intel-svm.c                                                |=
    9 -
 drivers/media/dvb-frontends/si2168.c                                     |=
    3=20
 drivers/media/pci/bt8xx/bt878.c                                          |=
    3=20
 drivers/media/platform/davinci/vpif_capture.c                            |=
    4=20
 drivers/media/platform/s5p-mfc/s5p_mfc.c                                 |=
    6=20
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h                          |=
    3=20
 drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c                            |=
    5=20
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c                    |=
    4=20
 drivers/mmc/core/block.c                                                 |=
    1=20
 drivers/mmc/core/core.c                                                  |=
    8 +
 drivers/mmc/host/sdhci-xenon.c                                           |=
    7=20
 drivers/net/hyperv/hyperv_net.h                                          |=
   19 ++
 drivers/net/hyperv/netvsc.c                                              |=
    5=20
 drivers/net/hyperv/netvsc_drv.c                                          |=
    4=20
 drivers/net/phy/meson-gxl.c                                              |=
   50 +++++--
 drivers/net/phy/sfp.c                                                    |=
   15 --
 drivers/net/usb/qmi_wwan.c                                               |=
    4=20
 drivers/net/wireless/ath/ath10k/mac.c                                    |=
    2=20
 drivers/net/wireless/realtek/rtlwifi/base.c                              |=
    2=20
 drivers/net/wireless/realtek/rtlwifi/pci.c                               |=
    7=20
 drivers/pci/dwc/pcie-designware-ep.c                                     |=
   12 -
 drivers/pci/dwc/pcie-designware.h                                        |=
    1=20
 drivers/pci/endpoint/pci-ep-cfs.c                                        |=
    5=20
 drivers/pci/host/pcie-rcar.c                                             |=
    5=20
 drivers/pci/pcie/aspm.c                                                  |=
   71 ++++++----
 drivers/pinctrl/core.c                                                   |=
   24 ++-
 drivers/pinctrl/pinctrl-rockchip.c                                       |=
    8 +
 drivers/platform/chrome/cros_ec_proto.c                                  |=
    8 -
 drivers/platform/chrome/cros_ec_sysfs.c                                  |=
    2=20
 drivers/rtc/rtc-ac100.c                                                  |=
   19 +-
 drivers/scsi/lpfc/lpfc_ct.c                                              |=
    1=20
 drivers/scsi/lpfc/lpfc_els.c                                             |=
   30 ++--
 drivers/scsi/lpfc/lpfc_nportdisc.c                                       |=
   34 ++--
 drivers/scsi/megaraid/megaraid_sas_fusion.c                              |=
   42 +----
 drivers/soc/qcom/smsm.c                                                  |=
    6=20
 drivers/spi/spi-sh-msiof.c                                               |=
   35 +++-
 drivers/staging/android/ashmem.c                                         |=
    8 -
 drivers/tty/Kconfig                                                      |=
    6=20
 drivers/tty/goldfish.c                                                   |=
    2=20
 drivers/tty/serial/8250/8250_dw.c                                        |=
    3=20
 drivers/tty/serial/8250/8250_pci.c                                       |=
   10 -
 drivers/tty/tty_io.c                                                     |=
    2=20
 drivers/video/console/vgacon.c                                           |=
   34 +++-
 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c         |=
    3=20
 drivers/watchdog/watchdog_dev.c                                          |=
   17 +-
 fs/nfsd/nfs4proc.c                                                       |=
    6=20
 include/linux/mlx5/driver.h                                              |=
    4=20
 include/uapi/linux/bpf.h                                                 |=
    3=20
 kernel/bpf/cgroup.c                                                      |=
   15 +-
 net/ipv4/ip_gre.c                                                        |=
    6=20
 net/ipv4/tcp_output.c                                                    |=
    9 -
 net/ipv6/ip6_vti.c                                                       |=
   20 ++
 security/Kconfig                                                         |=
    1=20
 tools/lib/bpf/libbpf.c                                                   |=
    2=20
 92 files changed, 715 insertions(+), 319 deletions(-)

Adit Ranadive (1):
      RDMA/vmw_pvrdma: Fix usage of user response structures in ABI file

Alexandre Belloni (1):
      rtc: ac100: Fix multiple race conditions

Alexey Kodanev (1):
      ip6_vti: adjust vti mtu according to mtu of lower device

Andy Shevchenko (1):
      serial: 8250_pci: Don't fail on multiport card class

Anton Vasilyev (1):
      RDMA/ocrdma: Fix permissions for OCRDMA_RESET_STATS

Arnd Bergmann (1):
      cros_ec: fix nul-termination for firmware build info

Artemy Kovalyov (1):
      IB/umem: Fix use of npages/nmap fields

Balaji Pothunoori (1):
      ath10k: handling qos at STA side based on AP WMM enable/disable

Benjamin Coddington (1):
      nfsd4: permit layoutget of executable-only files

Bharat Potnuri (1):
      iser-target: avoid reinitializing rdma contexts for isert commands

Bjorn Helgaas (2):
      PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics
      vgacon: Set VGA struct resource types

Bj=F8rn Mork (1):
      qmi_wwan: set FLAG_SEND_ZLP to avoid network initiated disconnect

Boris Pismenny (2):
      IB/mlx5: Fix integer overflows in mlx5_ib_create_srq
      IB/mlx5: Fix out-of-bounds read in create_raw_packet_qp_rq

Brian Norris (1):
      pinctrl: rockchip: enable clock when reading pin direction register

Christophe JAILLET (1):
      media: bt8xx: Fix err 'bt878_probe()'

Daniel Drake (1):
      mmc: avoid removing non-removable hosts during suspend

Erez Shitrit (1):
      IB/ipoib: Avoid memory leak if the SA returns a different DGID

Florian Fainelli (1):
      pinctrl: Really force states during suspend/resume

Gary R Hook (1):
      hwrng: core - Clean up RNG list when last hwrng is unregistered

Geert Uytterhoeven (3):
      RDMA/iwpm: Fix uninitialized error code in iwpm_send_mapinfo()
      spi: sh-msiof: Avoid writing to registers from spi_master.setup()
      PCI: rcar: Handle rcar_pcie_parse_request_of_pci_ranges() failures

Greg Kroah-Hartman (1):
      Linux 4.15.13

Guenter Roeck (2):
      watchdog: Fix potential kref imbalance when opening watchdog
      watchdog: Fix kref imbalance seen if handle_boot_enabled=3D0

Gustavo A. R. Silva (1):
      media: c8sectpfe: fix potential NULL pointer dereference in c8sectpfe=
_timer_interrupt

H. Nikolaus Schaller (1):
      omapdrm: panel: fix compatible vendor string for td028ttec1

Haishuang Yan (2):
      ip_gre: fix error path when erspan_rcv failed
      ip_gre: fix potential memory leak in erspan_rcv

Haiyang Zhang (2):
      hv_netvsc: Fix the receive buffer size limit
      hv_netvsc: Fix the TX/RX buffer default sizes

James Smart (2):
      scsi: lpfc: Fix SCSI LUN discovery when SCSI and NVME enabled
      scsi: lpfc: Fix issues connecting with nvme initiator

Jerome Brunet (4):
      net: phy: meson-gxl: check phy_write return value
      clk: check ops pointer on clock register
      clk: use round rate to bail out early in set_rate
      clk: migrate the count of orphaned clocks at init

Jerry Snitselaar (1):
      iommu/vt-d: clean up pr_irq if request_threaded_irq fails

Joel Stanley (1):
      ARM: dts: aspeed-evb: Add unit name to memory node

Johan Hovold (1):
      soc: qcom: smsm: fix child-node lookup

Jonathan Neusch=E4fer (1):
      dt-bindings: display: panel: Fix compatible string for Toshiba LT089A=
C29000

Kedareswara rao Appana (1):
      dmaengine: zynqmp_dma: Fix race condition in the probe

Kees Cook (1):
      /dev/mem: Add bounce buffer for copy-out

Kishon Vijay Abraham I (1):
      PCI: designware-ep: Fix ->get_msi() to check MSI_EN bit

Lars Persson (1):
      crypto: artpec6 - set correct iv size for gcm(aes)

Lars-Peter Clausen (1):
      clk: axi-clkgen: Correctly handle nocount bit in recalc_rate()

Leon Romanovsky (2):
      RDMA/ucma: Fix access to non-initialized CM_ID object
      RDMA/ucma: Don't allow join attempts for unsupported AF family

Liu, Changcheng (1):
      mmc: block: fix logical error to avoid memory leak

Logan Gunthorpe (1):
      drm/tilcdc: ensure nonatomic iowrite64 is not used

Loic Poulain (2):
      Bluetooth: hci_qca: Avoid setup failure on missing rampatch
      Bluetooth: btqcomsmd: Fix skb double free corruption

Mauro Carvalho Chehab (1):
      media: davinci: fix a debug printk

Neal Cardwell (1):
      tcp: allow TLP in ECN CWR

Nicolas Iooss (1):
      rtlwifi: always initialize variables given to RT_TRACE()

Niklas Cassel (1):
      PCI: endpoint: Fix find_first_zero_bit() usage

Parav Pandit (1):
      RDMA/cma: Use correct size when writing netlink stats

Peter Ujfalusi (1):
      drm/omap: DMM: Check for DMM readiness after successful transaction c=
ommit

Pixel Ding (1):
      drm/amdgpu: use polling mem to set SDMA3 wptr for VF

Prakash Kamliya (1):
      drm/msm: fix leak in failed get_pages

Robert Walker (1):
      coresight: Fix disabling of CoreSight TPIU

Romain Izard (1):
      clk: at91: pmc: Wait for clocks when resuming

Roman Gushchin (1):
      libbpf: prefer global symbols as bpf program name source

Ron Economos (1):
      media: [RESEND] media: dvb-frontends: Add delay to Si2168 restart

Russell King (2):
      sfp: fix EEPROM reading in the case of non-SFF8472 SFPs
      sfp: fix non-detection of PHY

Sahara (1):
      pty: cancel pty slave port buf's work in tty_release

Sebastian Andrzej Siewior (1):
      tty: goldfish: Enable 'earlycon' only if built-in

Sergej Sawazki (1):
      clk: si5351: Rename internal plls to avoid name collisions

Shawn Nematbakhsh (1):
      platform/chrome: Use proper protocol transfer function

Shivasharan S (1):
      scsi: megaraid_sas: Do not use 32-bit atomic request descriptor for V=
entura controllers

Shuah Khan (1):
      media: s5p-mfc: Fix lock contention - request_firmware() once

Stefan Potyra (1):
      serial: 8250_dw: Disable clock on error

Stephen Boyd (1):
      clk: Don't touch hardware when reparenting during registration

Tatyana Nikolova (1):
      RDMA/core: Do not use invalid destination in determining port reuse

Tsang-Shian Lin (1):
      rtlwifi: rtl_pci: Fix the bug when inactiveps is enabled.

Vignesh R (1):
      dmaengine: ti-dma-crossbar: Fix event mapping for TPCC_EVT_MUX_60_63

Viresh Kumar (1):
      cpufreq: longhaul: Revert transition_delay_us to 200 ms

Yisheng Xie (1):
      staging: android: ashmem: Fix possible deadlock in ashmem_ioctl

Yonghong Song (1):
      bpf/cgroup: fix a verification error for a CGROUP_DEVICE type prog

Yuval Shaia (1):
      IB/ipoib: Warn when one port fails to initialize

Zhoujie Wu (1):
      mmc: sdhci-xenon: wait 5ms after set 1.8V signal enable


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlq3ZXQACgkQONu9yGCS
aT76ig/3XuduOTaVgNZDIcSqoZpFoYFlHDYTsMZ1SiqaFwp+ToWmlpsGR3LjIBKC
OxPlo6szh/NL70A4SJ17LBSKlo60Khd2wd/qvh0GW0BAiiqf/Kv5+h01OYuRxYwG
j2cq72TLdqup+2Yq56Vn+8LG+O2dRqbV0mWmvsJpfsurAkI5KgF1TpeHYndl1sOw
mjpvUwj4hxQTqFEv0PIGoJkUPykXxx/o9RvqW2/77ppDWNHXQmeDOkT1X4bAeclV
MckqCcwmj0648gTkEs5o9H5YGhkf5St8TrR9FysQRaZJ8RlwQBThjhPpmjMrQ1s6
wK2CN8yi+enuTPih21PYXsNRJtj6/nAlr5BKqgsj3hhGLcvDt5XMWbxbLaL6lTG/
ZjYhn1etq+JBuQVQ9enNc4WAoMJI37T92zjm4e+8AKwni3qrHL4i3dv69VYVNChM
j/9hgiDGsxM6DquqP1IAZUckkXreD5Rr96nHmQTX+ZC+X8pcCtHjyyvSMZDB46wY
CF/ZfdBJ/kN2R/ITd7ZkDNEyoL5ZD61CqvZu/S9IxbSI2SNdDCdaGRFN0EY2BsNx
eKE5rQqLRCw2TjY1YrSKY/ktTzn92MDvZXMiu+pTnrbwxh6LZUZQDliP53/hbH+m
nr9eIXh/6zzFH67SVmbeADceYbUOMsdnjbDKXCmmgUjahGG6ew==
=7nvC
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
