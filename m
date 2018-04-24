Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758082AbeDXNqr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:46:47 -0400
Received: from narfation.org ([79.140.41.39]:36000 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933680AbeDXNpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:45:47 -0400
From: Sven Eckelmann <sven@narfation.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        "David S. Miller" <davem@davemloft.net>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Subject: Re: [PATCH] batman-adv: fix batadv_interface_tx()'s return type
Date: Tue, 24 Apr 2018 15:45:43 +0200
Message-ID: <2333740.P7S8BcYFuH@bentobox>
User-Agent: KMail/5.2.3 (Linux/4.14.0-0.bpo.3-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <20180424131847.5469-1-luc.vanoostenryck@gmail.com>
References: <20180424131847.5469-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7028284.oJHuMbyaZl"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7028284.oJHuMbyaZl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 24. April 2018 15:18:46 CEST Luc Van Oostenryck wrote:
[...]
> -static int batadv_interface_tx(struct sk_buff *skb,
> +static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
>  			       struct net_device *soft_iface)
>  {
>  	struct ethhdr *ethhdr;
> 

CHECK: Alignment should match open parenthesis
#76: FILE: net/batman-adv/soft-interface.c:192:
+static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
                               struct net_device *soft_iface)

Kind regards,
	Sven
--nextPart7028284.oJHuMbyaZl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrfNQcACgkQXYcKB8Em
e0ZD+A/9GMc5rOQAuWEhpa8dh3fpczfJ7E3JM30mEMbUR7+VEyW7/v3YJoIdIa9D
xPgdy847X8i7NXrfDbbIsp1XDBXrqjOiz5WAa7sBXEFCj3ZAOLXdKpuicCRp4H5W
xhGbOGcKCAjkvRYSVBtGjebTHmIlsCM87AUAR/ADuNrOVrAwzbNxPUFGTyyoxfpb
f689dU5z3C3+s3Lflq3m1H/xOpBfpdbg5Ip/ZsTVFeePJGlee6oWW6VqM99hGb/H
9cLc810PpacMQB337Lf68cNDU+m43rV0mSm+vw3HyC+ZVPDu1vxiLVZ4VZYzf1BK
OvHU84mYQMOVIJDHC4BW+1fFcF5JBSk2cDkQ5fmTXZzcGfdL0CjlCoOCmcP7mzal
JjXJNBc1w/KtaR9zjVe+MIp+ZJi0zJbmWQ5+51pEiXICTok4rNekii7lcklMIeoI
z4ehD2J/rah47KGk6I/lEg1RcN77MkdyoT7RLcqCuO68jY9inMT992pDkWAxyc9Q
tR+JkT6E22jC//opaxD4D4QGaJlVkuMxKLWfP90ETU7zG4eVW2J0WnP+1xWkZZWa
yuVVs9eCgZWUPmMXpWbXdKWZFNlCOwSoca6tQFXTyXpxyIQQJnQDxmhfMdgHGgmj
f17GctIlA7q+lUdhbdddFCGTJzTxzcn/hc3t/k5/Vojy/B+ySpU=
=jB6s
-----END PGP SIGNATURE-----

--nextPart7028284.oJHuMbyaZl--
