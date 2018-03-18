Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754736AbeCRWEY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:04:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36217 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754354AbeCRWEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:04:20 -0400
Date: Sun, 18 Mar 2018 23:04:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net
Subject: 4.16-rc5 on Motorola Droid 4
Message-ID: <20180318220418.GA22880@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have the phone, I have safestrap installed, kexec seems to work
(crashes my system). But I can't get any output from the new kernel.

All the howtos assume serial connection, but I don't yet have
that. I'm really bad at soldering. IIRC display should work in the
latest kernels, maybe with some patches?

Could someone give me .config and git hash that works for him? Once I
get working display I should be able to continue easily. I'd really
like to get voice calls working...

I took a brief look through dts, and I did not find anything that
could be easily used for debugging. (It seems that capslock LED and
keyboard backlight is not yet supported? Also volume down  seems to be
supported but not volume up, funny).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqu4mIACgkQMOfwapXb+vJ6UQCeISS+Gu2M4fPORKYEVg9c1Uci
gLwAmQGV6dJXHKA+tmri4Irwr6lUxNa1
=iPZk
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
