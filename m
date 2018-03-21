Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753316AbeCUTct (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:32:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58942 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752974AbeCUTc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:32:29 -0400
Date: Wed, 21 Mar 2018 20:32:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net
Subject: Re: 4.16-rc5 on Motorola Droid 4
Message-ID: <20180321193225.GA20561@amd>
References: <20180318220418.GA22880@amd>
 <20180320140322.GU5799@atomide.com>
 <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Maybe get somebody to help you locally with the debug cable
> > soldering? :)
>=20
> I suppose people from your hackerspace can help you. It's really
> easy to do. Soldering can be avoided btw. You can just use a pair
> of scissors to cut a USB -> Micro USB cable and use a knife to remove
> isolation. Then screw each of the 4 wires into a terminal strip.
> There are USB-TTL adapters available, that have an attached cable.
> If you also cut the connector from such a cable and connect it to
> the other side of the terminal strip you are done. No soldering
> involved ;)

Hehe. After some more experiments, it looks like hardware hacking can
not be avoided :-(.

I should have enough connectors, but I don't know the pinouts. I also
seem to have D-SUN USB to TTL from you (thanks again!).

You say TTL, Tony says 3V3... so I guess the port can survive both?

Ok, I guess I really only need to connect GND, and then D- to RXD?

So... where is the D-.. aha, got it. I hope USB has to be robust
enough against me making experiments?

I connected it the best way I could, but I do not get data in minicom,
and RXD led stays lit. I guess that is not a good thing :-(.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqys0kACgkQMOfwapXb+vIbjwCgup8PiEEfkJqaWogVhqzrXDG8
aJ0An0AgTYkzmez/uIroKAKUsBkBcQ51
=Z4FU
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
