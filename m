Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932356AbeCLOM0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:12:26 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:45337 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751322AbeCLOMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:12:24 -0400
X-Google-Smtp-Source: AG47ELsQ3DJK3nU3uo8ikj4psHLGdxMJNouL24ss0LmOFR7s6o9y1LftdTajc9E5u6MHo4Fml/t9BQ==
Date: Mon, 12 Mar 2018 14:12:21 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 3/3] mfd: rave-sp: Check received frame length before
 accepting next byte
Message-ID: <20180312141221.st253a7tfgmrzr7x@dell>
References: <20180308173756.13787-1-andrew.smirnov@gmail.com>
 <20180308173756.13787-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180308173756.13787-3-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Mar 2018, Andrey Smirnov wrote:

> Check received frame length _before_ accepting next byte in order to
> avoid incorrectly rejecting payloads that are RAVE_SP_RX_BUFFER_SIZE
> long.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/mfd/rave-sp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
