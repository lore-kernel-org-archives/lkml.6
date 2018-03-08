Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755465AbeCHPI5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:08:57 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52576 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754302AbeCHPI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:08:56 -0500
Date: Thu, 8 Mar 2018 16:08:53 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mylene Josserand <mylene.josserand@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: sunxi: mc-smp: Fix "lookback" typo
Message-ID: <20180308150853.masskeocuyl5mhp2@flea.lan>
References: <20180308150012.19045-1-wens@csie.org>
 <20180308150012.19045-2-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ilifn4hdkjc76jvu"
Content-Disposition: inline
In-Reply-To: <20180308150012.19045-2-wens@csie.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ilifn4hdkjc76jvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 11:00:09PM +0800, Chen-Yu Tsai wrote:
> The sunxi_mc_smp_lookback function is modeled after the mcpm_loopback
> function in the MCPM framework. "lookback" was a typo introduced when
> the new function was added.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ilifn4hdkjc76jvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqhUgQACgkQ0rTAlCFN
r3Q/Yw/+IyPxPudC8lpj1nP040J51aEF2mXJZXfoMbDA7tWVeKKM3YXFQ6ZjKqnl
6PlTX8T5p8LsJEM5dPiLaZdvjideRQtK/f7L0HRtBuXhfNob6xnN3XCMrC3lfhFF
sytjr+6MfzYkQymvWpbfwwTy1KT95BrGO0xsrDxDdZExNtatoFDhR5/QeKWUZDCs
v6OGyOAMcPkqggx7didZl3MPK1ACFXkYTotSfDX8g/TF0Y+m/v8h+if6S7KRXzhH
RuIgL342VYw3TJK396kKCuptavpHPXPChRx04iv14PIt8bl2yCsFkYLwZWJhMtxc
GMj8POk0oBnO0113vJPnGQsWz7w9RDyTO+Hx1lOVxiWPXele7LwRZ8sQjHxQsNlz
UyCBXf73t+FTCJtC6zoy9V3R+ZFSYGw9AJ1+D/MHlZl89z80YcrLpMGZgvjsmCSI
TGPjQnZfDeNuleTE+1JI2ZHBX6egFHvxk3gRq2rTpZ+vs2Nl3c2bmhi9xMzluhJy
2UbfFXAYOWiNny1PJXGY9nyFQSlfCr8f6eEUuNV9910BuL2D9d1nAy0kUOgncaVd
cd/n22PNMA3LFmk7zEq9icL/H0p3LA7h5sB6//BtRZZ7C6GsD9uxvbtQb21heF/P
b09TbsJXSqIZohygxbLazUkNzpRzmaipAABlqDh8xmE3fmuaM1w=
=XVcs
-----END PGP SIGNATURE-----

--ilifn4hdkjc76jvu--
