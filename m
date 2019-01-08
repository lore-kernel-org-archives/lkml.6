Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4970C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DFB20645
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfAHSP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:15:56 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50452 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfAHSPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:15:55 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DF6772078F; Tue,  8 Jan 2019 19:15:53 +0100 (CET)
Received: from localhost (alyon-652-1-61-72.w109-213.abo.wanadoo.fr [109.213.84.72])
        by mail.bootlin.com (Postfix) with ESMTPSA id AB3112074F;
        Tue,  8 Jan 2019 19:15:53 +0100 (CET)
Date:   Tue, 8 Jan 2019 19:15:53 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Tudor.Ambarus@microchip.com
Cc:     Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-mtd@lists.infradead.org,
        broonie@kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: at91: at91-sama5d27_som1_ek: enable qspi1
 memory
Message-ID: <20190108181553.GG10218@piout.net>
References: <20181212163057.22183-1-tudor.ambarus@microchip.com>
 <20181212163057.22183-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212163057.22183-2-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2018 16:31:11+0000, Tudor.Ambarus@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Enable qspi1.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Note that this should have your SoB too as you are sending a patch that
is not from you.

> ---
>  arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> index 363a43d77424..73d16d98bf9c 100644
> --- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> @@ -109,6 +109,10 @@
>  				status = "okay";
>  			};
>  
> +			qspi1: spi@f0024000 {
> +				status = "okay";
> +			};
> +
>  			spi0: spi@f8000000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_spi0_default>;
> -- 
> 2.9.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
