Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbeDXLGW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:06:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42980 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbeDXLGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:06:19 -0400
Date: Tue, 24 Apr 2018 13:06:17 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: wens@csie.org, clabbe@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: sun8i-h3-libretech-all-h3-cc: Move board
 definition to common dtsi
Message-ID: <20180424110617.pu3ibceramahodgn@flea>
References: <1524561576-2201-1-git-send-email-narmstrong@baylibre.com>
 <1524561576-2201-2-git-send-email-narmstrong@baylibre.com>
 <20180424095656.oormsyru7nw6hypn@flea>
 <20d4b1f5-b300-37e2-8dca-e80f691440a9@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3mhtwsqrz3j7t4ci"
Content-Disposition: inline
In-Reply-To: <20d4b1f5-b300-37e2-8dca-e80f691440a9@baylibre.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3mhtwsqrz3j7t4ci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 12:03:44PM +0200, Neil Armstrong wrote:
> On 24/04/2018 11:56, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Tue, Apr 24, 2018 at 11:19:35AM +0200, Neil Armstrong wrote:
> >> Since the libretech-all-h3-cc can use either the H2+, H3 or H5, move t=
he
> >> content of the dts file to a common dtsi file to be included by the H3=
 variant
> >> and in a following patch the H5 variant.
> >>
> >> By the way, update the SPDX licence tag position.
> >>
> >> Suggested-by: Corentin Labbe <clabbe@baylibre.com>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >=20
> > This patch looks fine, but doesn't apply anymore. Please resend it.
>=20
> I based it on 4.17-rc2, should I rebase in your tree ?

Yep, thanks!
Maxime


--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--3mhtwsqrz3j7t4ci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrfD6gACgkQ0rTAlCFN
r3SLBw//bBXtl91eHjYY2a9St+EZ9f7kg9RqMHDwhPsdtKKjQ8Smv9ESYLPHE1R0
a0UKbkRHIoNjLDUetuyC2PgRd+JDLQoS83iOylG802Yehc1FuXIMaw0GUFjKTwds
nt+vn9BXbfNTdk50fyPQMsooyCWL9l53UaCphBm1sveKV8BsHKeefq8/AxFfIAR3
b9E+pZWG8WzJHfs4br4N+e4J4UCECBhIRr8yN1Xbe1Pow+F20euBsPrvmOiA7rcQ
JHCkrPCnUUnJ8vE8AGHTxrcZiFZzU2rki8UaZRAD+ws6BC1PG/8GgmFLdoIe/gzR
levV9yquxsRiLDub2bc+Xzd/gl9XDJShgBeyyY8pavnCDmR/xOwR2XwjTsSxFcoU
kFqM5ZDxD0NbmADkfPGqJV6DDxnlXqPYnpEZmzaNzqxCg6W6NK06o5kdVM9e3ykO
KhsY7tiy0kq/SE6oTsDCeskwQonSX7M1cpcLy4+O/3O7mDfh71ouiHjfe/Ji/QED
v5UqHGHazt0afxAg7YnL//HtY327bChRSA5othkMvF3DakEG4Whbq68E5HrfaSgv
8JSoP9ke+YPeT4A/8FtirXVI9JYaYGm1MKVZmeVIJtKc4VFQFLS2ImX/G60NFaS6
f/+2eMfJzwUnsA08z+douT87B8/e7hhA2WZTVzBf17KvEJBqK/s=
=137v
-----END PGP SIGNATURE-----

--3mhtwsqrz3j7t4ci--
