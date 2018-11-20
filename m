Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A909C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD0F2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD0F2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeKTTMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:12:10 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50057 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKTTMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:12:10 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6F23D2074F; Tue, 20 Nov 2018 09:44:10 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3CD7120745;
        Tue, 20 Nov 2018 09:44:00 +0100 (CET)
Date:   Tue, 20 Nov 2018 09:44:00 +0100
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
Subject: Re: [RFC PATCH v2 04/14] dt-bindings: interrupt-controller: Add
 suniv interrupt-controller
Message-ID: <20181120084400.sn64fdxbpztaw26h@flea>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
 <e51824832fac0b981cf886f25efc25056d573da4.1542546735.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="agvmzaobxgm2oakk"
Content-Disposition: inline
In-Reply-To: <e51824832fac0b981cf886f25efc25056d573da4.1542546735.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--agvmzaobxgm2oakk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 18, 2018 at 05:17:03PM +0300, Mesih Kilinc wrote:
> Add compatible string for Alwinner suniv F1C100s SoC interrupt
> controller which is stripped version of sun4i
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  .../devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt  | 5=
 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwi=
nner,sun4i-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/=
allwinner,sun4i-ic.txt
> index b290ca1..e04ddb4 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,su=
n4i-ic.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,su=
n4i-ic.txt
> @@ -2,7 +2,10 @@ Allwinner Sunxi Interrupt Controller
> =20
>  Required properties:
> =20
> -- compatible : should be "allwinner,sun4i-a10-ic"
> +- compatible: should be "allwinner,<soc-familiy>-<soc-name>-ic" to ident=
ify

There's no need to define the pattern, just list the compatibles
supported. Otherwise, you give the idea that all the combinations are
supported, and they aren't.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--agvmzaobxgm2oakk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/PJUAAKCRDj7w1vZxhR
xYy1AP9t6baRTZppEHnHo3CNEkUWw0bn0lRDUU1SoXn1EA5YRgEA391BzYi+M0ZM
7i066sImaE+EFjYnQtd5+hySOGA64g8=
=/Ogu
-----END PGP SIGNATURE-----

--agvmzaobxgm2oakk--
