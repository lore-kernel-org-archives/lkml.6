Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeFEQhI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:37:08 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41272 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeFEQhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:37:06 -0400
X-Google-Smtp-Source: ADUXVKI0uEkS7mQh/5898+sYR/MqGfHMSpNn6cOubTki++CCUel+ncVHNKBYRnkj/NKzX9IRYP3Lsw==
Date: Tue, 5 Jun 2018 09:37:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        kernel@collabora.com, linux-input@vger.kernel.org
Subject: Re: [PATCH 6/9] Input: cros_ec_keyb - Switch to SPDX identifier.
Message-ID: <20180605163702.GB202428@dtor-ws>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
 <20180605092209.22887-7-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605092209.22887-7-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 11:22:06AM +0200, Enric Balletbo i Serra wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/input/keyboard/cros_ec_keyb.c | 26 ++++----------------------
>  1 file changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 79eb29550c34..342513ec0ede 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -1,25 +1,7 @@
> -/*
> - * ChromeOS EC keyboard driver
> - *
> - * Copyright (C) 2012 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the Chrome OS EC byte-level message-based protocol for
> - * communicating the keyboard state (which keys are pressed) from a keyboard EC
> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
> - * but everything else (including deghosting) is done here.  The main
> - * motivation for this is to keep the EC firmware as simple as possible, since
> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
> - * expensive.
> - */

Ugh, why did you remove this last paragraph? It has nothing to do with
license notice and should have been kept.

> +// SPDX-License-Identifier: GPL-2.0+
> +// ChromeOS EC keyboard driver
> +//
> +// Copyright (C) 2012 Google, Inc.
>  
>  #include <linux/module.h>
>  #include <linux/bitops.h>
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
