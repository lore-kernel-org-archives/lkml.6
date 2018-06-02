Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeFBRzL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 13:55:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33390 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeFBRzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 13:55:09 -0400
Date: Sat, 2 Jun 2018 19:55:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Dave Airlie <airlied@gmail.com>
Subject: Re: Linux 4.17-rc7
Message-ID: <20180602175508.GC14870@amd>
References: <CA+55aFwUqz9z1Rf4Wwr29W7DeKxQ67qKEW5xty+JPyCY3aNQ=A@mail.gmail.com>
 <20180530111715.GA19410@amd>
 <CAPj87rOuoTM_EHDHkPrA_RE=2=az8jS+Xdcqgh1emBg4oEoRiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <CAPj87rOuoTM_EHDHkPrA_RE=2=az8jS+Xdcqgh1emBg4oEoRiA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On 30 May 2018 at 12:17, Pavel Machek <pavel@ucw.cz> wrote:
> >> The bulk of it is really pretty trivial one-liners, and nothing looks
> >> particularly scary. Let's see how next week looks, but if nothing real=
ly
> >> happens I suspect we can make do without an rc8.
> >>
> >> Shortlog appended as usual. Go out and test.
> >
> > Any chance to still get in this one?
> >
> > https://github.com/freedesktop/drm-misc/commit/2bc5ff0bdc00d81d719dad74=
589317a260d583ed
> >
> > ...it fixes display on Nokia N900, and display is rather important for
> > cellphone.
>=20
> The pull request was sent to Dave just yesterday:
> https://lists.freedesktop.org/archives/dri-devel/2018-May/178606.html

Still nothing in the mainline. If there's no -rc8, time is running out
:-(.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsS2fwACgkQMOfwapXb+vIVXwCfR9vDCLJo/qtAVbHkE91Qtv3t
jO4AoIKcj5HsxfAMofWHDMj0sXiywmef
=m0lk
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
