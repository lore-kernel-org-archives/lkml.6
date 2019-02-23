Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82967C10F07
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528BF20850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550917267;
	bh=O14dGiYj0B1j3tQ2bXYiUZqwMbLGZk9wskG2NPAHi2I=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qH0+uLOpiX5RXSnqPFbEpLT+eI5KVfF4BlSZYhVWk9rmrY5yvo/3CvdmoPK2SziyX
	 uAuvtKjcA0CL5n9b6iIggbjKTOqVgQ+Va6M2ylJHIag/jloHs85H7LE1cR6SCO7bBR
	 81Q+EgUqk1Bh6pSGyR65nnbc74rpMPLAaL8BiIXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfBWKVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBWKVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:21:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E43020684;
        Sat, 23 Feb 2019 10:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550917264;
        bh=O14dGiYj0B1j3tQ2bXYiUZqwMbLGZk9wskG2NPAHi2I=;
        h=Date:From:To:Cc:Subject:From;
        b=tTHsgldbldLF1HM84BlogJ2ME5Csph4Ge39nNd1V7kBwfw74a6xxLyloJtc9WJJuh
         79YpJUcG3jiOYHPS2zI3wOHRgJXT1ltZNstz5YNKtgxquVmZdoC996aIUpQXdPZlWX
         txgau3PiBgtoYeFcdRSvZZYehiq+AnBIMJLmefyQ=
Date:   Sat, 23 Feb 2019 11:21:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.136
Message-ID: <20190223102102.GA14366@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.136 kernel.

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

 Makefile                                             |    2 -
 drivers/hwmon/lm80.c                                 |    4 ++-
 drivers/isdn/mISDN/timerdev.c                        |    2 -
 drivers/net/ethernet/marvell/sky2.c                  |    2 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c |   22 ++++++++++----=
-----
 drivers/net/vxlan.c                                  |   13 +++++++++--
 include/net/ax25.h                                   |   12 ++++++++++
 include/net/inetpeer.h                               |    1=20
 include/net/tcp.h                                    |    1=20
 net/ax25/ax25_ip.c                                   |    4 +--
 net/ax25/ax25_route.c                                |   19 ++++++--------=
--
 net/ipv4/inetpeer.c                                  |    1=20
 net/ipv4/route.c                                     |    7 ++++--
 net/ipv4/tcp.c                                       |    1=20
 net/ipv4/tcp_ipv4.c                                  |    7 +++---
 net/ipv6/addrconf.c                                  |    3 +-
 net/vmw_vsock/vmci_transport.c                       |    4 +++
 net/x25/af_x25.c                                     |    6 +----
 virt/kvm/kvm_main.c                                  |    3 +-
 19 files changed, 73 insertions(+), 41 deletions(-)

Eric Dumazet (6):
      tcp: tcp_v4_err() should be more careful
      tcp: clear icsk_backoff in tcp_write_queue_purge()
      vxlan: test dev->flags & IFF_UP before calling netif_rx()
      net/x25: do not hold the cpu too long in x25_new_lci()
      mISDN: fix a race in dev_expire_timer()
      ax25: fix possible use-after-free

Greg Kroah-Hartman (1):
      Linux 3.18.136

Jann Horn (1):
      kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)

Jose Abreu (1):
      net: stmmac: Fix a race in EEE enable callback

Kai-Heng Feng (1):
      sky2: Increase D3 delay again

Lorenzo Bianconi (1):
      net: ipv4: use a dedicated counter for icmp_v4 redirect packets

Paolo Abeni (1):
      vsock: cope with memory allocation failure at socket creation time

Wei Yongjun (1):
      hwmon: (lm80) Fix missing unlock on error in set_fan_div()

Zhiqiang Liu (1):
      net: fix IPv6 prefix route residue


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxxHo4ACgkQONu9yGCS
aT45Eg//SvQQBwbkoze8s4GN/S0EZVq2mVpIa8SI5tbsEZdSKZosTESFJA/RXvu/
LFe2UZmSMrXX8/NsjkJ6liLpo/0U2AC/LPqlxCAIbFknKbOBqYDKgtj0CtwJ4lM0
Y0HDa3Y+PRxYLrw1sDf7Tmf9yJAYvNMyzh30utXv43hghYWbOBOFu5B/4U1wj3OJ
PJfEfCMXR2s/XFcyzbm0/ehpXoUN62DvY8U3mtlG7Fb22KBWSgx+N4A0Q5yZnNhe
uUuvPzbE70aPW/sRLMEe7ty/d/1o90dJG6MQz+rAArKxrRJZnKwjV47FlUX3ynl2
RTlb2cmh++3M84EAmed6WbHoVtUFdVB86uJZDM91cJHqD9yiG+XkODWh5L7NbQp5
kvuA24PeZqeU4EWQMDTGJXj8GaOnT3Tb1rhOOvhQF7u8+HplLUB1M8SbqwOttr7T
vrRclylTuhszJbyF+O5xYMWplaxysvntCPSkJvkumYR1JnhR2rDhx4GHd/pRSQyC
IilIlO0acTt5Py1SX3MzLvZDfYdm/UbTTcgPfsznB24dZ3l1s0y2flDlxsd191XU
IAAnsgbIcwtwLzgp6gX7LVHG57gLxMVqgGeSSgYZQmP1kXGwCpo7kzvnGl1+uTJk
Btd5E4TuvNrtk8lB3rqul5c/7q9R8S67n+bB9u1FDLUIjPYwsfA=
=n8rA
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
