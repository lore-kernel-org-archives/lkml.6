Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BF4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06D52243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06D52243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbeKMXIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:08:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52096 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732728AbeKMXIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:08:53 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9A9B0207BB; Tue, 13 Nov 2018 14:10:46 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 46C8A206A7;
        Tue, 13 Nov 2018 14:10:46 +0100 (CET)
Date:   Tue, 13 Nov 2018 14:10:46 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: mali-utgard: Add compatible for
 A64 Mali
Message-ID: <20181113131046.lh3h66sq5z47imw3@flea>
References: <20181113120054.17639-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="byukk266anelispr"
Content-Disposition: inline
In-Reply-To: <20181113120054.17639-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--byukk266anelispr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 05:30:53PM +0530, Jagan Teki wrote:
> Allwinner A64 has Mali-400MP2, so document the relevant compatible
> as "allwinner,sun50i-a64-mali"
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - New patch, separated from previous version patch.
>=20
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/=
Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> index 63cd91176a68..a0ee62a5b221 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> @@ -11,6 +11,7 @@ Required properties:
>        + allwinner,sun4i-a10-mali
>        + allwinner,sun7i-a20-mali
>        + allwinner,sun8i-h3-mali
> +      + allwinner,sun50i-a64-mali

It uses a reset property, so that must be documented as well later in
that file.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--byukk266anelispr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+rNVgAKCRDj7w1vZxhR
xR0LAQCLr/r/+MylFdUKrYK5g+qrx1CZ6KdnE85voJRnAIujDQD/VaomA1PuzP8W
ngF87X9x/RjROsetw+qVWa2bgj+eJQY=
=GbSh
-----END PGP SIGNATURE-----

--byukk266anelispr--
