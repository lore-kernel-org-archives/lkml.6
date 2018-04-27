Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759288AbeD0VZI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:25:08 -0400
Received: from muru.com ([72.249.23.125]:39100 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757815AbeD0VZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:25:07 -0400
Date: Fri, 27 Apr 2018 14:25:04 -0700
From: Tony Lindgren <tony@atomide.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update OMAP MMC entry
Message-ID: <20180427212504.GE5671@atomide.com>
References: <20180427212228.25426-1-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427212228.25426-1-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [180427 21:24]:
> Jarkko's e-mail address hasn't worked for a long time. We still want
> to keep this driver working as it is critical for some of the OMAP boards.
> I use and test this driver frequently, so add myself as a maintainer
> with "Odd Fixes" status.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Good idea:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e41e12a88a4..0dbac7e43b17 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10206,9 +10206,9 @@ F:	drivers/media/platform/omap3isp/
>  F:	drivers/staging/media/omap4iss/
>  
>  OMAP MMC SUPPORT
> -M:	Jarkko Lavinen <jarkko.lavinen@nokia.com>
> +M:	Aaro Koskinen <aaro.koskinen@iki.fi>
>  L:	linux-omap@vger.kernel.org
> -S:	Maintained
> +S:	Odd Fixes
>  F:	drivers/mmc/host/omap.c
>  
>  OMAP POWER MANAGEMENT SUPPORT
> -- 
> 2.17.0
> 
