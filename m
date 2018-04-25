Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755891AbeDYRfG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:35:06 -0400
Received: from narfation.org ([79.140.41.39]:36420 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754654AbeDYRfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:35:04 -0400
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marek Lindner <mareklindner@neomailbox.ch>, netdev@vger.kernel.org,
        Antonio Quartulli <a@unstable.cc>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix batadv_interface_tx()'s return type
Date: Wed, 25 Apr 2018 19:35:00 +0200
Message-ID: <2141097.l2ETxyu3Mo@sven-edge>
In-Reply-To: <20180424131847.5469-1-luc.vanoostenryck@gmail.com>
References: <20180424131847.5469-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3058166.N0ZLB7ETp8"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3058166.N0ZLB7ETp8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 24. April 2018 15:18:46 CEST Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  net/batman-adv/soft-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied as 6bf9e4d39a58 [1] but the alignment was fixed

Thanks,
	Sven

[1] https://git.open-mesh.org/linux-merge.git/commit/6bf9e4d39a582a4beea1844d6955cb2ebc979a67

--nextPart3058166.N0ZLB7ETp8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrgvEUACgkQXYcKB8Em
e0bOUhAAhY8mwipI/xudtknw5gwSMq0iJAp5iGt6/YJQXHiO9uqU5WF1I3Te9owR
0CNcZq00sPbsdgJGuRxZoLJ9lvbIZxJYc1ZQHjkdO7Oa14l3kJO6cSjv41MHKsnE
IyFfEB+p+YtJcbSMVWoPXcjH///vFhCHTxKWv1TuxnvBXu7l/TzevkA2Hv0PDYdp
8dmLj/okqgg+FQpEFMSiJKp3eeh7pO+8CD6uH3pXSlPsCQ5o0rayfQZ5g2Stc8m3
SfYM3Jx7QQA2fML8v7GyfhHA0xjdDMKZ+4tcjbZx8l48R/JpSOR/FDp6aOJ+dLrT
2qTy26TUN10lSaeyxABvY74cdTTCxqrFXT9eT4vKNfklgRw34aIRrLWdZCg37Hm2
D+wO2p6UNkxwAeCCwDV0FHrQsU+eK3934gf7IfR0AVak5vgf5eHoF1chNXFmJLYl
RPAPqMzy1z2HqG4Mz7d3RfXlaCoN/eWt60XbM9OohvCgyhr+NKmqtMyrFhGtSOyM
dO+UQwjESOhs40U//OVAsMMqx3Hf7mQar2kimJOg7eKw6t710f3Bw+jm/eJOsZUp
6v2+8wZZRYJABnyQ0TQaczlsTUTo+awkVnApWGxaY3Yhk8tnhBDvemA/XR3JSch9
6NeHrh6AUzcnsWsVr4h9hbIBAnUjbmZyQqy0wH1SCctBUV/21wQ=
=Vp+V
-----END PGP SIGNATURE-----

--nextPart3058166.N0ZLB7ETp8--
