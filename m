Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbeCLOOM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:14:12 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45561 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932220AbeCLONG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:13:06 -0400
X-Google-Smtp-Source: AG47ELt3wtg/FzQDJMne6Rw6O18zP+Jfw8BdDUAEc3ZoFvu9ClhYjlYyMwnjiPYKB4bknE8Ya9kEWQ==
Date: Mon, 12 Mar 2018 14:13:03 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>
Subject: Re: [PATCH v2 1/2] backlight: Add RAVE SP backlight driver
Message-ID: <20180312141303.zspr2az2ijxwrus7@dell>
References: <20180308192046.27670-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180308192046.27670-1-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Mar 2018, Andrey Smirnov wrote:

> This driver provides access to RAVE SP backlight control
> functionality.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Aleksander Morgado <aleksander@aleksander.es>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> Changes since [v1]:
> 
>  - Collected various Acked-by form Lee and Daniel
> 
>  - Changes BACKLIGHT_FIRMARE to BACKLIGHT_PLATFORM
> 
> [v1] https://lkml.kernel.org/r/20180307024011.25033-1-andrew.smirnov@gmail.com
> 
>  drivers/video/backlight/Kconfig             |  6 +++
>  drivers/video/backlight/Makefile            |  1 +
>  drivers/video/backlight/rave-sp-backlight.c | 82 +++++++++++++++++++++++++++++
>  include/linux/mfd/rave-sp.h                 |  1 +
>  4 files changed, 90 insertions(+)
>  create mode 100644 drivers/video/backlight/rave-sp-backlight.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
