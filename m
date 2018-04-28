Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933490AbeD1Mim (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 08:38:42 -0400
Received: from sauhun.de ([88.99.104.3]:57468 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759778AbeD1Mil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 08:38:41 -0400
Date: Sat, 28 Apr 2018 14:38:38 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: David Engraf <david.engraf@sysgo.com>
Cc: ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: at91: Read all available bytes at once
Message-ID: <20180428123838.abxiht7k4egv7iel@ninjato>
References: <20180426082558.GX13305@rfolt0960.corp.atmel.com>
 <20180426095314.12758-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nzns2kqhetuwit6p"
Content-Disposition: inline
In-Reply-To: <20180426095314.12758-1-david.engraf@sysgo.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nzns2kqhetuwit6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 11:53:14AM +0200, David Engraf wrote:
> With FIFO enabled it is possible to read multiple bytes
> at once in the interrupt handler as long as RXRDY is
> set. This may also reduce the number of interrupts.
>=20
> This patch polls RXRDY and reads all available bytes at
> once.
>=20
> Signed-off-by: David Engraf <david.engraf@sysgo.com>

checkpatch said twice:

WARNING: line over 80 characters

While I am not super-strict with this limit, it makes sense here IMO.
The comment stays readable, and we don't even lose a line.

Fixed it this time for you.

Applied to for-next, thanks!


--nzns2kqhetuwit6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrka00ACgkQFA3kzBSg
KbZmOg/+IhlsJDzcKMB5N2UOolGljf8oOYDLSslHRZRLb8EjJM5TzbpUA/LzV8lA
fyH29EKFbh3Z4MWKzTn4+KnLsgy7q4ZhMsuyc2jBbX1/SblkeeyXRAjnpXln+APW
Us77mNu4wU04/q6Tlzs1rg+WWhoLOPbFo8VlTywQQPbE9YtABZpxcDSAVZQcl6sI
w38GoKR6mdLZKKQA7ZoSAh9YG8jvqTa4NRHYnF5I1YTLRCsrcje9cAFyASNYd04s
pZrYaBzlOeKwlI8hPC1rxtHAm3nwHFTUhS2Oib8c1p7xFM5hjkX54sxFn/BUuwGx
R1WOw+UUcuI0IUtKiMHhsEerKuAI7ZM6xkNy9hYtjR675bYNz6a4BK1gxwKEo0Sf
jACqmKtBtf5mFbc8F2pQRWhbSHcJInnbmTbfnjJyALFZdFG3jLXdVBUqUc9vSLNK
GY1rR4HDlJyCSbiwnSU6hN3uBFarMLvOdorwlS6DfUk0dgvhAzE9XFg/YOQi3SxY
n1CNWgPIYXHvf50pL7QwGzPIfCcT+X2+F20KKcvvR4x8CSYS3nNrkSNSz5i79+ea
rBaXe1Nqu+v8VO4fkqo4AlTKFYpdeimVEnVKMeEUuPb9l0IUjOMLlqW69fYmmODN
xVWEx0TARtm2Kpo+CbdUjWXdKuOJKx4RT2QfNRFW/cHqDWr74VY=
=pn8i
-----END PGP SIGNATURE-----

--nzns2kqhetuwit6p--
