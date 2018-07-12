Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDCFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68C220C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68C220C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbeGLGji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:39:38 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:61680 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbeGLGji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:39:38 -0400
X-IronPort-AV: E=Sophos;i="5.51,341,1526367600"; 
   d="scan'208";a="16228515"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Jul 2018 23:31:31 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Wed, 11 Jul 2018
 23:31:30 -0700
Date:   Thu, 12 Jul 2018 08:30:21 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: fix typo for PIN_PB22
Message-ID: <20180712063021.h7t424iksdulj74a@M43218.corp.atmel.com>
References: <1531326337-15504-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1531326337-15504-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Wed, Jul 11, 2018 at 07:25:37PM +0300, Claudiu Beznea wrote:
> Fix typo for PIN_PB22 on TD function.

In fact, this typo is present in several places in this file. It could
be worth fixing all those occurences in a single patch.

Regards

Ludovic

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/boot/dts/sama5d2-pinfunc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d2-pinfunc.h b/arch/arm/boot/dts/sama5d2-pinfunc.h
> index e57191fb83de..ac61491c9d7f 100644
> --- a/arch/arm/boot/dts/sama5d2-pinfunc.h
> +++ b/arch/arm/boot/dts/sama5d2-pinfunc.h
> @@ -375,7 +375,7 @@
>  #define PIN_PB22__GPIO			PINMUX_PIN(PIN_PB22, 0, 0)
>  #define PIN_PB22__LCDDAT11		PINMUX_PIN(PIN_PB22, 1, 1)
>  #define PIN_PB22__A11			PINMUX_PIN(PIN_PB22, 2, 1)
> -#define PIN_PB22__TDO			PINMUX_PIN(PIN_PB22, 3, 1)
> +#define PIN_PB22__TD0			PINMUX_PIN(PIN_PB22, 3, 1)
>  #define PIN_PB22__TIOA2			PINMUX_PIN(PIN_PB22, 4, 2)
>  #define PIN_PB22__FLEXCOM3_IO1		PINMUX_PIN(PIN_PB22, 5, 3)
>  #define PIN_PB22__GMDC			PINMUX_PIN(PIN_PB22, 6, 3)
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
