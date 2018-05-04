Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeEDPG5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:06:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35226 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeEDPGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:06:55 -0400
Date: Fri, 4 May 2018 17:06:53 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/7] clk: sunxi-ng: add support for H6 PRCM CCU
Message-ID: <20180504150653.n2rqqhr45hrpjfw6@flea>
References: <20180503183847.11046-1-icenowy@aosc.io>
 <20180503183847.11046-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ol54axoa4kjh4s7e"
Content-Disposition: inline
In-Reply-To: <20180503183847.11046-2-icenowy@aosc.io>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ol54axoa4kjh4s7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 02:38:41AM +0800, Icenowy Zheng wrote:
> The H6 has clock/reset controls in PRCM part, like old SoCs such as H3
> and A64. However, the PRCM CCU is rearranged; the register arragement
> is now similar to the main CCU of H6, and the PRCM now has two APB
> buses to control -- one is clocked from AHB clock derivde from AR100
> clock, the other is clocked from the same mux with AR100 clock.
> Therefore a new driver is written for it.
>=20
> As there's no official document about the PRCM in H6, all the information
> are indirectly collected from BSP and parts of the document, and the
> information source is noted as comments in the driver's source code. If
> reliable information is provided furtherly, the driver needs to be
> rechecked.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ol54axoa4kjh4s7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrsdwwACgkQ0rTAlCFN
r3SU7A/6AwzeO1L9lSof47Bf6ce5x4UH22356+xQz7RydiDqbLIuPjSAHqf52Tn4
cte614nWBBf31a+tLt0dkMdQ6KW1Ffc5E6uTqFRVtPtNNjy2fAHldH82z2v4Q4Xm
S5VOj6tJO+pIb+csBtBELseKwN3Iq0SfZDjwytJ+IfGzjDlLhTwVRHoUfU5+ouDx
kj44PJftJLS1adRQmH1fKjNoshQOuUAOmQanG+E35dgbBuB7o4B7pYRLyMUbBS4t
5YWbLmi7QFpWfXYqwl1GKgLBk9Ldv00hTBnryNRrkBe3E7NuJNJoLv1NJIUQ/eH6
CgyzVbbRrkZX/is1crNt5is8jWSyQdkrgJdMI/6KAej3/yPyZpVlVso27aHxnrz8
Pl0VWsnUcc5MgtRzKnhRkIV61x91hCIZUrFtb7RYwYBMrIZyVo8NrpjxLGz8wICM
wEvHs9R9ua+1XB2uEPC22QAc4+MxaFNo6Vu2IceCKS9kBtNsrg877ZmaXwCjemeQ
z51KrVu3/XwwkZ6OuMlQ+Jw9w+zzyCHxl4MRgVnzXyvd0ENpFinhSO1S9miuyyO4
p4/blP8XxSXMjpGsVTr7f6NfJhIvPE004PjMKsDc+0iaWafUu9IOaIzBcLfNGA6M
YsA4/JrMIm/wXkRbITKTglXw55lLRT1DRMTAhOcCZdDwS3g/yVc=
=x0gO
-----END PGP SIGNATURE-----

--ol54axoa4kjh4s7e--
