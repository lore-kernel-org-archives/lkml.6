Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeEBLea (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:34:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47457 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750939AbeEBLeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:34:25 -0400
Date: Wed, 2 May 2018 13:34:13 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 09/21] arm64: dts: allwinner: a64: Add HDMI support
Message-ID: <20180502113413.vv2r3ubfoh7gm3ms@flea>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-10-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jipx7koxxx7erdq4"
Content-Disposition: inline
In-Reply-To: <20180430114058.5061-10-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jipx7koxxx7erdq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 30, 2018 at 05:10:46PM +0530, Jagan Teki wrote:
> +		hdmi_phy: hdmi-phy@1ef0000 {
> +			compatible =3D "allwinner,sun50i-a64-hdmi-phy",
> +				     "allwinner,sun8i-h3-hdmi-phy";
> +			reg =3D <0x01ef0000 0x10000>;
> +			clocks =3D <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
> +				 <&ccu CLK_PLL_VIDEO1>;

You were discussing that the PLL0 could also be used to clock the PHY,
has that been figured out?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--jipx7koxxx7erdq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrpojQACgkQ0rTAlCFN
r3T+JQ//TxUuW9svfO940idbQAxF10oxginiBbDHcAPquDwd+/BxJz7Zn7ZmKML6
CcNvzMf+PpDqBqpPjrjBGY/6qkcwqDnaoG2efocjCDTrrY23xca/7EUHA9rxg7pd
2a7DMFWD2dAZycsDqhJNbZArtHxnu/aOFNU8TcFtvg0vuA+EvR0ceSS61K0FylxN
q5QzHLWUQIGH34inNSLwaGilzLAvEx/xzK01tQDxT5uY+0EyIwbyYWFR7XKiJP32
mYe2ByHUKgDnjDvVMoRNH8aPeosGwZTqD7bLmRcKOiG0H+dUQOfbND3R7ET/wipK
nmxvSXZfM8dtlpKIfOzPcpwc4jkiEbJwUioR2/EEoMTVb6b9eug8qTX0FxdS4KOp
a/lMfHsgQvVqOkJ1WoGaK5fP8iczWK0jmNeB18bYghot9fDmoGJ6RxoeNm6JvN8B
qs4C/oFI0f5EZ34EyDHOdp91YmpLuvuPv+qEoTSeeZF5QhtGE0p7l/AdVDZLyPO3
2Lur6tK6Z8vCIu5w2Ftdbn3I4X4dgpvfjcLy5QObvECi4bPMCqbigEdS2urBiciX
mTukfaLxKp193uqrF6WJqL9GIleTQUaO9x58jUz+gOOxL/zB5ohlLK2ENI/uvQrX
OVWI1oZSl/g7b59bdhNsXWKR1CiYgtLKw1tpshFNI0fJThYdamg=
=VgEg
-----END PGP SIGNATURE-----

--jipx7koxxx7erdq4--
