Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeB1HhP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:37:15 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52045 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751675AbeB1HgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:36:23 -0500
Date: Wed, 28 Feb 2018 08:36:08 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: wens@csie.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 06/16] drm/sun4i: Don't process LVDS if TCON doesn't
 support it
Message-ID: <20180228073608.r2zd3qkiudm2uarm@flea>
References: <20180227222701.9716-1-jernej.skrabec@siol.net>
 <20180227222701.9716-7-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aqjrippsxme475qi"
Content-Disposition: inline
In-Reply-To: <20180227222701.9716-7-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aqjrippsxme475qi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 11:26:51PM +0100, Jernej Skrabec wrote:
> TCON checks for LVDS properties even if it doesn't support it. Add a
> check to skip that part of the code if TCON doesn't support channel 0.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

I have already sent a similar patch here:
https://lists.freedesktop.org/archives/dri-devel/2018-February/166665.html

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--aqjrippsxme475qi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqWW+cACgkQ0rTAlCFN
r3SGzQ//SGozme2gO0ALeJqnCLt8CQMYDzC1rRw0xfUb2agk3B881NEi3X5fIJUn
nTj9yAWBYvff/BlGerf/n6B7DFJdAvH7qX+t5mDIZlh5BxIAWTjmxiTPP0rSNakT
R2WSoI7yh+lBV4hTSy+DhMQ9mweINss8jQMKRdlnC78St415S7aG5lQ1mAvGWpeZ
Cf5en3JOsysN8kUQ1EL3gbRC0S+oRZT+Q2WNNlMF2nA8jIMkgENTY425RwJMDPUA
tIPJN1yeg4NG4IwpUA7TGoZnaT5htu5Z1f9X05AcyBMRo/v3SX+XpitLIYJtG9pQ
2oFgyTA6dSprW3fC0eRrqxydWh+xo69vdj84RSdRbPRbQINuHobAREkZ85gCFJG2
DayROsddA9CGM+L9G4nIMOIXjZl93tJLSWAJFhQocS78l1sEaYkSy0FmdV4Ugpui
uG7/Uyk0mnzW4dBS1afOuuFntoKmgp55qU9KIEtRV9v7FOpuKcoXnkVXuVdo2sbo
YdrksU8i9TRFLlcZGuH5tB9OUThgL5ZYEJYZKxjf0lP/eBwJpiuWFH5z9pGsZ5hH
WxZGduaudW0z3K+5vnXt1BDbBye4Gjm2umwYPJjqLihc5/w6kDb8TQSRTjkG9M6n
0zMAvak60eOlPvZ8w86JsZKSjM1EcUu1V4ZsHTx068cVmQYvwBw=
=nYue
-----END PGP SIGNATURE-----

--aqjrippsxme475qi--
