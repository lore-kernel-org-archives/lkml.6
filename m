Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeERNpT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:45:19 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44892 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752204AbeERNpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:45:13 -0400
X-Google-Smtp-Source: AB8JxZqy1RF+PN5BBb7W13F0gUhuelDCP69mjPZO2ZowqdgVq5NMEm3t8qXoI2fKI62LbHL0v9Y96A==
Date: Fri, 18 May 2018 14:45:10 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
Subject: Re: [RESEND PATCH v5 0/7] mfd: cros_ec: add subdevices and fixes
Message-ID: <20180518134510.GN5130@dell>
References: <20180418102405.17790-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180418102405.17790-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018, Enric Balletbo i Serra wrote:

> Hi,
> 
> This is the five version of a patchset that collects some patches
> already send but that needed some rework due the patchset to split the
> cros_ec_devs modules in 2 parts. This patchset contains some improvements
> and also some fixes. They can be applied independently and I think that
> all can go through the MFD tree.
> 
> Note: In this RESEND I removed the patch
> 
> [PATCH v5 4/8] mfd: cros_ec_dev: Register cros-ec-rtc driver as a
>                subdevice
> 
> This patch needs some minor changes but actually I don't have the
> hardware to test it. The other patches has no dependency on this one,
> I'll send the above patch once I have the hardware to test again.
> 
> Best regards,
>  Enric

All applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
