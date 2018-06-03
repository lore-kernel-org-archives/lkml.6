Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeFCJme (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 05:42:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53781 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeFCJmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 05:42:33 -0400
Date: Sun, 3 Jun 2018 11:42:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Dave Airlie <airlied@gmail.com>
Subject: Re: Linux 4.17-rc7
Message-ID: <20180603094231.GA12074@amd>
References: <CA+55aFwUqz9z1Rf4Wwr29W7DeKxQ67qKEW5xty+JPyCY3aNQ=A@mail.gmail.com>
 <20180530111715.GA19410@amd>
 <CAPj87rOuoTM_EHDHkPrA_RE=2=az8jS+Xdcqgh1emBg4oEoRiA@mail.gmail.com>
 <20180602175508.GC14870@amd>
 <CAPj87rMftLP-XOYTOoH+Niz35ipcmE3xoqUn4bmQas=_226QMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <CAPj87rMftLP-XOYTOoH+Niz35ipcmE3xoqUn4bmQas=_226QMg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-06-03 10:27:02, Daniel Stone wrote:
> Hi Pavel,
>=20
> On 2 June 2018 at 18:55, Pavel Machek <pavel@ucw.cz> wrote:
> >> On 30 May 2018 at 12:17, Pavel Machek <pavel@ucw.cz> wrote:
> >> > Any chance to still get in this one?
> >> >
> >> > https://github.com/freedesktop/drm-misc/commit/2bc5ff0bdc00d81d719da=
d74589317a260d583ed
> >> >
> >> > ...it fixes display on Nokia N900, and display is rather important f=
or
> >> > cellphone.
> >>
> >> The pull request was sent to Dave just yesterday:
> >> https://lists.freedesktop.org/archives/dri-devel/2018-May/178606.html
> >
> > Still nothing in the mainline. If there's no -rc8, time is running out
> > :-(.
>=20
> https://lists.freedesktop.org/archives/dri-devel/2018-June/179000.html

Yep, and patch is in now and seems to work. Thanks to everyone
involved!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsTuAcACgkQMOfwapXb+vIFDgCgonaGLrGJjj24F6qoOWgJtD/d
hK8AnR4VMM1ah8xoowB8jjUHB6Le7+e3
=cZXg
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
