Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3807972-1518514444-2-11132008693084580403
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
    t=1518514444; b=pB3oe3zUeeDZFcPkQAqqbjFFzlgDJrfx7np/Kq+I3dBKjf7
    228kqSB3dgg4ZO5JiIN3UqMtWh/xvQMPo4axsHSsrQevs5RFieP1nrcI7B6WCz9t
    twFIc+gnUYq+/U/41xDoPH2BTZPytH3371fGApKzlAq9AUJTT/FYnb1HIDvX49u+
    jOnW9xtgDAHbinCY6/AZrdb2RymQAxHbd3b7mQkN21TQXUOJ1wnQJxYAXfnoYatU
    06sU/xgbMG2Mt0Y7tzF1kM2hby3lp87yJXp8TRAVZmfb+sHzO0hM40Zw3jbMZ1jS
    id2hkYxMLrRC1T53SiG4kSbX+4qqfSD5FsUWJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518514444; bh=K87O6EdJKFLICi+2UKo72t9+g59cFnGQXzQE/ihWfsE=; b=A
    sdRF7Dm1eUuznWoZkPYuRb+BAL3rB/E5Ti7S42rFkjiD9x7o3sRnGOvJQJK/BmTl
    HeR+p7Pfib7PvzjYnXow9B98yMCyFzCSyGMKuMRShoOR5SJIkXvzkojn+hQmp0d6
    TTJBS0mzNvuNZk9SZ2j5aGw0BIqxdWH0V9koODVoEMn2qKPPId+n+Yr5yOgsL+zx
    tJa6rhGbSoHWaTURtl51FIMwIgNU4QHGqTjKrm3l9HYZLVEuKjG9LKx8819kMrDN
    g+tpXNdjh52p3WZTWNWbUE/GnAvFdlackcEu9s3sH8Lnoq3sdTtksrfHuu1VRmhB
    9/ekq/IDh1tgDSQr1h0rg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934368AbeBMJd0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:33:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54940 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933936AbeBMJdV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 04:33:21 -0500
Date: Tue, 13 Feb 2018 10:33:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.3
Message-ID: <20180213093320.GA29537@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.3 kernel.

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

 Makefile                                            |    2 -
 crypto/tcrypt.c                                     |    6 ++-
 drivers/gpio/gpio-uniphier.c                        |    2 -
 drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c |    3 +
 drivers/media/platform/soc_camera/soc_scale_crop.c  |    4 ++
 drivers/media/platform/tegra-cec/tegra_cec.c        |    5 ++
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c |   18 ++++-----
 drivers/net/ethernet/realtek/r8169.c                |    4 +-
 drivers/net/ethernet/rocker/rocker_main.c           |   18 ++++-----
 drivers/net/usb/qmi_wwan.c                          |    1=20
 drivers/vhost/net.c                                 |    1=20
 include/net/sch_generic.h                           |    1=20
 mm/memcontrol.c                                     |   14 +++++++
 net/core/sock.c                                     |    5 --
 net/core/sock_reuseport.c                           |   35 ++++++++++-----=
--
 net/ipv4/igmp.c                                     |    4 ++
 net/ipv4/inet_connection_sock.c                     |    1=20
 net/ipv4/tcp.c                                      |    6 +++
 net/ipv4/tcp_bbr.c                                  |    6 +--
 net/ipv6/addrconf.c                                 |   32 ++++++++++++++--
 net/ipv6/af_inet6.c                                 |   11 +++--
 net/ipv6/ip6mr.c                                    |    1=20
 net/ipv6/ndisc.c                                    |    5 ++
 net/ipv6/route.c                                    |   20 ++++++----
 net/sched/cls_api.c                                 |   39 +++++++--------=
-----
 net/sched/cls_u32.c                                 |   12 +++---
 26 files changed, 162 insertions(+), 94 deletions(-)

Chunhao Lin (1):
      r8169: fix RTL8168EP take too long to complete driver initialization.

Cong Wang (1):
      net_sched: get rid of rcu_barrier() in tcf_block_put_ext()

David Ahern (1):
      net: ipv6: send unsolicited NA after DAD

Eric Dumazet (3):
      net: igmp: add a missing rcu locking section
      ipv6: addrconf: break critical section in addrconf_verify_rtnl()
      soreuseport: fix mem leak in reuseport_add_sock()

Greg Kroah-Hartman (1):
      Linux 4.15.3

Jason Wang (1):
      vhost_net: stop device during reset owner

Jesse Chan (3):
      media: mtk-vcodec: add missing MODULE_LICENSE/DESCRIPTION
      media: soc_camera: soc_scale_crop: add missing MODULE_DESCRIPTION/AUT=
HOR/LICENSE
      media: tegra-cec: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jiri Pirko (2):
      rocker: fix possible null pointer dereference in rocker_router_fib_ev=
ent_work
      net: sched: fix use-after-free in tcf_block_put_ext

Junxiao Bi (1):
      qlcnic: fix deadlock bug

Kristian Evensen (1):
      qmi_wwan: Add support for Quectel EP06

Li RongQing (1):
      tcp: release sk_frag.page in tcp_disconnect

Martin KaFai Lau (1):
      ipv6: Fix SO_REUSEPORT UDP socket with implicit sk_ipv6only

Masahiro Yamada (1):
      gpio: uniphier: fix mismatch between license text and MODULE_LICENSE

Neal Cardwell (1):
      tcp_bbr: fix pacing_gain to always be unity when using lt_bw

Nikolay Aleksandrov (1):
      ip6mr: fix stale iterator

Paolo Abeni (1):
      cls_u32: add missing RCU annotation.

Robert Baronescu (1):
      crypto: tcrypt - fix S/G table for test_aead_speed()

Roman Gushchin (1):
      Revert "defer call to mem_cgroup_sk_alloc()"

Wei Wang (1):
      ipv6: change route cache aging logic


--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqCsN8ACgkQONu9yGCS
aT5RaQ//Zc6e8tuqINrczlShq8tp95KUHtIRkIyOeSzhHHbOr0Q7xncvTqvu+S5h
fiiCD2sofofMWnq59rztwuLvQSAfV40tAKhyt0ICVQBSxDzb1C77HAeBXacYb1De
pW8aVEdHd3I+9OmCgz4+NXDylnGt1UV0VxplctjXTBFbAxT1Gt79dtCBv+IGw+CI
0tzaEHopze7CEc2yBKH/uyl9HYx16uJ+cDqVwbVV7aXwKKOLd0dASgXTwiI0Jlj1
nDNC1trf8Vxix4XpPt5fjJVH2lQbxCBhME8F1jCoCSf6WEbe8yRZt+buRnbUe9wb
iLv2/aE4ts6NAo7qckQsI59YCqkpKQJHS6Oq8ufkuZGHZ32gwosR3VgQSMPtIeS9
2Ri+8uAlzkCZC3ZUbl3buztpslBVS4Mne1OElweVhb96m7uqdmNG82RGC0EM5rFa
pwbge1W8HKhSIiHgwmcuASHbqh6vC9oovxxM3AJSV0KOkPAif/uPE6EZ6PwBDYbb
Tymd5phDNVPTtd423XRM+DR1SUvMjebbhAoy0j5swD9IpioB1parkQ6vLbXMib5T
vPQmbU/SI9wFGpmA5HHZWPloRqqSRalhrphZY3DM9+0wMlV1DuGYyqZi1wMGFEfB
LJOa/8DdWqXrsdryh4Qx/m9wJD1DxzYuGX0J+6mhzgLn8xBoDzA=
=Hccj
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
