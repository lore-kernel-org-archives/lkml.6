Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FDEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848DA20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848DA20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbeLCI71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:59:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52286 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbeLCI71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:59:27 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 211A020787; Mon,  3 Dec 2018 09:59:19 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id C64B220D29;
        Mon,  3 Dec 2018 09:58:41 +0100 (CET)
Date:   Mon, 3 Dec 2018 09:58:42 +0100
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
Subject: Re: [PATCH v6 15/17] dt-bindings: watchdog: Add Allwinner ARMv5
 F1C100s wdt
Message-ID: <20181203085842.mpst2t73znwgtudf@flea>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
 <fb0c64319cbb5c2b062844ff38aba7b7323eefcb.1543781680.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m4fvvd6pyti6fryv"
Content-Disposition: inline
In-Reply-To: <fb0c64319cbb5c2b062844ff38aba7b7323eefcb.1543781680.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m4fvvd6pyti6fryv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 02, 2018 at 11:23:49PM +0300, Mesih Kilinc wrote:
> Allwinner ARMv5 F1C100s has similar watchdog timer to sun6i A31.
> Add definition for it.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--m4fvvd6pyti6fryv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXATwQQAKCRDj7w1vZxhR
xeQrAQDOLgvsA+9wOnSnJHYIPQjgKwNdKEkrtH3DS2a9HLyiMwD9H2tTE3CQrVCb
ZM5QBhAlTvweB6Ucm3JPB1Q0XVMGdgw=
=Uykn
-----END PGP SIGNATURE-----

--m4fvvd6pyti6fryv--
