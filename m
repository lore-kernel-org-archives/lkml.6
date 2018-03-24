Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbeCXXZY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 19:25:24 -0400
Received: from sauhun.de ([88.99.104.3]:44922 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752174AbeCXXZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 19:25:23 -0400
Date: Sun, 25 Mar 2018 00:25:21 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jassisinghbrar@gmail.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v5 2/2] i2c: add support for Socionext SynQuacer I2C
 controller
Message-ID: <20180324232521.ofzk3fikda42ywep@ninjato>
References: <20180302083123.7259-1-ard.biesheuvel@linaro.org>
 <20180302083123.7259-3-ard.biesheuvel@linaro.org>
 <20180324231910.unzvwty3xia4mqu2@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wyihmnao436dfmvi"
Content-Disposition: inline
In-Reply-To: <20180324231910.unzvwty3xia4mqu2@ninjato>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wyihmnao436dfmvi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

My code checkers mention this:

    CPPCHECK
drivers/i2c/busses/i2c-synquacer.c:422: style: Checking if unsigned variabl=
e 'timeout' is less than zero.


  CC      drivers/i2c/busses/i2c-synquacer.o
drivers/i2c/busses/i2c-synquacer.c: In function =E2=80=98synquacer_i2c_prob=
e=E2=80=99:
drivers/i2c/busses/i2c-synquacer.c:678:15: warning: comparison of unsigned =
expression < 0 is always false [-Wtype-limits]
  if (i2c->irq < 0) {
               ^

--wyihmnao436dfmvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq23mEACgkQFA3kzBSg
KbaCSA/+O7XpntYVfmQJehXglIPajwoNqQSgW2U5sGGrtAbwqBhUa71E+bA1IcOH
usumkWUvH9c6Vf1s9oaWlF0B5LrIKmqfBA369rOTIGOXtMOHZQvaOPdUlS7czhR0
dvrI206HhJIL8rmmpgUUz4kAuCGMxdZUzH1MrsqkjM6md3xjLPeedCxG0WHCXu9K
WqXKxwJGUM/rkJGQfqedvQA7lXIZrWyEPh3DmSijJed2sSWzGuRcJnSswcH6ZNR3
q8NHIotOkU6GeB5/8W5F412w5vYYhhBGPAPpI4AJywhWho2+ZRZI8F2D83JjiQMs
tb/9ps8Jp3aP4qXxeUk4uyIVF4crkbqJJrODcHiZbYi1H/k8a1YP2sBjM3ax57xK
0a6YuRISLvlo1YtmVnubLDDxzyihidq8IvllaP7iWGgXiCHHfM+Gu1/roqgsRBnS
N+VJFY9TJlwUtX7/XSKdHu/gaLUys95kz0QN1WxWULHhdSxv9NvDCAUhqhDQtKLF
oSeZgwwUBJXt2sNJH/7xgLBmKGCkWJWScdn3PJSS8nDYTadW09HX1HjzwJ5d+TWk
RSYOSxEq5PFb6FH+JywJjr20Bh0nGlkeXb9xFycKykLsz0jL4+S7QD43N8whu8U0
Hk/p1YdEjwcRzr/lasUWZqMv8ZPYgokkKPnFMTP7ntL46tyYmqU=
=mnKS
-----END PGP SIGNATURE-----

--wyihmnao436dfmvi--
