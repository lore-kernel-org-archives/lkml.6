Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbeDDHNE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:13:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38478 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750762AbeDDHND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:13:03 -0400
Date: Wed, 4 Apr 2018 09:13:01 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] spi: sun4i: coding style/readability improvements
Message-ID: <20180404071301.hr3t225bt3dstikr@flea>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-4-ssuloev@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y2vn7dmartpqftwe"
Content-Disposition: inline
In-Reply-To: <20180403152905.1524-4-ssuloev@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y2vn7dmartpqftwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 06:29:02PM +0300, Sergey Suloev wrote:
> Minor changes to fulfill the coding style and
> improve the readability.

Again, this is a very subjective statement. Overall, I'm not convinced
by the idea of moving code around and shuffling variables assignments
just for the sake of it.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--y2vn7dmartpqftwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrEevwACgkQ0rTAlCFN
r3TD2Q//Scf0Mi1Q/oSNxw47xPh6H2oAWaUcl3smBNut+968VY+GN232ahOs9hCM
TcJME+cKOoMaFzU+6yiI66Z6YHFao2SJZkBOtQSjIZqc+Eu3IgqSAltgTjzRk1pE
KdhYDp/IL3Vovl+xOcRXFscbxukvjZl+8QpYb4hC+2QVxpIYjtXPJljgWc0Jlkis
cqswxGrNBs1mtBfbtSiLCk/2bGUDlEQCmYtykjK0gx/dwxVVgZF9QxkzQKvCKR/r
B3BV8yV5HQBJFJr/AQ64TPV2B5bMOdWVlzu+UKKXSNFjlhXfpZveqE3ycVInZTj5
yKsGgUqlqlAombxkL6RMHS3+uG3wE/Ko9DLNB/7qXx2lPFmmKl6Ndy89RrqwImJZ
IO22+0lO2T968FRvVk6yN8HbnzvKkS+WlpoWdh03c12PK9Z/6cy3aOmME8ECNsKO
r2r0uIzEpioteOvRuNW8kF8rUg2OAj8piqlWZ24HUHNEsBr1Hmpf5PuYPJ8VLEzL
UpDO7ofGsg/WyNt40NV7wt0o8wJro3IZzmv+4A9o0ZEN8Z9gpHWUpcE/hVh4SLlU
+lZKcwNPpMQaV8Itt9ETX4hw1Ke3FwcTSlwVEGiFMTFuvtmdjuMpclQDJxLjIJQz
ILaeKJZJWvG10XuIXk2/G8+beOwQagCcVs+PX2fByEXnPkeGQqU=
=KT/F
-----END PGP SIGNATURE-----

--y2vn7dmartpqftwe--
