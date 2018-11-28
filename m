Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221DAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B3121104
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B3121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeK2JXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:23:16 -0500
Received: from mleia.com ([178.79.152.223]:59294 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeK2JXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:23:16 -0500
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 7A99842D297;
        Wed, 28 Nov 2018 22:20:05 +0000 (GMT)
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
To:     Matheus Tavares <matheus.bernardino@usp.br>,
        Jonathan Cameron <jic23@kernel.org>,
        Lucas Santos <ilucas.ms@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Support Opensource <support.opensource@diasemi.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andreas Klinger <ak@it-klinger.de>, Milo Kim <milo.kim@ti.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-usp@googlegroups.com
References: <20181128175312.9634-1-matheus.bernardino@usp.br>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <ac2e8875-f4c8-70be-6ff6-9a7cbd3f3e46@mleia.com>
Date:   Thu, 29 Nov 2018 00:20:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181128175312.9634-1-matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20181128_222005_557926_FEC6EE06 
X-CRM114-Status: GOOD (  41.89  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/2018 07:53 PM, Matheus Tavares wrote:
> From: Lucas Santos <ilucas.ms@gmail.com>
> 
> This patch removes all license boilerplate texts from the .c and .h
> files at drivers/iio/adc/ and, instead, adds the proper SPDX license
> identifiers.
> 
> Signed-off-by: Lucas Santos <ilucas.ms@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

[snip]

> diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
> index 041dc4a3f66c..00d39234143d 100644
> --- a/drivers/iio/adc/lpc18xx_adc.c
> +++ b/drivers/iio/adc/lpc18xx_adc.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * IIO ADC driver for NXP LPC18xx ADC
>   *
>   * Copyright (C) 2016 Joachim Eastwood <manabian@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   * UNSUPPORTED hardware features:
>   *  - Hardware triggers
>   *  - Burst mode
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index 20b36690fa4f..e361c1532a75 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -1,23 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   *  lpc32xx_adc.c - Support for ADC in LPC32XX
>   *
>   *  3-channel, 10-bit ADC
>   *
>   *  Copyright (C) 2011, 2012 Roland Stigge <stigge@antcom.de>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
>  #include <linux/module.h>

For lpc18xx/lpc32xx:

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
