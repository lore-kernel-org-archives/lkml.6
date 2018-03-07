Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933829AbeCGQ2w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:28:52 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33621 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933335AbeCGQ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:28:49 -0500
X-Google-Smtp-Source: AG47ELtXX+rWwSE6UH25xIf5Vdn0QCbUxQMARkmQWr9KyE1tuWWpt4kTj9OZkrgWE7qEfov7JUaocA==
Date: Wed, 7 Mar 2018 16:28:46 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com, groeck@chromium.org, gwendal@chromium.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 6/6] platform/chrome: mfd/cros_ec_dev: Add sysfs entry
 to set keyboard wake lid angle
Message-ID: <20180307162846.6he3rtvtzkvuwpem@dell>
References: <20180221170748.27505-1-enric.balletbo@collabora.com>
 <20180221170748.27505-7-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180221170748.27505-7-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018, Enric Balletbo i Serra wrote:

> From: Gwendal Grignou <gwendal@chromium.org>
> 
> This adds a sysfs attribute (/sys/class/chromeos/cros_ec/kb_wake_angle)
> used to set and get the keyboard wake lid angle. This attribute is
> present only if 2 accelerometers are controlled by the EC.
> 
> This patch also moves the cros_ec features check before the device is
> added so the features map obtained from the EC is ready on time.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes since v1:
> - Suggested by Andy Shevchenko:
>   - Use the previous defined to_cros_ec_dev
>   - Use one line when fits in 80 characters.
>   - Use DEVICE_ATTR_RW variant.
> 
>  drivers/platform/chrome/cros_ec_sysfs.c | 81 +++++++++++++++++++++++++++++++++

>  drivers/mfd/cros_ec_dev.c               | 19 ++++----
>  include/linux/mfd/cros_ec.h             |  1 +

Please send me a PR with this patch contained.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
