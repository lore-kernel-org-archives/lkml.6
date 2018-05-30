Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeE3LS1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:18:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44571 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbeE3LRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:17:17 -0400
Date: Wed, 30 May 2018 13:17:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sre@kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com
Subject: Re: Linux 4.17-rc7
Message-ID: <20180530111715.GA19410@amd>
References: <CA+55aFwUqz9z1Rf4Wwr29W7DeKxQ67qKEW5xty+JPyCY3aNQ=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <CA+55aFwUqz9z1Rf4Wwr29W7DeKxQ67qKEW5xty+JPyCY3aNQ=A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> So this week wasn't as calm as the previous weeks have been, but despite
> that I suspect this is the last rc.
>=20
> This week we had the whole "spectre v4" thing, and yes, the fallout from
> that shows up as part of the patch and commit log. But it's not actually
> dominant: the patch is pretty evenly one third arch updates, one third
> networking updates, and one third "rest".
>=20
> The arch updates are largely - although not exclusively - spectre v4.
>=20
> The networking stuff is mostly network drivers, but there's some core
> networking too.
>=20
> And "the rest" is just that - misc drivers (rdma, gpu, other),
> documentation, some vfs, vm, bpf, tooling..
>=20
> The bulk of it is really pretty trivial one-liners, and nothing looks
> particularly scary. Let's see how next week looks, but if nothing really
> happens I suspect we can make do without an rc8.
>=20
> Shortlog appended as usual. Go out and test.

Any chance to still get in this one?

https://github.com/freedesktop/drm-misc/commit/2bc5ff0bdc00d81d719dad745893=
17a260d583ed

=2E..it fixes display on Nokia N900, and display is rather important for
cellphone.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsOiDsACgkQMOfwapXb+vJrswCfWIkHcnJGTflOT0PvwuLQu1oT
QMMAmgKjij6nhXm5/51fcbx7UVH1tNXC
=WFFj
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
