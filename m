Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E1AC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD352088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD352088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeG1HwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 03:52:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeG1HwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 03:52:22 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 98104825;
        Sat, 28 Jul 2018 06:27:02 +0000 (UTC)
Date:   Sat, 28 Jul 2018 08:27:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.11
Message-ID: <20180728062700.GA12127@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.11 kernel.

All users of the 4.17 kernel series must upgrade.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.17.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                |    2=20
 arch/mips/ath79/common.c                                |    2=20
 arch/mips/pci/pci.c                                     |    2=20
 arch/powerpc/include/asm/mmu_context.h                  |    4=20
 arch/powerpc/kvm/book3s_64_vio.c                        |    2=20
 arch/powerpc/kvm/book3s_64_vio_hv.c                     |    6=20
 arch/powerpc/mm/mmu_context_iommu.c                     |   37 +
 arch/x86/kvm/x86.c                                      |    4=20
 arch/x86/xen/xen-pvh.S                                  |   26 +
 drivers/acpi/acpica/psloop.c                            |   26 +
 drivers/base/dd.c                                       |    8=20
 drivers/clk/clk-aspeed.c                                |   46 +
 drivers/clk/meson/gxbb.c                                |    1=20
 drivers/clk/mvebu/armada-37xx-periph.c                  |   38 +
 drivers/gpu/drm/nouveau/dispnv04/disp.c                 |    3=20
 drivers/gpu/drm/nouveau/nouveau_drm.c                   |    7=20
 drivers/gpu/drm/nouveau/nv50_display.c                  |    8=20
 drivers/iommu/Kconfig                                   |    1=20
 drivers/iommu/intel-iommu.c                             |   62 +-
 drivers/net/bonding/bond_options.c                      |   23=20
 drivers/net/can/m_can/m_can.c                           |   11=20
 drivers/net/can/peak_canfd/peak_pciefd_main.c           |   19=20
 drivers/net/can/xilinx_can.c                            |  392 +++++++++++=
-----
 drivers/net/dsa/mv88e6xxx/chip.c                        |   21=20
 drivers/net/ethernet/huawei/hinic/hinic_tx.c            |    1=20
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c   |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/en.h            |    3=20
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c       |    7=20
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c      |   17=20
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c       |   15=20
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c        |   32 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c         |   42 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h         |   13=20
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c       |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c     |   12=20
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c |    2=20
 drivers/net/ethernet/realtek/r8169.c                    |    3=20
 drivers/net/phy/phy.c                                   |    2=20
 drivers/net/vxlan.c                                     |  126 +++--
 drivers/staging/rtl8188eu/Kconfig                       |    1=20
 drivers/staging/rtl8188eu/core/rtw_recv.c               |  161 ++++--
 drivers/staging/rtl8188eu/core/rtw_security.c           |   92 +--
 drivers/staging/speakup/speakup_soft.c                  |    6=20
 drivers/usb/class/cdc-acm.c                             |    3=20
 drivers/usb/core/hub.c                                  |    8=20
 drivers/usb/dwc2/hcd.c                                  |   44 -
 drivers/usb/gadget/composite.c                          |    1=20
 drivers/usb/gadget/function/f_fs.c                      |    2=20
 drivers/usb/host/xhci.c                                 |    1=20
 drivers/vfio/vfio_iommu_spapr_tce.c                     |    2=20
 include/net/tcp.h                                       |    7=20
 net/core/rtnetlink.c                                    |    9=20
 net/core/skbuff.c                                       |   10=20
 net/core/sock.c                                         |    6=20
 net/ipv4/igmp.c                                         |    3=20
 net/ipv4/ip_output.c                                    |    2=20
 net/ipv4/ip_sockglue.c                                  |    7=20
 net/ipv4/tcp_dctcp.c                                    |   50 --
 net/ipv4/tcp_input.c                                    |   65 ++
 net/ipv4/tcp_output.c                                   |   33 +
 net/ipv6/datagram.c                                     |    7=20
 net/ipv6/icmp.c                                         |    5=20
 net/ipv6/ip6_output.c                                   |    2=20
 net/ipv6/mcast.c                                        |    3=20
 net/ipv6/tcp_ipv6.c                                     |    6=20
 net/tls/tls_sw.c                                        |    3=20
 66 files changed, 1096 insertions(+), 473 deletions(-)

