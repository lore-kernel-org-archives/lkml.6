Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AF8C18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C909720851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C909720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeKTTUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:20:42 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50323 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeKTTUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:20:41 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9D26A2074F; Tue, 20 Nov 2018 09:52:39 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6F5A6206D8;
        Tue, 20 Nov 2018 09:52:29 +0100 (CET)
Date:   Tue, 20 Nov 2018 09:52:29 +0100
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
Subject: Re: [RFC PATCH v2 11/14] dt-bindings: clock: Add Allwinner suniv
 F1C100s CCU
Message-ID: <20181120085229.suf3affnix3d7bi2@flea>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
 <5f0322d5e37726f0c597b919f59e121f0b2855c3.1542546735.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x6dkfyopoy5uzc7a"
Content-Disposition: inline
In-Reply-To: <5f0322d5e37726f0c597b919f59e121f0b2855c3.1542546735.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x6dkfyopoy5uzc7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 18, 2018 at 05:17:10PM +0300, Mesih Kilinc wrote:
> Add compatiple string for Allwinner suniv F1C100s CCU.
> Add clock and reset definitions.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |  1 +
>  include/dt-bindings/clock/suniv-ccu-f1c100s.h      | 69 ++++++++++++++++=
++++++
>  include/dt-bindings/reset/suniv-ccu-f1c100s.h      | 37 ++++++++++++
>  3 files changed, 107 insertions(+)
>  create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
>  create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Docu=
mentation/devicetree/bindings/clock/sunxi-ccu.txt
> index 47d2e90..92c16eb 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> @@ -3,6 +3,7 @@ Allwinner Clock Control Unit Binding
> =20
>  Required properties :
>  - compatible: must contain one of the following compatibles:
> +		- "allwinner,suniv-f1c100s-ccu"

Letters come after the numbers in alphabetical order, so that should
be moved at the end of that list (and you have that issue in a couple
of other patches).

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--x6dkfyopoy5uzc7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/PLTQAKCRDj7w1vZxhR
xRW9AP4wogVwb2BGDjY1CIHtmXYM9Ryx+9n5D1NMV5/1Hriu9gD9H9JA5u6+33n+
rauUIyuNPoLKtlWELTd62XM03RwYwA0=
=qNcn
-----END PGP SIGNATURE-----

--x6dkfyopoy5uzc7a--
