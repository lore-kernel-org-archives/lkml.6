Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbeBZNNV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:13:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47429 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbeBZNNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:13:20 -0500
Date: Mon, 26 Feb 2018 14:13:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        afd@ti.com, broonie@kernel.org, peter.ujfalusi@ti.com,
        alsa-devel@alsa-project.org
Subject: Re: regression v4.16 on Nokia N900: sound does not work
Message-ID: <20180226131318.GA14045@amd>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> JFYI: This issues is tracked in the regression reports for Linux 4.16
> (http://bit.ly/lnxregrep416 ) with this id:
>=20
> Linux-Regression-ID: lr#4b650f

Ok, so it seems that issue is bigger: whole sound subsystem does not
work. /proc/asound/cards is empty.

7e6127c1240ed569cdda2a67c8f03836f9f28c05 seems to be bad already.

I tried to revert sound/soc changes, and sound is broken, too. Nasty
:-(.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqUB+4ACgkQMOfwapXb+vIhdwCgkR+ZVhkvkCoNjdoCziV2w6FC
YYQAn2VYm6zqizP3Kg1a/eIUwWPmlYBX
=nnpw
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
