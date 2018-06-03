Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeFCVBT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 17:01:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42628 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbeFCVBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 17:01:18 -0400
Date: Sun, 3 Jun 2018 23:01:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Cc: aaro.koskinen@iki.fi
Subject: Re: Common config for N900 and D4
Message-ID: <20180603210115.GA7438@amd>
References: <20180603104839.GA21197@amd>
 <20180603165336.GA26995@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20180603165336.GA26995@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Aaro, I know I have asked before, but if you have common config for
> > N900 and Droid4, please send me a copy. Yes, it should be somewhere in
> > my inbox already, but I can't find it and version for v4.17 would be
> > more useful.
> >=20
> > While trying to came up with common config, I hit:
> >=20
> > [    0.000000] L2C-310 erratum 727915 enabled
> > [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> > [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
>=20
> I tried disabling outer cache to get rid of this. That got me further
> in boot, but not to working system:

I now have config that works.

My kernels were probably grossly misconfigured (OMAP4 not enabled on
droid4)... still I'd expect some kind of panic explaining board is not
compatible with kernel, not a random oops...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsUVxsACgkQMOfwapXb+vLvkQCfZbppLGnuOsgB4b1v18Qxz12+
5i8AoLMw2tjfXzHyo7VWQkejyRK1Mvoh
=aRrE
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
