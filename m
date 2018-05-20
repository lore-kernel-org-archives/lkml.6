Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2928030-1526822474-2-6352596851858128527
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
    1526822473; b=HnVaxN5KLgzc+FfKI39HNXD1QRfUjFkNx8nU593JPWyiy1kyqf
    nv8Kl5Rno6dj3S8yrgbBz8ejsP2HFC9IlY+md48fO/LGGXuPyQOs25cd8Ba77Ej0
    Zr81TbS6rXc53ekKtjhM/mXFsKsn/wNc7d6tCHHZK8niiQwWsj1Stpjv0b6hZF/c
    tLUcnF5i3HoqbyPtUBcVaogHlvVM3j2aismEtjh//4oiD2iFCxnw2qL/hvkt3MyA
    W0GvLi18wWfgE2pQyGPSvavhiS4tepBJMemMSGaI+sB+AC3sc5RGtChNNG5zzV1M
    8xQlkN/pQezkcQnZlx6hG0mzWfSVx8/3xD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526822473;
    bh=/xaQ9kj74wXogC9oawQVYhZSeX2QBDGluy/K01zX/hI=; b=O0XpSkJgLO9n
    80lgGw4ak4aIQjCuBUvueylNJt+sE42rGsO9G2Nf8ZP0Ca080/DqsgpG7gHyaGFs
    AN+UIJEyqscbLFOe4zomdC9aydVPV5474PQjeGqQBoQqFjwKjt8iCPdNVKtSG2T+
    gLUUKxMZphYRPqo5IivdmrVyM9ECcw83yqAOTQCfhdTiz2QxTDkSbNe4Ek9NIHGc
    H5jm70F8EbHqpJj1+kcYWcY/4bXky8dXSMAedteT6VKifS2IDUg8NjI9w/Au4KG6
    PdOe1OqyPI0i69vqlRGVhjgm8S2tDgqKmMC8Hh6iEXk1YdPhufnLF6kv1qo5JcDS
    2+Y50YQK8g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=P3N2OMmX x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=P3N2OMmX x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMUU72TYZ3kdWvUhNMSEfeb4EDLUVPCRl799k6WlF6S8xBekHPcB297RYV5I92rPFoO1wF+BrSiDhNOTznozntof+uP9zKZMK011PHsKUwo2wRHlaEir
    orS7W28T0K+f1pffh4i1T0leiYVyOls9kvtpRVd1IWbSmmqKAHZRHkRD75JCafvRXUU6KpSUndKPnX8rZN8vuHuFKPUXoSH4/KOx5zR27b5EhSuCc+8sj/BJ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=FA1-4knchhqWklvrLS8A:9 a=wPNLvfGTeEIA:10 a=2AGQGUAaLx61w7i3RGIA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeETNVK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 20 May 2018 09:21:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751902AbeETNVJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 20 May 2018 09:21:09 -0400
Date: Sun, 20 May 2018 15:20:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.42
Message-ID: <20180520132052.GA7787@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.42 kernel.

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

 Makefile                                          |    2=20
 drivers/net/bonding/bond_alb.c                    |   15 +-
 drivers/net/bonding/bond_main.c                   |    2=20
 drivers/net/ethernet/broadcom/tg3.c               |    9 -
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c   |   16 ++
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c    |    8 -
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h      |    7 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c   |    7 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c   |   20 +--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |   11 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |   23 ++--
 drivers/net/ethernet/realtek/8139too.c            |    2=20
 drivers/net/ethernet/realtek/r8169.c              |    3=20
 drivers/net/ethernet/sun/niu.c                    |    5=20
 drivers/net/ethernet/ti/cpsw.c                    |    2=20
 drivers/net/hyperv/netvsc_drv.c                   |    3=20
 drivers/net/usb/qmi_wwan.c                        |   12 ++
 drivers/scsi/aacraid/commsup.c                    |    8 -
 fs/btrfs/extent-tree.c                            |    7 +
 fs/proc/base.c                                    |    8 -
 include/linux/mm.h                                |    1=20
 include/net/bonding.h                             |    1=20
 include/net/tls.h                                 |    1=20
 mm/gup.c                                          |    3=20
 net/bridge/br_if.c                                |    4=20
 net/compat.c                                      |    6 -
 net/dccp/ccids/ccid2.c                            |   14 ++
 net/dccp/timer.c                                  |    2=20
 net/ipv4/ping.c                                   |    7 -
 net/ipv4/route.c                                  |  118 +++++++++--------=
-----
 net/ipv4/tcp.c                                    |    3=20
 net/ipv4/tcp_bbr.c                                |    4=20
 net/ipv4/udp.c                                    |   11 +-
 net/ipv6/route.c                                  |    7 +
 net/ipv6/udp.c                                    |    4=20
 net/l2tp/l2tp_netlink.c                           |    2=20
 net/llc/af_llc.c                                  |    3=20
 net/nsh/nsh.c                                     |    2=20
 net/openvswitch/flow_netlink.c                    |    9 -
 net/rds/recv.c                                    |    1=20
 net/sched/act_skbmod.c                            |    5=20
 net/sched/cls_api.c                               |    2=20
 net/sched/sch_fq.c                                |   37 ++++--
 net/sctp/associola.c                              |   30 +++++
 net/sctp/inqueue.c                                |    2=20
 net/sctp/ipv6.c                                   |    3=20
 net/sctp/sm_statefuns.c                           |   88 ++++++++--------
 net/sctp/ulpevent.c                               |    1=20
 net/tls/tls_main.c                                |    8 +
 net/xfrm/xfrm_input.c                             |    2=20
 net/xfrm/xfrm_state.c                             |    1=20
 51 files changed, 348 insertions(+), 204 deletions(-)

