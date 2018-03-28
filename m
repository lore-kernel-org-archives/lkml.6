Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeC1LLA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:11:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36189 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeC1LK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:10:59 -0400
X-Google-Smtp-Source: AIpwx49BDvpT/TockD2rPsEAvBSz4KSeQWUvd1DfFujo5EBs936IVyKQr4wRF++C3GjratcpnQvZQg==
Date: Wed, 28 Mar 2018 12:10:55 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: bleung@chromium.org, groeck@chromium.org, andy.shevchenko@gmail.com,
        kernel@collabora.com, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 6/6] platform/chrome: mfd/cros_ec_dev: Add sysfs entry
 to set keyboard wake lid angle
Message-ID: <20180328111055.tfyl2nkgls7eb47j@dell>
References: <20180323174247.6680-1-enric.balletbo@collabora.com>
 <20180323174247.6680-7-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180323174247.6680-7-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018, Enric Balletbo i Serra wrote:

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
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> 
> Changes in v4:
> - [6/6] Allocate only one extra sensor (Gwendal)
> 
> Changes in v3:
> - [6/6] Add Reviewed-by Andy Shevchenko
> - [6/6] Fix the code that has_kb_wake_angle in cros_ec_sensors_register().
> 
> Changes in v2:
> - [6/6] Use DEVICE_ATTR_RW variant.
> - [6/6] Use one line when fits in 80 characters.
> - [6/6] Use the previous defined to_cros_ec_dev
> 
>  drivers/mfd/cros_ec_dev.c               | 31 ++++++-------
>  drivers/platform/chrome/cros_ec_sysfs.c | 81 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/cros_ec.h             |  2 +
>  3 files changed, 96 insertions(+), 18 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
