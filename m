Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbeEJSj0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:39:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42050 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbeEJSjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:39:24 -0400
Date: Thu, 10 May 2018 20:39:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, mark.rutland@arm.com,
        jacek.anaszewski@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 2/2] leds: lm3601x: Introduce the lm3601x LED driver
Message-ID: <20180510183922.GA12846@amd>
References: <20180510122718.8413-1-dmurphy@ti.com>
 <20180510122718.8413-2-dmurphy@ti.com>
 <87eaf628-3cf6-6855-5732-b0e5291f3b34@ti.com>
 <08526618-7463-1e6e-a4ac-c4da4627c1b2@ti.com>
 <7832225b-115c-2316-025e-29929cd4f208@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <7832225b-115c-2316-025e-29929cd4f208@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Plus, removing the driver is not a command to disable the LED anyway.
> >=20
> > True but you don't want to leave any LEDs in the on state without a dri=
ver to support it.
> > This could burn out the LED or the board if left on on max brightness
>=20
> I disagree, we should not try to decide what the user wants here. We
> should only do what we are instructed to do, which for remove() is to
> cleanup what probe has done so the driver can be removed w/o leaking
> memory or device state.

We normally powerdown on rmmod. We should do that here, too.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr0kdoACgkQMOfwapXb+vIfsgCeNsFH+hGjLHgRwD6e/r4rWcmE
fxMAoJ4iKLz7nXtYLLRoeH0YaacQRtiU
=Q/r+
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