Adi Nissim (1):
      net/mlx5: E-Switch, Include VF RDMA stats in vport statistics

Andre Tomt (1):
      net/tls: Fix connection stall on partial tls record

Andrey Ignatov (1):
      ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg

Antony Antony (1):
      xfrm: fix xfrm_do_migrate() with AEAD e.g(AES-GCM)

Bj=F8rn Mork (1):
      qmi_wwan: do not steal interfaces from class drivers

Christophe JAILLET (1):
      net/mlx4_en: Fix an error handling path in 'mlx4_en_init_netdev()'

Dave Carroll (1):
      scsi: aacraid: Correct hba_send to include iu_type

Dave Watson (1):
      net/tls: Don't recursively call push_record during tls_write_space ca=
llbacks

Debabrata Banerjee (2):
      bonding: do not allow rlb updates to invalid mac
      bonding: send learning packets for vlans on slave

Eric Dumazet (6):
      dccp: fix tasklet usage
      llc: better deal with too small mtu
      net_sched: fq: take care of throttled flows before reuse
      rds: do not leak kernel memory to user land
      ipv6: fix uninit-value in ip6_multipath_l3_keys()
      nsh: fix infinite loop

Greg Kroah-Hartman (1):
      Linux 4.14.42

Grygorii Strashko (1):
      net: ethernet: ti: cpsw: fix packet leaking in dual_mac mode

Hangbin Liu (1):
      bridge: check iface upper dev when setting master via ioctl

Heiner Kallweit (1):
      r8169: fix powering up RTL8168h

Herbert Xu (1):
      xfrm: Use __skb_queue_tail in xfrm_trans_queue

Ingo Molnar (1):
      8139too: Use disable_irq_nosync() in rtl8139_poll_controller()

James Chapman (1):
      l2tp: revert "l2tp: fix missing print session offset info"

Jianbo Liu (1):
      net/mlx5e: Allow offloading ipv4 header re-write for icmp

Jiri Pirko (1):
      net: sched: fix error path in tcf_proto_create() when modules are not=
 configured

Julian Anastasov (1):
      ipv4: fix fnhe usage by non-cached routes

Lance Richardson (1):
      net: support compat 64-bit time in {s,g}etsockopt

Michael Chan (1):
      tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().

Moshe Shemesh (1):
      net/mlx4_en: Verify coalescing parameters are in range

Neal Cardwell (1):
      tcp_bbr: fix to zero idle_restart only upon S/ACKed data

Paolo Abeni (1):
      udp: fix SO_BINDTODEVICE

Rob Taglang (1):
      net: ethernet: sun: niu set correct packet size in skb

Roi Dayan (1):
      net/mlx5e: Err if asked to offload TC match on frag being first

Roman Mashak (1):
      net sched actions: fix refcnt leak in skbmod

Stefano Brivio (1):
      openvswitch: Don't swap table in nlattr_set() after OVS_ATTR_NESTED i=
s found

Stephen Hemminger (1):
      hv_netvsc: set master device

Talat Batheesh (1):
      net/mlx5: Avoid cleaning flow steering table twice during error flow

Tariq Toukan (1):
      net/mlx5e: TX, Use correct counter in dma_map error flow

Willy Tarreau (1):
      proc: do not access cmdline nor environ from file-backed areas

Xin Long (5):
      sctp: delay the authentication for the duplicated cookie-echo chunk
      sctp: fix the issue that the cookie-ack with auth can't get processed
      sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr
      sctp: remove sctp_chunk_put from fail_mark err path in sctp_ulpevent_=
make_rcvmsg
      sctp: use the old asoc when making the cookie-ack chunk in dupcook_d

Yuchung Cheng (1):
      tcp: ignore Fast Open on repair mode

ethanwu (1):
      btrfs: Take trans lock before access running trans in check_delayed_r=
ef


--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsBdjMACgkQONu9yGCS
aT5+ZA/+NTiNahWWArSkM+ckfRVbvSemGE16FouwhL+DnuaQdEUX2bzf37BqlfSz
Lz1XPgAYlpigHtpn9KfjpupDO/Qqlo9sr3grAAWS8Zy+0+CRF/RNE/zABFPfjoJY
fQPh8UW0uayli/Ulzi7YsEhgy0O+HX+Ff2MsFdCnyomCnY3TEt+EPcV3EMTPyrIP
Y7GmX3ggF3GtHjb6/gBw5pfV+/F+tNTblwO+AfoB2rDhYP6fvGzMlNF6wNwOFS+7
qF2yRCZMHbj8zAlhy4hiLLTkGFwi41/lvZEq8svYZ2nRFAK1HNGYp2Vf2gWz4pVc
a44BU0Qc4AttBoNXf4ddfIa2yyKfCJ/rKZaK7nW5hTMYF9ybkmLDmB6cedbw7r4Y
e5ZXJAgtTpt82tE4LS9XO9LZ3SRbzF5v4Tb/o9mJsP9Eh4E3cAaPjX9UidfVFmK8
hLJGH3HzRjWg0GAiv9P4qp7KAkUKLFlQF0BuVVNh89pHonSF6wMqZDiOGIAEl1Qo
DzZy6PUCOzDSh9X0jc6ikSNHtuIr8GJ36Ok7clRSdwLIZ2oEwQt7LhzuqESLi5d6
3uxiFqHs6hoXsFN4iCJ58Gb9awO7VwzZNXbwKBtv0cn6lZcz7egnd84vZoN+NYfk
Xw21WXxeuOCJWw7Qys9khy8Pe64/7CxI2TFDtuwypuqe3lYcBVk=
=jxGb
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
