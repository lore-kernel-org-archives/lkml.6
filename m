Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8D6C04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2623A20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2623A20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393117AbeKVTP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:15:58 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46273 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbeKVTP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:15:57 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6773320F8D; Thu, 22 Nov 2018 09:37:29 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3A10B20DD1;
        Thu, 22 Nov 2018 09:36:59 +0100 (CET)
Date:   Thu, 22 Nov 2018 09:36:59 +0100
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
Subject: Re: [RFC PATCH v3 09/17] pinctrl: sunxi: add support for suniv
 F1C100s (newer F-series SoCs)
Message-ID: <20181122083659.qajcd4w3azcdpn5y@flea>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <fc20d96f5531d7d1eb5ce3d5cf920c8bf59cad58.1542824904.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hpm4q25bdgcwew2c"
Content-Disposition: inline
In-Reply-To: <fc20d96f5531d7d1eb5ce3d5cf920c8bf59cad58.1542824904.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hpm4q25bdgcwew2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 09:30:42PM +0300, Mesih Kilinc wrote:
> The suniv F1C100s chip (several new F-series SoCs) of Allwinner has a
> pin
> controller like other SoCs from Allwinner.
>=20
> Add support for it.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hpm4q25bdgcwew2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/ZqqwAKCRDj7w1vZxhR
xSIfAP9xXLhNdoLlPQOH4gYEtizpIVsI+3mtOk2EYWgVlv/a/gD+PH52Yb08p/5K
JGel1LxBWeOwyGw7Tft9FDg56pQcjgs=
=b61W
-----END PGP SIGNATURE-----

--hpm4q25bdgcwew2c--
