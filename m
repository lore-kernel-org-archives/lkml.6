Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755656AbeCHPMF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:12:05 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37688 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752058AbeCHPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:12:03 -0500
X-Google-Smtp-Source: AG47ELu8NUonEyRJDl86uGFygalbtuyWT+HnBodUj6rHtKcLQZKChcoPFRa3RdsAOwzECnkrMpW/rw==
Date: Thu, 8 Mar 2018 16:11:59 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] ARM: dts: tegra: apalis/colibri updates
Message-ID: <20180308151159.GC13814@ulmo>
References: <20180210013638.28164-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20180210013638.28164-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2018 at 02:36:35AM +0100, Marcel Ziswiler wrote:
>=20
> This series fixes the I2C bus frequencies, uses the correct compatible
> for the RTC and removes an unneeded reg property for Tegra based
> Toradex Apalis and Colibri modules.
>=20
>=20
> Marcel Ziswiler (3):
>   apalis_t30/tk1, colibri_t20/t30: fix i2c bus frequencies
>   ARM: dts: tegra: apalis/colibri: use correct compatible for rtc
>   ARM: dts: tegra: apalis/colibri: remove unneeded reg property
>=20
>  arch/arm/boot/dts/tegra124-apalis-eval.dts    |  7 +++----
>  arch/arm/boot/dts/tegra124-apalis.dtsi        |  2 +-
>  arch/arm/boot/dts/tegra20-colibri-512.dtsi    | 16 +++++++++++-----
>  arch/arm/boot/dts/tegra30-apalis-eval.dts     |  4 ++--
>  arch/arm/boot/dts/tegra30-apalis.dtsi         |  3 +--
>  arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |  4 ++--
>  arch/arm/boot/dts/tegra30-colibri.dtsi        |  3 +--
>  7 files changed, 21 insertions(+), 18 deletions(-)

Applied, thanks.

Thierry

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqhUr8ACgkQ3SOs138+
s6GusxAAqCyCkcL688gAHUc3s0CGQmJJqeguHAyhM0HFi+z+6z2rtlnSYoJSGq7J
emp74DisYPJTkQjZV1ZnDf8ZqTXxAaujxHyXeS1uOAnVZC4v8qgUWIl+RsphRu9S
/P+YTzjeXtTuq8BJSpYGAy/jmzr95j/C10Ko9OHS1tuxgEmS4opXd1QH8VuJZpQI
SmWNmmjLbrKPzqKeIZJynJUHSMqVVmNTkjbEwmM/4onYWhD4pUzK4j3rooqbAqM6
IpLFvgkOboC1rJ+eua9ovDjN5FAiUAC/SBCjcB0BgqWiN6NiY+OOP4MFIEsOewmL
GlJXYHq/V0PFhQFSulfnskG6fyA2QVU/ZnPlnJqrtAXWNYEujSDx9dNEeQa0RNVa
ilxCp6KtH4XZuD44wiMLeJe7U64D/4B4w0JgDs1DXrpBhf+9ikyDyYl3wJU85L4A
NMDJvFOBYFAhw12cCEzPUymUeIbbWTbUH03ebqs+2nR//aUbKXgHnkqexQ4UYtUB
fiusw4dyFvcrx95nQkba64mk7uFXKc6+wuoNPfBcLwf5XlTwZ+ZzwnrMw84R9exN
G3GgysdJb4wHOL1XPf9xyNGsOjDjBSOSpdEqzVX5+L/cq1bkzBRBOwkTI/MFsQ4y
MbvXNbUk7Uj8wDCTdsYsItOoXZ4XjhmBG5mGYY0b+2kAKN0lhXw=
=9g5E
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
