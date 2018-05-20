Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2928030-1526822444-2-16926902835218464314
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526822444; b=kP7QypS9o8BWhRDU+8C4ZxUQzGeQjm2u6gZHNoxnSuS+cGrgbc
    57R3Jk386qcyepctFJb+D2Uz2/RXwqk57ctK8mzNoO4YmOnwzaMOes8NdXupBaeA
    9OFnS8U+1wZ67ZMJ1uqUe6JeTXcWYhB49oekpbFV4aWyxndGfFe1lp99KLtUhrhc
    cMC+9M31vmNDvIbhPwoTJqxCS+L7HuYzpPcnDKihAfQyLQ9sA7OkEJLTATpk2kly
    H1MJLkkd+tcr1HLJiNlP2TxJIVygH9AHwC+xnC9ZQZA5AewLhKqKWWzcQtvaIjsW
    NT1R6chJ8yL7w6KpnSEqgV/59TMg6HphRejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526822444;
    bh=sco69txwyx0ufQiPOUWWIS1Gtpt1eJr6uJNhZMZUTUE=; b=T1KstbjmKT96
    TWi+w1Y1cP1RkdMZvOK6El8AewNRq9id+Jwm2tkfWoWUDNw6n+n6kk2TbdL4RFAD
    rQrWYMEuvei95hbvYhoT5wupu6pdqCwF7yL5Y86KAc1KyYG5HemYTm/7Fr2aJwBn
    6gbgb2tVu2LdCpueK7O1FtGkC/VtGg6FkU7Sz0XkVy6GoMr/asyy4Swd00izyPJl
    eTs2841zpGD5OqmYMBQXZsCG6ymMC+aRrQXRLlbN6qViCzGXPWCQW6kz6aUxj8oi
    T2iV4cFECD9wuVnbX7ITvSakUWgttnPhn9raUEGm1ls/ZIJQq1nFueaTMH9fJLHW
    1mqaTLzVsQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=mDaEcX7c x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=mDaEcX7c x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE+unbdVAC1eP+Kq4xBtTecJ4PIkKTbSAQOCOQTk3A9z+poxlGJAu7nJq35evGRE+vsxxjBtCGtrWltlFCX7phNMtC+WJuYat6ns97ViCPgSO/TfNSNF
    8oT5KZ3PF7nB/yjd/gNDcbztICTI/W4e2cZBzVrMpkN5nAQ4LB0r/Fy8yANSck/Yu8n7cHLUSoOTooi1E+WH+QqRfxjCejOiA6IBzuY4AnaSiUxoVQnZliak
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=2xw1LlEQEL1tVTFNpDoA:9 a=wPNLvfGTeEIA:10 a=LZhtMj8InAulJpAlrZIA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbeETNUl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 20 May 2018 09:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751122AbeETNUk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 20 May 2018 09:20:40 -0400
Date: Sun, 20 May 2018 15:20:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.101
Message-ID: <20180520132023.GA7699@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.101 kernel.

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

 Makefile                                            |    2=20
 arch/alpha/include/asm/futex.h                      |   26 +----
 arch/arc/include/asm/futex.h                        |   40 +-------
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi            |    1=20
 arch/arm/include/asm/futex.h                        |   26 -----
 arch/arm64/include/asm/futex.h                      |   27 ------
 arch/frv/include/asm/futex.h                        |    3=20
 arch/frv/kernel/futex.c                             |   27 ------
 arch/hexagon/include/asm/futex.h                    |   38 --------
 arch/ia64/include/asm/futex.h                       |   25 -----
 arch/microblaze/include/asm/futex.h                 |   38 --------
 arch/mips/include/asm/futex.h                       |   25 -----
 arch/parisc/include/asm/futex.h                     |   26 -----
 arch/powerpc/include/asm/futex.h                    |   26 +----
 arch/s390/include/asm/futex.h                       |   23 +----
 arch/sh/include/asm/futex.h                         |   26 -----
 arch/sparc/include/asm/futex_64.h                   |   26 +----
 arch/tile/include/asm/futex.h                       |   40 +-------
 arch/x86/include/asm/futex.h                        |   40 +-------
 arch/xtensa/include/asm/futex.h                     |   27 +-----
 drivers/net/bonding/bond_alb.c                      |   15 ++-
 drivers/net/bonding/bond_main.c                     |    2=20
 drivers/net/ethernet/broadcom/tg3.c                 |    9 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c     |   16 +++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h        |    7 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c   |   11 ++
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c   |   21 ++--
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c |    4=20
 drivers/net/ethernet/realtek/8139too.c              |    2=20
 drivers/net/ethernet/realtek/r8169.c                |    3=20
 drivers/net/ethernet/sun/niu.c                      |    5 -
 drivers/net/ethernet/ti/cpsw.c                      |    2=20
 drivers/net/usb/qmi_wwan.c                          |   12 ++
 drivers/tty/serial/sccnxp.c                         |   13 ++
 fs/lockd/svc.c                                      |    2=20
 fs/proc/base.c                                      |   10 +-
 include/asm-generic/futex.h                         |   50 ++---------
 include/linux/mm.h                                  |    1=20
 include/net/bonding.h                               |    1=20
 kernel/exit.c                                       |    4=20
 kernel/futex.c                                      |   39 ++++++++
 mm/gup.c                                            |    3=20
 net/bridge/br_if.c                                  |    4=20
 net/compat.c                                        |    6 -
 net/dccp/ccids/ccid2.c                              |   14 ++-
 net/dccp/timer.c                                    |    2=20
 net/ipv4/ping.c                                     |    7 +
 net/ipv4/tcp.c                                      |    2=20
 net/ipv4/tcp_bbr.c                                  |    4=20
 net/ipv4/udp.c                                      |    7 +
 net/l2tp/l2tp_netlink.c                             |    2=20
 net/llc/af_llc.c                                    |    3=20
 net/openvswitch/flow_netlink.c                      |    9 --
 net/sched/sch_fq.c                                  |   37 +++++---
 net/sctp/associola.c                                |   30 ++++++
 net/sctp/inqueue.c                                  |    2=20
 net/sctp/ipv6.c                                     |    3=20
 net/sctp/sm_statefuns.c                             |   89 +++++++++++----=
