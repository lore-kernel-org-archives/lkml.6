Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeBZIot (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:44:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39681 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbeBZIop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:44:45 -0500
Date: Mon, 26 Feb 2018 09:44:33 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: hao_zhang <hao5781286@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, wens@csie.org, Claudiu.Beznea@microchip.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 1/4] dt-bindings: pwm: binding allwinner sun8i.
Message-ID: <20180226084433.jcahdixnz63jo34m@flea.lan>
References: <20180225135045.GA14508@arx-s1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rzg4gjmtenrchmoq"
Content-Disposition: inline
In-Reply-To: <20180225135045.GA14508@arx-s1>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rzg4gjmtenrchmoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 25, 2018 at 09:50:45PM +0800, hao_zhang wrote:
> This patch adds allwinner sun8i pwm binding documents.
>=20
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sun8i.txt | 18 +++++++++++++++=
+++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Docume=
ntation/devicetree/bindings/pwm/pwm-sun8i.txt
> new file mode 100644
> index 0000000..e8c48be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> @@ -0,0 +1,18 @@
> +Allwinner sun8i R40/V40/T3 SoC PWM controller
> +
> +Required properties:
> +  - compatible: should be one of:
> +    - "allwinner,sun8i-r40-pwm"
> +  - reg: physical base address and length of the controller's registers
> +  - #pwm-cells: should be 3. See pwm.txt in this directory for a descrip=
tion of
> +    the cells format.
> +  - clocks: From common clock binding, handle to the parent clock.
> +
> +Example:
> +
> +pwm: pwm@1c23400 {
> +	     compatible =3D "allwinner,sun8i-pwm";

The compatible you have here isn't the one documented.

> +	     reg =3D <0x01c23400 0x154>;

And the size isn't correct, even though that doesn't really make any
difference here.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--rzg4gjmtenrchmoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqTyPAACgkQ0rTAlCFN
r3TyaQ/9GikdziVYAKqwaqJ5Ak1H9bU3XgtLpJ3uYTelfB0Zcq1sTY50v0Iw24+U
FtXspyouhbrOe5RTHQYIVLyXrXvI65Ufo3oCVKGtS27txUB6FpVkkuRZCUD9Jgbv
BvMGteYfADuOv+COxonHuuRNTvbxP8ZaMRpgFUhwKzVEKmBucUP/yAB9xyiznori
dlm0VCIIHp/G6HL0FWuCLC1f/AzSw3vtQvbtvfx8CnmT9HDXxLTjO20WiNpUeCEM
NhqY93sNBr8UAH1wLRBh3fFcwgOxI9e7+1fs3WKxY2gNinZsVFO3c2kvPQBxwrpj
qqYxE+0qc6Y49CyWCx+4VuWgytDo3vDavkhm0sopgihd8GDeA6kUQpK0COpSV8LE
h4OrOaBkNfsZBQgIdWtJGeaWZCEjuaDqMZnyJ+ZKkvzJZERWC2gRgNqilxqssT1W
OLMz3MQMnxQExGe9iPScxDteYPFlcTEiJd+z3pSsHBX2B4OTSLS+bdW/mSyIHazP
L5GUNTe6M271WczTHCbg89/n5fBvpIJTOYwlk/pUgNgl85eLAVAWY0p9ultCmH+Y
cuUzzWA5kR1dm3tSBX+kK3ndiaFyn/h3w0bVpbwOBoC9tKnJqic0KmDRjMG5FcMt
biOpZ6ahEeXj3j7X6VOVcUGKEUXnnN7AfVrPj4jweeacWRZGKeM=
=naAz
-----END PGP SIGNATURE-----

--rzg4gjmtenrchmoq--
