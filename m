Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754399AbeEUVkX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:40:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42871 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754318AbeEUVj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:39:56 -0400
Date: Mon, 21 May 2018 23:39:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com,
        abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: v4.17-rc1: regressions on N900, N950
Message-ID: <20180521213952.GA11596@amd>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI!

> On Sun, Apr 22, 2018 at 09:42:13AM +0200, Pavel Machek wrote:
> > v4.17-rc1 broke display for me on Nokia N900. (I don't know if system
> > boots, but I can see on red flash LED that at least that driver
> > succeeded. So it should not be early boot crash).
> >=20
> > v4.17-rc1 also broke boot on N950.
> >=20
> > Any ideas? Does it work for you?
>=20
> Below config works for me on N900 and N950. (On N950, I need to disable to
> display DTS entry as discussed in other threads.)

Thanks... On N900 it works for me in v4.16, but display stays blank in
v4.17-rc1...

And I'm starting to suspect I have somehow special N900, or maybe
special gcc version... Whether display on N900 works or not seems to
depend on completely unrelated config options :-(. Maybe it is timing
during boot or something.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsDPKgACgkQMOfwapXb+vKRdgCgw/d5kwoj1Y0AWn9WFqGhnOz/
3I8AmwTI02rWx45oZcEbv1PHdh7HqfB+
=jt29
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
