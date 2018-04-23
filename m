Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbeDWTC2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:02:28 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33642 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932235AbeDWTCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:02:23 -0400
X-Google-Smtp-Source: AIpwx4/N2L0V97Jz0x+Xt1kau1MuNB8GB15d+f465sQnpoxskWpvYd0iphOMLMaycZQWf8qRzaiTQQ==
Date: Mon, 23 Apr 2018 12:02:20 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Masanari Iida <standby24x7@gmail.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: touchscreen: Fix a typo in Kconfig
Message-ID: <20180423190220.GD66646@dtor-ws>
References: <20180419184514.9668-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419184514.9668-1-standby24x7@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 03:45:14AM +0900, Masanari Iida wrote:
> This patch fix a spelling typo found in Kconfig.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 4f15496fec8b..3e613afa10b4 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -362,7 +362,7 @@ config TOUCHSCREEN_HIDEEP
>  
>  	  If unsure, say N.
>  
> -	  To compile this driver as a moudle, choose M here : the
> +	  To compile this driver as a module, choose M here : the
>  	  module will be called hideep_ts.
>  
>  config TOUCHSCREEN_ILI210X
> -- 
> 2.17.0.140.g0b0cc9f86731
> 

-- 
Dmitry
