Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbeEUICB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 04:02:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37765 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbeEUIB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 04:01:59 -0400
Date: Mon, 21 May 2018 10:01:47 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 04/15] dt-bindings: display: sunxi-drm: Add TCON TOP
 description
Message-ID: <20180521080147.72esi2kwzcvzmetk@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-5-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ml3nrfyv2c4gred"
Content-Disposition: inline
In-Reply-To: <20180519183127.2718-5-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ml3nrfyv2c4gred
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 19, 2018 at 08:31:16PM +0200, Jernej Skrabec wrote:
> TCON TOP main purpose is to configure whole display pipeline. It
> determines relationships between mixers and TCONs, selects source TCON
> for HDMI, muxes LCD and TV encoder GPIO output,

I'm not sure you mean GPIO here, but rather pin?

> selects TV encoder clock source and contains additional TV TCON and
> DSI gates.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt      | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.tx=
t b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 3346c1e2a7a0..a099957ab62a 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -187,6 +187,26 @@ And on the A23, A31, A31s and A33, you need one more=
 clock line:
>     - 'lvds-alt': An alternative clock source, separate from the TCON cha=
nnel 0
>                   clock, that can be used to drive the LVDS clock
> =20
> +TCON TOP
> +--------
> +
> +TCON TOPs main purpose is to configure whole display pipeline. It determ=
ines
> +relationships between mixers and TCONs, selects source TCON for HDMI, mu=
xes
> +LCD and TV encoder GPIO output, selects TV encoder clock source and cont=
ains
> +additional TV TCON and DSI gates.
> +
> +Required properties:
> +  - compatible: value must be one of:
> +    * allwinner,sun8i-r40-tcon-top
> +  - reg: base address and size of the memory-mapped region.
> +  - clocks: phandle to the clocks feeding the TCON TOP
> +    * bus: TCON TOP interface clock
> +  - clock-names: clock name mentioned above
> +  - resets: phandle to the reset line driving the DRC
> +    * rst: TCON TOP reset line
> +  - reset-names: reset name mentioned above
> +  - #clock-cells : must contain 1
> +

I guess you should better describe the OF-graph endpoints, and the
clocks output. Just using the binding additions here doesn't allow to
get a clear idea of how the DT should look like.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--6ml3nrfyv2c4gred
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsCfOsACgkQ0rTAlCFN
r3Tr2g//TSH3w+DxFk8kkj0BXT7kxlxYgUNAyh+wzKXYhv/akZEXRBYODGylh+hS
aJLX45Eg+xHK6xGWS+u5sm4WboUgmxtMfxYnS06dFPtWWeMDFpDeN7JgdLMWSuh2
GktruPv7EsOCre7IUVUhtGaXyouz6jHQA7glGXvXtf3WbJqAwQ+8gMonrT7p3xZP
yh9oDtjtOvlV0cOv2fPMAU1WF63ly8AqCXFhuMmDHNR371sqoj2z/LZqCNjULC8E
FV3APQ/YmZrMBeXEcRCPcg+LoapYKAtGlCuMCxflPKRX4NIzMDYjB7x9ZreKiDM7
NpSL3bY/whrcmM+c3MnmzO4f7qO5bYLOxqmEP42WYilZybnATqYdt2EFr4QBI/zI
WWP4IKLcSARHZ0/gJjJw7UrFUF01iEjL7BlyEPpv2KX1usl9jSOkTpNTDTJIf1nb
mBKFdQYTr45zED44wcj30lieuhK4L6U3zOhCxvtp/1z6XzAX9eIxMdc9P1abXHJj
op2wJzBTIw6kH7im4cXXEQ7XzqAbLKQn63rjcvyYlxDWpzI2WlAdBKRqIj3vVLgw
/NKz0ClGx41W0aATVceOIWVBNLFf4XQ2qMqOQp//K35TFkBOk63MOwaOjCxYZ+Lk
V6rRA1bYofnxBTMytXVbnJfDjwAAVeVrOITkQPDR4qPvJOY40xg=
=W+4R
-----END PGP SIGNATURE-----

--6ml3nrfyv2c4gred--
