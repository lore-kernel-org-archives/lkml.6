Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeCUUbn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:31:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60878 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753087AbeCUUbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:31:39 -0400
Date: Wed, 21 Mar 2018 21:31:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net
Subject: Re: 4.16-rc5 on Motorola Droid 4
Message-ID: <20180321203137.GA23637@amd>
References: <20180318220418.GA22880@amd>
 <20180320140322.GU5799@atomide.com>
 <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
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

Hm. How big no-no is connecting USB-TTL adapter to D+/D- pins? Because
that's what I could do "easily" and seems to work ;-).

								Pavel
							=09

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqywSkACgkQMOfwapXb+vIpVgCfZPvfOkG+K38fIky6WCLZeUJE
/F8AoJY42jl/mj9Vaal2iOvU2FdlhTt0
=PGR+
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