Alexey Kardashevskiy (1):
      KVM: PPC: Check if IOMMU page is contained in the pinned physical page

Anssi Hannula (7):
      can: xilinx_can: fix RX loop if RXNEMP is asserted without RXOK
      can: xilinx_can: fix power management handling
      can: xilinx_can: fix recovery from error states not being propagated
      can: xilinx_can: fix device dropping off bus on RX overrun
      can: xilinx_can: keep only 1-2 frames in TX FIFO to fix TX accounting
      can: xilinx_can: fix incorrect clear of non-processed interrupts
      can: xilinx_can: fix RX overflow interrupt not being enabled

Antti Sepp=E4l=E4 (1):
      usb: dwc2: Fix DMA alignment to start at allocated boundary

Ariel Levkovich (1):
      net/mlx5: Adjust clock overflow work period

Benjamin Herrenschmidt (1):
      usb: gadget: Fix OS descriptors support

Bin Liu (1):
      usb: core: handle hub C_PORT_OVER_CURRENT condition

Boris Ostrovsky (1):
      xen/PVH: Set up GS segment for stack canary

Christoph Hellwig (1):
      Revert "iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=3Dy and clean=
 up intel_{alloc,free}_coherent()"

Daniel Borkmann (1):
      sock: fix sg page frag coalescing in sk_alloc_sg

David Ahern (1):
      net/ipv6: Fix linklocal to global address with VRF

Doron Roberts-Kedes (1):
      tls: check RCV_SHUTDOWN in tls_wait_data

Eran Ben Elisha (2):
      net/mlx5e: Don't allow aRFS for encapsulated packets
      net/mlx5e: Fix quota counting in aRFS expire flow

Eric Dumazet (6):
      net: skb_segment() should not return NULL
      tcp: free batches of packets in tcp_prune_ofo_queue()
      tcp: avoid collapses in tcp_prune_queue() if possible
      tcp: detect malicious patterns in tcp_collapse_ofo_queue()
      tcp: call tcp_drop() from tcp_data_queue_ofo()
      tcp: add tcp_ooo_try_coalesce() helper

Faiz Abbas (1):
      can: m_can: Fix runtime resume call

Felix Fietkau (1):
      MIPS: ath79: fix register address in ath79_ddr_wb_flush()

Greg Kroah-Hartman (1):
      Linux 4.17.11

Gregory CLEMENT (1):
      clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to=
 1.2GHz

Hangbin Liu (1):
      multicast: do not restore deleted record source filter mode to new one

Hans de Goede (1):
      Revert "staging:r8188eu: Use lib80211 to support TKIP"

Heiner Kallweit (2):
      r8169: restore previous behavior to accept BIOS WoL settings
      net: phy: consider PHY_IGNORE_INTERRUPT in phy_start_aneg_priv

Jack Morgenstein (1):
      net/mlx4_core: Save the qpn from the input modifier in RST2INIT wrapp=
er

Jarod Wilson (1):
      bonding: set default miimon value for non-arp modes if not set

Jerry Zhang (1):
      usb: gadget: f_fs: Only return delayed status when len is 0

Joel Stanley (2):
      clk: aspeed: Mark bclk (PCIe) and dclk (VGA) as critical
      clk: aspeed: Support HPLL strapping on ast2400

John Hurley (1):
      nfp: flower: ensure dead neighbour entries are not offloaded

Lubomir Rintel (1):
      usb: cdc_acm: Add quirk for Castles VEGA3000

Lyude Paul (2):
      drm/nouveau/drm/nouveau: Fix runtime PM leak in nv50_disp_atomic_comm=
it()
      drm/nouveau: Set DRIVER_ATOMIC cap earlier to fix debugfs

Neil Armstrong (1):
      clk: meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL

