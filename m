Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbeC3VRd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:17:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54740 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753167AbeC3VRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:17:31 -0400
Date: Fri, 30 Mar 2018 23:17:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net
Subject: Re: 4.16-rc5 on Motorola Droid 4
Message-ID: <20180330211729.GA3389@amd>
References: <20180318220418.GA22880@amd>
 <20180320140322.GU5799@atomide.com>
 <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
 <20180327212156.GA10834@amd>
 <20180330121959.uxx6kcl7v5w777vq@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20180330121959.uxx6kcl7v5w777vq@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-30 14:19:59, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, Mar 27, 2018 at 11:21:56PM +0200, Pavel Machek wrote:
> > Also, if you know how to get information from light sensor, that would
> > be nice.
>=20
> You need CONFIG_SENSORS_ISL29028. Once the driver is probed:
>=20
> $ cat /sys/bus/iio/devices/iio\:device1/name
> isl29030
> $ cat /sys/bus/iio/devices/iio\:device1/in_illuminance_input
> 19

Thanks, that works.

I was also able to get accelerometers to work, but they are extremely
slow to read (6 seconds for all 3 axis). Interesting, but probably not
too important for now.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq+qWkACgkQMOfwapXb+vJcagCeOC0Ob0OW88gG5JzFRVNTmU+8
zQYAnAxfDt8CcEvGRtUtEyd0NcZcBTr2
=7JY8
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
