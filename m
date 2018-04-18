Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeDRVYi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 17:24:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33393 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeDRVYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 17:24:37 -0400
Date: Wed, 18 Apr 2018 23:24:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Screen brightness behaves _very_ differently across different
 machines
Message-ID: <20180418212434.GB26962@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I tried to run auto brightness settings tuned for Nokia N900 on Droid
4, and results were not nice.

So I tried matching brightness between Nokia N900 and Droid 4, and I
have a reason:

Brightness 1 on n900 corresponds to brightness _50_ on droid 4.

| n900 |  d4 |
|    1 |  50 |
|    2 |  70 |
|    6 | 100 |
|    8 | 120 |
|   20 | 130 |
|   30 | 140 |
|   40 | 150 |
|  100 | 180 |
|  128 | 190 |
|  150 | 200 |
|  200 | 210 |
|  255 | 220 |

Values are very approximate, I did manually. (Light sensors are funny,
Nokia seems to have calibscale on intensity input, which should be
unitless, but not on illumination input, which should be in lux. And
I'm not sure... is value_in_lux =3D illumination_input /
illumination_scale?)

I'll get some sleep now, if you know what is going on there, let me
know...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrXt5IACgkQMOfwapXb+vLoFgCgiDghCe0L4O5mw9K5XDLyUCxg
134AnRYd+jKxPPqxzuyfTeLZfuNQ4AbL
=dp2w
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
