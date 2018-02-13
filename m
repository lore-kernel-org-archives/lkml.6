Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3813382-1518514461-2-11589884921189668893
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518514460; b=a4CahB8AVSzy7HN1j6b9uPU83Eo4j/LDJVHVffKwdfkXSXM
    8GPSGb3TpcsfukHGcOAxzXEeX7RoKW2XAPIfVibzJ/fORFXsqMHU2A5kkCTtyhjS
    0AMuVEvZaQL9Ua+rVbx3C2dRT214rqzk3vZCgZzcURRrjFnls1v0A/4YFSrrGjr+
    pIwJaKnuKrd5ziBD5O1G1tNKy+5RqaXowgt61D+ApknOBcYKdaGLA10GYkLZT3Kz
    JSRIovbi9uYpIiZOyidjZ0FVjP+k/RoS8L0I4JGcL9FsgxtXMGvGqKUkaJ19ramj
    kV+HzTirZ4KsfXnjg78GSUv5mEUxcDX9JYm6vOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518514460; bh=uJvAYx90HdevXumqy5hmb+p90wVcIUVmj/ggzEgGakU=; b=S
    JZD6X4it16kLM2B1c0nMZAL/EAD18QwMyhkcow72nbtFc/xpaY9DMiJ5TlqNWBM6
    SzUbOGuf1tZK4DrGh9qkauuVyvBsTdgOi5N6YsCiOuCqRaaEIRJcPcyEFgZnmuFd
    5xIAeAS0mJc5BdOe3gg/ZpaFI1GtP/GhuiaZ9U52aU2e8fBmpvW1Jac5doBRDvao
    7gHmtLtmVpUpqIl0QplrzI6Sk0F/DtDZNeJN9QCWtHRCNsNOSGyFGwNN8ji+YfbH
    8/qwWfZrki6vbPKLyOAByX/ZewGAc5AUBFbaMeYcSallVUrRHEGhAdMy79neSNcP
    PoIOKGA/54oOV0bN9LmCQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934322AbeBMJdC (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:33:02 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54840 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933936AbeBMJc7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 04:32:59 -0500
Date: Tue, 13 Feb 2018 10:32:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.19
Message-ID: <20180213093257.GA29345@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.19 kernel.

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

 .gitignore                                          |   49 +++++++++++----=
-----
 Makefile                                            |    2=20
 arch/arc/boot/.gitignore                            |    1=20
 arch/arm/boot/.gitignore                            |    1=20
 arch/arm/kernel/traps.c                             |    1=20
 arch/arm64/boot/dts/.gitignore                      |    1=20
 arch/m32r/kernel/traps.c                            |    1=20
 arch/metag/boot/.gitignore                          |    1=20
 arch/microblaze/boot/.gitignore                     |    1=20
 arch/mips/boot/.gitignore                           |    1=20
 arch/nios2/boot/.gitignore                          |    1=20
 arch/powerpc/boot/.gitignore                        |    1=20
 arch/unicore32/kernel/traps.c                       |    1=20
 arch/x86/kernel/alternative.c                       |   14 ++---
 arch/xtensa/boot/.gitignore                         |    1=20
 crypto/tcrypt.c                                     |    6 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c |    3 +
 drivers/media/platform/soc_camera/soc_scale_crop.c  |    4 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c |   18 +++----
 drivers/net/ethernet/realtek/r8169.c                |    4 -
 drivers/net/ethernet/rocker/rocker_main.c           |   18 +++----
 drivers/net/usb/qmi_wwan.c                          |    1=20
 drivers/of/unittest-data/.gitignore                 |    2=20
 drivers/scsi/storvsc_drv.c                          |    4 +
 drivers/vhost/net.c                                 |    1=20
 kernel/exit.c                                       |    9 +++
 mm/memcontrol.c                                     |   14 +++++
 net/core/sock.c                                     |    5 --
 net/core/sock_reuseport.c                           |   35 ++++++++------
 net/ipv4/igmp.c                                     |    4 +
 net/ipv4/inet_connection_sock.c                     |    1=20
 net/ipv4/tcp.c                                      |    6 ++
 net/ipv4/tcp_bbr.c                                  |    6 +-
 net/ipv6/addrconf.c                                 |   30 ++++++++++--
 net/ipv6/af_inet6.c                                 |   11 ++--
 net/ipv6/ip6mr.c                                    |    1=20
 net/ipv6/ndisc.c                                    |    5 ++
 scripts/package/Makefile                            |    4 -
 38 files changed, 170 insertions(+), 99 deletions(-)

Andrew Morton (1):
      kernel/exit.c: export abort() to modules

Chunhao Lin (1):
      r8169: fix RTL8168EP take too long to complete driver initialization.

Dan Carpenter (1):
      scsi: storvsc: missing error code in storvsc_probe()

David Ahern (1):
      net: ipv6: send unsolicited NA after DAD

Eric Dumazet (2):
      net: igmp: add a missing rcu locking section
      soreuseport: fix mem leak in reuseport_add_sock()

Greg Kroah-Hartman (2):
      Revert "x86/alternative: Print unadorned pointers"
      Linux 4.14.19

Jason Wang (1):
      vhost_net: stop device during reset owner

Jesse Chan (2):
      media: mtk-vcodec: add missing MODULE_LICENSE/DESCRIPTION
      media: soc_camera: soc_scale_crop: add missing MODULE_DESCRIPTION/AUT=
HOR/LICENSE

Jiri Pirko (1):
      rocker: fix possible null pointer dereference in rocker_router_fib_ev=
ent_work

Junxiao Bi (1):
      qlcnic: fix deadlock bug

Kristian Evensen (1):
      qmi_wwan: Add support for Quectel EP06

Li RongQing (1):
      tcp: release sk_frag.page in tcp_disconnect

Martin KaFai Lau (1):
      ipv6: Fix SO_REUSEPORT UDP socket with implicit sk_ipv6only

Masahiro Yamada (3):
      .gitignore: sort normal pattern rules alphabetically
      .gitignore: move *.dtb and *.dtb.S patterns to the top-level .gitigno=
re
      kbuild: rpm-pkg: keep spec file until make mrproper

Neal Cardwell (1):
      tcp_bbr: fix pacing_gain to always be unity when using lt_bw

Nikolay Aleksandrov (1):
      ip6mr: fix stale iterator

Robert Baronescu (1):
      crypto: tcrypt - fix S/G table for test_aead_speed()

Roman Gushchin (1):
      Revert "defer call to mem_cgroup_sk_alloc()"

Sudip Mukherjee (1):
      arch: define weak abort()


--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqCsMUACgkQONu9yGCS
aT69YQ/5AeUKeZuu05eQSo+3RSXc97O0otw+YcIGe4aphj1xglgGOiUOOyBRiPvm
ETREpD9ovK7sqCClqKlmQcI2zGt9+EWTnlapPZ4+/QOW4VQlKgj7bOx8/ZA+AxGx
zHKJhdoHFgxuNWBjyEsmFazizIVVgLfv43ac9jNPjOz8x2DRcIswJIaoA9Ydzo1r
LSbA+UG7uI47ZtTbmOMJRW4EgDcjkRlJW5tQrxO+h7l8NHHyz1iL8marwdOSUsj0
PvBONmWD7idpehPOzCYJ8/4EHw9FkVFs7lvV0xyg7vfFjfxNUVwj6iU+GjMsiYFQ
et13Fc1mzUZ0dcEYdl0fJec5LHknl8AkQA2MtvQNoobZWRPqw088j4K5pcoIl0ur
S03yDQfctMcd1GEMMVabgC59nYyzAS7N2PgeCwHLXRDy2AgWR1dIYDV9UgCMlB3S
V//TTeFlPAJLC+kgYOD/VoeGQdqqd1TMjWRKYaedmNnKzs48TrswtmRsXLzPGcfv
innmBmCFiJ6GANr5cKOc6NFOr+oKJxwQ0H1FVly2RUvqZVtXHXd0gvwK/xLNzLoS
LNVVZ4E0/qPPWwIf5vp9qw8xft6eCyodqE3kSW6sAsxVMTxMHFYHlJaBQgBulWcK
MhDGEY5sXIl5QqmBjbzx+TAYcKcsL2Ymwl8PEHonS0BOUkmHyQY=
=jrmL
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
