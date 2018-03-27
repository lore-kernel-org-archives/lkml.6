Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeC0VWA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:22:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44170 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeC0VV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:21:58 -0400
Date: Tue, 27 Mar 2018 23:21:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net
Subject: Re: 4.16-rc5 on Motorola Droid 4
Message-ID: <20180327212156.GA10834@amd>
References: <20180318220418.GA22880@amd>
 <20180320140322.GU5799@atomide.com>
 <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Yeah display related stuff is half merged in Linux next, backlight
> > needs some binding changes from what I remember. I think the
> > minimal set is something like this against v4.16-rc:
>=20
> I have an updated lm355x backlight driver almost ready, that uses
> an updated binding scheme and exposes the keyboard backlight
> using the LED subsystem.

If I could get a diff, I'd happily test it :-).

Also, if you know how to get information from light sensor, that would
be nice.

> The keyboard backlight and lcd backlight are controlled by LM3552,
> that's the driver mentioned above. The other LEDs (status rgb,
> shift/capslock, and the android button backlight) are working.

Confirmed. They work, and they have reasonable names.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq6tfQACgkQMOfwapXb+vL6ewCgkCoyVkOIjWSYVORrUWptgX0W
q1IAoIZE2F+6n5FOE7CinEtHrBUWaiGQ
=Eb0w
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
