Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754117AbeD2SlF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 14:41:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57507 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeD2SlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 14:41:03 -0400
Date: Sun, 29 Apr 2018 20:41:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429184101.GA31156@amd>
References: <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org>
 <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20180429170541.lrzwyihrd6d75rql@sultan-box>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-04-29 10:05:41, Sultan Alsawaf wrote:
> On Sun, Apr 29, 2018 at 04:32:05PM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > > This is why ultimately, we do need to attack this problem from both
> > > ends, which means teaching userspace programs to only request
> > > cryptographic-grade randomness when it is really needed --- and most
> > > of the time, if the user has not logged in yet, you probably don't
> > > need cryptographic-grade randomness....
> >=20
> > IOW moving them from /dev/random to /dev/urandom?
>=20
> /dev/urandom isn't cryptographically secure, so that's not an
> option.

Umm. No. https://www.youtube.com/watch?v=3DxneBjc8z0DE


									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrmEb0ACgkQMOfwapXb+vLkWQCfS0wFgTqg6KPGmiyCcxeBFMSG
L3MAn22qTpZuJovB++ZHytET5q05yZm9
=mTu6
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
