Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70798C18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC2720C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC2720C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeKTTZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:25:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50425 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeKTTZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:25:06 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F3B1420D31; Tue, 20 Nov 2018 09:57:02 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id C73FD2074F;
        Tue, 20 Nov 2018 09:56:52 +0100 (CET)
Date:   Tue, 20 Nov 2018 09:56:52 +0100
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
Subject: Re: [RFC PATCH v2 00/14] initial support for "suniv" Allwinner new
 ARM9 SoC
Message-ID: <20181120085652.3hqmyofxaknoq7an@flea>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ofcvkfm5ig7h33mb"
Content-Disposition: inline
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ofcvkfm5ig7h33mb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 18, 2018 at 05:16:59PM +0300, Mesih Kilinc wrote:
> This is the second version of RFC patchset for Allwinner ARMv5 F1C100s
> SoC. Icenowy (author of the initial patchset) allowed me to continue.
> For patch 1~3 which introduces first ARMv5 Allwinner SoC I looked=20
> freescale,imx configs and tried to organize patches better.=20
> Addressed comment from Maxime Ripard and added SoC name to
> compatibles and filenames.=20
> Addressed comment from Rob Herring and added dt-bindings.
>=20
> This is my first patch. Sorry for any inconvenience :-)

Apart from the minor comments you'll find with each patches, you did
great :)

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ofcvkfm5ig7h33mb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/PMVAAKCRDj7w1vZxhR
xRx7AQCtoduqkwO04y3fuxH4Yt6MutflOJlPcEI7AKULiW03NAD/VXbhFZfCT0Yl
RqIRQ+3HWAovFQQdiWhfN8+rBbnJkAs=
=OruB
-----END PGP SIGNATURE-----

--ofcvkfm5ig7h33mb--
