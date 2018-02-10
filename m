Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeBJPci (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 10:32:38 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41998 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeBJPch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 10:32:37 -0500
X-Google-Smtp-Source: AH8x225h1aASBRgls28FjhANI6Te7p4qumnOm//bCDk4GK2SZiQ5VbXRAeUnoBqRzznXVJImXmaQ4g==
Subject: Re: [PATCH] watchdog: coh901327: make license text and module licence
 match
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180210092702.4393-1-marcus.folkesson@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <63b79477-3506-0cb7-3d5d-a2c34d2de82c@roeck-us.net>
Date: Sat, 10 Feb 2018 07:32:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180210092702.4393-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 01:27 AM, Marcus Folkesson wrote:
> Licence text is specifying "GPLv2" but the MODULE_LICENSE is set to "GPLv2
> or later".
> 
> See include/linux/module.h:
> "GPL"				[GNU Public License v2 or later]
> "GPL v2"			[GNU Public License v2]
> 
> When on it, add SPDX identifier tag.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/coh901327_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
> index 5d8eb9a30879..7b71e0a3e6cc 100644
> --- a/drivers/watchdog/coh901327_wdt.c
> +++ b/drivers/watchdog/coh901327_wdt.c
> @@ -1,8 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * coh901327_wdt.c
>    *
>    * Copyright (C) 2008-2009 ST-Ericsson AB
> - * License terms: GNU General Public License (GPL) version 2
>    * Watchdog driver for the ST-Ericsson AB COH 901 327 IP core
>    * Author: Linus Walleij <linus.walleij@stericsson.com>
>    */
> @@ -420,5 +420,5 @@ MODULE_DESCRIPTION("COH 901 327 Watchdog");
>   module_param(margin, uint, 0);
>   MODULE_PARM_DESC(margin, "Watchdog margin in seconds (default 60s)");
>   
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>   MODULE_ALIAS("platform:coh901327-watchdog");
> 
