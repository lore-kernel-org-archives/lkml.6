Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbeENWNB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:13:01 -0400
Received: from sauhun.de ([88.99.104.3]:57906 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbeENWNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:13:00 -0400
Date: Tue, 15 May 2018 00:12:58 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: hix5hd2: remove some dead code
Message-ID: <20180514221258.gpp4yfdylnxnhrlb@ninjato>
References: <20180509194603.28986-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ct3bz724acewibmw"
Content-Disposition: inline
In-Reply-To: <20180509194603.28986-1-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ct3bz724acewibmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 09:46:03PM +0200, Peter Rosin wrote:
> The else branch cannot be taken as i will always equal num.
> Get rid of the whole construct.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-next, thanks!


--ct3bz724acewibmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr6CekACgkQFA3kzBSg
KbYG6g//eWyJCZu2WfKrT2nRbqkTWMHisv/nng+sEjKlIAsEEKX+zTDgKIhD3p5m
fYxsEN5ma3C83OWZ/z5KKs/OkuIEZ/vimwUOmQ06wxSApWA/Mi9DnEZbvcVfi4xD
ZNLFuBR615RhULgQjuddkzyok/yi2xkxaP4clcaIsFgCQKVRf3WIngkzuh5c3BeJ
PKww9Dj6q2T8JIxa3cAPN1Ua4L3vT7FMoBNX4IZoWXAxpXAST6Gx20r2FqdumNSV
RMyJDlQDU05d6VACeHV4WRphS6eZvxgttOQkXSt3QAKX1KSAFV4aE/flCTMIWi5f
HtKYZTikHre+91HUswy4sbBRtAHTXHhH3I+hD7rEJMwkyUcHJr9i6Y1NWNjcPQtN
mwu5mCDltvSQZIRbhRk6kZN+GuzsV/3Pc8fmAe9yqZLTvg796srJJlRznM8wJqvZ
lbdhTviHpX4fHZrhXIf+TbGD+fa0Ia2XZJcoRMbNmNNluD/W407QJfIJozRhge5h
jBmNRy+fUewm+Zg9NcluubCAFU9qY1JyP7jZkCU6iHqrEQKYOVyorKZ6BaYNMVDs
lal5MnyJV29nUGykXv4PNxhvmAgTGphgIFPLw+ytoPYNiEyCrGtXB8BPI5YcwJXf
D4xD2KH/mzTUdwUWb/ATI1FLWCZpDb/aB7R4879ZE7d8ynOCbPo=
=W/Pb
-----END PGP SIGNATURE-----

--ct3bz724acewibmw--
