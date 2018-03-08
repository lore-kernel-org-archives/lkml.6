Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933575AbeCHPH3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:07:29 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43715 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeCHPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:07:27 -0500
X-Google-Smtp-Source: AG47ELu9vIWg9SU6ryQsW53POy33VM5Doh6u8GLDIAkkHJ+ZzNBloKO+iZ5Yg8sBcQhFSnGq5So3VA==
Date: Thu, 8 Mar 2018 16:07:23 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] dt/bindings & ARM: dts: tegra: updates
Message-ID: <20180308150723.GB13814@ulmo>
References: <20180210013326.27771-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20180210013326.27771-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2018 at 02:33:21AM +0100, Marcel Ziswiler wrote:
>=20
> This series fixes the Tegra GMI controller DT/bindings example, a few
> IRQ type definitions, removes some invalid uses of rsvd1 pin muxes on
> Beaver and removes a duplicate pcie-1 node on Venice2.
>=20
>=20
> Marcel Ziswiler (4):
>   dt/bindings: fix binding examples for tegra gmi controller
>   ARM: dts: tegra: use proper irq type definitions
>   ARM: dts: tegra: beaver: remove invalid uses of rsvd1
>   ARM: dts: tegra: venice2: remove duplicate pcie-1 node
>=20
>  .../devicetree/bindings/bus/nvidia,tegra20-gmi.txt |  6 ++--
>  arch/arm/boot/dts/tegra114-dalmore.dts             |  2 +-
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  2 +-
>  arch/arm/boot/dts/tegra124-venice2.dts             |  9 ++----
>  arch/arm/boot/dts/tegra30-apalis.dtsi              |  4 +--
>  arch/arm/boot/dts/tegra30-beaver.dts               | 32 +++++++++++-----=
------
>  arch/arm/boot/dts/tegra30-colibri-eval-v3.dts      |  2 +-
>  7 files changed, 25 insertions(+), 32 deletions(-)

Applied, thanks.

Thierry

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqhUasACgkQ3SOs138+
s6H90g//SF56gv/VDQdTnhEJNU6E84br4xcCdQzeH3/nL+wZMv9PwIFsj3NjS8ta
gKfsTyW9qsmIudsFjZN/R2KShotcqPAi22hb91fkgpmyQqUq/yU2bvlMUnXvl70j
MV9NbGhP0fVtTqpFG3fufqhZLltw+U8NLZYTXVDS6ieGEMExs7x+AaCECg84sJfH
tMl8m+yN5SrYyeGcK+KYmLgh4cwk3U9ey+HTmIyGN1glLwa469x4Ty12C0jYmixl
PMpjF0UAAlYcK7z8IzE5Oa7D9ZzuJz4iJQVAWYhDf5IZtjb0WyEObZiUMDh1gSA1
SDGhCmMb6vJjgm+8XaP4QeWa9oIQWT37NYQoJjg18DQaqeHz6xgDG8YPKK39KKGI
o4pKK8Yg6u/xctwH58EoaiQl+7Ko3o0qV+z29wk2iDnferhONpGD2N4ixSaWmI0r
5ihlk1t1DXituvuikkMrfasLLEUb2mPc2irixtBWoiYoGmSu2F0TJSyXgIrmcGbN
Nus9+1UBDT20sWpWZpi4UIYtNMu6k8Q/CrpOrw6QU4oQPUvQA5/wjXyXDwufIXlb
ZHzafhxAamB1fxZyPtkBcc+0zC81q9J4foufUvt4vwRcAOuJMEpbpOT5ca4HlWxm
Ed78tVZWwpmsu7y/WZXpA8V5iLRNFNSNp/fgMPfXnr5LC4eGuWo=
=ErrX
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
