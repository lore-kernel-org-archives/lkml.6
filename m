Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751123AbeBQQKT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 11:10:19 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35356 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbeBQQKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 11:10:18 -0500
X-Google-Smtp-Source: AH8x227VwwPIQ3jt9c/LzwwaMyvuD0pAD9jp4+tB6sFh9c2b8JwF9yajKVZ1exmK44Qi1+vV8LEgZA==
Date: Sat, 17 Feb 2018 08:10:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [v3,02/11] watchdog/hpwdt: remove include files no longer needed.
Message-ID: <20180217161015.GA6155@roeck-us.net>
References: <20180215234400.5022-3-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215234400.5022-3-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:43:51PM -0700, Jerry Hoemann wrote:
> Remove header files used by NMI sourcing and DMI decoding.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

This patch should have been merged with the 1st patch of the series,
since it is logically the same change. However, that does not raise
to the level of objection.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/hpwdt.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 113058644fc3..20a13c5d0285 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -28,16 +28,7 @@
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  #include <linux/watchdog.h>
> -#ifdef CONFIG_HPWDT_NMI_DECODING
> -#include <linux/dmi.h>
> -#include <linux/spinlock.h>
> -#include <linux/nmi.h>
> -#include <linux/kdebug.h>
> -#include <linux/notifier.h>
> -#include <asm/set_memory.h>
> -#endif /* CONFIG_HPWDT_NMI_DECODING */
>  #include <asm/nmi.h>
> -#include <asm/frame.h>
>  
>  #define HPWDT_VERSION			"1.4.0"
>  #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
