Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeCMI3N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:29:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36946 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752023AbeCMI3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:29:11 -0400
Date: Tue, 13 Mar 2018 09:29:09 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a64: Add pwm device
Message-ID: <20180313082909.236etgyrtkr3o432@flea>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180312161050.7647-5-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5nittou4ns7ssr2s"
Content-Disposition: inline
In-Reply-To: <20180312161050.7647-5-harald@ccbib.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5nittou4ns7ssr2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 04:10:49PM +0000, Harald Geyer wrote:
> This device is compatible with A13, so no new driver is needed.
>=20
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> I saw that Andre Przywara has been working on A64 pwm too and has
> submitted some patches a few days ago. I think his patches are functional=
ly
> equivalent to this one here, but clean up things a bit and thus are
> preferable. See:
>=20
> https://groups.google.com/forum/#!topic/linux-sunxi/hQFeteP591k
>=20
> I'm including my patch here mostly to have a consistent series for others
> to test. OTOH you might merge the device tree changes here and pick up
> the cleanup patches from him. Either way should work fine.
>=20
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index 05d5e8def68a..95d52f6aa07f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -364,6 +364,11 @@
>  				bias-pull-up;
>  			};
> =20
> +			pwm_pin: pwm_pin {
> +				pins =3D "PD22";
> +				function =3D "pwm";
> +			};
> +
>  			rmii_pins: rmii_pins {
>  				pins =3D "PD10", "PD11", "PD13", "PD14", "PD17",
>  				       "PD18", "PD19", "PD20", "PD22", "PD23";
> @@ -629,6 +634,14 @@
>  			#interrupt-cells =3D <3>;
>  		};
> =20
> +		pwm: pwm@1c21400 {
> +			compatible =3D "allwinner,sun5i-a13-pwm";

Just like for the watchdog, you should have an A64 compatible there.

> +			reg =3D <0x01c21400 0x8>;

And you should use the full memory range here.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--5nittou4ns7ssr2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqni9QACgkQ0rTAlCFN
r3TaOA/+NMl2EJf1U/fQit6/vBRkc5av7js2OXfOliGiIiRvewBM7GySnhatF/Cm
kF6OQG8xN9JxYv1RorMkpyuSz4V+bNK+c5aW89ibkIjtWNJYiNhnwCQCTCUGdsVg
2wg3OydNf3rMUb4BMTM6R9EGYvguULh6D1/YaJEqrzkkKLnq7bk6Bav8BEanDRle
KAfq9HeSfSGoAn11YUHeDc5CDCCUQb7wQqxknw73wch4LTkNNmLzXaU3fqMSjFZm
ZNlPaOdGU7MWIsfkZKN36MMmuiRdmjkYPWbLcjVSFYbB5sUFrohzqgDsLvOviwVN
7ddY0hJK9NNKlgZddubKdIE9+uxg4Z/n19l2OYxWbrFjjKh4Uhg7f8/cFvuyLam9
AzMeqztYo8/3xlqFFPw6rB0a6lEWZxf0YqeSGkeyxeGzDAgcUzzY/oDyIf7VX8jt
seMWrt5NtW9poKFB6e/NVYVjT8YqpwceYYd+PH0df78TpOYgV4GS2DHpGMnTlZ4O
QxjPUy5jccazi3nmJyfCNm3rzfZSsyE42BD69cE0uUl+8IMZGu/Pt53//m+wPSgl
krk946KenJnGLVpo6q/tUK2249nMNaVuseyZ9szUJOsjns0g4KnK4Obgv2W/4ass
NokXA0sgXZWGlHrTs/mNx8Y5FyUlj0lNX5wEfSbhFFigaFAJnsQ=
=/sjq
-----END PGP SIGNATURE-----

--5nittou4ns7ssr2s--
