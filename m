Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755341AbeDPOAh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:00:37 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43990 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeDPOAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:00:35 -0400
X-Google-Smtp-Source: AIpwx4+wv8NTwUgj2K0bxsaqq0ARHzeS6EZyrqrWrHjK/dQ/+NTT1+wFf0Lq/I7Z6Q4RlCFWOnYzvA==
Date: Mon, 16 Apr 2018 15:00:30 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Felix Brack <fb@ltec.ch>
Cc: linux-fbdev@vger.kernel.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] backlight: otm3225a: add support for ORISE OTM3225A
 LCD SoC
Message-ID: <20180416140030.mojc6uy6ak65meoc@dell>
References: <1523190765-2823-1-git-send-email-fb@ltec.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523190765-2823-1-git-send-email-fb@ltec.ch>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Apr 2018, Felix Brack wrote:

> This patch adds a LCD driver supporting the OTM3225A LCD SoC
> from ORISE Technology. This device can drive TFT LC panels having a
> resolution of 240x320 pixels. After initializing the OTM3225A using
> it's SPI interface it switches to use 16-bib RGB as external
> display interface.
> 
> Signed-off-by: Felix Brack <fb@ltec.ch>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Changes in v3:
> - fix a type in a comment
> - don't make useless calls to msleep() by callig it with delay 0
> - add Daniel Thompson's Acked-by
> 
> Changes in v2:
> - use descriptive names for registers instead of hard coding them
> - remove unnecessary registers in initialization sequence
> - make use of resource-managed functions like devm_kzalloc()
>   instead of kzalloc() which simplifies and shortens the code
> - replace mdelay() by msleep()
> - use module_spi_init() since we do not do anything special
>   in init/exit
> - use dev_name() instead of hard coding driver name multiple times
> - use static storage class for structure otm3225a_ops
> - sort include files alphabetically
> - use standardized licensing header
> - modify Makefile respecting alphabetical sort order
> ---
>  drivers/video/backlight/Kconfig    |   7 ++
>  drivers/video/backlight/Makefile   |   1 +
>  drivers/video/backlight/otm3225a.c | 252 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 260 insertions(+)
>  create mode 100644 drivers/video/backlight/otm3225a.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
