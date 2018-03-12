Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeCLOMN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:12:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45459 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCLOMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:12:10 -0400
X-Google-Smtp-Source: AG47ELsXCX7PfOSFN4H2jGVijZeUkOrujUYk/jJCVaE1V6iddxTJTsqtS0oqoL43Zsd6Ax1Wh6APdw==
Date: Mon, 12 Mar 2018 14:12:07 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/3] mfd: rave-sp: Convert print_hex_dump() to
 print_hex_dump_debug()
Message-ID: <20180312141207.gi3oph5icxsbsbpb@dell>
References: <20180308173756.13787-1-andrew.smirnov@gmail.com>
 <20180308173756.13787-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180308173756.13787-2-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Mar 2018, Andrey Smirnov wrote:

> Convert print_hex_dump() to print_hex_dump_debug() to be able to
> leverage CONFIG_DYNAMIC_DEBUG.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/mfd/rave-sp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
