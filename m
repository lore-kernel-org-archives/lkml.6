Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbeBQVTV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 16:19:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57943 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeBQVTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 16:19:19 -0500
Date: Sat, 17 Feb 2018 22:19:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Subject: setterm -blank force no longer works after switch to omapdrm
Message-ID: <20180217211927.GC9640@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I used to have use omap fb driver, and blanking worked as expected. It
no longer works with omap drm driver. (Tested on v4.16-rc1, but I
believe it is broken in older versions, too.)

Can you test it on your hw? Any ideas what could be wrong?

xset dpms force on/off works as expected.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqInF8ACgkQMOfwapXb+vL2dQCbBjh4ATmX6PNABemFiW5BYkDY
OLkAoJM1ggMNjEeommMEbzvgyCUTIw/o
=vZqS
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
