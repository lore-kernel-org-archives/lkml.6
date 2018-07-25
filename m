Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9565C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF64120685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF64120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbeGYKwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:52:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbeGYKwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:52:24 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 62C53CC3;
        Wed, 25 Jul 2018 09:41:18 +0000 (UTC)
Date:   Wed, 25 Jul 2018 11:41:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.115
Message-ID: <20180725094116.GA25314@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.115 kernel.

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

 Makefile                                   |    2 -
 arch/arc/configs/axs101_defconfig          |    1=20
 arch/arc/configs/axs103_defconfig          |    1=20
 arch/arc/configs/axs103_smp_defconfig      |    1=20
 arch/arc/configs/nsim_700_defconfig        |    1=20
 arch/arc/configs/nsim_hs_defconfig         |    1=20
 arch/arc/configs/nsim_hs_smp_defconfig     |    1=20
 arch/arc/configs/nsimosci_defconfig        |    1=20
 arch/arc/configs/nsimosci_hs_defconfig     |    1=20
 arch/arc/configs/nsimosci_hs_smp_defconfig |    1=20
 arch/arc/include/asm/page.h                |    2 -
 arch/arc/include/asm/pgtable.h             |    2 -
 arch/x86/include/asm/apm.h                 |    6 ----
 arch/x86/kernel/apm_32.c                   |    5 +++
 arch/x86/kernel/cpu/mcheck/mce.c           |    3 --
 block/blk-core.c                           |    9 ++----
 drivers/gpu/drm/i915/i915_irq.c            |   32 +++++++++++++++++++++--
 drivers/net/ethernet/broadcom/tg3.c        |    9 ++++++
 drivers/net/phy/phy_device.c               |    7 +----
 drivers/net/usb/asix_devices.c             |    4 ++
 drivers/net/usb/qmi_wwan.c                 |    1=20
 drivers/ptp/ptp_chardev.c                  |    1=20
 drivers/usb/host/xhci.c                    |   40 ++++++++++++++++++++++++=
++---
 drivers/usb/host/xhci.h                    |    4 ++
 drivers/vfio/pci/vfio_pci.c                |    4 ++
 fs/fat/inode.c                             |   20 +++++++++-----
 include/linux/skbuff.h                     |   10 +++----
 include/net/ipv6.h                         |    2 -
 lib/rhashtable.c                           |   17 +++++++-----
 mm/huge_memory.c                           |    2 +
 mm/memcontrol.c                            |    2 -
 net/core/gen_stats.c                       |   16 ++++++++++-
 net/core/skbuff.c                          |    1=20
 net/ipv4/fib_frontend.c                    |    1=20
 net/ipv4/sysctl_net_ipv4.c                 |    5 ++-
 net/ipv4/tcp.c                             |    3 --
 net/sunrpc/xprtrdma/rpc_rdma.c             |    2 -
 sound/core/rawmidi.c                       |   20 ++++++++++----
 virt/kvm/eventfd.c                         |    6 +++-
 39 files changed, 175 insertions(+), 72 deletions(-)

Alan Jenkins (1):
      block: do not use interruptible wait anywhere

Alexander Couzens (1):
      net: usb: asix: replace mii_nway_restart in resume path

Alexey Brodkin (2):
      ARC: Fix CONFIG_SWAP
      ARC: configs: Remove CONFIG_INITRAMFS_SOURCE from defconfigs

Chuck Lever (1):
      xprtrdma: Return -ENOBUFS when no pages are available

Colin Ian King (1):
      ipv6: fix useless rol32 call on hash

David Ahern (1):
      net/ipv4: Set oif in fib_compute_spec_dst

Davidlohr Bueso (1):
      lib/rhashtable: consider param->min_size when setting initial table s=
ize

Dewet Thibaut (1):
      x86/MCE: Remove min interval polling limitation

Greg Kroah-Hartman (1):
      Linux 4.9.115

Gustavo A. R. Silva (2):
      vfio/pci: Fix potential Spectre v1
      ptp: fix missing break in switch

Heiner Kallweit (1):
      net: phy: fix flag masking in __set_phy_supported

Hugh Dickins (1):
      mm/huge_memory.c: fix data loss when splitting a file pmd

Jing Xia (1):
      mm: memcg: fix use after free in mem_cgroup_iter()

Lan Tianyu (1):
      KVM/Eventfd: Avoid crash when assign and deassign specific eventfd in=
 parallel.

Lorenzo Colitti (1):
      net: diag: Don't double-free TCP_NEW_SYN_RECV sockets in tcp_abort

Matevz Vucnik (1):
      qmi_wwan: add support for Quectel EG91

Mathias Nyman (1):
      xhci: Fix perceived dead host due to runtime suspend race with event =
handler

OGAWA Hirofumi (1):
      fat: fix memory allocation failure handling of match_strdup()

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

Vineet Gupta (1):
      ARC: mm: allow mprotect to make stack mappings executable


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltYRbkACgkQONu9yGCS
aT4y2xAAkIZ8U27E5Kt1BA1USXyOzBXcBS9jpa5BtD/AYC8RG2EhbU0EWZKO1P8o
otFkKBpKyUSvqdmtH3Piq5seHFajxr8yJZwXCcveNJZzh1LKvXwxmWBPHcSNHea5
raiGdVCaxMbkDEVMHtE04DQVZWZBN2TdYU8iaOIGvRT012Z5hIMbkqE+uKsLjWvx
PikSlGsT2an7kNJ4SFjpRnRyYIHWe3+4DrkQGd6O+HSbFZRTK71UcsLQwr9w+RHp
rXmUAxBR49Ip7F9HxBVFeRy7BjwLXcd7qydXfQXAfDGoDWlAJ8vyXJI1muAdekFk
RECRWrZnDiz8kyp0tu6l+rk3uRsQ2tclX+lbETdvU0AybyoQMsHjWYkcqjGSS2vU
O3vxAl/VQI1O8Gzwz5SV5EFirwddhU+cydMxle5xla9tuL4GetUZ9D4gndeNQKhQ
j8wsZyZt0KRI8qdCoIV5RDUwxgOIsVmNu5gOjBJCoRxEFFJ4QkHGHbSKunZMNtBq
i4Hrk4HCsNXe1lCIBtW8mU/Yw3hI7g8uAT2KqfOi8fqjOdaVx71LGtoEO2jlNuNu
oVcM+vmSCcvT6PH3GYg3a0aGQOnluv9SY9eiOa/T9BVr2onq0YY3k4Y5x6DH3uKR
HZzwOGeawDpTpq/Z3HIhzExYND6lr4LA2qotCLiAlm3iWaUeoHY=
=IhBN
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
