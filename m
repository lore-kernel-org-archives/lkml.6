Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbeBXIxL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 03:53:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36470 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbeBXIxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 03:53:09 -0500
Date: Sat, 24 Feb 2018 09:53:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Florian Vaussard <florian.vaussard@gmail.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] leds: Add driver for NCP5623 3-channel I2C LED
 driver
Message-ID: <20180224085307.GD12996@amd>
References: <20180221214654.3306-1-florian.vaussard@gmail.com>
 <20180221214654.3306-3-florian.vaussard@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <20180221214654.3306-3-florian.vaussard@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +module_i2c_driver(ncp5623_driver);
> +
> +MODULE_AUTHOR("Florian Vaussard <florian.vaussard@gmail.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("NCP5623 LED driver");

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqRJ/MACgkQMOfwapXb+vJhYQCfe23wantgKLJBLC8L3n+zs7XL
4XIAmwZOSlKsI6Gi51YXxM0lI6yYXOJ9
=LIiM
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
