Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeEEVjy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 17:39:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37672 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeEEVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 17:39:53 -0400
Date: Sat, 5 May 2018 23:39:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Handling lm3559 flash on Motorola Droid 4 and others
Message-ID: <20180505213951.GA4530@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It seems lm3559 flash driver is available on github (
https://github.com/ZenfoneArea/android_kernel_asus_zenfone5/tree/master/lin=
ux/modules/camera/drivers/media/i2c
) but there'll be some fun getting it cleaned up and merged.

Did anyone start doing anything in that area? Is there possibly better
source to start from?

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlruJKcACgkQMOfwapXb+vJHGgCfSGTxLUmID5z2ko06fXG4QSpl
SpsAn3NiFfkzFvb+YML5pxM7E8I1vhvk
=+9Jx
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
