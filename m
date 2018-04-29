Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753482AbeD2OWW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 10:22:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52111 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752895AbeD2OWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 10:22:20 -0400
Date: Sun, 29 Apr 2018 16:22:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429142218.GA13475@amd>
References: <42c1b84b-ab1f-5577-6304-e0985a637cf9@molgen.mpg.de>
 <20180424135621.GD4189@thunk.org>
 <20180424154904.GC30619@thunk.org>
 <d251173a-d7c0-3f55-7c22-a100f6093176@molgen.mpg.de>
 <20180425074144.GA18803@thunk.org>
 <4d707453-0771-2d1f-3ebb-0d19b85177a2@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <4d707453-0771-2d1f-3ebb-0d19b85177a2@molgen.mpg.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Am 25.04.2018 um 09:41 schrieb Theodore Y. Ts'o:
> >Does this help on your system?
>=20
> Thank you, after figuring out how to apply the paste, yes it helped on my
> Lenovo X60.
>=20
> >commit 4e00b339e264802851aff8e73cde7d24b57b18ce
> >Author: Theodore Ts'o <tytso@mit.edu>
> >Date:   Wed Apr 25 01:12:32 2018 -0400
> >
> >     random: rate limit unseeded randomness warnings
> >     On systems without sufficient boot randomness, no point spamming dm=
esg.
>=20
> I guess this is a problem with old hardware?

Ok, I see it too, thinkpad x60.

But... this machine has spinning harddrive and independend RTC; there
really should be enough randomness...

Could we exploit either of them as randomness source when we run out
of entropy?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrl1RoACgkQMOfwapXb+vK5zACgphRq7tc258wO9zvI9IGb4jQK
zXkAoJhNTiBnwg9yk3OPlT0HstrNbkW/
=Wb+l
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
