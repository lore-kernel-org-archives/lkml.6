Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeB0HMs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 02:12:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43830 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752314AbeB0HMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 02:12:43 -0500
Date: Tue, 27 Feb 2018 08:12:11 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: linux@armlinux.org.uk, wens@csie.org, davem@davemloft.net,
        arnd@arndb.de, mchehab@kernel.org, clabbe.montjoie@gmail.com,
        rask@formelder.dk, krzk@kernel.org, sean@mess.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [RFC PATCH] ARM: configs: sunxi: Set ondemand govenor as default
Message-ID: <20180227071211.4c5okbwcp5qjx4ok@flea>
References: <20180217142235.28541-1-embed3d@gmail.com>
 <20180219081050.vvfhnbw4foved2fb@flea.lan>
 <15992664-76be-2584-0f8d-424eadc23925@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2xqif3dc46ew3mkr"
Content-Disposition: inline
In-Reply-To: <15992664-76be-2584-0f8d-424eadc23925@gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2xqif3dc46ew3mkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 10:29:29PM +0100, Philipp Rossak wrote:
>=20
>=20
> On 19.02.2018 09:10, Maxime Ripard wrote:
> > On Sat, Feb 17, 2018 at 03:22:35PM +0100, Philipp Rossak wrote:
> > > Right now the performance govenor is the default frequency govenor on
> > > sunxi devices. This causes some general problems.
> > > When the cpu is idle the cpu runs with its maximum frequency.
> > > This causes a higher cpu temperature in the idle state. When the cpu =
is
> > > now under load the cpu gets with that higher idle temperature now fas=
ter
> > > to its thermal limits.
> > > An other big problem of the performace govenor is the missing
> > > thermal throttling. Some tests with cpuburn resulted in a system crash
> > > when the soc reached its thermal limits since no thermal throttling
> > > occurred.
> >=20
> > This won't change anything with cpuburn. While cpuburn will be
> > running, ondemand will increase the frequency of the cores to the
> > maximum frequency, putting yourself in the exact same situation.
>
> I see here a totally different behavior on the hardware (Bananapi M2, A31=
s).
> First ondemand increases the cpu frequency, when the maximum temperature =
is
> reached, then it throttles down the cpu step by step to its minimum.

This is the thermal throttling, not the cpufreq governor.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--2xqif3dc46ew3mkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqVBMoACgkQ0rTAlCFN
r3S6ig//Yu36CVGyfUqGk2hGDK218HKJIjUxE1fCX4CyZuYfcK5CEH88sEd+70oM
mIr/JSAi5mWymOUO8CrIE5/0ajQDbjo2x/lVsZdG6GuU/MpJUK8zc5wFuGKhg9wd
YZsx6foZAGRvz47fhHb4YCdQLy+qtfqlOaKL8saHI8qzwff1iiFwhX+T1ZKBD3F2
QlN7gKESCzo+N94uOIzC8mFNWtXRtmJ2vaPd5yOCDFbHl+jZs70L0n46I1/OhAl6
Th5ks5kL+G+8Zn3PYfhC2VVZzgG2nIP9FWSsz5x4npGLd3UWMekOITOrj7aQHScy
8dvlc5MqPNThZDp3YN9UUO1Ju22csKgmiw9fF8A4smGokNTYLlfdexsVf/FhZYe0
zxrszPhEdckmcj+UBvy8eh9QVVBZGrvhdrJS8o+nniS6CWdC0OkoP8DKebpFF/Se
JIQ0/98lwFWhHuTxCY4d5kH01RhJlr8CZL7nk7xzt4vUCXjhSWDoe94LJIdz49eJ
eBMR9pkHgV4DgqI7oe1CblmPBJXvRITMeCDsnBPlARm03nOASbzkBDC7kH2bM+90
fHDn/qy5kL0bRGn/+WjCuLJ/zwIi9XsQEbE1WowOJh4JjBcO8mSBXM7lhVOmhLw5
3TCpdwMZSI4HYsEX2AIzcTYpbbwXmmknXsi+o+NgANDZyg57pQI=
=gRQ4
-----END PGP SIGNATURE-----

--2xqif3dc46ew3mkr--
