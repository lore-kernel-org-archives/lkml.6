Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66BDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF38213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF38213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbeK0UrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:47:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33089 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729869AbeK0UrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:47:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 40638207A8; Tue, 27 Nov 2018 10:49:56 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0D0D820DD6;
        Tue, 27 Nov 2018 10:49:46 +0100 (CET)
Date:   Tue, 27 Nov 2018 10:49:46 +0100
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
Subject: Re: [RFC PATCH v4 07/17] irqchip/sun4i: Add support for Allwinner
 ARMv5 F1C100s
Message-ID: <20181127094946.zm4rzbscqc5okupl@flea>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <1f3cce09623052eaa90093f13ea9d13047a2b250.1543131714.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gsrcfvey53yqwqsi"
Content-Disposition: inline
In-Reply-To: <1f3cce09623052eaa90093f13ea9d13047a2b250.1543131714.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gsrcfvey53yqwqsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

65;5402;1c
On Sun, Nov 25, 2018 at 10:43:10AM +0300, Mesih Kilinc wrote:
> This patch adds support for suniv Allwinner ARMv5 F1C100s SoC which has
> stripped version of interrupt controller that found in A10/A13.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gsrcfvey53yqwqsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0TOgAKCRDj7w1vZxhR
xfmPAP0WpnCQ+cK5l/QXMbNIaf8Z7CrfjRI3tezRCBlHPyvAdAEA9yXNwrSb2aLF
2U4xtNEV4YUa3OZWCtraX7/VFVrPaQg=
=E2QK
-----END PGP SIGNATURE-----

--gsrcfvey53yqwqsi--
