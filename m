Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E9BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356A4218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548868604;
	bh=Oatp8hHzMKUaCp26kUxlwj8i5yYQCiqot1zlvVr2AE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hc0iSOXsfJjq6zHDUltgiVyrTw3+vpRHpmKEfsXsUGZX2x6u/YNscGOSKJBQgdi6C
	 VEYwJBdrPTVL3vEp0WajrAJPwm0HS/wjlCG7eCeFggOE3/BE1UWj6c/B5+XorXt07d
	 885Sy2uAWmm2PNHUQnXhT7CFHRKmFCoYyWvXSEWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfA3RQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:16:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727680AbfA3RQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:16:42 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E4B2087F;
        Wed, 30 Jan 2019 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548868601;
        bh=Oatp8hHzMKUaCp26kUxlwj8i5yYQCiqot1zlvVr2AE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tCZqGIjcOgaTCj9ogJHGm3d7Ov8jJuPhwUZVJIaLsXpihDzQ2B1+qclis+/W1wkNe
         lpwadyRvoU96DWncXa/btn+bIp9ebgahJVKysWxslc/yDKJnt2OvHzFOXJbLfymFJF
         HPw51pP9OkpBWSh/l0/h0NVnoc6IzL8U3wVshOTY=
Date:   Wed, 30 Jan 2019 18:16:32 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/9] spi: atmel-quadspi: order header files inclusion
 alphabetically
Message-ID: <20190130181616.175206b8@bbrezillon>
In-Reply-To: <20190130150818.24902-3-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-3-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 15:08:31 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Cosmetic change, no functional change.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.com>

> ---
>  drivers/spi/atmel-quadspi.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index f79b17792a11..64475ad16c83 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -22,16 +22,15 @@
>   * This driver is based on drivers/mtd/spi-nor/fsl-quadspi.c from Freescale.
>   */
>  
> -#include <linux/kernel.h>
>  #include <linux/clk.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> -#include <linux/of.h>
> -
>  #include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/spi/spi-mem.h>
>  
>  /* QSPI register offsets */

