Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeDQHiP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:38:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36890 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeDQHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:38:13 -0400
Date: Tue, 17 Apr 2018 09:38:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: mutt@amd.karlin.mff.cuni.cz,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        nick@shmanahar.org, dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org
Subject: atmel_mxt_ts on droid4: powersave seems to break the driver
Message-ID: <20180417073811.GA9450@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI!

v4.17-rc1 on motorola droid 4.

If I disable/reenable touschreen with xinput, it fails, with this in
the logs:

[ 1633.749450] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[ 1655.938751] atmel_mxt_ts 1-004a: __mxt_read_reg: i2c transfer
failed (-121)
[ 1655.945800] atmel_mxt_ts 1-004a: Failed to read T44 and T5 (-121)
[ 1663.829498] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host

Unfortunately, xscreensaver seems to break it in a similar way.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrVpGMACgkQMOfwapXb+vLhzwCgnnaXi77vp+AXvDtspVtoqAoc
1igAoJsCXQGyDClCDFDJ6+oqyOf3cSZ5
=zQue
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
