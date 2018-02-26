Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeBZT40 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:56:26 -0500
Received: from sauhun.de ([88.99.104.3]:38291 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751446AbeBZT4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:56:25 -0500
Date: Mon, 26 Feb 2018 20:56:23 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>,
        =?utf-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@pr.hu>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: piix4: Use usleep_range()
Message-ID: <20180226195623.wivl3h6eyl3s7n3a@ninjato>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
 <1514652658-6228-2-git-send-email-linux@roeck-us.net>
 <20180212115336.4b828ab8@endymion>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wzhdeftkab4zgqpa"
Content-Disposition: inline
In-Reply-To: <20180212115336.4b828ab8@endymion>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wzhdeftkab4zgqpa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >  	/* If the SMBus is still busy, we give up */
> >  	if (timeout =3D=3D MAX_TIMEOUT) {
>=20
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

Does this still hold given despite the discussion in this thread?


--wzhdeftkab4zgqpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqUZmcACgkQFA3kzBSg
KbYsexAAkOqUByGSk66nZtntXHYBA9hkIVOI9ZbDu48AMOcehWu0qt9kV6+e4Cv8
x4RsX0Ur5VPvK/we3j278nThJbp2uOUDC2Xm3xpCyKeMMMvUXJcHhIGhYbHEhlP6
uPzjzq8sjWYuw3a+ic4V2tO2+MOug78oOxxqd+36R82wS4QpVLasFe5YWhwT1v5U
ecyp0+VetSLOelnsVN51DIOBUVj/5osGfGJ5ugq6j3PXdkkW8nIv0KUmRrB0Zd8O
pH2AIOgpFLWo8wjGsZRcibYafa5aC9aBDf06PVcbGx6X/2Y7NvnqN5vYp+j3jTcy
xy0tKQlElk1uvoyTEoqZOwC07e1dgcN6waJieZct5kqR97/ejW/SRdb+bBXVR55D
PQ9HUlliU9KNkaS9mFw5azFF9nX1w4IkPfaqV6/n5cpNv2/ajkyYnAzU/T+8LE8V
PH5GvN2po98eM87NldAGIGFtlasZwarSlTKxJcMoS6kMjgrFVGPhNldU1p2lj0i4
m7Ci5ghQwSlM8+tqeHPL3VMZSQUvaIqP+H5+fHQr9C1xdg8YC0UjNNexro1uA0N8
MtLfdkMobcc/kFnz/yNN9svSu9416nTyPhD7oRQMAfjlmbMoGxH05Y/hqIpNtMjQ
O5y6GhrcD5KxhNGEHQvAb5ulLXTRwiKWLk0xl6u3tGBktgwNF5k=
=Q+cZ
-----END PGP SIGNATURE-----

--wzhdeftkab4zgqpa--
