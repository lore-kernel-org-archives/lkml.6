Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CF0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E731C20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E731C20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388610AbeGXJr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:47:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51461 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388406AbeGXJr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:47:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F328C20756; Tue, 24 Jul 2018 10:42:02 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id BF7EB207B0;
        Tue, 24 Jul 2018 10:41:52 +0200 (CEST)
Date:   Tue, 24 Jul 2018 10:41:53 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Corentin Labbe <clabbe@baylibre.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/5] dt-bindings: sunxi-sram: add binding for Allwinner
 H6 SRAM C
Message-ID: <20180724084153.in6jl5mi3x4f3y3a@flea>
References: <20180722053955.25266-1-icenowy@aosc.io>
 <20180722053955.25266-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wo2rk2ph6hkxnnma"
Content-Disposition: inline
In-Reply-To: <20180722053955.25266-3-icenowy@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wo2rk2ph6hkxnnma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2018 at 01:39:52PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC's DE3 needs the SRAM C section being claimed in the
> system controller to work, like A64 DE2.
>=20
> As H6 and A64 system controller are quite similar, code is reused now,
> and the A64 fallback compatible string is added after the H6 compatible
> string.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Docu=
mentation/devicetree/bindings/sram/sunxi-sram.txt
> index c51ade86578c..6527a1a535a3 100644
> --- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> +++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
> @@ -18,6 +18,7 @@ Required properties:
>      - "allwinner,sun8i-h3-system-control"
>      - "allwinner,sun50i-a64-sram-controller" (deprecated)
>      - "allwinner,sun50i-a64-system-control"
> +    - "allwinner,sun50i-h6-system-contorl", "allwinner,sun50i-a64-system=
-control"

                                     ^ control

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--wo2rk2ph6hkxnnma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltW5lAACgkQ0rTAlCFN
r3QzDg//QtbQnbZgD4h0POPamB+swglhORB8iohiZr26+NGQ+g2ewCzA3oOSUR87
SHfNrgNDM1rPK58OH0ydIkrPb46rscHKC0DJNron1VKFL0NdzoJw4DZS1K8/bhiZ
F2TjhQr5eIP/fnavCwsLUN2bIuA7RiGubPzno6z9XrTwjqY6y9+0MHeC+gtCIRtC
zk6KwALFRbSk4U+5dlmp9oaUJHqF7OrpMJXir7NDZM/o7zz4jN/UljGMIXHUkK16
g1HY+2ROnvq1zSq5G8bO8GVBvhXQdI7R0rZ+1hF0WVgIl77QPMZkxDpIpBs2eeMn
EDW6sD8nmxnyjrI8s1vjodOuXtwtxPW16Q4auu6XRlLbWayS1PfJjU4S08qj5c97
NbL7dA4JDtiXp9Wei90gLfXF/zUocUL8p0aIuUrvbL8prFrVaDYOjGuoypmka7ma
VqkNIeHt75OIp3qoJ4j4n857F5tDH9qCvlIP7PrScMNMygO+DWApxKFNCREJgsd9
PdE5tdFEPjBozMPDg/TwI1MeXjggxHXjK1fPB1rKBZE6AcLYH6NiHj6fxByjAPo3
VHP1WKREK9CL2HLvlMXJULdYJRf/G8L3etNKwyRSXgK9ZOGngPORwOLLc+T31E/H
prxHlpUSRCa3zpXOhcaG17bLKi0+5g/dWQ3rsX2gKOv/FsOfcoA=
=MZIC
-----END PGP SIGNATURE-----

--wo2rk2ph6hkxnnma--
