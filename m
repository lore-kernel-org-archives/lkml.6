Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754114AbeDWHOe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:14:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53585 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbeDWHOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:14:33 -0400
Date: Mon, 23 Apr 2018 09:14:21 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Pascal Roeleven <dev@pascalroeleven.nl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sun4i: Fix incorrect clocks for displays
Message-ID: <20180423071421.byupsz4gxpmhfe44@flea>
References: <20180420102112.2843-1-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yofuic37aad2weiq"
Content-Disposition: inline
In-Reply-To: <20180420102112.2843-1-dev@pascalroeleven.nl>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yofuic37aad2weiq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 12:21:12PM +0200, Pascal Roeleven wrote:
> Some displays on SUN4i devices wouldn't properly stay on unless
> 'clk_ignore_unused' is used.
>=20
> Change the duplicate clocks to the probably intended ones.
>=20
> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>

What was the difference with the first patch you sent?

Anyway, I've applied it, thanks

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--yofuic37aad2weiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrdh8wACgkQ0rTAlCFN
r3S1oA/+P22r7q3WrFzmbh+WhPBVxB+/8xP5RRyJsb1kxBhZPYhsFeJjMyiyKHu/
wjEb0kdfvAjixuMOo+qOKFUjwu/BGywIEMhySIOdGgLzORmNvC6U46ZPnObnN0oy
5nPTByzsEnPdwgkdsfhjUpSB8LSY8uLeL5s6K6LGSKTeerYtn5UgYPNOAgi48JLP
jQD003q5H1NOCndPetv3tXfYwd2ek4M5xNoIountXovB/XO7Zvn/GBL8yPlJLyRp
4eP5moywYZyEi9PmsTI8Qxod5XKWsSodR8iecoOp9gTBxeWP1bqNEUpXhgclnAlI
HbfASEVLiCTyE5L0K4K2J/vlykr96SSHMLaGh16Tsphh7YQioi168UU3wVlfMbir
V2L9qn47so1KvorWx6DyDVOxGGY72hR0WZnHkwIXzxJxvrNH2U57MynrkWKIdV85
zJzlYBz1xwxIIbiEMpH1IUq2d+617OT2hdWIWFwWrJgbNaLQPn5sqtu0+W9jx9Fj
d2J0tgj7M1ozsm+Sq1HPifq28GUi2f4dlU4UT7X81g1bPPKiWryHP+Ays6+hgGq3
3HR6vaiDN+BDiDF07dGGBYQxq+FUGze2EqEHzGtwbf3vzfsORkJTYuys/7UWn9TO
iLP5RYQyE1wSrlndnSf2FolWtooHYKM2RiGno33bOMEz3Thj4zc=
=Fzfb
-----END PGP SIGNATURE-----

--yofuic37aad2weiq--
