Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967083AbeCAJmB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:42:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35082 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966904AbeCAJmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:42:00 -0500
Date: Thu, 1 Mar 2018 10:41:47 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Fix dclk_set_phase
Message-ID: <20180301094147.2mjgpfq4q64gtptv@flea>
References: <1519836413-35023-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sw2z33woyim2jc76"
Content-Disposition: inline
In-Reply-To: <1519836413-35023-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sw2z33woyim2jc76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 05:46:53PM +0100, Giulio Benetti wrote:
> Phase value is not shifted before writing.
>=20
> Shift left of 28 bits to fit right bits
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--sw2z33woyim2jc76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqXytoACgkQ0rTAlCFN
r3Q8YQ//eU+d75DbMK4MmimUvRpulU17kvVlEcS5C705yEjQIHj0Dh/RokXVuavM
jhBzYfHeKJEQhoTFG7y1uHo0fVhBGHyjXLoQaPSJ4b4lsT5Krc2bOwq5cYX6UcdJ
PrUEsBrzvWlPn2UUfgXG8kCNbM0/5OoTHwe9Hbl223r7EGWaaDabk8mHG364/l2H
DHbkVR7cYCLgCPaZNXMLYWgOuuTFcfikcwZTOGA2CXQIf9rYgZIs58zy/ysDiH5q
GXdvqNZ/WEOB+nPCVoFmNujbNJC7rZfnbrvYVs0iBlO8nAK8u2Fi/kI9RkvWau2u
2jYeCi9naMt4SlPOWBdq1346hXlVG3Pj3IVkh4u6Vz8VG1k+F2Savvv4WP6RFGFS
ABZtXDpE0fPebcqtsNPFDb2JwPTNUDOuGn4MlfqvoldFaiuXUHs/9F4Kn55zm5WR
7j13E/VW7QujlF2mlSWWbp9WEJ0eUMhhUJuIDtG7lzotvwRgpTajX14I2tOOPZsl
LUwMyMhesaKtawryO/hQ0xYE6HLEDFsDx3nHHrilXtcpyO+bpqAQyTE6m4+JpYQQ
NIIZKjx30yeVsdza+CTFYLDYNs3FIRkCM97UOd+vbmUSfMdfbhCjkEqXJE5eRYnL
Hh5mh/Oe2x4KN73BAkmE0yQKZpzKzBKXuygyoATvNEA+S+pkyUo=
=3yvl
-----END PGP SIGNATURE-----

--sw2z33woyim2jc76--
