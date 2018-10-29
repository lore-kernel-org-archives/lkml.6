Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDACAC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FBD2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FBD2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbeJ2Q71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:59:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53223 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeJ2Q71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:59:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A8ED8208AF; Mon, 29 Oct 2018 09:11:51 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7DCE520728;
        Mon, 29 Oct 2018 09:11:51 +0100 (CET)
Date:   Mon, 29 Oct 2018 09:11:52 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2] arm64: defconfig: Enable MFD_AXP20X_I2C
Message-ID: <20181029081151.pvx5mrvngzv26agg@flea>
References: <20181025150659.19657-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c7qtxypgasbdtf2m"
Content-Disposition: inline
In-Reply-To: <20181025150659.19657-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c7qtxypgasbdtf2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2018 at 08:36:59PM +0530, Jagan Teki wrote:
> The Allwinner H6 SoC is paired with the X-Powers AXP805 PMIC
> connected via I2C.
>=20
> Enable the driver for this PMIC.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Tested-by: Jagan Teki <jagan@amarulasolutions.com> # OPI-1+

Queued for 4.21

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--c7qtxypgasbdtf2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9bAxwAKCRDj7w1vZxhR
xcY5AP45eopqSnh6XzZ6lpLdUkSkkuYYAtlIrtcnKTCGv+UN7AD/ch8YSIMEVrq2
B9HwoaVTv7SVwzztU96CAcoNr/C3HwY=
=JqqN
-----END PGP SIGNATURE-----

--c7qtxypgasbdtf2m--
