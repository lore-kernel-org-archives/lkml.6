Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD337C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AAB2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbfAaMdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:33:20 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62331 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfAaMdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:33:20 -0500
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; 
   d="scan'208";a="24062346"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 05:33:19 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Thu, 31 Jan 2019
 05:33:18 -0700
Date:   Thu, 31 Jan 2019 13:33:10 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Message-ID: <20190131123310.wwikkuiniqlcg445@M43218.corp.atmel.com>
Mail-Followup-To: Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
 <1548937733-20189-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1548937733-20189-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 01:29:33PM +0100, Claudiu Beznea - M18063 wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add compatibles for SAM9X60 pin controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/pinctrl/pinctrl-at91.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 46443b97d811..5456a2692b8c 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1215,6 +1215,7 @@ static const struct of_device_id at91_pinctrl_of_match[] = {
>  	{ .compatible = "atmel,sama5d3-pinctrl", .data = &sama5d3_ops },
>  	{ .compatible = "atmel,at91sam9x5-pinctrl", .data = &at91sam9x5_ops },
>  	{ .compatible = "atmel,at91rm9200-pinctrl", .data = &at91rm9200_ops },
> +	{ .compatible = "microchip,sam9x60-pictrl", .data = &sam9x60_ops },

Typo s/microchip,sam9x60-pictrl/microchip,sam9x60-pinctrl

>  	{ /* sentinel */ }
>  };
>  
> @@ -1757,6 +1758,7 @@ static const struct gpio_chip at91_gpio_template = {
>  static const struct of_device_id at91_gpio_of_match[] = {
>  	{ .compatible = "atmel,at91sam9x5-gpio", .data = &at91sam9x5_ops, },
>  	{ .compatible = "atmel,at91rm9200-gpio", .data = &at91rm9200_ops },
> +	{ .compatible = "microchip,sam9x60-gpio", .data = &sam9x60_ops },
>  	{ /* sentinel */ }
>  };
>  
> -- 
> 2.7.4
> 
