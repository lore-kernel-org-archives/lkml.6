Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeBKD4b (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 22:56:31 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43601 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbeBKD43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 22:56:29 -0500
X-Google-Smtp-Source: AH8x224p3tH4L+FJzWd6GlnOIumt0bNiv9uFJaZoHJzSO3ODyxEl0K5D6QSVsckFSUKnTkWFDICrUQ==
Subject: Re: [PATCH 4/4] watchdog: lpc18xx: remove assignment of unused
 ret-value
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Joachim Eastwood <manabian@gmail.com>
Cc: linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180210203623.17832-1-marcus.folkesson@gmail.com>
 <20180210203623.17832-4-marcus.folkesson@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <55a198d0-3d58-52e5-0304-5212d7ba5dca@roeck-us.net>
Date: Sat, 10 Feb 2018 19:56:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180210203623.17832-4-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 12:36 PM, Marcus Folkesson wrote:
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/lpc18xx_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
> index b4221f43cd94..331cadb459ac 100644
> --- a/drivers/watchdog/lpc18xx_wdt.c
> +++ b/drivers/watchdog/lpc18xx_wdt.c
> @@ -265,7 +265,7 @@ static int lpc18xx_wdt_probe(struct platform_device *pdev)
>   	lpc18xx_wdt->wdt_dev.parent = dev;
>   	watchdog_set_drvdata(&lpc18xx_wdt->wdt_dev, lpc18xx_wdt);
>   
> -	ret = watchdog_init_timeout(&lpc18xx_wdt->wdt_dev, heartbeat, dev);
> +	watchdog_init_timeout(&lpc18xx_wdt->wdt_dev, heartbeat, dev);
>   
>   	__lpc18xx_wdt_set_timeout(lpc18xx_wdt);
>   
> 
