Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0038AC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5AF20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="LSuNPn19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfAQMBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:01:37 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:60813 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfAQMBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:01:36 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id D581025B760;
        Thu, 17 Jan 2019 23:01:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1547726491; bh=ruO83q8hxHJPFPBe8ARuOetb0LH4VO1rcbBXKkUkhoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSuNPn1936n1B55LUqi84bmAQWPc/piETE0uNpiB1thlPqDnf60WP/pcnedzMoWaC
         yfxiaqmXiVgvD4kx+ubhrML+85QR9tWK78FhjWE/UUbxRIuJvAwOeC5cZhxiSoWx37
         mfCMuqIo21iIcNap/eWdAJyFbwX8YApdq9KW6ldk=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 45739940459; Thu, 17 Jan 2019 13:01:29 +0100 (CET)
Date:   Thu, 17 Jan 2019 13:01:29 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Lukasz Majewski <lukma@denx.de>,
        Michal Simek <monstr@monstr.eu>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-clk@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        linux-kernel@vger.kernel.org, ebiharaml@si-linux.co.jp
Subject: Re: [PATCH 09/11] dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
Message-ID: <20190117120128.arjdug2mhqyuvq3k@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-10-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547663874-29411-10-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 06:37:52PM +0000, Fabrizio Castro wrote:
> According to the latest information, the clock options for CAN on RZ/G2
> are the same as the ones available on R-Car Gen3

I'm taking your word for the above.
As the patch matches the description:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> Fixes: 868b7c0f43e6 ("dt-bindings: can: rcar_can: Add r8a774a1 support")
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> index 7fcf501..b463e12 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -28,13 +28,8 @@ Required properties:
>  
>  - reg: physical base address and size of the R-Car CAN register map.
>  - interrupts: interrupt specifier for the sole interrupt.
> -- clocks: phandles and clock specifiers for 2 CAN clock inputs for RZ/G2
> -	  devices.
> -	  phandles and clock specifiers for 3 CAN clock inputs for every other
> -	  SoC.
> -- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
> -	       3 clock input name strings for every other SoC: "clkp1", "clkp2",
> -	       "can_clk".
> +- clocks: phandles and clock specifiers for 3 CAN clock inputs.
> +- clock-names: 3 clock input name strings: "clkp1", "clkp2", and "can_clk".
>  - pinctrl-0: pin control group to be used for this controller.
>  - pinctrl-names: must be "default".
>  
> @@ -50,8 +45,7 @@ using the below properties:
>  Optional properties:
>  - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values are:
>  			    <0x0> (default) : Peripheral clock (clkp1)
> -			    <0x1> : Peripheral clock (clkp2) (not supported by
> -				    RZ/G2 devices)
> +			    <0x1> : Peripheral clock (clkp2)
>  			    <0x3> : External input clock
>  
>  Example
> -- 
> 2.7.4
> 
