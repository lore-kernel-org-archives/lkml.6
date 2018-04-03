Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755271AbeDCIrs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:47:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40556 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755154AbeDCIrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:47:46 -0400
Date: Tue, 3 Apr 2018 10:47:45 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/13] ARM: sun9i: smp: Move structures
Message-ID: <20180403084745.zuq6o3tlxpvcynev@flea>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-11-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="blum7rsypaplwhpn"
Content-Disposition: inline
In-Reply-To: <20180403061836.3926-11-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--blum7rsypaplwhpn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 08:18:33AM +0200, Myl=E8ne Josserand wrote:
> To prepare the support for sun8i-a83t, move some structures
> at the beginning of the file.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>

I'm not quite sure what would be the benefit from that, if it's was
working before, then it would probably work in your case as welle, right?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--blum7rsypaplwhpn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrDP7AACgkQ0rTAlCFN
r3ShhhAAmZpovgsG7AMg9YreUNPWAtJonO+8Zwz9waQyGy4Qkc3RhvMBCkGx9I/b
SC88gHuzKWrqfxLKhzV/9tea7y0gSZzm8cpAiTwWkAQPXr+y2ZTWMFXtH0R6Mz+p
w4KzRso96Q3/mGh9wAbOn84TKdz3d82Z2vwN1p8LMJRFtwCep+iicDYQg2DUtTkQ
MUs/ySrJXsBWYvzEJZELxoMBbeDJBTxKje2s/KHYLODPEPPcNhkVHFvuiB4O+ZaM
6hozEtNgiRumoStlAerx2qAmtyEALZZiZw/ozV8kp2AP3OdunkgjBjDSuIAfjDYD
IIi1N12WVPW2S4dJqlgbRJCxsUwuGmJEhvi7KrLBvrmz+bxtVk2y3DdaRj+Nk66y
9LahMsb2oVA0YCBGgsq1HryY59/ArgLmCxSnbMJipS780YgGAwT1wbOHH2UhNrKx
xomHrXdiF2F+70M99JjdgYetV10FR1pJ2Kzl9camev7mtQ1rrXMNYyXETSNwGfX3
7T/jGh1yQV72Ruk/mF2+2Az1YwIJnaqTZZs2k+YehUlmv+zJx8nh/0gjhu9xPLzC
IjaD7HY/uueyK17i1Wpz4yBpi4VISzcMMIpc8kB34pzf1PvbaaS8oAiaEQ96EbJM
Y+c3/WLZlmcKqY91ROz9wvbp8YIcO6IjptYDz/UXMP7tY7BDvNg=
=qh1r
-----END PGP SIGNATURE-----

--blum7rsypaplwhpn--
