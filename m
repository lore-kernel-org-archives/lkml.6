Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753740AbeDJNCG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:02:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47621 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752775AbeDJNCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:02:04 -0400
Date: Tue, 10 Apr 2018 15:01:52 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] pinctrl: sunxi: Use of_clk_get_parent_count()
 instead of open coding
Message-ID: <20180410130152.cccquujj7j6asv5b@flea>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
 <1523364701-15383-6-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o3guqvonumlxhijw"
Content-Disposition: inline
In-Reply-To: <1523364701-15383-6-git-send-email-geert+renesas@glider.be>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o3guqvonumlxhijw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2018 at 02:51:41PM +0200, Geert Uytterhoeven wrote:
> A new open coder has crept in since 470b73a38470e8ba ("pinctrl: sunxi:
> Use of_clk_get_parent_count() instead of open coding"), replace it.
>=20
> of_clk_get_parent_count() was moved to <linux/of_clk.h>, so include that
> instead of <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--o3guqvonumlxhijw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrMtb8ACgkQ0rTAlCFN
r3S8Mg//ZpBQHXcvZIXgRQTDxBsbN/raSOmakCV8l1JmXYXKrQ6vSrHuQdQgA5jz
PJRAZaYRlR6ZVI3sTnqR17oxAxa2b1C+Jusz9Qfl3kuirfXipu2lRKtlUnZfzR/D
cL1XBODMO7/MgcI+ip1TZe3D9zzyRsa2ZzJ6AQOfsZg44O6LkvlXDVRljhpR7fmH
7k9PvEJCLkgldXTFSe/FsQvGLFP2eDNrc6v3CFthfdX/gzTugGL83PyRJwRj8Agj
0eB2GIeTpKmLGRq2ESWmVIls/w/Q1trxVyfHNp3pg3n+m6K/1qixYD8aECPW2/88
0ITTZYfZ955Kgr9RY3ieqVIAg9SfrRu+eaEBFlrceo5AZTEIrslpBWbaGJcHG9sW
Z6R019Tb46ufXXdaEUEMdFN7d/hlXu1bfz0uxtSe7Dcv8UaQyEUH4h+N5bpt8FfV
DjD2m1zDGiznCDLVZECfbT6mjXeGkwrIAwP2Kz4lU8v6rilGiCIsYv2ecnyTMNUB
B5Z0pJt2j1czGlQO2jpovt2QAXg9lmuHlg0ny/xXwlpG8YbBUz1ZOPYT+a/g09FE
7BEkNXYe0FDJlkIuVjBjF/qFgtK0jylsi4hUsOMai6SG4vQMXe8QzX9lECcx/cB7
iqMASBwI5iyTRX+A8UVzCymbw8Zk10me91tXaTtk0Tji3qKxuUY=
=tkZm
-----END PGP SIGNATURE-----

--o3guqvonumlxhijw--
