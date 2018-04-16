Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755266AbeDPOGV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:06:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35888 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeDPOGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:06:19 -0400
X-Google-Smtp-Source: AIpwx48AycZLQ7INphvXag//ayLkQQD7NV8EGrGZlJeVIgHKKEty64C69kgPnQlDJFDCWiZiBIxbOQ==
Date: Mon, 16 Apr 2018 15:06:14 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/8] mfd: cros_ec_dev: Register cros-ec-rtc driver as
 a subdevice.
Message-ID: <20180416140614.rwu6yalwjn76thhc@dell>
References: <20180405113313.27340-1-enric.balletbo@collabora.com>
 <20180405113313.27340-5-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180405113313.27340-5-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Apr 2018, Enric Balletbo i Serra wrote:

> Check whether this EC instance has RTC host command support and instatiate
> the RTC driver as a subdevice in such case.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> 
> Changes in v5:
> - [4/8] For mfd_cell struct use one line and no need for the comma.
> 
> Changes in v4:
> - [4/8] Nit: check -> Check (Lee Jones)
> - [4/8] Use ARRAY_SIZE() instead of hardcoded number (Lee Jones)
> 
> Changes in v3:
> - [4/8] Add the Reviewed-by Andy Shevchenko.
> 
> Changes in v2:
> - [4/8] Add the Reviewed-by Gwendal.
> 
>  drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
