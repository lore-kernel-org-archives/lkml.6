Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeB1IGD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 03:06:03 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39102 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeB1IGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 03:06:01 -0500
X-Google-Smtp-Source: AH8x226SPEwkx9VF7Y/X8zHKVCYClTJYYQPGN1hl6yDXt1/GrsRnYL/pGppHh33uiGD+1W9uZF6Zbw==
Date: Tue, 27 Feb 2018 22:05:53 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <shemminger@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-kernel@vger.kernel.org, Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH] net/tcp/illinois: replace broken algorithm reference link
Message-ID: <20180228080553.wfgmz46fn452hddn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="satxfn6mdfuakrmy"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--satxfn6mdfuakrmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The link to the pdf containing the algorithm description is now a
dead link; it seems http://www.ifp.illinois.edu/~srikant/ has been
moved to https://sites.google.com/a/illinois.edu/srikant/ and none of
the original papers can be found there...

I have replaced it with the only working copy I was able to find.

n.b. there is also a copy available at:

http://citeseerx.ist.psu.edu/viewdoc/download?doi=3D10.1.1.296.6350&rep=3Dr=
ep1&type=3Dpdf

However, this seems to only be a *cached* version, so I am unsure
exactly how reliable that link can be expected to remain over time
and have decided against using that one.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_illinois.c b/net/ipv4/tcp_illinois.c
index 7c843578f2333db581..faddf4f9a707f1583f 100644
--- a/net/ipv4/tcp_illinois.c
+++ b/net/ipv4/tcp_illinois.c
@@ -6,7 +6,7 @@
  * The algorithm is described in:
  * "TCP-Illinois: A Loss and Delay-Based Congestion Control Algorithm
  *  for High-Speed Networks"
- * http://www.ifp.illinois.edu/~srikant/Papers/liubassri06perf.pdf
+ * http://tamerbasar.csl.illinois.edu/LiuBasarSrikantPerfEvalArtJun2008.pdf
  *
  * Implemented from description in paper and ns-2 simulation.
  * Copyright (C) 2007 Stephen Hemminger <shemminger@linux-foundation.org>
--=20
2.16.2

--satxfn6mdfuakrmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlqWYuEACgkQruvLfWhy
VBm1WhAA0NyUdhoDcXFB7uBi8wPXNdhzZY/kllJ3LHsqY1uLQbDLazB27nFfF8NB
G+ygkuHv0WvpBHxV8/iYsM0M9SUoaBFvczbawlg7IFGqV1ihtzuDSZCO+8r6ysX6
/X3ifDNDiwdfdMkGgAYVl/K5CbZTFxvpKPR0lu4Wss4pHa3UQqn0/RpPAfHtoS20
zo6r9KEU/5TAjsm8m85vrf0h00gIJbtDzXx0/564SRc4P3TKh5RGdxLwDkWXSO+E
jNSM82xr2CByK0pyT+COW/3Hc/rhIRCqA3kJcN/jO1zkl1GChjWO80PtO0CCF38A
YzgDyK1IyIKLmj9ac8aNTkA2Y955DyAEsamzffD4fwATQGhiSjheqmODIduhS0wE
MrLCAyyGzI9LSeL0ufscXj/ozktuhrO9OipR+b2YQ5vCVYF4+RUvOQ1hyke/yTvL
McufhprJtOCYSg6yFoyC7hYX1vIhDbsWwErdwJTUSzIavx5H4CjCcvzlOJQVoNI1
GAG4FF4+rPA7pk9VlqAX4ZS83G7k0JqotUkDbjpHqiOIEj0AI/6kozfAPxYUbN4i
BOR9GiObkEVNXpaixgKPZIIOarxJi3e7BoqO5k6As2udICsKof4HwEFyKmyTYPjo
5ql+9L5yHvZeiWeJjCCEkugZX+yjcqmE7WAqxPPOUGs9Tea1ux8=
=aDsn
-----END PGP SIGNATURE-----

--satxfn6mdfuakrmy--
