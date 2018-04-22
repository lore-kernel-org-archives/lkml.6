Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeDVHmR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 03:42:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55038 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeDVHmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 03:42:16 -0400
Date: Sun, 22 Apr 2018 09:42:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: v4.17-rc1: regressions on N900, N950
Message-ID: <20180422074213.GA12428@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

v4.17-rc1 broke display for me on Nokia N900. (I don't know if system
boots, but I can see on red flash LED that at least that driver
succeeded. So it should not be early boot crash).

v4.17-rc1 also broke boot on N950.

Any ideas? Does it work for you?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrcPNUACgkQMOfwapXb+vItbwCgxMiazn80J5FzBe0n9SWG/fx2
MWwAoKnWTGW+TIxz70DV0PYrzrVaaXFR
=al96
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
