Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeBAWbT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 17:31:19 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36272 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeBAWbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 17:31:11 -0500
X-Google-Smtp-Source: AH8x226BU+83KqAdGFXKAakWa8sijkDq+1XINbWIxMDwMXfNHRAXSgKMsIeeHjzGZCkH1r1WXSA+DQ==
Date: Thu, 1 Feb 2018 14:31:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Corentin Labbe <clabbe@baylibre.com>
Cc: corbet@lwn.net, wim@iguana.be, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] documentation: watchdog: remove documentation for
 ixp2000
Message-ID: <20180201223109.GB29374@roeck-us.net>
References: <1517517852-35113-1-git-send-email-clabbe@baylibre.com>
 <1517517852-35113-2-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517517852-35113-2-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 08:44:11PM +0000, Corentin Labbe wrote:
> The ixp2000 watchdog driver was removed in commit 065e8238302b ("watchdog: remove ixp2000 driver")
> 
> No need to keep its documentation, so remove it.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/watchdog/watchdog-parameters.txt | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 407d013b8643..603140485ac6 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -157,11 +157,6 @@ testmode: Watchdog test mode (1 = no reboot), default=0
>  nowayout: Watchdog cannot be stopped once started
>  	(default=kernel config parameter)
>  -------------------------------------------------
> -ixp2000_wdt:
> -heartbeat: Watchdog heartbeat in seconds (default 60s)
> -nowayout: Watchdog cannot be stopped once started
> -	(default=kernel config parameter)
> --------------------------------------------------
>  ixp4xx_wdt:
>  heartbeat: Watchdog heartbeat in seconds (default 60s)
>  nowayout: Watchdog cannot be stopped once started
> -- 
> 2.13.6
> 
