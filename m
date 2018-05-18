Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeERKjO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:39:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34783 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeERKjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:39:12 -0400
X-Google-Smtp-Source: AB8JxZoCiBNJAhBjI//mCDyboFWZZgv7Z7QzAbyBmy2psE9AQMKRM0+HXelGhg11fVFL0LVQSE/GwQ==
Date: Fri, 18 May 2018 12:39:08 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pinctrl: tegra20: Provide CDEV1/2 clock muxes
Message-ID: <20180518103908.GF5312@ulmo>
References: <20180508162607.3500-1-digetx@gmail.com>
 <20180508162607.3500-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Content-Disposition: inline
In-Reply-To: <20180508162607.3500-3-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 07:26:04PM +0300, Dmitry Osipenko wrote:
> Muxing of pins MCLK1/2 determine the muxing of the corresponding clocks.
> Make pinctrl driver to provide clock muxes for the CDEV1/2 pingroups, so
> that main clk-controller driver could get an actual parent clock for the
> CDEV1/2 clocks.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Marcel Ziswiler <marcel@ziswiler.com>
> Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
> Tested-by: Marc Dietrich <marvin24@gmx.de>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>=20
> Changelog:
>=20
> v3:
> 	- No change.
>=20
> v2:
> 	- See changelog of "Restore ULPI USB on Tegra20" v2 series.
>=20
>  drivers/pinctrl/tegra/pinctrl-tegra.c   | 11 ---------
>  drivers/pinctrl/tegra/pinctrl-tegra.h   | 11 +++++++++
>  drivers/pinctrl/tegra/pinctrl-tegra20.c | 30 ++++++++++++++++++++++++-
>  3 files changed, 40 insertions(+), 12 deletions(-)

Linus,

were you going to pick this up for v4.18? There's a runtime dependency
on this from some clock patches that I'd like to get into v4.18.

I see I never gave my Acked-by on this particular patch, so here goes:

Acked-by: Thierry Reding <treding@nvidia.com>

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+rUwACgkQ3SOs138+
s6F4Zg/+PiE7355bzPMINxgk/9Q+qcq1ME2JselWa8MQtM5FT5RcXkLY5OlkNk9+
Nf+1BlqOI2cEzUQK7OfB0Qi/Ev0eDaEcLyVt+R41QUkd5QH5Cf+k5/7Xc1BS6E3q
qQjPgLPk/DGBUl3Rv97Z08x6JZsTfw/Qzubz1l9l9baCIPSrpBq6ou7T2zbG/6B8
bh7qYQlZFieFPuFQGqKw6l28mNBqV6HWTsunBSjpbLISs/LmXSKkjEQvYuUn3PIx
HGFoMOtHBlbCQ93/kjL/6+ZjELSJhYgcJ+x4Fy6FWLMVWkUkk3/wjitzYN3ZyS/R
MwWfhDBuT3fuaPiFQj8ZrD+B8lCiKm5rWBeao0g8fTNzSIGfXFqCC0byS8MzN+CV
96BbSB8zRww4+TTAIRIVXIExqsBtHmQK9b/IjOIEPQ20UD3nWiIp0B9jBgWTOrUT
wvncljX+VoZgYWAHUhZnp5ylC5KpPv8u8PyI323DICI1PkIVi4C6YYWSgUw8oIMZ
+t1TYLeJlcPPZ0aRTjX5kda6ivwULV/lsbebKA8cMxfWm2ufb70Bqc6Gp3I+Inzz
aVph7jGViUNZnWWt8AO9XvXDka+Otrk8YzLn6F2pjnHoL3Dk+UykUx6kDKSTDZWT
ep17CM2hrXFXBSVbZ1mjT9rILYKfdmwf7A2X5NLbUDKL6ATD1RU=
=Or8C
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
