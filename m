Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbeBSIDT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:03:19 -0500
Received: from protonic.xs4all.nl ([83.163.252.89]:3642 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeBSIDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:03:18 -0500
Date: Mon, 19 Feb 2018 08:44:17 +0100
From: Robin van der Gracht <robin@protonic.nl>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: w@1wt.eu, geert@linux-m68k.org, triad@df.lth.se, paul.burton@mips.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: Replace licenses with SPDX identifiers
Message-ID: <20180219084417.3235d622@erd979>
In-Reply-To: <20180217193955.shfhvp3afwiurzfm@gmail.com>
References: <20180217193955.shfhvp3afwiurzfm@gmail.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2018 20:39:55 +0100
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> Cc: Willy Tarreau <w@1wt.eu>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Linus Walleij <triad@df.lth.se>
> Cc: Robin van der Gracht <robin@protonic.nl>
> Cc: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
> Please let me know if you agree for your files and I will queue it up.
> Thanks!

...

>  
>  #include <linux/delay.h>
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index fbfa5b4cc567..a43276c76fc6 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -1,18 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * HT16K33 driver
>   *
>   * Author: Robin van der Gracht <robin@protonic.nl>
>   *
>   * Copyright: (C) 2016 Protonic Holland.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
>   */
>  

Signed-off-by: Robin van der Gracht <robin@protonic.nl>

Best regards, / vriendelijke groet,

-- 
Robin van der Gracht
Protonic Holland
tel.: +31 (0) 229 212928
fax.: +31 (0) 229 210930
Factorij 36 / 1689 AL Zwaag
