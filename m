Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757579AbeBPJJ3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:09:29 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46319 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757564AbeBPJJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:09:27 -0500
Date: Fri, 16 Feb 2018 10:09:25 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: wens@csie.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, narmstrong@baylibre.com,
        Jose.Abreu@synopsys.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 00/12] drm/sun4i: Add A83T HDMI support
Message-ID: <20180216090925.bct4u3rfdg4epmpa@flea.lan>
References: <20180214200906.31509-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v7eapcxguafrbstv"
Content-Disposition: inline
In-Reply-To: <20180214200906.31509-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v7eapcxguafrbstv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 09:08:54PM +0100, Jernej Skrabec wrote:
> This patch series implements support for A83T DW HDMI and PHY. Contrary to
> v1 series, this one is based on latest linux-next, since all needed patch=
es
> were merged.
>=20
> While exactly this combination of HDMI controller and PHY is not common in
> Allwinner SoCs, this patch series nevertheless makes groundwork for other
> SoCs, which have same DW HDMI IP block, but different PHYs, like H3 and H=
5.
>=20
> Please take a look.

Applied and pushed everything, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--v7eapcxguafrbstv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqGn8QACgkQ0rTAlCFN
r3RXPw/9GDjBOi4+Nv9x+jhnrPNiddQ1dIuAA4seBO1Hg6/GanA6niQnTF0FhYmS
wWn6iC8ZHYfmtinO3kSAiqHGHVO4J6LBL682+ycoy8Su2XzUsAo7X76nZxI5m7Kw
rSqByCmPgCXfiXmcHvizK9axkwNlHyNRy9fWDUR1CSyD45YgkaQrpGdecvbQ4JY/
Lj+wU+2zq6cqIZ4xnESOH+qshWyL988gIGWcR8VtF+SCv/9dgdpJge/T6EnYzj7K
aDayrsmJGEqng/GAWT90fCEYt4XzLGEMAqbXU2whTR2rT4LKJUgTwvc+sITpM8/I
6wCP3ChT2ZYZ0h/YGGiKgFsYU3aSD5JldDAhLqVG7/6Q206zblBI+21XZ7L88Vv4
aTBizZXFbIsuMFTqMZD+Y1RkfrW2xw0dtblcqwjTBRvW3pk0ufJhdIwFZSkHc4N4
wZu/gTRFASGz+wr3DzKa+qHerRI9xU6Ycm7748fSeMp/RV7JcqXTjAQF5Zej5COT
JuVKw2Xrt5dbWApHNdTMdQbV2Zs4x5fsjjKJTg4vrcC3HulPcqEADRHN1CxAv2fh
ALMN3FWz/rUdHMs4FGAK5HmsPHxMyEDpvs3Nk3ydEZn0syDqQIVo4zNVfXzfL2xE
VJL82vp9OeUwbUjDj2jpKU9mrWrmxsxM7RtjVuKbuJ4WHK/SpNo=
=fIM/
-----END PGP SIGNATURE-----

--v7eapcxguafrbstv--
