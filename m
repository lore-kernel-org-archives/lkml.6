Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934024AbeCGQFU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:05:20 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51884 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbeCGQFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:05:16 -0500
X-Google-Smtp-Source: AG47ELsd1hyS3DpbNiBPBB9wkF33tb1AwWXEI2gCYpGn1501icV/zM0CBJeoP6IYeE/j/GWco+0smA==
Date: Wed, 7 Mar 2018 16:05:13 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Daniel Hung-yu Wu <hywu@google.com>,
        Daniel Hung-yu Wu <hywu@chromium.org>
Subject: Re: [PATCH v3 6/8] mfd: cros_ec_dev: register shutdown function for
 debugfs
Message-ID: <20180307160513.wv3vjkw77hx456gt@dell>
References: <20180226102606.15093-1-enric.balletbo@collabora.com>
 <20180226102606.15093-7-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226102606.15093-7-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Enric Balletbo i Serra wrote:

> From: Daniel Hung-yu Wu <hywu@google.com>
> 
> Reboot or shutdown during delayed works could corrupt communication with
> EC and certain I2C controller may not be able to recover from the error
> state.
> 
> This patch registers a shutdown callback used to cancel the debugfs log
> worker thread.
> 
> Signed-off-by: Daniel Hung-yu Wu <hywu@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> 
> Changes in v3:
> - [6/8] Add the Reviewed-by Andy Shevchenko.
> 
> Changes in v2:
> - [6/8] This patch is new in this series.
> 
>  drivers/mfd/cros_ec_dev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
