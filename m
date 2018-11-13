Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96E0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B0E22360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B0E22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbeKMS5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:57:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41380 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730924AbeKMS5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:57:44 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9377020714; Tue, 13 Nov 2018 10:00:34 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 610732039F;
        Tue, 13 Nov 2018 10:00:24 +0100 (CET)
Date:   Tue, 13 Nov 2018 10:00:24 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add mali node
Message-ID: <20181113090024.puzll77rx5dylnhf@flea>
References: <20181111121811.21638-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dflgs3elxdgqizus"
Content-Disposition: inline
In-Reply-To: <20181111121811.21638-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dflgs3elxdgqizus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Sun, Nov 11, 2018 at 01:18:11PM +0100, Jernej Skrabec wrote:
> A64 has Mali400 MP2 GPU. Add a node for it.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  This node and A64 GPU binary driver was tested with Kodi on LibreELEC.
>=20
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index f3a66f888205..48cc5451d0eb 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -753,6 +753,28 @@
>  			#size-cells =3D <0>;
>  		};
> =20
> +		mali: gpu@1c40000 {
> +			compatible =3D "allwinner,sun50i-a64-mali",
> +				     "arm,mali-400";

You should document that new compatible string. The patch looks good
otherwise, thanks!

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dflgs3elxdgqizus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+qSqAAKCRDj7w1vZxhR
xd5LAP9sPAyqmGLxfpUXrUL3/59yFZ5XKnj1mYcmKVOqQwHjoQD+IZGSL8LTxu4r
Nle/BpHo/axKq4lQJdeMNgQg9zthAw0=
=hg8i
-----END PGP SIGNATURE-----

--dflgs3elxdgqizus--
