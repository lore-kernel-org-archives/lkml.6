Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBJOyE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 09:54:04 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41164 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbeBJOyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 09:54:02 -0500
X-Google-Smtp-Source: AH8x224asLFbcyLPtOaZdeThDSXdqa2KH40DMLWTCNms7LMaidD4kTsEXtQrQrJlon1Vu8++AroovdLZvFA2qE2KdGU=
MIME-Version: 1.0
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Sat, 10 Feb 2018 15:53:20 +0100
Message-ID: <CAOFm3uGhfmz0A3UuPaP=T-Hf5=kFK_rNJUGge9QVy_Sz8Rpk1w@mail.gmail.com>
Subject: Re: [PATCH] watchdog: coh901327: make license text and module licence match
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-watchdog@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 10:27 AM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> Licence text is specifying "GPLv2" but the MODULE_LICENSE is set to "GPLv2
> or later".
>
> See include/linux/module.h:
> "GPL"                           [GNU Public License v2 or later]
> "GPL v2"                        [GNU Public License v2]
>
> When on it, add SPDX identifier tag.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/watchdog/coh901327_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
> index 5d8eb9a30879..7b71e0a3e6cc 100644
> --- a/drivers/watchdog/coh901327_wdt.c
> +++ b/drivers/watchdog/coh901327_wdt.c
> @@ -1,8 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * coh901327_wdt.c
>   *
>   * Copyright (C) 2008-2009 ST-Ericsson AB
> - * License terms: GNU General Public License (GPL) version 2
>   * Watchdog driver for the ST-Ericsson AB COH 901 327 IP core
>   * Author: Linus Walleij <linus.walleij@stericsson.com>
>   */
> @@ -420,5 +420,5 @@ MODULE_DESCRIPTION("COH 901 327 Watchdog");
>  module_param(margin, uint, 0);
>  MODULE_PARM_DESC(margin, "Watchdog margin in seconds (default 60s)");
>
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:coh901327-watchdog");

Thank you!

Reviewed-by: Philippe Ombredanne <pombredanne@nexb.com>

-- 
Cordially
Philippe Ombredanne
