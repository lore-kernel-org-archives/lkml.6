Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3rrpJSyXHlvkOwAAmS7hNA
	; Mon, 11 Jun 2018 15:38:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E2DDA60850; Mon, 11 Jun 2018 15:38:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6967F60791;
	Mon, 11 Jun 2018 15:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6967F60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932948AbeFKPiQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:38:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55292 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932433AbeFKPiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:38:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 82A7F20702; Mon, 11 Jun 2018 17:38:12 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 85FF6203D9;
        Mon, 11 Jun 2018 17:37:57 +0200 (CEST)
Date: Mon, 11 Jun 2018 17:37:58 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: broonie@kernel.org, nicolas.ferre@microchip.com,
        lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, gregkh@linuxfoundation.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 2/6] dt-bindings: add binding for atmel-usart in SPI
 mode
Message-ID: <20180611153758.GH10521@piout.net>
References: <20180607110020.20565-1-radu.pirea@microchip.com>
 <20180607110020.20565-3-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607110020.20565-3-radu.pirea@microchip.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/06/2018 14:00:16+0300, Radu Pirea wrote:
> diff --git a/include/dt-bindings/mfd/at91-usart.h b/include/dt-bindings/mfd/at91-usart.h
> new file mode 100644
> index 000000000000..ac811628a42d
> --- /dev/null
> +++ b/include/dt-bindings/mfd/at91-usart.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides macros for AT91 USART DT bindings.
> + *
> + * Copyright (C) 2018 Microchip Technology
> + *
> + * Author: Radu Pirea <radu.pirea@microchip.com>
> + *
> + */
> +
> +#ifndef __DT_BINDINGS_AT91_USART_H__
> +#define __DT_BINDINGS_AT91_USART_H__
> +
> +#define AT91_USART_MODE_SERIAL	1
> +#define AT91_USART_MODE_SPI	2
> +

Nitpick, I'd make that 0 and 1 instead of 1 and 2. That would feel more
natural to me regarding the default value.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
