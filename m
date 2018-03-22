Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754676AbeCVMfX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:35:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51501 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCVMfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:35:20 -0400
Date: Thu, 22 Mar 2018 13:35:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: v4.16-rc5 on Motorola Droid 4
Message-ID: <20180322123518.GA27004@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Just... I got recent mainline to work on Motorola Droid 4. (Thanks for
all the help).

Tree is at kernel.org:

kernel.org:pub/scm/linux/kernel/git/pavel/linux-n900.git all-v4.16:all-v4.16

branch all-v4.16 contains config.4 (which is config I'm using) and the
patches I used. (But I did not do anything special).

What does _not_ yet work is battery charging, and I'm not sure if the
phone will actually shut down itself or if it will drain & damage the
battery.

user@devuan:/my/unicsy_demo$ lib/hardware.py
Battery 3.67V 3.67V 3.82V 15% 49% 0% 0/0 mAh Discharging -353/-1/-1 mA
user@devuan:/my/unicsy_demo$ lib/hardware.py
Battery 3.65V 3.65V 3.88V 15% 61% 0% 0/0 mAh Discharging -534/-1/-1 mA

Usb networking works with that config, and I can boot useful system
with maemo leste.

Good luck,
    	       	     	       	       	     	 			Pavel
=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqzowYACgkQMOfwapXb+vKu+wCgnimN/qk9VJBWZKGFzc8H4raw
Jt8AniWRv5sbvIAS2JJwl8Tq7CKsccCd
=H1JN
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
