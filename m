Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeBHIDj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 03:03:39 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:36688 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHIDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 03:03:38 -0500
Date: Thu, 8 Feb 2018 09:03:35 +0100
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
Subject: Re: [PATCH v4 02/12] clk: sunxi-ng: Use u64 for calculation of nkmp
 rate
Message-ID: <20180208080335.uduk2aa6vdkaa5n3@flea>
References: <20180207211713.3638-1-jernej.skrabec@siol.net>
 <20180207211713.3638-3-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gmiu3sxsclb4fsnm"
Content-Disposition: inline
In-Reply-To: <20180207211713.3638-3-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gmiu3sxsclb4fsnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2018 at 10:17:03PM +0100, Jernej Skrabec wrote:
> When parent rate is 24MHz and multiplier N >=3D 180, intermediate clock
> rate doesn't fit in 32 bit variable anymore.
>=20
> Because of that, introduce function for calculating clock rate which
> uses 64 bit variable for intermediate result.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--gmiu3sxsclb4fsnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp8BFYACgkQ0rTAlCFN
r3TClRAAg2q00R9Ae7dCh1Zyb5ztVhCT4VAqCTFiAZSlSW7NBYxrMCUBt1+JXl2H
tlld0BOW+3nVnMnql3U6unl8/lfqTsndVczVXEW/Qz+WNBQgqaS9jGfZSdgMcrLk
lgXd5cOvkvVBYQdFlkClQx5BbESN4l9MefFM++oVj08icksy+P5WLz39/PxZ0WG8
/GlTMs9+vl/d0OZRRnbRnzrDm58cy2GhIcedqJMP0wlsME5jA319aea2+2jAJSAP
Sxa3ds+oS0CifxVWqQam3uyUxuyOjPP+ZnNQNmhVBpqwYiPW2+NFGUm7AjUZ/ScP
0bBIybY1xqu6VjIWuzgF4TPeZQ5R0E5lOyTT7BwwKhbMZsR4LBjy4jCFQPQtAeHj
e21D/6tAZ2de3xlgIx2P7+Ij4a1Np2gI+s+2btj9pYAMEMFjojjbvG5eDepf32gq
E8QySefQE5dF82jFiM28IhucNUfgDM1+Ya5uisBzGvvVmiiHa516ePt9YNoGZS+J
jZ0bS6RXM0bzQXHnK8G9JhU53yZb/iDXbc3SlzFNH38vleFbOnVoHpOAW+6pQMHg
LpfHzvGa5Sd51+0/u+bLcbvvlFRuVAhDodES+8BdGlo8BoBE60JU1BoAX8/n4RGg
nxxQX28qhaw6Zg9wjrSlYVNmfrI5BXxF1tc9DQ+unLf8/fGeWlw=
=05Kc
-----END PGP SIGNATURE-----

--gmiu3sxsclb4fsnm--
