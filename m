Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427227AbeCBLYj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:24:39 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36548 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427212AbeCBLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 06:24:34 -0500
X-Google-Smtp-Source: AG47ELuWAafmXu2/i6+fqsKBLPqidIFT2h5QbRRYqfjZkXvD/Oov784xWcvWEvSRM73stg81lMcetw==
Date: Fri, 2 Mar 2018 12:24:16 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Add Nuvoton NPCM description
Message-ID: <20180302112416.GB27322@gmail.com>
References: <20180302063746.10993-1-joel@jms.id.au>
 <20180302063746.10993-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <20180302063746.10993-2-joel@jms.id.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 05:07:45PM +1030, Joel Stanley wrote:
> These bindings describe the watchdog IP as used by the Nuvoton NPCM750
> (Poleg) BMC SoC.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../bindings/watchdog/nuvoton,npcm-wdt.txt         | 25 ++++++++++++++++=
++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,np=
cm-wdt.txt
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.=
txt b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
> new file mode 100644
> index 000000000000..599db288337e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
> @@ -0,0 +1,25 @@
> +Nuvoton NPCM Watchdog
> +
> +Nuvoton NPCM timer module provides five 24-bit timer counters, and a wat=
chdog.
> +The watchdog supports a pre-timeout interrupt that fires 10ms before the
> +expiry.
> +
> +Required properties:
> +- compatible      : "nuvoton,npcm750-wdt" for NPCM750 (Poleg).
> +- reg             : Offset and length of the register set for the device.
> +- interrupts      : Contain the timer interrupt with flags for
> +                    falling edge.
> +
> +Required clocking property, have to be one of:
> +- clocks          : phandle of timer reference clock.
> +- clock-frequency : The frequency in Hz of the clock that drives the NPC=
M7xx
> +                    timer (usually 25000000).

Optional properties:
- timeout-sec : Contains the watchdog timeout in seconds

watchdog_init_timeout() will fix this for you.
> +
> +Example:
> +
> +timer@f00080c1 {
> +    compatible =3D "nuvoton,npcm750-wdt";
> +    interrupts =3D <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +    reg =3D <0xf00080c1 0x4>;
> +    clocks =3D <&clk NPCM7XX_CLK_TIMER>;
> +};
> --=20
> 2.15.1
>=20


Best regards
Marcus Folkesson

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqZNFsACgkQiIBOb1ld
UjLUug/9FKQmbDGOcyi80kxHKqnKZmIhWtQ926N0QWoSL5MNEEOuE4UDjwaldw5z
CO5TWEvGfbKiiQZReug0OWiPK/dYmnD5CCyMGUeumPdtdXlrUWKcZ8rVEn5g0UZf
NMtEFDhWYNR6TyP5PWzIOJ7g2U2RFuooWbw5n5xOemn3QuoTBqjFRH6fPZnBWoSx
vgGL1dgR2usnepu6sbDKBPSegvPmNgjk050vbycyrAGUFM/+6J+YAWvf5RJVQfGp
MKXXeeWripDs/OBf6OrvsbntnmtI5BEBI4RNuW2yjDMFhkMEVgrvqWzZOQfBOITn
NxH1hFKfgyWIZ/Yxk26uodWsiMowIy8mhyOInPm2HtTwXpmcqrucd9vBEXCGvWyx
FCD7MfiUe/oi8gwPVvnadSBm49x7B1oYc6UMR7ddDhgbKioCsIhBk7IiFBD5NR0G
HMZ4FV0Wf4zOEo892dAG8lpD179E5Qj7UEqE8H8df2bI+6mIIsfRwD0U61A5Wqwh
u7cu2G7/9E/D8964yssAgJG7hqEmtIAvXzOT2wGlcPbpZERy/XeSM/FnY6e5CnDp
u32c+AkN4d5fdYT6GMRKhEt3FceVuJmV/J33VOLnFDIq6wQPMyYin/8I3HYmWOJJ
epzeVPL7C5YudzAUUWHml5yfNdgUW9/ZqUesLeo7x3bJavxGQI8=
=yuLj
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
