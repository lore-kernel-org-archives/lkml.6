Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C6DC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201A820685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201A820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbeGYKwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:52:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43506 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbeGYKwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:52:38 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 84236BBF;
        Wed, 25 Jul 2018 09:41:43 +0000 (UTC)
Date:   Wed, 25 Jul 2018 11:41:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.58
Message-ID: <20180725094141.GA25425@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.58 kernel.

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

 Makefile                                    |    2 -
 arch/alpha/kernel/osf_sys.c                 |    5 ---
 arch/arc/Kconfig                            |    2 -
 arch/arc/configs/axs101_defconfig           |    1=20
 arch/arc/configs/axs103_defconfig           |    1=20
 arch/arc/configs/axs103_smp_defconfig       |    1=20
 arch/arc/configs/haps_hs_defconfig          |    1=20
 arch/arc/configs/haps_hs_smp_defconfig      |    1=20
 arch/arc/configs/hsdk_defconfig             |    1=20
 arch/arc/configs/nsim_700_defconfig         |    1=20
 arch/arc/configs/nsim_hs_defconfig          |    1=20
 arch/arc/configs/nsim_hs_smp_defconfig      |    1=20
 arch/arc/configs/nsimosci_defconfig         |    1=20
 arch/arc/configs/nsimosci_hs_defconfig      |    1=20
 arch/arc/configs/nsimosci_hs_smp_defconfig  |    1=20
 arch/arc/include/asm/page.h                 |    2 -
 arch/arc/include/asm/pgtable.h              |    2 -
 arch/arc/plat-hsdk/Kconfig                  |    2 +
 arch/powerpc/kernel/idle_book3s.S           |    2 +
 arch/x86/events/intel/ds.c                  |    8 +++--
 arch/x86/include/asm/apm.h                  |    6 ----
 arch/x86/kernel/apm_32.c                    |    5 +++
 arch/x86/kernel/cpu/mcheck/mce.c            |    3 --
 drivers/cpufreq/intel_pstate.c              |   17 +++++++++++
 drivers/cpufreq/pcc-cpufreq.c               |    4 ++
 drivers/gpu/drm/i915/i915_irq.c             |   32 +++++++++++++++++++++-
 drivers/gpu/drm/nouveau/nouveau_backlight.c |    6 ++--
 drivers/gpu/drm/nouveau/nouveau_connector.c |    9 ++++--
 drivers/gpu/drm/nouveau/nouveau_connector.h |   36 ++++++++++++++++++++++-=
--
 drivers/gpu/drm/nouveau/nouveau_display.c   |   10 +++++--
 drivers/misc/cxl/api.c                      |    8 ++---
 drivers/net/ethernet/broadcom/bcmsysport.c  |    4 +-
 drivers/net/ethernet/broadcom/bcmsysport.h  |    3 +-
 drivers/net/ethernet/broadcom/tg3.c         |    9 ++++++
 drivers/net/ethernet/mellanox/mlx4/en_rx.c  |    8 ++++-
 drivers/net/hyperv/netvsc.c                 |   17 +++++++----
 drivers/net/phy/phy_device.c                |    7 +---
 drivers/net/usb/asix_devices.c              |    4 ++
 drivers/net/usb/qmi_wwan.c                  |    1=20
 drivers/ptp/ptp_chardev.c                   |    1=20
 drivers/scsi/sd_zbc.c                       |    5 ++-
 drivers/usb/host/xhci.c                     |   40 +++++++++++++++++++++++=
++---
 drivers/usb/host/xhci.h                     |    4 ++
 drivers/vfio/pci/vfio_pci.c                 |    4 ++
 drivers/vfio/vfio_iommu_spapr_tce.c         |    8 ++---
 fs/fat/inode.c                              |   20 +++++++++-----
 include/linux/sched/task.h                  |    2 -
 include/linux/skbuff.h                      |   10 +++----
 include/net/ipv6.h                          |    2 -
 kernel/stop_machine.c                       |    6 +++-
 lib/rhashtable.c                            |   17 +++++++----
 mm/huge_memory.c                            |    2 +
 mm/memcontrol.c                             |    2 -
 net/core/gen_stats.c                        |   16 +++++++++--
 net/core/skbuff.c                           |    1=20
 net/ipv4/fib_frontend.c                     |    1=20
 net/ipv4/sysctl_net_ipv4.c                  |    5 ++-
 net/ipv4/tcp.c                              |    3 --
 net/ipv6/Kconfig                            |    1=20
 net/ipv6/ndisc.c                            |    2 -
 sound/core/rawmidi.c                        |   20 +++++++++-----
 sound/pci/hda/patch_conexant.c              |    1=20
 sound/pci/hda/patch_realtek.c               |    1=20
 virt/kvm/eventfd.c                          |    6 +++-
 64 files changed, 294 insertions(+), 112 deletions(-)

Al Viro (2):
      alpha: fix osf_wait4() breakage
      cxl_getfile(): fix double-iput() on alloc_file() failures

Alexander Couzens (1):
      net: usb: asix: replace mii_nway_restart in resume path

Alexey Brodkin (2):
      ARC: Fix CONFIG_SWAP
      ARC: configs: Remove CONFIG_INITRAMFS_SOURCE from defconfigs

Alexey Kardashevskiy (1):
      vfio/spapr: Use IOMMU pageshift rather than pagesize

