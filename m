Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeBENqs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:46:48 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:55388 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeBENql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:46:41 -0500
Date: Mon, 5 Feb 2018 14:46:38 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 09/20] clk: sunxi-ng: Remove SUNXI_CCU_* selects
Message-ID: <20180205134638.ugngvfmdixnpxihk@flea>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-10-ulfalizer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qibptpmrcb5iyvxp"
Content-Disposition: inline
In-Reply-To: <20180205012146.23981-10-ulfalizer@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qibptpmrcb5iyvxp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Mon, Feb 05, 2018 at 02:21:21AM +0100, Ulf Magnusson wrote:
> The selected symbols were removed in commit 06e226c7fb23 ("clk:
> sunxi-ng: Move all clock types to a library").
>=20
> Remove the selects from SUN4I_A10_CCU.
>=20
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefin=
ed.py
> script.
>=20
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>

This has already been submitted by Corentin:
https://patchwork.kernel.org/patch/10175435/

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--qibptpmrcb5iyvxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp4YD4ACgkQ0rTAlCFN
r3QtyA/9Fm+szM2mf5g406tyFmVHFdbHaTDP5jD54fhjBPPK1Jg0uw8Ig9dpFOe5
m4Bcq7rPAMfjAYHOAd+FCv7P0oT4/K7n3NQ/9I7e1WqMNAKzqNyN/WcloDjFS/gK
lhxPPorybKvvChE2ZddU9w5oC4AETILJ5B+gveN2IsTO3YDJv2Ufly8YmS4+OyO9
AtNh84XQ1lTen1W9HvS9S3hCJwXHYMq1cMoVS83azCMMBBM38D5DOoeMaJID2kR8
N8LHkVxrtYMB7tE9mjTRRHDWqIxRQww0B+/5qUcFN513NgQxsOcSmIJp9xu9N4qw
Ypk74ydvysGOylvBmn69tdW5Q4BYY9w0HEPBxNwbEVrsr4Ez8Ij8aKY4YD2uPm0S
5svM5KJBA1vXi244n4689MnC+EYdrGwzDtYK0H1F1p24yRAtdXRgDxVHoz+9A10L
dvMVCeSsqBm+WQlXnCiIItbLHRyAYeuxsV75ANnQDiqNN1GsDvsYMLcSXjXBgPhp
vyDMkzgCYQwDvDCQ0sdIPg5niDiKONdIGWyADPNiy7s/It2hT0dGofezV/yC8Odl
uX8pV4yvd8rdBTNSS566kjYaqyTUyPegwov651837ZzxOZwyVBEM/GYOt90po6Se
79uIi7P/koSCTRbe9zEFrUkcdh9hGR2h9Uxvho0kjjhxXYCPB+s=
=vQgV
-----END PGP SIGNATURE-----

--qibptpmrcb5iyvxp--
