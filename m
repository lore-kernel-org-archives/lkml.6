Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932535AbeEWKxJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:53:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37782 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932391AbeEWKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:53:04 -0400
Date: Wed, 23 May 2018 12:53:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christian =?iso-8859-1?Q?Kr=FCger?= <C.Krueger.B@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suggestion: =?utf-8?B?4oCec3BlY3RyZV92?=
 =?utf-8?B?Mj1vZmbigJwgYW5kIOKAnm5vcHRp?= =?utf-8?B?4oCc?= per default in
 "Intel Atom N270" case?
Message-ID: <20180523105302.GE15312@amd>
References: <72a7122d-0020-f307-a76d-bb80a2c19842@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <72a7122d-0020-f307-a76d-bb80a2c19842@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-05-19 21:53:02, Christian Kr=FCger wrote:
> Hi,
>=20
> Since the old "in-order-execution" Intel CPUs like the Intel Atom N270
> (known for being installed in many Netbooks and Nettops) are not sensitive
> for "Meltdown" & "Spectre" , wouldn't it be a good idea to exclude these
> anyway "weak" CPUs from the costly patches by default?
>=20
> Browsing the web, I can "feel the difference" if the matching kernel opti=
ons
> are applied on such a device.

Can you also measure the difference? Placebo effect is hard to avoid.

But yes, we do not need to do workarounds on non-buggy machines...

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsFSA4ACgkQMOfwapXb+vJCPACgjUfIt4MrQuWRA1SL/d72GEby
YGsAnjDf0q57pK4WO8YDjYiikKjcyxXf
=Ivix
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
