Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967257AbeEXUIA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:08:00 -0400
Received: from sauhun.de ([88.99.104.3]:48520 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935330AbeEXUH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:07:58 -0400
Date: Thu, 24 May 2018 22:07:56 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: ibm_iic: don't check number of messages in the
 driver
Message-ID: <20180524200756.ccklgg7gdsg4dcja@ninjato>
References: <20180520065035.7920-1-wsa@the-dreams.de>
 <20180520065035.7920-2-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fqui7yr3ktpr24px"
Content-Disposition: inline
In-Reply-To: <20180520065035.7920-2-wsa@the-dreams.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fqui7yr3ktpr24px
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 20, 2018 at 08:50:33AM +0200, Wolfram Sang wrote:
> Since commit 1eace8344c02 ("i2c: add param sanity check to
> i2c_transfer()"), the I2C core does this check now. We can remove it
> from drivers.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--fqui7yr3ktpr24px
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsHG5wACgkQFA3kzBSg
KbYbYA/9G4Nfj9s/9hs6xfqpjD0zs9b7TwK4zQZ8yerT6riYxboTUhoBE4JUjaCT
bICg6nm2qRQKrNWPPXuXeCdom1O/hLvaCSBA4Y/cCsYBBGiRuRXdPAfxovD6bEDu
IWTQkGAgy2DfyKxGwoqj/5aK21HCijcD/Y+ccbkjcYZCAKqxClRWCT72xlgK2ZJf
AA122+7WLqxT1WCOilIdeKp98CSOaMvt8hirRBJKdW9JmWe4wPAMYvCYDAHFISoy
+VUPemp0Hbna/BnW7I0cwQb5thFV+SU6NQ6VwlT0/gMiS2sBDl4SURYRD494jr24
tg00oWir7Y8VE8S/Piv2BQfwvzLUpuMi1qvpkbW6yoQDmG+dZu/JEiWX71Jwc5fb
zwiln9TRM35hd7VyLqyS7oIKK9qRaCE0d0C0pKVtpUbTaC4O+hakgiNIz42s1N9d
5q5KvctMzmaS6KXOu3ijgdT0a4kYseux1ia9Q4zmmpXj6KIL/AVvHyI++4OAUpQ+
HSCNZsaxYKz/v1h2bO5B7gGMahYty37NBWpTxNjaBbBMU0dtEl6udHAlYJoeO9gn
8KD8h+E9RhSDYOJWdMeKsxvssX8xPAC5NCLM7DNO1pNx1hhzihxx8ovRRdvEZj/c
fI/tonU6ohMj8wQKmhGIaEdpXiD106NX1fQHbIhnAZ09iqnBePA=
=QA7v
-----END PGP SIGNATURE-----

--fqui7yr3ktpr24px--
