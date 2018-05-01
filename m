Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753978AbeEAIaA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:30:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55631 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753848AbeEAI36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:29:58 -0400
X-Google-Smtp-Source: AB8JxZpc3qsy4xyBpOCG0vTLGPXn+Zk58oUyCV1TRl4WdwR/Skddc483aFv63GZk6Wm4y8RjkUwc7g==
Date: Tue, 1 May 2018 09:29:55 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 2/3] power: supply: add cros-ec USBPD charger driver.
Message-ID: <20180501082955.GK5147@dell>
References: <20180430131403.14296-1-enric.balletbo@collabora.com>
 <20180430131403.14296-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180430131403.14296-3-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018, Enric Balletbo i Serra wrote:

> From: Sameer Nanda <snanda@chromium.org>
> 
> This driver gets various bits of information about what is connected to
> USB PD ports from the EC and converts that into power_supply properties.
> 
> Signed-off-by: Sameer Nanda <snanda@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2:
> - [2/3] Add SPDX header, use devm_ variant and drop .owner
> - [2/3] Removed the PD log functionality (will be send on a follow up patch)
> - [2/3] Removed the extra custom sysfs attributes (will be send on a follow up patch)
> 
>  drivers/power/supply/Kconfig              |  10 +
>  drivers/power/supply/Makefile             |   1 +
>  drivers/power/supply/cros_usbpd-charger.c | 511 ++++++++++++++++++++++

>  include/linux/mfd/cros_ec.h               |   2 +

Acked-by: Lee Jones <lee.jones@linaro.org>

>  4 files changed, 524 insertions(+)
>  create mode 100644 drivers/power/supply/cros_usbpd-charger.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
