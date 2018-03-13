Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeCMI1d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:27:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36863 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeCMI1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:27:32 -0400
Date: Tue, 13 Mar 2018 09:27:24 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com
Subject: Re: [PATCH 3/5] arm64: dts: allwinner: a64: add simplefb for A64 SoC
Message-ID: <20180313082724.7optc2xwgqoiibtx@flea>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180312161050.7647-4-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zqztf6atuxy743zp"
Content-Disposition: inline
In-Reply-To: <20180312161050.7647-4-harald@ccbib.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zqztf6atuxy743zp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 04:10:48PM +0000, Harald Geyer wrote:
> The A64 SoC features two display pipelines, one has a LCD output, the
> other has a HDMI output.
>=20
> Add support for simplefb for the LCD output. Tested on Teres I.
>=20
> This patch was inspired by work of Icenowy Zheng.
>=20
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index ca1b365bc722..05d5e8def68a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -52,6 +52,26 @@
>  	#address-cells =3D <1>;
>  	#size-cells =3D <1>;
> =20
> +	chosen {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +/*
> + * The pipeline mixer0-lcd0 depends on clock CLK_MIXER0 from DE2 CCU.
> + * However there is no support for this clock on A64 yet, so we depend
> + * on the upstream clocks here to keep them (and thus CLK_MIXER0) up.
> + */

There's definitely support for the CLK_MIXER0 clock in the DE2 CCU
driver, so I guess this would need to be amended / fixed

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--zqztf6atuxy743zp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqni2sACgkQ0rTAlCFN
r3TCkw//UUyP1rmIsElv2naASm/OXnHkBrQu/SsOhg6WOf0lZU5QLI7PGOjoGBtm
MDD+RmOtJvWY7l1y5PViGzVSbXFUldxP8iNQKSLTyxn4VC7OVnN/WEjyt5qGgw2i
oJFSpy9cX5A02WkBy7G5fNvQw873dxDSeU3w2NxydPoysxNG33WknBtsyW7/HjiG
EHrJVEOCsUe9X9j+vzyGxXvXr1Swx4ky13cP2THW5xrV5palY9q9E+PbXPNKCCpF
+hAEdLcvxh/ajVXROpa6AI1e55D0p0LSG7O00o+1O/+vW3s7ZrITBn51LJnrOMx3
IhA9klj9bAuDCgpbPV/f6l+Tz9BbN5SCGyE/0tL0ltR35yyymVp3kRhguREHANXX
he53YR3MbfqKFCY27R/FHSn4udJiA6ky0xxaJVObVH2J8/hNkEAwuDRQfgoH5TkC
mI6ZKRlqm8BeZ4mabP0/71XuMmpraeuVLWrxIpOOq+CCG2kco6Px0b85lD8luoyU
v9RW2vRed9XUiyzxrLWAZyd8EblKNd+MCendyun8HErnqEsvM4R4H20DIPqRn4hL
ghvTNyLLSvVgXkiFxcuFyyUKtMDuQBcUraGGvBzpao+Nd8ycArz9QMd9N1dj1Nsx
NKYxjKOvsZlIVxmRL4hn+YRIRh+r8AttRnsZBhL3ahxwU1uDZ3M=
=BmJp
-----END PGP SIGNATURE-----

--zqztf6atuxy743zp--
