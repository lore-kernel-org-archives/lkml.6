Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756045AbeCHPTg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:19:36 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44611 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754993AbeCHPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:19:33 -0500
X-Google-Smtp-Source: AG47ELuX8F0b11JAr7fVVN39agVuf8BOFYEDlUUnHIvSCTr39xPIn0xEVnDyL4+wgKyoND1+NoFE6w==
Date: Thu, 8 Mar 2018 16:19:29 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] ARM: dts: tegra: apalis-tk1: updates incl. v1.2
 hardware support
Message-ID: <20180308151929.GE13814@ulmo>
References: <20180210013806.28496-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <20180210013806.28496-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2018 at 02:38:00AM +0100, Marcel Ziswiler wrote:
>=20
> This series sets critical trips, activates PWM pin muxing for PWM3,
> adds a missing AS3722 GPIO0 configuration, adds a hog group for
> Ethernet, PCIe, reset GPIOs, updates the copyright period, removes
> spurious newlines and adds support for the V1.2 hardware revision of
> the Toradex Apalis TK1 system on module.
>=20
>=20
> Marcel Ziswiler (6):
>   arm: tegra: apalis-tk1: set critical trips
>   ARM: dts: tegra: apalis-tk1: activate pwm pin muxing for pwm3
>   ARM: dts: tegra: apalis-tk1: add missing as3722 gpio0 configuration
>   ARM: dts: tegra: apalis-tk1: hog group for ethernet, pcie, reset gpios
>   ARM: dts: tegra: apalis-tk1: copyright period, spurious newlines
>   ARM: dts: tegra: apalis-tk1: support v1.2 hardware revision
>=20
>  arch/arm/boot/dts/Makefile                      |    1 +
>  arch/arm/boot/dts/tegra124-apalis-eval.dts      |   16 +-
>  arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts |  250 +++
>  arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     | 2052 +++++++++++++++++=
++++++
>  arch/arm/boot/dts/tegra124-apalis.dtsi          |   70 +-
>  5 files changed, 2344 insertions(+), 45 deletions(-)
>  create mode 100644 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
>  create mode 100644 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi

Applied, thanks.

Thierry

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqhVIEACgkQ3SOs138+
s6GdFBAArxRzFoP2qvn5sTy+YxuR35WGzCzljcKp+Sem03Frmn2znFS3iehH6dT7
IU2xjdyN2J8CKc2AXxodLYWVM/EFMvpldvZNyzd2XfpzGvUO3hwAYTdtU5XGcXub
uSV+/UJcXjcGgLVerMv6/+JcddE/KX/WsyzAWhRwaGxdxc/ILZe2rk1LGsv3/d7S
sUqYjPKZdbxkx2yhLPGH0PmBGTG6utU0s7BCJAzlSPlQ8hn4Ia6aYapRhXWtc7Q3
7KD30irjMETNG1VbwJym55oG40kkBG9dMrQEws/7X30vUWD+DOlXmLxXGeCflqTI
55ltG5JIYOcV2C6cqqdFuB18P3T7vwaPBty2UG7kjpEgVY0KikrXAwhQbrG9kCTB
Xwj+k8etRbX5IOcZVs9Xr3BUjNpL0lz6HnfTfQNv6nwZ5KWG+C0nHhGcFpigWDWH
jMAFoqH2Xhrjo9ym7AOQiWYj9tFI7brI2O29tz6vX8EqaFe/ynnrGTScGHF2Xoyx
jWc5OBRpKGjMdjvamoxr+D/1DZpUabETo1Nxjs9uQUHWtnd8qJXHgNsauuZOxnJ+
i1SoBPaZ39xN8ZE49m61MMn9QTYF7ghhUL+N7gk2BvMhlg9b2zdy5o2wnvLL6FdK
fD7dX6T9FKQW++l6w58gT4AKuOo7mqx5JSB7WO1g9spK3nmVAP4=
=hCn0
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
