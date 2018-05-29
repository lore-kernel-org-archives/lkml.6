Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967805AbeE2Wec (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:34:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52880 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967502AbeE2Wea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:34:30 -0400
Date: Wed, 30 May 2018 00:34:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org
Subject: Re: v4.17-rc1: regressions on N900, N950
Message-ID: <20180529223427.GA5045@amd>
References: <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
 <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
 <20180523140615.GA27180@amd>
 <20180523201208.GA31731@amd>
 <20180523220456.GY98604@atomide.com>
 <20180524094705.GA16705@amd>
 <20180529204517.GA6765@amd>
 <20180529210909.7m4cyhh524xqipju@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20180529210909.7m4cyhh524xqipju@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-05-29 23:09:09, Sebastian Reichel wrote:
> Hi Pavel,
>=20
> On Tue, May 29, 2018 at 10:45:17PM +0200, Pavel Machek wrote:
> > > > > still results in working touchscreen, removing any of the three f=
ields
> > > > > breaks it again.
> > > >=20
> > > > I bisected one regression down, see "omapdrm regression in v4.17-rc=
 series"
> > > > not sure if it covers all the issues being discussed here though.
> > >=20
> > > Reverting 24aac6011f70 fixes screen on n900 in v4.17-rc for me. (But
> > > strange dependency on tsc2005@0 is still there).
> >=20
> > Laurent, your patch looks pretty obvious, but unfortunately breaks
> > display on Nokia N900.
> >=20
> > The patch is pretty big as is, perhaps you have version split to sdi
> > =3D> *sdi and then static =3D> dynamic allocation?
>=20
> There is a queued fix:
>=20
> https://github.com/freedesktop/drm-misc/commit/2bc5ff0bdc00d81d719dad7458=
9317a260d583ed

Thanks for the pointer! I hope it makes it in time for v4.17...

                                                                        Pav=
el

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsN1XMACgkQMOfwapXb+vLe4ACghJwgHTzFCX9hdxnm9yuZAKbf
aC8AoLxD0FHwm9QxpVU9Az/eFK/fQ8PH
=1IyN
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
