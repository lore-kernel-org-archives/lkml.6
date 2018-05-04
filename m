Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeEDPHK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:07:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35263 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeEDPHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:07:08 -0400
Date: Fri, 4 May 2018 17:07:06 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/7] arm64: allwinner: h6: add PRCM CCU device node
Message-ID: <20180504150706.hivzti5eoejwlavm@flea>
References: <20180503183847.11046-1-icenowy@aosc.io>
 <20180503183847.11046-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h63zj6d43wukwd46"
Content-Disposition: inline
In-Reply-To: <20180503183847.11046-3-icenowy@aosc.io>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h63zj6d43wukwd46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 02:38:42AM +0800, Icenowy Zheng wrote:
> Allwinner H6 has also a PRCM CCU.
>=20
> Add its device node into the device tree.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--h63zj6d43wukwd46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrsdxkACgkQ0rTAlCFN
r3S3hg//WGTFJTlY/rV9zfXAy8/M3rpQl15cPT+tuuj+MwfLK/wWfXEnDSKLFZdC
AW8aEB5whirknKPnH0DTy296ioel/EFJzIEylnkByKtcbGq3aIMNAAQuhGTDViY/
2tfOhGaar6phqW72ZhOMMBbw3oYy1Sl5xIhmQa8tCxzYj3QyV7wW2mlFbnyQkACT
Aa21o2KZ6Au75Nby/gvqRsBnSmU14l3SAHI3GhuPxUizP2ZCPPLBIlp6f5ZvhJXs
i8hiLa1m+pycXeGeqD2h99T//R+mo3reiUNdQFWyRzayY6BgnhAiE9naKJQS0QFt
tAvuukMfLiYOBZPwvF8602cqcPq79HyZjZG3eaVFPOJSwKTg4IDCJi3NnwEwq9sQ
OUUN0NZpCSw91YovT7p8CC3ANKCKn3dwtquhlFMaN18eJe613M7elm9ACG/+2zeI
WLQb5p38EB+xIdKtg7+qr+WqMkBn9rsKRW1qper/LLaPdVNN+YfJGI+hzdqASvjz
2i8CPaKcwq3Fg0JA7oGfUVnCNaCUZxfB4V94HDh0qi7jQtE17LRdli06Si/Sxb49
HzQG12R4K3Z2zJ1krNn0ndsn69szzjMpWI/8dUVpc6cnfVj3Q1eIAzIFf8LInxPD
sECJw2DR5Y46Jg0m+9mLAtfiC9h531XFWdIlClBCl+sxXDbytm4=
=/Qtv
-----END PGP SIGNATURE-----

--h63zj6d43wukwd46--
