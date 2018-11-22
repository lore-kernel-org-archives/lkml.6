Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC10C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F0A20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F0A20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393163AbeKVTSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:18:09 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46725 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbeKVTSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:18:08 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 07AEA20DE4; Thu, 22 Nov 2018 09:39:40 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id C97252072F;
        Thu, 22 Nov 2018 09:39:29 +0100 (CET)
Date:   Thu, 22 Nov 2018 09:39:29 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH v3 13/17] SoC: sunxi: Add support for Allwinner ARMv5
 F1C100s sram
Message-ID: <20181122083929.rauqn2tckn2tegpc@flea>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <89f6179c17a98f160301fdeef27df35b359847e3.1542824904.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3rzw5xqqthqxr4a2"
Content-Disposition: inline
In-Reply-To: <89f6179c17a98f160301fdeef27df35b359847e3.1542824904.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3rzw5xqqthqxr4a2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 09:30:46PM +0300, Mesih Kilinc wrote:
> Allwinner ARMv5 F1C100s has similar sram controller to sun4i A10
> Add compatible strings for it.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3rzw5xqqthqxr4a2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/ZrQQAKCRDj7w1vZxhR
xRY/AQCWm9YweFv/yc3hpAsemawEkBHp2B379jwrchaAzSDgGAEAwT6VMMuPe9Dz
dT2l+b51CRvaVlItlMk/DrIzIQKOFgw=
=o6OT
-----END PGP SIGNATURE-----

--3rzw5xqqthqxr4a2--
