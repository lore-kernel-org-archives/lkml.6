Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09F4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7648C2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7648C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeK3AXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:23:54 -0500
Received: from gloria.sntech.de ([185.11.138.130]:52936 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbeK3AXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:23:54 -0500
Received: from ip5f5a905a.dynamic.kabel-deutschland.de ([95.90.144.90] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gSMCi-0003Ql-47; Thu, 29 Nov 2018 14:18:04 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matheus Tavares <matheus.bernardino@usp.br>,
        Milo Kim <milo.kim@ti.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-usp@googlegroups.com,
        Lucas Santos <ilucas.ms@gmail.com>
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
Date:   Thu, 29 Nov 2018 14:18:03 +0100
Message-ID: <3999722.Y4omgby9AG@phil>
In-Reply-To: <20181128175312.9634-1-matheus.bernardino@usp.br>
References: <20181128175312.9634-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 28. November 2018, 18:53:12 CET schrieb Matheus Tavares:
> From: Lucas Santos <ilucas.ms@gmail.com>
> 
> This patch removes all license boilerplate texts from the .c and .h
> files at drivers/iio/adc/ and, instead, adds the proper SPDX license
> identifiers.
> 
> Signed-off-by: Lucas Santos <ilucas.ms@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---

> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 1f98566d5b3c..234c6df348ce 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -1,16 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Rockchip Successive Approximation Register (SAR) A/D Converter
>   * Copyright (C) 2014 ROCKCHIP, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/module.h>

For the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>