-----
 net/sctp/ulpevent.c                                 |    1=20
 net/xfrm/xfrm_state.c                               |    1=20
 60 files changed, 383 insertions(+), 584 deletions(-)

Adi Nissim (1):
      net/mlx5: E-Switch, Include VF RDMA stats in vport statistics

Alexey Khoroshilov (1):
      serial: sccnxp: Fix error handling in sccnxp_probe()

Andrey Ignatov (1):
      ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg

Antony Antony (1):
      xfrm: fix xfrm_do_migrate() with AEAD e.g(AES-GCM)

Bj=F8rn Mork (1):
      qmi_wwan: do not steal interfaces from class drivers

Debabrata Banerjee (2):
      bonding: do not allow rlb updates to invalid mac
      bonding: send learning packets for vlans on slave

Eric Dumazet (3):
      dccp: fix tasklet usage
      llc: better deal with too small mtu
      net_sched: fq: take care of throttled flows before reuse

Greg Kroah-Hartman (2):
      Revert "ARM: dts: imx6qdl-wandboard: Fix audio channel swap"
      Linux 4.9.101

Grygorii Strashko (1):
      net: ethernet: ti: cpsw: fix packet leaking in dual_mac mode

Hangbin Liu (1):
      bridge: check iface upper dev when setting master via ioctl

Heiner Kallweit (1):
      r8169: fix powering up RTL8168h

Ingo Molnar (1):
      8139too: Use disable_irq_nosync() in rtl8139_poll_controller()

Jakub Kicinski (1):
      nfp: TX time stamp packets before HW doorbell is rung

James Chapman (1):
      l2tp: revert "l2tp: fix missing print session offset info"

Jiri Slaby (2):
      futex: Remove duplicated code and fix undefined behaviour
      futex: futex_wake_op, fix sign_extend32 sign bits

Lance Richardson (1):
      net: support compat 64-bit time in {s,g}etsockopt

Michael Chan (1):
      tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().

Moshe Shemesh (1):
      net/mlx4_en: Verify coalescing parameters are in range

Neal Cardwell (1):
      tcp_bbr: fix to zero idle_restart only upon S/ACKed data

Rob Taglang (1):
      net: ethernet: sun: niu set correct packet size in skb

Stefano Brivio (1):
      openvswitch: Don't swap table in nlattr_set() after OVS_ATTR_NESTED i=
s found

Talat Batheesh (1):
      net/mlx5: Avoid cleaning flow steering table twice during error flow

Vasily Averin (1):
      lockd: lost rollback of set_grace_period() in lockd_down_net()

Willy Tarreau (1):
      proc: do not access cmdline nor environ from file-backed areas

Xin Long (5):
      sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr
      sctp: remove sctp_chunk_put from fail_mark err path in sctp_ulpevent_=
make_rcvmsg
      sctp: use the old asoc when making the cookie-ack chunk in dupcook_d
      sctp: fix the issue that the cookie-ack with auth can't get processed
      sctp: delay the authentication for the duplicated cookie-echo chunk

Yuchung Cheng (1):
      tcp: ignore Fast Open on repair mode

zhongjiang (1):
      kernel/exit.c: avoid undefined behaviour when calling wait4()


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsBdhMACgkQONu9yGCS
aT7esBAAqIf5Pbkw/W0f2yF520hnltdt1ALz48WRdWSjgIvxUKxD0UIQXDQK3xbj
GC8Kw/ypKc3WWmcMX2z3obI4GwhJojQhwCRwegNUzbOGILmNrOw+B+1rt5n5nm3N
Ht90M//P9PWrb6p8FkaUxEeD0SXtlPsEuOjRMnuCWXql9Utyt7MquBaYYv8GbHio
X4lkikDZCBvejEEjJthsLjn5GHvdbqnZ9dcoZEPFOlKJNQAnVKRrpfSb4LwJ6olu
EqXWpCdxKB60HNFkcAJs8GnUhIPk9fy1pPQagD9F0w/fGg4D2a0B9Jok+995qToA
iBkP3i3jFGh0zx7Zq/8bdjOX6t2l7Ca9ErhS2zgCwZNoObPuc6mqU82lPSjBjtL7
RzNLG6ErLJ2ZfGlF/IPXUhpXCkPrf1uC5gY7LUZZgTDieD3RojvvbW596TwfauyT
fB1/MSuAcbjYozk1WBXcSVX4VA0oSLnXt+JV+Vj5/DRk/PbpXC8zP8Vmi8X7o5Yx
kvbyl6zteO6QYOqpVfOIaRbz967fIs0g81Ma/EM1DXgs6INoezpRbU+tTKrdLK7h
WJFlaEeVWDZFM+1gSPvMPifHXh2XM1Gzid3SDD309TTage3tMuzwTu5S+A76+AdW
ouWLDOOdzfa/fizqg6ezjoyCnDZIHDBXPzA8p7/hiOsT65BGjiE=
=ZmZ5
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
