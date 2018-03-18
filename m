Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754569AbeCRUPW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:15:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38026 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754264AbeCRUPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:15:17 -0400
Date: Sun, 18 Mar 2018 21:15:03 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 2/9] pinctrl: sunxi: introduce IRQ bank conversion
 function
Message-ID: <20180318201503.g3ksrwcxzjurll3m@flea>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180316140215.28663-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pcmdpne3ti4c4xtj"
Content-Disposition: inline
In-Reply-To: <20180316140215.28663-3-icenowy@aosc.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pcmdpne3ti4c4xtj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2018 at 10:02:08PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC have its pin controllers with the first IRQ-capable
> GPIO bank at IRQ bank 1 and the second bank at IRQ bank 5. Some
> refactors in the sunxi pinctrl framework are needed.
>=20
> This commit introduces a IRQ bank conversion function, which replaces
> the "(bank_base + bank)" code in IRQ register access.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--pcmdpne3ti4c4xtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlquyMYACgkQ0rTAlCFN
r3TSDw//VmvyAb+NmW2CFFLCwcnIfzjIthgNXsT9LVtnDQQiWBXyZ/LblXOCS8AM
5x/O2KCVP+mkjjAhYPaCmaCLW30MMEBEE+vyeVX0FFpUgIghPbiC0WD1K5RSTrX8
Qqwv63v/I+8KdssjVLn56nGxC6JBBEeY9nqwt5yfCheun1yp1J1viKr+9Oxik6cG
G7BQXaMVG9Ytw9zMQNZgP+qNZK1OoZaDuZlAnUasJX0YfWwPpeomFg3w9ab4i89Y
sidN/6ErwUI8zFuztC13RxIbMhqWRWibyqCXumDp/jZ/fs+s2q3hqCXWhmjC1wrZ
hbj20BGkg7gx9CHTRGSHP1D7hCOExCWCPc8ciDZHQsyXGhkJXm/oOdIrtaLO1J2w
jxIJ/iUlZqGTS7AO+jGpMalhvK2x9fcVhUQEqy+NNoaN+3jcjc68AbeIVSEGVR1P
At34knsS0y8vThWJlsZrvX480wKg5qPm3EnP28MjdLKw20xse/+4Y+L2h+yUKV4w
5lM1yeDQUXojCS4NanDvYxZJmS3ureEEkWjE0BuwzY6bLqg5/bELsumAEsbbS8DX
FehZNEh9WiBYtMVmZY08SD9zuDnCQrhbsudxhpcOkMkNRHMoroF7uzH9wR0Wj+1n
Pe1KM1W64ohr0tAHQUhMrpZdYk24upgT9hTW6tWKPT7CA2HUOq8=
=NJrC
-----END PGP SIGNATURE-----

--pcmdpne3ti4c4xtj--
