Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeERILp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:11:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50838 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbeERILn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:11:43 -0400
Date: Fri, 18 May 2018 10:11:41 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Emmanuel Vadot <manu@freebsd.org>
Cc: wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: sun50i: a64: Add spi flash node for sopine
Message-ID: <20180518081141.itlc4pelwkkpfvtv@flea>
References: <20180517150613.11916-1-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3dfrmciid7fgg2ew"
Content-Disposition: inline
In-Reply-To: <20180517150613.11916-1-manu@freebsd.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3dfrmciid7fgg2ew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 17, 2018 at 05:06:13PM +0200, Emmanuel Vadot wrote:
> The Sopine and Pine64-LTS have a winbond w25q128 spi flash on spi0.
> Add a node for it.
>=20
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/=
arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> index 43418bd881d8..3285aebc06d9 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> @@ -66,6 +66,18 @@
>  	};
>  };
> =20
> +&spi0  {
> +	status =3D "okay";
> +
> +	flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "w25q128", "jedec,spi-nor";

This applies to this patch and your previous Orange Pi PC2 one, but
the part name must have a vendor. Or you can drop it entirely if the
SPI-NOR driver can auto-detect it properly.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--3dfrmciid7fgg2ew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr+ir0ACgkQ0rTAlCFN
r3Q5KBAAipzUPlHR9Dh2SPT5FSOyXo9okYVIh2my5Bw5moEtcgT/vMIc8FVK9iux
YAlGwp5Bl1EOsWqXlDwDZuHbC+/0m8yTLfUrgdmFJfppjwyy8jtPR1af1NUT4aFh
5qE4EWzIRVglkSWxb86Tk4NF4ejm159H7ymFAj3s2RUIARrrNrTyTLDai52epC7y
iyNNqgeBhHv8mye7NoPQb4dEL5Jmmju/Xhn7n0i+5y2gLVheWX8dxX4HJuVAJtEm
DteMRXKwpZt+ym2Olup8YOv1qsuwuuiiSZuC5rkEqnC6/BKB+vYiJMDn4totuhAB
qJPy9sH69Bm8BhfaX277fDNpVphooXI6q0fm3b0MYW9aNeQRvvQALYDlOiQqloYz
Tk9uJrHwmbHLSyFmPOZmbflTk2GcBfjvOCefaAwnjmeax1iBBf/CHgmQWaERZom2
GvZu6X321lwJFQ165DD4U6KE6aWfPc4axkpIXm0BO0uuJNFSfzVN4wUSjHrycb8j
5ZozSmJf4zRuPPMUGoFbqiLso4Kx1E9MP5iuERBOfp1GYns0ArHGRUeSpyla11W7
lEySKzpZIL3JAAF/3S1Mlvretlx0nom2b428o9UU47Ls4M8tMQArif1vcrV4qAxS
D64Trdfn277PRO9Wwo0K2qtCp3AMvsiJ/gMvk9XP3CHAWtUKosk=
=AvFI
-----END PGP SIGNATURE-----

--3dfrmciid7fgg2ew--
