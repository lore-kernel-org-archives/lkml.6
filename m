Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF21C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EF720833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EF720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeIJTS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:18:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41909 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbeIJTS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:18:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 340B4207B0; Mon, 10 Sep 2018 16:24:06 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id E47252074F;
        Mon, 10 Sep 2018 16:23:55 +0200 (CEST)
Date:   Mon, 10 Sep 2018 16:23:54 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/5] ARM: sun8i: dts: drop A64 HDMI PHY fallback
 compatible from R40 DT
Message-ID: <20180910142354.5ldexkvnan6ohz4x@flea>
References: <20180907072234.48282-1-icenowy@aosc.io>
 <20180907072234.48282-6-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="25znzmfo6omd7fkm"
Content-Disposition: inline
In-Reply-To: <20180907072234.48282-6-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--25znzmfo6omd7fkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 03:22:34PM +0800, Icenowy Zheng wrote:
> The R40 HDMI PHY seems to be different to the A64 one, the A64 one
> has no input mux, but the R40 one has.
>=20
> Drop the A64 fallback compatible from the HDMI PHY node in R40 DT.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r=
40.dtsi
> index ffd9f00f74a4..5f547c161baf 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -800,8 +800,7 @@
>  		};
> =20
>  		hdmi_phy: hdmi-phy@1ef0000 {
> -			compatible =3D "allwinner,sun8i-r40-hdmi-phy",
> -				     "allwinner,sun50i-a64-hdmi-phy";
> +			compatible =3D "allwinner,sun8i-r40-hdmi-phy";

If you could use the A64 phy before, you can still use it now.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--25znzmfo6omd7fkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluWfnoACgkQ0rTAlCFN
r3QMGg/+JNcdN0iDoL7IleXz8P7+l/i0IpRNNF5lRSWudciBbnAPIecC9ZG6Ly3f
pbH0l9Py6hxZo8v042S6VRklPYINbbncb0TIyLASx2HreGIBQE1OTKxbCnpbqgcX
46nr4IKIWLOyoBA6ALbimfyD/yy+xEaVmSz4nntmeDPEZOGl0feo4vISZ9aY5NPx
B5iPXPR5xjfV5XfKjdeMrGd5uTi+DJ9WCXIOvWaMz6sC9Ixi8JcUyU1trjz/VLRD
CVIsHyzpxDuMniOPYBnWd2OiRZKWkuaZ9WTh+bRPyyfVHZf9Ic5Y7NXPa5W6qvFN
jJEtOyW2KS9arujySir1IvvqPFntV09S/AmrZMVK4Vlz/Ytwrth20apT3ZT0lMiD
j2uYHTBnX+YzUfJSaGle+mA55mw/P14vzNVTUeY4gvF+UXgMtdOAS9Tgkfb4Hzak
mq+YRkFhYGopNWOYjZpgCawzrJM3OfqG645fyZdHGufTfr6rfcxDnPLm5Q+yHLNH
OB9zUCnfBZEl53sjmbZWP1bCirFAzAEiyHT1AVVqzK8e/310HaUua+KtRIQrFMc5
MFQHCcbBtjkfLaxDTda3GimPO77btaMelp5nDE+zm017fo1Lr9Rd9mU7hsKfiUFv
xxz1DwgkJ/kcJT/pEf1inN+BK+87GM6fwxBfheGpQ8cMET6Dgk8=
=QZDp
-----END PGP SIGNATURE-----

--25znzmfo6omd7fkm--
