Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeFAVqh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 17:46:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59963 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeFAVqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 17:46:34 -0400
Date: Fri, 1 Jun 2018 23:46:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "H. Nikolaus Schaller" <hns@computer.org>
Cc: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] gnss: add new GNSS subsystem
Message-ID: <20180601214632.GA3234@amd>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180601093311.GA31639@amd>
 <20180601094959.GA13775@localhost>
 <20180601102612.GC31639@amd>
 <20180601122217.GB13775@localhost>
 <20180601162645.GA30792@amd>
 <3A356534-FEB0-4E0D-A8C8-922EEF1E0926@computer.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <3A356534-FEB0-4E0D-A8C8-922EEF1E0926@computer.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-06-01 18:37:36, H. Nikolaus Schaller wrote:
> Hi Pavel,
>=20
> > Am 01.06.2018 um 18:26 schrieb Pavel Machek <pavel@ucw.cz>:
> >=20
> > NMEA would not be my first choice, really. I'd propose something very
> > similar to existing /dev/input/eventX, but with wider data types.
>=20
> Since even Rome wasn't built in a day, my first choice is NMEA, but I am
> open to anything on higher level to come second.
>=20
> What about iio?
>=20
> It is quite flexible and extensible and GNSS coordinates are a not very
> different from accelerometer, gyroscope or compass data as all of them
> describe the position and orientation, maybe speed of the device these
> things are built into (at least for mobile devices).

As I said, I do not want to have that discussion at the
moment. Transfering position and orientation is easy, transfering some
other data (such as sattelites used for fix) might be
trickier. Anyway, I'm pretty sure reasonable solution exists; and yes
we could use NMEA.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsRvrgACgkQMOfwapXb+vJt5QCdF1wx3Dera+wjZN9XGjeFlsnk
ke0AoIGxXyASL/AEpjOMrOLt+ehaO+ew
=YiiC
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
