Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeDVKQ6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 06:16:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58907 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeDVKQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 06:16:55 -0400
Date: Sun, 22 Apr 2018 12:16:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ferry Toth <ftoth@telfort.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DOS by unprivileged user
Message-ID: <20180422101654.GA26243@amd>
References: <9023506.UBh6vynRGa@delfion>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <9023506.UBh6vynRGa@delfion>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-04-19 21:13:35, Ferry Toth wrote:
> It appears any ordinary user can easily create a DOS on linux.
>=20
> One sure way to reproduce this is to open gitk on the linux kernel repo=
=20
> (SIC) on a machine with 8GB RAM 16 GB swap on a HDD with btrfs and quad c=
ore=20
> + hyperthreading. But I will be easy enough to get the same effect with m=
ore=20
> RAM, other fs etc.

You may want to disable swap.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrcYRYACgkQMOfwapXb+vKvCQCgrIY4oOaVe/XaxV5FCpC/YXrQ
gqAAnitD+zjsSI4yOHEunLo9kK/1Wqgm
=o7QQ
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
