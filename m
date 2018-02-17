Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeBQVVa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 16:21:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:55170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbeBQVV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 16:21:29 -0500
Subject: Re: [PATCH 10/10] MAINTAINERS: Add Actions Semi S900 pinctrl and gpio
 entries
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-11-manivannan.sadhasivam@linaro.org>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <9a7720b7-586e-8275-db41-19764e40f367@suse.de>
Date: Sat, 17 Feb 2018 22:21:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180217204433.3095-11-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.02.2018 um 21:44 schrieb Manivannan Sadhasivam:
> Add S900 pinctrl and gpio entries under ARCH_ACTIONS
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96b8b6531196..b718be5af680 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1126,11 +1126,15 @@ F:	arch/arm/boot/dts/owl-*
>  F:	arch/arm64/boot/dts/actions/
>  F:	drivers/clocksource/owl-*
>  F:	drivers/soc/actions/
> +F:	drivers/pinctrl/actions/*
> +F:	drivers/gpio/gpio-owl.c
>  F:	include/dt-bindings/power/owl-*
>  F:	include/linux/soc/actions/
>  F:	Documentation/devicetree/bindings/arm/actions.txt
>  F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
>  F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
> +F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
> +F:	Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt

Please retain alphabetical ordering.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
