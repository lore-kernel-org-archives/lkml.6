Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeDTHkk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:40:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53265 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbeDTHki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:40:38 -0400
Date: Fri, 20 Apr 2018 09:40:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, afd@ti.com,
        pali.rohar@gmail.com, linux-pm@vger.kernel.org
Subject: bq27000: directory/files exists even when hardware is not available
Message-ID: <20180420074036.GA16257@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On droid4 (4.17-rc1), /sys/class/power_supply/bq27000-battery exists
even when hardware is not present (as on Droid 4).

Any ideas?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrZmXQACgkQMOfwapXb+vKifwCgw0cgRJUD8yOJ5gpCpq8g1see
1n8AnR1R3pvso3Rd21esB6VyxPe7E3SB
=Bql9
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
