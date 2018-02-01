Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeBAWav (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 17:30:51 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44421 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeBAWap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 17:30:45 -0500
X-Google-Smtp-Source: AH8x225E58eOcoH/wEyQGHZHJ7gvSAuXKEGjt1i041Jixe3AoN+e0j9rXSq92JX4x9M0ZOkQ7Y7Kog==
Date: Thu, 1 Feb 2018 14:30:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Corentin Labbe <clabbe@baylibre.com>
Cc: corbet@lwn.net, wim@iguana.be, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] documentation: watchdog: remove documentation of
 at32ap700x_wdt
Message-ID: <20180201223042.GA29374@roeck-us.net>
References: <1517517852-35113-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517517852-35113-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 08:44:10PM +0000, Corentin Labbe wrote:
> Since at32ap700x_wdt is gone, no need to keep its documentation
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/watchdog/watchdog-parameters.txt | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 6f9d7b418917..407d013b8643 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -40,11 +40,6 @@ margin: Watchdog margin in seconds (default=60)
>  nowayout: Disable watchdog shutdown on close
>  	(default=kernel config parameter)
>  -------------------------------------------------
> -at32ap700x_wdt:
> -timeout: Timeout value. Limited to be 1 or 2 seconds. (default=2)
> -nowayout: Watchdog cannot be stopped once started
> -	(default=kernel config parameter)
> --------------------------------------------------
>  at91rm9200_wdt:
>  wdt_time: Watchdog time in seconds. (default=5)
>  nowayout: Watchdog cannot be stopped once started
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
