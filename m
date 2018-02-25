Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3799018-1519556899-2-12756154230613700630
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
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
    t=1519556898; b=OyVjCJc+0ADkhY2r2Yr/YCTLV1nD0/U258jDxr77PmtyWGF
    5qEDUdKEsq9bSqM5bMc3rqvDpsM3KjAeLPwsbFTK2hkL58D0j2FyFvaAO2RtqrpC
    X4N9w4o2ldj1RmbT7/27wodsZgGg2FQfwqRlZX6GBdPI15fjVnsl68Ia0bWT2QVe
    3nV/eaXW/sdjdEeoOhsn7IYcO27bvm/n1RTlpKZbZQNoKnGgKmoAo+5vxsIAK+q9
    yZ1pKuSBjtLycaH4y6ANEuhhvT51iKGyDQ5knk7xIh/RcVgU9Tmnlw9xYUQPPXqO
    q93lRCA7uma3wOlRneBc+Jjr8JYevb3Iqdu0A6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519556898; bh=9MLBwJvFF9ESs8z1mvFJNnZQzrW8qw86gUhW8VLBVRw=; b=Q
    lLDJnxjaNtGELix4mdO/4fmOAmRURqX33UnbKzRwRMSa7LSW8aIr+2ldzwEqcm+R
    xysGp8hK+Vzx7SYaprOfHkKw40nHgs80KTNncNVo5N/ICnOUDJU05W1tUzV3OfoH
    Boi8H7YwqZetwNNuhCRIBhZ9aILFi1Jad+NvpXvf71eQW22sMSaEf5x8feMdzcHo
    fOvS3rlJwsYhFHCdltgiSfA6/NasGLaD5hh+JgHjIRqG7TP5uerXcK3tc2qiNsQI
    XE1X3lm55h1XH0ciBUPlPLc66CU1Cc4afplgJAGs/K7jIIAUxonPcTgwbmQ96Una
    eKqU4zWwJZVxnEluB/DaA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeBYLIR (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 06:08:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41174 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbeBYLIP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Feb 2018 06:08:15 -0500
Date: Sun, 25 Feb 2018 12:08:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.96
Message-ID: <20180225110809.GA21422@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.96 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/dma/snps-dma.txt |    2=20
 Documentation/filesystems/ext4.txt                 |    2=20
 Makefile                                           |    2=20
 arch/arm/boot/dts/am4372.dtsi                      |    6 -
 arch/arm/boot/dts/s5pv210.dtsi                     |    1=20
 arch/arm/boot/dts/spear1310-evb.dts                |    2=20
 arch/arm/boot/dts/spear1340.dtsi                   |    4=20
 arch/arm/boot/dts/spear13xx.dtsi                   |    6 -
 arch/arm/boot/dts/spear600.dtsi                    |    1=20
 arch/arm/mach-omap2/prm33xx.c                      |   12 --
 arch/powerpc/perf/core-book3s.c                    |    4=20
 arch/s390/kernel/compat_linux.c                    |    8 -
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S       |  112 +++++++++++-----=
-----
 arch/x86/kvm/x86.c                                 |   34 ++++--
 arch/x86/mm/ioremap.c                              |    4=20
 arch/x86/mm/kmmio.c                                |   12 +-
 drivers/Makefile                                   |    1=20
 drivers/crypto/s5p-sss.c                           |   13 +-
 drivers/devfreq/devfreq.c                          |    2=20
 drivers/dma/dma-jz4740.c                           |    4=20
 drivers/gpu/drm/radeon/radeon_uvd.c                |    2=20
 drivers/infiniband/hw/mlx4/main.c                  |   13 --
 drivers/media/i2c/s5k6aa.c                         |    5=20
 drivers/media/tuners/r820t.c                       |   13 +-
 drivers/net/ethernet/freescale/gianfar.c           |    6 -
 drivers/net/ethernet/mellanox/mlx4/qp.c            |    3=20
 drivers/net/hippi/rrunner.c                        |    2=20
 drivers/s390/block/dasd_eckd.c                     |   16 +--
 drivers/spi/spi-sun4i.c                            |    2=20
 drivers/usb/usbip/stub_dev.c                       |    3=20
 drivers/usb/usbip/vhci_hcd.c                       |    2=20
 drivers/video/console/dummycon.c                   |    1=20
 drivers/video/fbdev/atmel_lcdfb.c                  |    8 +
 drivers/video/fbdev/mmp/core.c                     |    5=20
 drivers/xen/Kconfig                                |    2=20
 fs/btrfs/inode.c                                   |    5=20
 fs/btrfs/ioctl.c                                   |    2=20
 fs/btrfs/tree-log.c                                |    9 +
 fs/ext4/super.c                                    |    1=20
 include/linux/string.h                             |    1=20
 include/net/red.h                                  |   13 ++
 lib/oid_registry.c                                 |    8 +
 mm/early_ioremap.c                                 |    2=20
 mm/util.c                                          |   24 ++++
 mm/vmscan.c                                        |    3=20
 net/core/dev.c                                     |    2=20
 net/decnet/af_decnet.c                             |   62 ++++++-----
 net/ipv4/ip_sockglue.c                             |   14 --
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |   16 ++-
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c     |    6 -
 net/ipv6/ipv6_sockglue.c                           |   17 ---
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c     |   18 ++-
 net/netfilter/x_tables.c                           |   10 +
 net/netfilter/xt_RATEEST.c                         |   22 +++-
 net/sched/sch_choke.c                              |    3=20
 net/sched/sch_gred.c                               |    3=20
 net/sched/sch_red.c                                |    2=20
 net/sched/sch_sfq.c                                |    3=20
 net/xfrm/xfrm_user.c                               |   24 ++++
 scripts/kernel-doc                                 |    2=20
 security/selinux/ss/services.c                     |   21 ++-
 sound/core/seq/seq_clientmgr.c                     |   23 ++--
 sound/soc/ux500/mop500.c                           |    4=20
 sound/soc/ux500/ux500_pcm.c                        |    5=20
 tools/perf/bench/numa.c                            |   56 +++++++++-
 tools/perf/builtin-top.c                           |   15 ++
 66 files changed, 477 insertions(+), 234 deletions(-)

Arnd Bergmann (4):
      ARM: dts: s5pv210: add interrupt-parent for ohci
      media: r820t: fix r820t_write_reg for KASAN
      ASoC: ux500: add MODULE_LICENSE tag
      video: fbdev/mmp: add MODULE_LICENSE

Bjorn Andersson (1):
      PM / devfreq: Propagate error from devfreq_add_device()

Cong Wang (2):
      xfrm: check id proto in validate_tmpl()
      netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert

Dave Young (1):
      mm/early_ioremap: Fix boot hang with earlyprintk=3Defi,keep

David Howells (1):
      Provide a function to create a NUL-terminated string from unterminate=
d data

Dmitry Vyukov (2):
      netfilter: x_tables: fix int overflow in xt_alloc_table_info()
      netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_=
check()

Eric Biggers (2):
      crypto: x86/twofish-3way - Fix %rbp usage
      509: fix printing uninitialized stack memory when OID is empty

Eric Dumazet (1):
      netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{ma=
tch|target}

Ernesto A. Fern=E1ndez (1):
      ext4: correct documentation for grpid mount option

Eugene Syromiatnikov (1):
      s390: fix handling of -1 in set{,fs}[gu]id16 syscalls

Greg Kroah-Hartman (1):
      Linux 3.18.96

Jack Morgenstein (1):
      IB/mlx4: Fix incorrectly releasing steerable UD QPs when have only ET=
H ports

Jan Beulich (1):
      xen: XEN_ACPI_PROCESSOR is Dom0-only

Jia-Ju Bai (1):
      hippi: Fix a Fix a possible sleep-in-atomic bug in rr_close

Jiri Olsa (1):
      perf top: Fix window dimensions change handling

Johan Hovold (1):
      video: fbdev: atmel_lcdfb: fix display-timings lookup

Julia Lawall (1):
      drm/radeon: adjust tested variable

Kamil Konieczny (1):
      crypto: s5p-sss - Fix kernel Oops in AES-ECB mode

Karol Herbst (1):
      x86/mm/kmmio: Fix mmiotrace for page unaligned addresses

Keerthy (1):
      ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst function

Liu Bo (2):
      Btrfs: fix deadlock in run_delalloc_nocow
      Btrfs: fix crash due to not cleaning up tree log block's dirty bits

Mauro Carvalho Chehab (1):
      media: s5k6aa: describe some function parameters

Nicolas Pitre (1):
      console/dummy: leave .con_font_get set to NULL

Nikolay Borisov (1):
      btrfs: Fix possible off-by-one in btrfs_search_path_in_tree

Nogah Frankel (2):
      net_sched: red: Avoid devision by zero
      net_sched: red: Avoid illegal values

Paolo Abeni (2):
      netfilter: on sockopt() acquire sock lock only in the required scope
      dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock

Paul Moore (2):
      selinux: skip bounded transition processing if the policy isn't loaded
      selinux: ensure the context is NUL terminated in security_context_to_=
sid_core()

Peter Ujfalusi (1):
      ARM: dts: am4372: Correct the interrupts_properties of McASP

Randy Dunlap (1):
      usb: build drivers/usb/common/ when USB_SUPPORT is set

Ravi Bangoria (1):
      powerpc/perf: Fix oops when grouping different pmu events

Satheesh Rajendran (1):
      perf bench numa: Fixup discontiguous/sparse numa nodes

Shuah Khan (1):
      usbip: keep usbip_device sockfd state in sync with tcp_socket

Stefan Haberland (1):
      s390/dasd: prevent prefix I/O error

Steffen Klassert (1):
      xfrm: Fix stack-out-of-bounds with misconfigured transport mode polic=
ies.

Takashi Iwai (2):
      ALSA: seq: Fix regression by incorrect ioctl_mutex usages
      ALSA: seq: Fix racy pool initializations

Takuo Koguchi (1):
      spi: sun4i: disable clocks in the remove function

Tetsuo Handa (1):
      mm,vmscan: Make unregister_shrinker() no-op if register_shrinker() fa=
iled.

Tobias Jordan (1):
      dmaengine: jz4740: disable/unprepare clk if probe fails

Viresh Kumar (3):
      arm: spear600: Add missing interrupt-parent of rtc
      arm: spear13xx: Fix dmas cells
      arm: spear13xx: Fix spics gpio controller's warning

Wanpeng Li (1):
      KVM: async_pf: Fix #DF due to inject "Page not Present" and "Page Rea=
dy" exceptions simultaneously

Will Deacon (1):
      scripts/kernel-doc: Don't fail with status !=3D 0 if error encountere=
d with -none

Willem de Bruijn (1):
      net: avoid skb_warn_bad_offload on IS_ERR

Zhouyi Zhou (1):
      ext4: save error to disk in __ext4_grp_locked_error()

Zumeng Chen (1):
      gianfar: fix a flooded alignment reports because of padding issue.


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqSmRUACgkQONu9yGCS
aT6ZaBAAr8y8hGJ6jA8aZPR+dsu8P9YbSrsiX5OQVSnchbQrrCC7kRtmgoe8KPW6
R9Ft3Mj++blAVLKkgxcMWGeIpIeTwAd/CerN4Ac8uQIUb+G43HfFOpB4zALOG5uS
RThGqwE8t/y15zWxCW8EAn0wsf5dxjdwXzxTyjmLBW7/I690Oz/jXjYJuElLll6Q
/ozvrJj/ymyFtgZgUuXZ3GNVI/iDefCS3s9Dpe59nOplZSmcz2PVxq9gK/otxBka
6GgPY6tluD79XmzACzoiaJyZ6RD89TWbtOTUNuzCZDTl7WDVsWauDz7YMowbelPZ
vmE0rLR6Qv4tbHijTGCz8sDavWsL57P6yWULHp1ETDHLK/tHeJGrarPZzs2kYMfB
eW3MGzKGuSLke+HmM3Tfnjceu56cDYhJ1JHerRnxo3Wi8U/9l76E0SHq5Sequ+eQ
NcHSqXESRzNRngHaAGk92YBvFF+zSbVcwIuoWRSE28wT3wIvC3+tQlqIFS956g6K
Slz53yYE9dcEY2fXVqjO9eA3zcM264AiRrV21Mx3tSNt+6woFf9qnG/TQRNFwsZs
e0adlK7xx/ZBTCu5JRv+385JKbSb6YiT8Bui9PPaDg/5VQHeBnmshWDdg1j5/KQ7
HhwdnByzhUn/utCw1VeYQ8xzuVxwOhr2d/m/s33nJYVWGSt/zDc=
=bN6n
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