Or Gerlitz (1):
      net/mlx5e: Add ingress/egress indication for offloaded TC flows

Paolo Abeni (1):
      ip: hash fragments consistently

Paolo Bonzini (1):
      KVM: VMX: support MSR_IA32_ARCH_CAPABILITIES as a feature MSR

Paul Burton (1):
      MIPS: Fix off-by-one in pci_resource_to_user()

Rafael J. Wysocki (1):
      driver core: Partially revert "driver core: correct device's shutdown=
 order"

Roi Dayan (1):
      net/mlx5e: Only allow offloading decap egress (egdev) flows

Roman Fietze (1):
      can: m_can.c: fix setup of CCCR register: clear CCCR NISO bit before =
checking can.ctrlmode

Roopa Prabhu (4):
      rtnetlink: add rtnl_link_state check in rtnl_configure_link
      vxlan: add new fdb alloc and create helpers
      vxlan: make netlink notify in vxlan_fdb_destroy optional
      vxlan: fix default fdb entry netlink notify ordering during netdev cr=
eate

Saeed Mahameed (1):
      net/mlx5: E-Switch, UBSAN fix undefined behavior in mlx5_eswitch_mode

Samuel Thibault (1):
      staging: speakup: fix wraparound in uaccess length check

Schmauss, Erik (1):
      ACPICA: AML Parser: ignore dispatcher error status during table load

Shay Agroskin (1):
      net/mlx5e: Refine ets validation function

Stephane Grosjean (1):
      can: peak_canfd: fix firmware < v3.3.0: limit allocation to 32-bit DM=
A addr only

Uwe Kleine-K=F6nig (1):
      net: dsa: mv88e6xxx: fix races between lock and irq freeing

Willem de Bruijn (1):
      ip: in cmsg IP(V6)_ORIGDSTADDR call pskb_may_pull

Yuchung Cheng (4):
      tcp: fix dctcp delayed ACK schedule
      tcp: helpers to send special DCTCP ack
      tcp: do not cancel delay-AcK on DCTCP special ACK
      tcp: do not delay ACK in DCTCP upon CE status change

Zhao Chen (1):
      net-next/hinic: fix a problem in hinic_xmit_frame()

Zheng Xiaowei (1):
      usb: xhci: Fix memory leak in xhci_endpoint_reset()


--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltcDLQACgkQONu9yGCS
aT5qNg/+Kql/B+nyGkElcOjgtjlC036z6hH9yKz0RY3F7rVfQRkmPajb8A+6Cn1Q
1q5r8d6LlSVSBBPcHSU4OHREgi1fB0FEdHg3/GpXRyR0dj45sgFO4FMiwmCrikCp
JHc7Tx0SZ+pfGkkWknLWmhW1VbRrsvx/QTAofMm01ke/lHfmnodNN/yTlZ74q6Oe
na1amJyuA3dnyY3SOFIBNN4V8XnXXsf1nfPnqPavLtk3cig29G1nZQvApwScFzcT
Cdfi7FLGks7TYv2AvnHQeTs0YrMsbJidYBpfkTTOLUWXXdErWOyeynWibzfIJH8z
8M0kdiDERytstS117WfUIA1KuL/6x4BZO80f0X/E80kUjBSz1AmaFLfJH621OBZ/
epJoGyz606KaBPPzEjybJ6NfM0K6mu3gwi0rXjSen2RBdTAuI/usA7UrqJx5JGTC
vVHxGEiBhb141Ow+BUuayOE5ZZtchIvSqsWF0hrot3gAjzz9eEfgGm8qo5cgoaoD
jaqzuFkd/fnoFKzBF5/hIaDAFF7eslVwsDm2zzHeMr/asYQdi6vI1c8Gh/+1dE/r
q/1qsjoitIie5bFtRtag1HzEdVvkt7Pau/p2Qt2EY5vPCGkuHpnGcXefYmXWxXbs
73P1uizskfPZ8Yz8+I0Es1dZWJaY45MTBnohsyNvRywAgjdP0cQ=
=F4Ww
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
