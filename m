Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeBYX5W (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 18:57:22 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41694 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbeBYX5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 18:57:19 -0500
X-Google-Smtp-Source: AH8x225qHQt1CoXhbT38iY+ruq8HOtdGNnQwO7CKZYVVBJbhWl5KMgHFTYNTtyyHcHtr5FBcIWTojg==
Date: Sun, 25 Feb 2018 15:57:17 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [v4,01/10] watchdog/hpwdt: Update copyright.
Message-ID: <20180225235717.GA6627@roeck-us.net>
References: <20180225213259.2861-2-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180225213259.2861-2-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2018 at 02:32:50PM -0700, Jerry Hoemann wrote:
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index f1f00dfc0e68..3d435d6d3226 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -4,7 +4,7 @@
>   *
>   *	SoftDog	0.05:	A Software Watchdog Device
>   *
> - *	(c) Copyright 2015 Hewlett Packard Enterprise Development LP
> + *	(c) Copyright 2018 Hewlett Packard Enterprise Development LP

Not really sure if it makes sense to have this as separate patch.
Either case, it messes up your changelog.

Guenter

>   *	Thomas Mingarelli <thomas.mingarelli@hpe.com>
>   *
>   *	This program is free software; you can redistribute it and/or
