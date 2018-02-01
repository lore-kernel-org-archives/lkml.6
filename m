Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeBAWbo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 17:31:44 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43416 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeBAWbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 17:31:37 -0500
X-Google-Smtp-Source: AH8x224Tx6Uey1bg0wA/v0vks2bR2Gps2FYxvh2KKybmQDR3LLW1i2UGx9yzCJ1eRMwlf3wE81qT4g==
Date: Thu, 1 Feb 2018 14:31:34 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Corentin Labbe <clabbe@baylibre.com>
Cc: corbet@lwn.net, wim@iguana.be, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/3] documentation: watchdog: remove documentation of
 w83697hf_wdt/w83697ug_wdt
Message-ID: <20180201223134.GC29374@roeck-us.net>
References: <1517517852-35113-1-git-send-email-clabbe@baylibre.com>
 <1517517852-35113-3-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517517852-35113-3-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 08:44:12PM +0000, Corentin Labbe wrote:
> Since w83697hf_wdt/w83697ug_wdt watchdogs drivers were removed
> in commit 7285fae9345e ("watchdog: Remove drivers for W83697HF and W83697UG")
> There are no need to keep their documentation
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/watchdog/watchdog-parameters.txt | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 603140485ac6..beea975980f6 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -371,19 +371,6 @@ timeout: Watchdog timeout in seconds. 1 <= timeout <= 255, default=60.
>  nowayout: Watchdog cannot be stopped once started
>  	(default=kernel config parameter)
>  -------------------------------------------------
> -w83697hf_wdt:
> -wdt_io: w83697hf/hg WDT io port (default 0x2e, 0 = autodetect)
> -timeout: Watchdog timeout in seconds. 1<= timeout <=255 (default=60)
> -nowayout: Watchdog cannot be stopped once started
> -	(default=kernel config parameter)
> -early_disable: Watchdog gets disabled at boot time (default=1)
> --------------------------------------------------
> -w83697ug_wdt:
> -wdt_io: w83697ug/uf WDT io port (default 0x2e)
> -timeout: Watchdog timeout in seconds. 1<= timeout <=255 (default=60)
> -nowayout: Watchdog cannot be stopped once started
> -	(default=kernel config parameter)
> --------------------------------------------------
>  w83877f_wdt:
>  timeout: Watchdog timeout in seconds. (1<=timeout<=3600, default=30)
>  nowayout: Watchdog cannot be stopped once started
> -- 
> 2.13.6
> 
