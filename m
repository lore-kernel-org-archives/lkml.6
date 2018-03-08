Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755941AbeCHNoc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:44:32 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33107 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755144AbeCHNo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:44:29 -0500
X-Google-Smtp-Source: AG47ELsXcKUFddb6zt/dNdIOOqYAE14FMQhTDNFnUthCwvsdoI45XOq5fcw0hfhdh6IVZoUAh5W19A==
Date: Thu, 8 Mar 2018 14:44:26 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: jonathanh@nvidia.com, robh+dt@kernel.org, mark.rutland@arm.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, pombredanne@nexb.com
Subject: Re: [PATCH v4 0/7] Initial support for NVIDIA Tegra194
Message-ID: <20180308134426.GE3529@ulmo>
References: <20180220115812.24108-1-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline
In-Reply-To: <20180220115812.24108-1-mperttunen@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 01:58:05PM +0200, Mikko Perttunen wrote:
> Hello everyone,
>=20
> this series adds initial support for the NVIDIA Tegra194 "Xavier"
> system-on-chip. Initially UART, I2C, SDMMC, as well as the PMIC
> are supported, allowing booting to a console.
>=20
> The changes consist almost completely of the new device trees,
> however some fixes are required in the BPMP driver to support the
> new channel layout in Tegra194.
>=20
> The series has been tested on Tegra186 (Jetson TX2) and Tegra194
> (P2972).
>=20
> Cheers,
> Mikko
>=20
> Mikko Perttunen (7):
>   firmware: tegra: Simplify channel management
>   soc/tegra: Add Tegra194 SoC configuration option
>   soc/tegra: pmc: Add Tegra194 compatibility string
>   dt-bindings: tegra: Add missing chips and NVIDIA boards
>   dt-bindings: tegra: Add documentation for nvidia,tegra194-pmc
>   arm64: tegra: Add Tegra194 chip device tree
>   arm64: tegra: Add device tree for the Tegra194 P2972-0000 board
>=20
>  Documentation/devicetree/bindings/arm/tegra.txt    |  16 +
>  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |   2 +
>  arch/arm64/boot/dts/nvidia/Makefile                |   1 +
>  arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     | 248 +++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |  16 +
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi           | 344 +++++++++++++++=
++++++
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/firmware/tegra/bpmp.c                      | 142 ++++-----
>  drivers/soc/tegra/Kconfig                          |  10 +
>  drivers/soc/tegra/pmc.c                            |   1 +
>  include/dt-bindings/clock/tegra194-clock.h         | 321 +++++++++++++++=
++++
>  include/dt-bindings/gpio/tegra194-gpio.h           |  61 ++++
>  include/dt-bindings/power/tegra194-powergate.h     |  35 +++
>  include/dt-bindings/reset/tegra194-reset.h         | 152 +++++++++
>  include/soc/tegra/bpmp.h                           |   4 +-
>  15 files changed, 1274 insertions(+), 80 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra194.dtsi
>  create mode 100644 include/dt-bindings/clock/tegra194-clock.h
>  create mode 100644 include/dt-bindings/gpio/tegra194-gpio.h
>  create mode 100644 include/dt-bindings/power/tegra194-powergate.h
>  create mode 100644 include/dt-bindings/reset/tegra194-reset.h

Applied, thanks.

Thierry

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqhPjoACgkQ3SOs138+
s6Ffeg/8DhaIZ2XeWg/oQ7SOEVS/1ykCnG6zZZVXxcC8AkVbwOjaKVFpzJa5fs4T
ohbU/9V0WqvDecXSLGdqq4vq6mgFzACxqkuGZBhtIRiNbGswVwFSnBgZkUKdiasa
elOQYz6kMYKl/MfoLqfxrvQmhciXukF19VKVZLBT6GRDoFDccN7wXjFr6CMxaeh0
LfcNGCslLYbHq8IAjmM3qRkK3n+N/6tjrQzwqIvH6hO8qmzRY4ms/005/91iqNj+
/b7JBgr9STN1S1smyZqMxS0Fv0E70avInFDso15HZgaiF88IODBIylR2ZYDKzAey
IZ9flNUwcXk6hSGng8oxd5CgKTDUhZLtt56KHZau/rF8BfnTCjVwEV4mLRqdQyFe
d9JiHVk8bsRoXoZ1wAUDQWC+9Xpv423YLV36FA5g/JPA68+GvVqWI1cT0blNMnw6
QsoypJq36HzPCbjOlwYVZswhxi0Yyw7BIG3VHYF51Y6nGYxrIRoCA+8Cf3FvIaTX
8sm3SxYJ1XEBnW1NVnyEhCvKKsFG3QG/Ub0TpXzQpB98LRydjmvEVxpDMb6Sn0gA
oPFF57dP9RhLbk0piMp6U6fqomj6KvA6Cn+cNTnNhvJkARGkUdAF2aiPjMLAaDyN
myyuokzxii3BantL+pIcP4qAr8/lpT4WvaPOjN9eKj3bADPxfmw=
=pSgW
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
