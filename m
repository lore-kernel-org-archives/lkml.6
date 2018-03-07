Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934282AbeCGPx0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:53:26 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41172 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934262AbeCGPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:53:20 -0500
X-Google-Smtp-Source: AG47ELvLrQ5n0Zpayeo0Ylpkna9eLSiPTUz/Y8/nA3yMBocRYyw+rWAuMRNM6q+fgYg4b7BldgVaAQ==
Date: Wed, 7 Mar 2018 15:53:17 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 3/8] mfd: cros_ec: Don't try to grab log when suspended
Message-ID: <20180307155317.nnqfbnrf2w6wlgk4@dell>
References: <20180226102606.15093-1-enric.balletbo@collabora.com>
 <20180226102606.15093-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226102606.15093-4-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Enric Balletbo i Serra wrote:

> From: Douglas Anderson <dianders@chromium.org>
> 
> We should stop our worker thread while we're suspended.  If we don't
> then we'll get messages like:
> 
>   cros-ec-spi spi5.0: spi transfer failed: -108
>   cros-ec-spi spi5.0: cs-deassert spi transfer failed: -108
>   cros-ec-ctl cros-ec-ctl.0.auto: EC communication failed
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> 
> Changes in v3:
> - [3/8] Add Reviewed-by Andy Shevchenko.
> 
> Changes in v2:
> - [3/8] That patch is new in this series.
> 
>  drivers/mfd/cros_ec_dev.c                 |  4 ++++
>  drivers/platform/chrome/cros_ec_debugfs.c | 20 ++++++++++++++++++++
>  include/linux/mfd/cros_ec.h               |  2 ++
>  3 files changed, 26 insertions(+)

I plan to make this patch 1/X and send it out as a pull-request.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