Arnd Bergmann (1):
      ipv6: ila: select CONFIG_DST_CACHE

Colin Ian King (1):
      ipv6: fix useless rol32 call on hash

Damien Le Moal (1):
      scsi: sd_zbc: Fix variable type and bogus comment

David Ahern (1):
      net/ipv4: Set oif in fib_compute_spec_dst

Davidlohr Bueso (1):
      lib/rhashtable: consider param->min_size when setting initial table s=
ize

Dewet Thibaut (1):
      x86/MCE: Remove min interval polling limitation

Florian Fainelli (1):
      net: systemport: Fix CRC forwarding check for SYSTEMPORT Lite

Gautham R. Shenoy (1):
      powerpc/powernv: Fix save/restore of SPRG3 on entry/exit from stop (i=
dle)

Greg Kroah-Hartman (1):
      Linux 4.14.58

Gustavo A. R. Silva (2):
      vfio/pci: Fix potential Spectre v1
      ptp: fix missing break in switch

Haiyang Zhang (1):
      hv_netvsc: Fix napi reschedule while receive completion is busy

Heiner Kallweit (1):
      net: phy: fix flag masking in __set_phy_supported

Hugh Dickins (2):
      x86/events/intel/ds: Fix bts_interrupt_threshold alignment
      mm/huge_memory.c: fix data loss when splitting a file pmd

Isaac J. Manjarres (1):
      stop_machine: Disable preemption when waking two stopper threads

Jing Xia (1):
      mm: memcg: fix use after free in mem_cgroup_iter()

Lan Tianyu (1):
      KVM/Eventfd: Avoid crash when assign and deassign specific eventfd in=
 parallel.

Lorenzo Colitti (1):
      net: diag: Don't double-free TCP_NEW_SYN_RECV sockets in tcp_abort

Lyude Paul (2):
      drm/nouveau: Use drm_connector_list_iter_* for iterating connectors
      drm/nouveau: Avoid looping through fake MST connectors

Matevz Vucnik (1):
      qmi_wwan: add support for Quectel EG91

Mathias Nyman (1):
      xhci: Fix perceived dead host due to runtime suspend race with event =
handler

OGAWA Hirofumi (1):
      fat: fix memory allocation failure handling of match_strdup()

Po-Hsu Lin (1):
      ALSA: hda: add mute led support for HP ProBook 455 G5

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Register when ACPI PCCH is present

Sabrina Dubroca (1):
      ipv6: make DAD fail with enhanced DAD when nonce length differs

Saeed Mahameed (1):
      net/mlx4_en: Don't reuse RX page when XDP is set

Sanjeev Bansal (1):
      tg3: Add higher cpu clock for 5762.

Stefano Brivio (2):
      net: Don't copy pfmemalloc flag in __copy_skb_header()
      skbuff: Unconditionally copy pfmemalloc in __skb_clone()

Takashi Iwai (1):
      ALSA: rawmidi: Change resized buffers atomically

Toke H=F8iland-J=F8rgensen (1):
      gen_stats: Fix netlink stats dumping in the presence of padding

Tyler Hicks (1):
      ipv4: Return EINVAL when ping_group_range sysctl doesn't map to user =
ns

Ville Syrj=E4l=E4 (2):
      x86/apm: Don't access __preempt_count with zeroed fs
      drm/i915: Fix hotplug irq ack on i965/g4x

Vineet Gupta (2):
      ARCv2: [plat-hsdk]: Save accl reg pair by default
      ARC: mm: allow mprotect to make stack mappings executable

YOKOTA Hiroshi (1):
      ALSA: hda/realtek - Add Panasonic CF-SZ6 headset jack quirk


--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltYRdUACgkQONu9yGCS
aT530Q/9Gqz5jG8BPP4libhoNfOkKUJelyyWETk1oTzjHNjdJ4z8GkMIwoEDkpFz
AO73kLCdALv9+4ne8qKz38Xn3xbfJypuuxuJzDuhM7as9fJIp5WCn1OkLunHi9Eo
95489AXAdklSZreEJ8fnNm5Vrij4VN7pCMVIgzd9nN80jK6v+apT1LizBUsVGnQt
GxVeFaUqTagcZN+sL7WtlrM8W4v0vpe144Pnn8u/NKd2sXC1s72+7yu6DSeUU3JK
s45r0PV0JYVY7loGd/+eobK5XMPu+DEQPgSUfHeSA9QWExbuu1S0IgYeHVNqdhMB
XPaYCqnSHVJ441yHWz/If59JEhfIQx5j2fFu3MiW+V25mCpOIXylUZYFlpo/VeWF
hrVXjZKlYmZQrSZzZN8VHbP5kc5iIWSxOGLFkQpoxMXE9ZKl1aLuDDxd7hhAMrGj
Cz9l3e43UZOE7m5ehicNAj9yhzghQKUxXcU/5snlMQHYpsLVD6vx+tTCG6fzv7bH
RI+lwcZAUiCe4Y8sIXPLiZCYpFY5AJ6m0M/cRmRBaMpV54TsNNRWc2CJIrEeftaQ
QYWNQ4a/joe4Rfl5VU9gj5Bc9xzWy5hJ2PfdpnyqtOm4GxiuaOiJHQZuGSaa2w2E
xIWWVFIyBIKRk9H7ahIVkdp1pQz69zS8vf9U2kVFu2TMRNMCi28=
=pkM2
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
