Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753623AbeDRIJc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:09:32 -0400
Received: from sauhun.de ([88.99.104.3]:34690 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753567AbeDRIJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:09:29 -0400
Date: Wed, 18 Apr 2018 10:09:27 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Sam Hansen <hansens@google.com>
Cc: linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Documentation/i2c: sync docs with current state
 of i2c-tools
Message-ID: <20180418080927.l56nlorhxkdbmdyu@ninjato>
References: <20180413174257.139182-1-hansens@google.com>
 <20180413174257.139182-2-hansens@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t2ddmxiqsi6rleya"
Content-Disposition: inline
In-Reply-To: <20180413174257.139182-2-hansens@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t2ddmxiqsi6rleya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2018 at 10:42:56AM -0700, Sam Hansen wrote:
> Currently, Documentation/i2c/dev-interface describes the use of
> i2c_smbus_* helper routines as static inlined functions provided by
> linux/i2c-dev.h.  Work has been done to refactor the linux/i2c-dev.h file
> in the i2c-tools project out into its own library.  As a result, these
> docs have become stale.
>=20
> This patch corrects the discrepancy and directs the reader to the
> i2c-tools project for more information.
>=20
> Signed-off-by: Sam Hansen <hansens@google.com>

Applied to for-current, thanks!


--t2ddmxiqsi6rleya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrW/TcACgkQFA3kzBSg
KbYy8Q/9HpyHPXWjL+UKDV1WRBxzeLe93sQF0xibmhnj18Yg9N6ZEzav/vtrHZaF
OC+faYNsPTqjd7cRK1EOv+LB7ghItILACc+MlNxFh/+JgCcw/ncZFWfPw1AhzdZ6
rI7/353z81MGn+fuCGLBx8uSwRMCKLUAgc1zhZ8hOAv2qmKQdYk/omnOBEKcrBZT
SrQ5MS+rxi+ILHAsyG13ZacKRndhBQQZfboB21Bt5exbWME/ZWYURrFzx19cuXZa
iH7X63d8z5Zmb3XwGONZ0z7Fqvw4jeBm3J7v9ZO8Q6XO8CWQuqpEhVicWhoIxRQe
ol7+aaRja1lIY6lcIRy2auQAA6K4CWCEWQ94Y7YdEw27qb0W5mAIsUyGAhBaavtW
65MFcr9CqrCvYBJTLRQO6ww2AUCjfFFiyG/M8+DoXmiWRopLWxlDTynQIa6MYbcf
x4AAq4Co9+FSIvkyAhG47pgJRqoaETZMaD7X1eJAQKBkQAR1ReU47WEDDOOQO5S+
0gjTDTJjhK+00US4xBXLK6b2T3jEmbTwITpaXn8jynz+Vmz2aFuqEB8R/c/a9cvm
bYSlDmMsxYfKvHWEcRJ2aGiu52pgj55K4vyt4U+E/V5vstq8qNbdD8GDp0AHqSG6
JEqMsThWhyzOxmsaDoLuLEQYNwqqvx8SWUu0E7R99lbcIfYmyzw=
=pINU
-----END PGP SIGNATURE-----

--t2ddmxiqsi6rleya--
