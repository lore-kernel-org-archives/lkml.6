Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeERN1Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:27:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36092 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeERN1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:27:15 -0400
X-Google-Smtp-Source: AB8JxZqM/o505V7mg4ANh963wRLhZeTaISGJoju4iJ+yms6oTMxXIyfancuyUhIlG7CULG8y1GKjaQ==
Date: Fri, 18 May 2018 14:27:11 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH REPOST] mfd: syscon: atmel-smc: include string.h
Message-ID: <20180518132711.GM5130@dell>
References: <20180504103446.20104-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180504103446.20104-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 May 2018, Sebastian Andrzej Siewior wrote:

> The string.h header file is needed for the memset() definition. The RT
> build fails because it is not pulled in via other header files.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/mfd/atmel-smc.c |    1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
