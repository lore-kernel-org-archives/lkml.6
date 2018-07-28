Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FA5C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242AC20891
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242AC20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeG1HwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 03:52:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeG1HwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 03:52:01 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C693CA95;
        Sat, 28 Jul 2018 06:26:42 +0000 (UTC)
Date:   Sat, 28 Jul 2018 08:26:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.59
Message-ID: <20180728062640.GA12057@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.59 kernel.

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

 Makefile                                              |    3=20
 arch/mips/ath79/common.c                              |    2=20
 arch/mips/pci/pci.c                                   |    2=20
 arch/powerpc/include/asm/mmu_context.h                |    4=20
 arch/powerpc/kvm/book3s_64_vio.c                      |    2=20
 arch/powerpc/kvm/book3s_64_vio_hv.c                   |    6=20
 arch/powerpc/mm/mmu_context_iommu.c                   |   37 +
 arch/x86/xen/xen-pvh.S                                |   26 +
 drivers/base/dd.c                                     |    8=20
 drivers/gpu/drm/nouveau/dispnv04/disp.c               |    3=20
 drivers/gpu/drm/nouveau/nouveau_drm.c                 |    7=20
 drivers/gpu/drm/nouveau/nv50_display.c                |    8=20
 drivers/net/bonding/bond_options.c                    |   23 -
 drivers/net/can/m_can/m_can.c                         |    3=20
 drivers/net/can/peak_canfd/peak_pciefd_main.c         |   19=20
 drivers/net/can/xilinx_can.c                          |  392 +++++++++++++=
-----
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c     |    7=20
 drivers/net/ethernet/mellanox/mlx5/core/en_clock.c    |   12=20
 drivers/net/phy/phy.c                                 |    2=20
 drivers/net/vxlan.c                                   |  126 +++--
 drivers/staging/speakup/speakup_soft.c                |    6=20
 drivers/usb/class/cdc-acm.c                           |    3=20
 drivers/usb/core/hub.c                                |    8=20
 drivers/usb/dwc2/hcd.c                                |   44 +-
 drivers/usb/gadget/function/f_fs.c                    |    2=20
 drivers/vfio/vfio_iommu_spapr_tce.c                   |    2=20
 fs/cifs/smb2pdu.c                                     |    7=20
 include/linux/skbuff.h                                |    2=20
 include/net/tcp.h                                     |    7=20
 net/core/rtnetlink.c                                  |    9=20
 net/core/skbuff.c                                     |   10=20
 net/ipv4/igmp.c                                       |    3=20
 net/ipv4/ip_output.c                                  |    2=20
 net/ipv4/ip_sockglue.c                                |    7=20
 net/ipv4/tcp_dctcp.c                                  |   50 --
 net/ipv4/tcp_input.c                                  |   65 ++
 net/ipv4/tcp_output.c                                 |   33 +
 net/ipv6/datagram.c                                   |    7=20
 net/ipv6/icmp.c                                       |    5=20
 net/ipv6/ip6_output.c                                 |    2=20
 net/ipv6/mcast.c                                      |    3=20
 net/ipv6/tcp_ipv6.c                                   |    6=20
 net/tls/tls_sw.c                                      |    7=20
 44 files changed, 690 insertions(+), 294 deletions(-)

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

Arnd Bergmann (1):
      turn off -Wattribute-alias

Bin Liu (1):
      usb: core: handle hub C_PORT_OVER_CURRENT condition

Boris Ostrovsky (1):
      xen/PVH: Set up GS segment for stack canary

Daniel Borkmann (1):
      sock: fix sg page frag coalescing in sk_alloc_sg

David Ahern (1):
      net/ipv6: Fix linklocal to global address with VRF

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

Felix Fietkau (1):
      MIPS: ath79: fix register address in ath79_ddr_wb_flush()

Greg Kroah-Hartman (2):
      Revert "cifs: Fix slab-out-of-bounds in send_set_info() on SMB2 ACE s=
