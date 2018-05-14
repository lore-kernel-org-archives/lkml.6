Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeENUFH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:05:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41417 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbeENUFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:05:05 -0400
Date: Mon, 14 May 2018 22:05:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dan Murphy <dmurphy@ti.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, afd@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: lm3601x: Introduce the lm3601x LED driver
Message-ID: <20180514200503.GB3276@amd>
References: <20180510174717.26540-1-dmurphy@ti.com>
 <20180510174717.26540-2-dmurphy@ti.com>
 <41267191-1308-6b9b-78fa-2893a525b49a@gmail.com>
 <17630aca-1225-df61-7a5d-a921ecd9c78c@ti.com>
 <86c2bc2f-e622-9447-e4bb-b4ee37e2d44a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <86c2bc2f-e622-9447-e4bb-b4ee37e2d44a@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > OK.
>=20
> OK I looked at the max776973 driver and well if the flash-max-microamp and
> flash-max-timeout-us nodes are missing it sets a default value for each i=
f the
> node is not present.
>=20
> So should we remove this code from the Max77693 driver too and fail probe=
 as being asked
> in this driver?

Well, modifying driver without access to the hardware is tricky
:-(. If it does something stupid (like using other than minimum values
for the flash-max-microamp/flash-max-timeout-us), it needs to be
fixed.

And maybe comment "don't copy this, its wrong" would be in order...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr56+8ACgkQMOfwapXb+vJsdACfbufxCmhkivW0rFmmNq5c24UX
UE0AoJLP7Fh8r2XQl+xn0dACfvFZcHnz
=mKky
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
