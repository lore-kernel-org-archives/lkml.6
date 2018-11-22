Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4674BC04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F50F20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F50F20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393132AbeKVTSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:18:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46680 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbeKVTSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:18:01 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3173520DC4; Thu, 22 Nov 2018 09:39:32 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5DC4F20DB0;
        Thu, 22 Nov 2018 09:38:53 +0100 (CET)
Date:   Thu, 22 Nov 2018 09:38:53 +0100
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
Subject: Re: [RFC PATCH v3 11/17] clk: sunxi-ng: add support for suniv
 F1C100s SoC
Message-ID: <20181122083853.3xsuhnrnzbhviihs@flea>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <07f02fdac83c27d208aba1c6537d051df651778e.1542824904.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vssvjjkz3kz2nsp"
Content-Disposition: inline
In-Reply-To: <07f02fdac83c27d208aba1c6537d051df651778e.1542824904.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vssvjjkz3kz2nsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 09:30:44PM +0300, Mesih Kilinc wrote:
> The suniv F1C100s SoC (the chip in some new F-series products of
> Allwinner)
> has a CCU which seems to be a stripped version of the CCU in SoCs after
> sun6i.
>=20
> Add support for the CCU.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5vssvjjkz3kz2nsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/ZrHQAKCRDj7w1vZxhR
xZJ8AP0WpdwJT1omwwNNnwcnvkeNu4tBVRaYto7E6KpzpmXBAAD7B2/N7A4r+1/3
t2kJ4CAXBBm+LerY0q/6BTeYz0VUYAU=
=HRDG
-----END PGP SIGNATURE-----

--5vssvjjkz3kz2nsp--
