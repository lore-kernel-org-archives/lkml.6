Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeC1LI4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:08:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53639 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbeC1LIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:08:55 -0400
X-Google-Smtp-Source: AIpwx4+nm3HBIIOUb9GEYOBnU+0VVTlAOrpRY1opnhqmRGAJizk1JjyzyBtgxYN1W9SSBGBWj1E/SA==
Date: Wed, 28 Mar 2018 12:08:51 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: bleung@chromium.org, groeck@chromium.org, andy.shevchenko@gmail.com,
        kernel@collabora.com, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, Shawn Nematbakhsh <shawnn@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 5/6] platform/chrome: cros_ec_debugfs: Add PD port
 info to debugfs
Message-ID: <20180328110851.5pe6sqiovowvxmjj@dell>
References: <20180323174247.6680-1-enric.balletbo@collabora.com>
 <20180323174247.6680-6-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180323174247.6680-6-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018, Enric Balletbo i Serra wrote:

> From: Shawn Nematbakhsh <shawnn@chromium.org>
> 
> Add info useful for debugging USB-PD port state.
> 
> Signed-off-by: Shawn Nematbakhsh <shawnn@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> 
> Changes in v4: None
> Changes in v3:
> - [5/6] Add EC_USB_PD_MAX_PORTS define to avoid interdependencies.
> - [5/6] Add Reviewed-by Andy Shevchenko
> 
> Changes in v2:
> - [5/6] Drop unrelated changes.
> 
>  drivers/platform/chrome/cros_ec_debugfs.c | 72 +++++++++++++++++++++++++++++++

>  include/linux/mfd/cros_ec_commands.h      |  3 ++

Acked-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 75 insertions(+)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