etting"
      Linux 4.14.59

Hangbin Liu (1):
      multicast: do not restore deleted record source filter mode to new one

Heiner Kallweit (1):
      net: phy: consider PHY_IGNORE_INTERRUPT in phy_start_aneg_priv

Jack Morgenstein (1):
      net/mlx4_core: Save the qpn from the input modifier in RST2INIT wrapp=
er

Jarod Wilson (1):
      bonding: set default miimon value for non-arp modes if not set

Jerry Zhang (1):
      usb: gadget: f_fs: Only return delayed status when len is 0

Lubomir Rintel (1):
      usb: cdc_acm: Add quirk for Castles VEGA3000

Lyude Paul (2):
      drm/nouveau/drm/nouveau: Fix runtime PM leak in nv50_disp_atomic_comm=
it()
      drm/nouveau: Set DRIVER_ATOMIC cap earlier to fix debugfs

Paolo Abeni (1):
      ip: hash fragments consistently

Paul Burton (1):
      MIPS: Fix off-by-one in pci_resource_to_user()

Rafael J. Wysocki (1):
      driver core: Partially revert "driver core: correct device's shutdown=
 order"

Roman Fietze (1):
      can: m_can.c: fix setup of CCCR register: clear CCCR NISO bit before =
checking can.ctrlmode

Roopa Prabhu (4):
      rtnetlink: add rtnl_link_state check in rtnl_configure_link
      vxlan: add new fdb alloc and create helpers
      vxlan: make netlink notify in vxlan_fdb_destroy optional
      vxlan: fix default fdb entry netlink notify ordering during netdev cr=
eate

Samuel Thibault (1):
      staging: speakup: fix wraparound in uaccess length check

Stephane Grosjean (1):
      can: peak_canfd: fix firmware < v3.3.0: limit allocation to 32-bit DM=
A addr only

Willem de Bruijn (1):
      ip: in cmsg IP(V6)_ORIGDSTADDR call pskb_may_pull

Yuchung Cheng (4):
      tcp: fix dctcp delayed ACK schedule
      tcp: helpers to send special DCTCP ack
      tcp: do not cancel delay-AcK on DCTCP special ACK
      tcp: do not delay ACK in DCTCP upon CE status change


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltcDKAACgkQONu9yGCS
aT41ag/+LHTAvGtGuXx6dAgScDN8kQitOkG2OgWDcsqLC3lM/y2gDYA5uzRSSMkk
Fa3YHEHZ08Som4gYoqWl6jpVGp0aZ8AyrlFjLYb3HF6hsx9FWsZKW6cTLeaK+23Z
hOzaZtLWsFFOj2Upr4zvXkHvl416G8T8WPifuJaRt3BBll8RkQY6ER6xHuN99E15
DPt7sT4ZjGhFnrmyu3jIXNV0qPDUvym99GbBm6xkxx54VmvvomNvGU3jrz7/nl9o
Il6nmR9fh+F16+kQRuzThrxEoPgv+qRLi7ioC21fNoTBIUw/DmpkR13PGcejvhcr
4KP/ehQV7vFp7DU4umA0s2MfM/kjKirY5VB5Dgi6SSmUE6ySbR/h7PGQmacKsj2n
9j7jVLS8MuY4MuaEh8ChCvIJqDLbsZhGzyNLOgZOzEsGmxbGhrGncS9dofQ5gyeU
mOFbzkBKcD0EXT/HxrsU29+dg7/kNhFXPInis/QwsoDmKXUlUXz/HjORALa+N0rn
os3ThV7DOix0m76YuDRxN0bfMQSpzA6q8af6O5ACCtSfo6RAQmdjdOt0NU8Vctt1
1oJy1LOxPtphhA58176xb5ENxCdr0hRYG5V+AjRoAeXbs39VYmFlyGraYcY8b7Kn
hs9ae006+R2nFA0w8f/ynOirnhAzCGtZvSx3zT5TeV+j0nXArvw=
=p0wn
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
