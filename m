Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeFBVfS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 17:35:18 -0400
Received: from www.zeus03.de ([194.117.254.33]:48762 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbeFBVfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 17:35:16 -0400
X-UD-Smtp-Session: l3s3148p1@65zQea9tpqwgAwDPW+NQAAId4P/+oMhl
Date: Sat, 2 Jun 2018 23:35:13 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Juergen Fitschen <me@jue.yt>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2,3/3] i2c: at91: added slave mode support
Message-ID: <20180602213513.qv45gaq2kogagju3@katana>
References: <c9b749fca8e684aa47ead9a5d9e68751326f63cb.1510247114.git.me@jue.yt>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="63zfksmmzk62fyot"
Content-Disposition: inline
In-Reply-To: <c9b749fca8e684aa47ead9a5d9e68751326f63cb.1510247114.git.me@jue.yt>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--63zfksmmzk62fyot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2017 at 06:22:29PM +0100, Juergen Fitschen wrote:
> Slave mode driver is based on the concept of i2c-designware driver.
>=20
> Signed-off-by: Juergen Fitschen <me@jue.yt>

I lost the original mail where Ludovic said:

"I tested it quickly on a sama5d2 xplained board: I used an i2c-gpio
master and the eeprom driver. It works pretty well. I tried to increase
the size of the eeprom by adding:
+ { "slave-24c64", 65536 / 8 },"

That won't work. The comment at the beginning of the file says:

 * ... It is prepared to simulate bigger EEPROMs with an internal 16 bit
 * pointer, yet implementation is deferred until the need actually arises.

So,  no EEPROMs > 256 byte for now.

BTW maybe I asked already and forgot: is this IP core capable of being
master and slave on the same bus?


--63zfksmmzk62fyot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsTDYcACgkQFA3kzBSg
KbaTyxAAnRbYK+fUJpqqsPELVgFhv+jt6NY/e+YeWCiZza5s1mfYxeSBtCdzctIt
PRN1KaMNbo8FvtNQ0q8JgBSVaE8YTr1iEWPiAkxtw85KblbuNXTp+1emfaubF4wd
GHOTeIwm0WrpsHVv/OVl5SEnks3HMnijUwVv6hnEHypNOXqm/UzNsEfnXuzoIblx
R96mnmfJjRjFOUNY3Jb60A9YrKRKWDmwKUlCmET4Yeu4fRVXsamEkS/j6+aCXwAU
TAWit/2MZXZZVXndMtGapki0V8mbY86qMzk/v+mVu8Kq9KMKL2ika2pipOKpGNbT
48gCSYRiwIkfqvFEPdoxVZU8fRb9wehF+SEVVi8eoMrxh7bhq3uANvhBx0W4HGTn
VsDvgpetWZYtm5GYtsK2e726e7L9SgZOEo53ogtuuSttD/rjWwivn3jdDUbLYCnG
wAePQ4FM6uHnDOMFqrBbdOoK3qLdvzS1hCfS8NiypK9kXweHdZMFB0TtZUZIi57G
KJfubOHdrYVEwZd9RhPNzuPBULIsSvQaog82omBzljXa0c1p3RidS6BQxC5SdUPF
9Nk63WtSuR37DMAmZOc6ewnsWfZ/lSwsN34kiVnpC4ByAfum60sisNU4broqgqIi
DysspsJtZHXYAIjgHX9AAZD4/ZfGGT/ZdIoXMAOv3b9QcXZrAxI=
=Pud/
-----END PGP SIGNATURE-----

--63zfksmmzk62fyot--
