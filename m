Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0D0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77D220854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77D220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeKES0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:26:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57624 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKES0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:26:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 282E7208B1; Mon,  5 Nov 2018 10:07:42 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id EA31720884;
        Mon,  5 Nov 2018 10:07:31 +0100 (CET)
Date:   Mon, 5 Nov 2018 10:07:31 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Lothar Felten <lothar.felten@gmail.com>
Cc:     linux-sunxi@googlegroups.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org
Subject: Re: [PATCH v3] ARM: dtsi: sun8i-r40: add mali node
Message-ID: <20181105090731.vkcdwde5zmkxjzmc@flea>
References: <20181101085710.15774-1-lothar.felten@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hmehpeleewvssyd5"
Content-Disposition: inline
In-Reply-To: <20181101085710.15774-1-lothar.felten@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hmehpeleewvssyd5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,x

On Thu, Nov 01, 2018 at 09:57:10AM +0100, Lothar Felten wrote:
> This patch adds a node for the mali 400 GPU of the R40/V40 SoC
>=20
> Signed-off-by: Lothar Felten <lothar.felten@gmail.com>
> ---
> Changes v2->v3:
> - remove mali clock rates
> - drop hdmi-phy sun50i-a64 compatibility =20
> - patch version, change log added
>=20
> Changes v1->v2:
> - commit message uppercase ARM prefix
> - wrong patch submitted by mistake
> ---
>=20
>  arch/arm/boot/dts/sun8i-r40.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r=
40.dtsi
> index 6f4c9ca5a3ee..136c248cc7d1 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -542,6 +542,28 @@
> =20
>  		};
> =20
> +		mali: gpu@1c40000 {
> +			compatible =3D "allwinner,sun7i-a20-mali", "arm,mali-400";

You should have an r40 compatible here. You can have a look at the
A23-A33 DTSI compatible for an example if you want.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hmehpeleewvssyd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+AIUwAKCRDj7w1vZxhR
xYZBAQDwqi7FxeVxHfJkU5LXXIvrmcdULrYcrOAveJR3DGvjwwEAngeAhZgPANMb
RXwoBpMoM/q0aSYqcEwNv8IT2K1VeQA=
=Jepv
-----END PGP SIGNATURE-----

--hmehpeleewvssyd5--
