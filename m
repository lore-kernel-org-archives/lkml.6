Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934130AbeB1P4E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:56:04 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40255 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933397AbeB1P4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:56:02 -0500
Date: Wed, 28 Feb 2018 16:55:59 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: init dclk_min_div & dclk_max_div inside
 encoder init functions
Message-ID: <20180228155559.lqm22dzeiptrwyxe@flea>
References: <1519822318-3974-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5gbfw7g7hxhf23t4"
Content-Disposition: inline
In-Reply-To: <1519822318-3974-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5gbfw7g7hxhf23t4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2018 at 01:51:58PM +0100, Giulio Benetti wrote:
> sun4i_dclk_round_rate is called before sun4i_tcon_mode_set,
> so it finds dclk_min_div and dclk_max_div set to 0 and fails
> adding crtc.
>=20
> Move dclk_min_div and dclk_max_div to encoders init functions.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

I sent a similar patch there:
https://lists.freedesktop.org/archives/dri-devel/2018-February/166666.html

I guess eventually, we'll want to remove the usage of the clock
framework entirely, but it's not really the scope of a fix.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--5gbfw7g7hxhf23t4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqW0Q4ACgkQ0rTAlCFN
r3Sm9Q//SRjm419L2UjZkPa719KL759OGk396Oj7wSRWA9wUFREggYKpJyx5hcRF
hKZYVV9gIn3IvKeNAVnOjeliSDHRQQ88dCjiTHLa4ClsxNoQvyo7cMTMHu9e9n8W
Y+acGnnmUVKcyMgvimI+tmG72iAhvfhn5+7jL6yDyOxabiYhJPcYqMIDXO8Cxd5Q
zjX+jRJkbAkEanOEjACbA2t93+jSs5RCeh6BVn5FhlLAcuNus+iahOeGJQwir8oh
WtpLwPUJwWrp4wMuzmr3kRMqOdYka4A32leNFpR4/+ERayqbBNmqQXhRIncBOAfl
8A3+GAfjwUlgL8sQ9aphmsgm+psY0KCL06LW77gyU6cIpKnmqlrKPQbAsxwZnLY7
22Tp9ntHTLpYbEXvPBozGdpOiyhuKus69VgLSKfmht5GuhaUTptSt+u3C3M21iSs
neHd4DKlG+39Z+/l2aumap4TQw2QCy6AXTqAicnF05xb8DX7LVh95KP3TrVNBrfS
ELy8SlRtkmJRwdYezYdpJdbk5EdeSJQtPlstrsD9E5XzWpXnC5th9h+9kXHAQwrd
h/Tiai7HzRDtv+IA9u9wcxuZty8+gbTeXPXVzaWHYovSAloI+WvabNt/LjWNm+VJ
86ni6+BpTkT9B6LVscWwkE9bL+faW2ZSvh6q2cGcQp/rVidytpw=
=EvAZ
-----END PGP SIGNATURE-----

--5gbfw7g7hxhf23t4--
