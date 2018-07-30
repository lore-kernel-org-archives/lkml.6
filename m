Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E756A13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C20820893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C20820893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeG3KTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:19:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50109 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbeG3KTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:19:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 24B8F207AC; Mon, 30 Jul 2018 10:45:19 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id E610D20712;
        Mon, 30 Jul 2018 10:45:18 +0200 (CEST)
Date:   Mon, 30 Jul 2018 10:45:19 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Diego Rondini <diego.rondini@kynetics.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Jagan Teki <jteki@openedev.com>
Subject: Re: [PATCH] ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3
 support
Message-ID: <20180730084519.iqyhvocxsfuopze7@flea>
References: <20180727125739.22871-1-diego.rondini@kynetics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5k6awrech3twpden"
Content-Disposition: inline
In-Reply-To: <20180727125739.22871-1-diego.rondini@kynetics.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5k6awrech3twpden
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 02:57:39PM +0200, Diego Rondini wrote:
> +/dts-v1/;
> +
> +#include "sun8i-h3.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model =3D "OrangePi Zero Plus2 H3";
> +	compatible =3D "xunlong,orangepi-zero-plus2", "allwinner,sun8i-h3";

The H5 version doesn't make that easy, and it's unfortunate, but we
should have a different compatible for the H3 and H5 versions.

What about something like xunlong,orangepi-zero-plus2-h3?

> +&uart1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	status =3D "okay";
> +};

I guess it is the BT chip? Which chip is it?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--5k6awrech3twpden
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlte0B4ACgkQ0rTAlCFN
r3RUsw//XAW2TzGtAUTQAnxNUtQ0F2XjYNgy4BetgY1fO/ZFh01RV1yEelDFhXba
dSJA29WRhmMSvq4/dET5NqDixXPeg5higpqJiSEBDlBI5BsQ/J1V92NSfP3gz4DT
NW8HKZZO7B8eDyDfvDiL0FT8Ze34f37IrXTW+zOR5E/VcVKmOLLUNchz+eH1rhA2
QfjD0HVato0jcJVJJhiiatih2IAySqwumIOEUdWvNBSShJAj27UGDWSWHT62rrCu
8k/xoHVr3id0nvQ3t3vN2jHYlde3gIpyNlDHfym5xggD+zOb0+HOSuXYkeWliRZn
YblhjSr5MQ+klgEBeZ3n5SmLGemiEFaotMcAZB++qXT3NO6+GCZBqcxudWJEZ9DU
qvWAT5+Dd1+gTAF5zc8xftxGtucCo6zsAFYOx/iOpiBqM+pxLtdfGYT9dzK+C3XQ
kiXCWcY1ckxDE943+pQMIJQXZPTb+09f7IvoZwTM+x1aYUYuadNMWb3mhmCuPLzD
srufORl5KG4q2isp8Yr8Dvd2Fgimw+7g83R///Px0PUe/CH14b9Zx9GEKm9X4AbR
LYkIpNXPTnTQgsysdMoIH4RqEqetk5VKaV9X2XRUKFbeo3kTIdTMQWHGNTAgVbGe
fQ6Ckz9wINEgLJQcPPAolpVkls7kuE+TEBGmDORZ/GKotcghsYg=
=T3pi
-----END PGP SIGNATURE-----

--5k6awrech3twpden--
