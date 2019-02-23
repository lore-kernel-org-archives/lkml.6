Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98A4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7573620684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550917340;
	bh=1BZvLu2F2hGW8s51HmBMj3jYruMZ8d4IIO47aufkyoo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=eX/LoBQmtu/+Vwibrw62xLStWX4UkwcfwE6LFCBxtNj8WuQ6QDhgWM6hfsWA+2Kma
	 Z3tENU0kXShoMQlT5tIP0i703dB8RE4sJzgFgy4WyR67QZD7wWwyJuLMgJkjg+aY8I
	 4YY+8D1CAnhXbhKYxU7L8DqgAwTYO4/g5vDKfGlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfBWKWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:22:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfBWKWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:22:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B58B20684;
        Sat, 23 Feb 2019 10:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550917337;
        bh=1BZvLu2F2hGW8s51HmBMj3jYruMZ8d4IIO47aufkyoo=;
        h=Date:From:To:Cc:Subject:From;
        b=nYPVVK0GA+gwDZYabFeQ/yCurUVBpxkUtxMZHWuq6rssPtC2RFPm10SQVVZ2HXCku
         PBSGJQcpH5B9FwXgEkkkT4vfK4CVxpS9bfvniis7IIODdapFGV4wXaQKWnsBHcPnB/
         +LFyOi9kD/iDeY3kQgW9Wt3qCLvzJw5nfjM2E/9U=
Date:   Sat, 23 Feb 2019 11:22:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.160
Message-ID: <20190223102215.GA14600@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.160 kernel.

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

 Makefile                                             |    2 -
 drivers/hwmon/lm80.c                                 |    4 ++
 drivers/isdn/mISDN/timerdev.c                        |    2 -
 drivers/net/ethernet/marvell/sky2.c                  |    2 -
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c   |    9 ++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c |   22 ++++++++------
 drivers/net/phy/xilinx_gmii2rgmii.c                  |    5 ++-
 drivers/net/vxlan.c                                  |   13 +++++++-
 drivers/vhost/vhost.c                                |    2 -
 fs/btrfs/extent_io.c                                 |   28 ++++++++------=
-----
 include/linux/netdev_features.h                      |   24 ++++++++++++++=
--
 include/net/ax25.h                                   |   12 ++++++++
 include/net/inetpeer.h                               |    1=20
 include/net/tcp.h                                    |    1=20
 net/ax25/ax25_ip.c                                   |    4 +-
 net/ax25/ax25_route.c                                |   19 +++++-------
 net/core/dev.c                                       |    4 +-
 net/core/skbuff.c                                    |    4 ++
 net/ipv4/inetpeer.c                                  |    1=20
 net/ipv4/route.c                                     |    7 +++-
 net/ipv4/tcp.c                                       |    1=20
 net/ipv4/tcp_ipv4.c                                  |    7 ++--
 net/ipv6/addrconf.c                                  |    3 +-
 net/vmw_vsock/vmci_transport.c                       |    4 ++
 net/x25/af_x25.c                                     |    6 +---
 25 files changed, 122 insertions(+), 65 deletions(-)

Alexander Duyck (1):
      net: Do not allocate page fragments that are not skb aligned

Alexandre Torgue (1):
      net: stmmac: handle endianness in dwmac4_get_timestamp

David S. Miller (1):
      net: Add header for usage of fls64()

Eric Dumazet (6):
      tcp: tcp_v4_err() should be more careful
      tcp: clear icsk_backoff in tcp_write_queue_purge()
      vxlan: test dev->flags & IFF_UP before calling netif_rx()
      net/x25: do not hold the cpu too long in x25_new_lci()
      mISDN: fix a race in dev_expire_timer()
      ax25: fix possible use-after-free

Greg Kroah-Hartman (1):
      Linux 4.9.160

Hauke Mehrtens (1):
      net: Fix for_each_netdev_feature on Big endian

Jason Wang (1):
      vhost: correctly check the return value of translate_desc() in log_us=
ed()

Jose Abreu (1):
      net: stmmac: Fix a race in EEE enable callback

Kai-Heng Feng (1):
      sky2: Increase D3 delay again

Lorenzo Bianconi (1):
      net: ipv4: use a dedicated counter for icmp_v4 redirect packets

Paolo Abeni (1):
      vsock: cope with memory allocation failure at socket creation time

Paul Kocialkowski (1):
      net: phy: xgmiitorgmii: Support generic PHY status read

Qu Wenruo (1):
      btrfs: Remove false alert when fiemap range is smaller than on-disk e=
xtent

Wei Yongjun (1):
      hwmon: (lm80) Fix missing unlock on error in set_fan_div()

Zhiqiang Liu (1):
      net: fix IPv6 prefix route residue


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxxHtcACgkQONu9yGCS
aT7OWRAAsn5h2q0BLUHT68bGSa816YdeTM5U4eIbUWqBEvzsruXWCs9jPynO5Ctn
Rk0Z/7GfZF9qYMclU+JJaQwgYqzhjpJ1P7UczudAaQuakUeU3qN8Wz6PL2nYJ+UN
zpZjRcBoAuYw6lGcRqVFkOZzkZqLwMNHf/LNjy5BnxZtBA3odPTR5/Gq5XoAgs4M
/UF4w6+jVw+O9PDyBdQtRKdcSOVQAXm4pgU+7O6iXOSiAV6yQpBfkzqZDiafrKu1
otZuZAwZ183o21dZIVnLsjCzey1pkg/N1aNYYYOGPBTW/+bXTyBh49CN7UEYuf+9
a3DRG2EYpx/G9/X/CT5apj0tqQPjnYKzuYWAlbpPMfGKy2qGD3A/t3uA3xq/qRLn
q9AoA1SRZCIc5rY7yIbMlxyWEgEM4XM+p686PjiDRM5FMAndaJY2UTLRgQjr1QL4
eIcmc9rgr9LSxNCpivLXgZsHis9vwnxq/YxinIWOwjLGZ8eTxtJATtbFu0IGuNXy
F3ZYtsggFjpuLZTGN3l/nhjhZkQIc7oQdG881/mKX2asXcfcEZDGnWVcOR+tQ1P/
PpPy2ZxffJyOlm5fgeEy1XcDGXMHqiHYV7d2vf1UWL5fWiQ4TxbhgJAk5ygWIUtK
ZJc8EGxvLGy4vhNCd+4BwPuwikg+2HkAu++00XvlXeWYQTChu0U=
=7TmL
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
