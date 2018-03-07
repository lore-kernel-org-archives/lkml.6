Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934227AbeCGPwe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:52:34 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54747 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933970AbeCGPwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:52:32 -0500
X-Google-Smtp-Source: AG47ELsmCVpb9fEAlJ4bKyh6f7g5OPZYBgNV08Z7h74BcYO27o4ujS6hK7BGnkC6Wyi91FB6M1k5eA==
Date: Wed, 7 Mar 2018 15:52:28 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH v3 2/8] mfd: cros_ec: free IRQ automatically
Message-ID: <20180307155228.xipsaoxc4lfmntyn@dell>
References: <20180226102606.15093-1-enric.balletbo@collabora.com>
 <20180226102606.15093-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226102606.15093-3-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Enric Balletbo i Serra wrote:

> From: Vincent Palatin <vpalatin@chromium.org>
> 
> Free the IRQ we might have requested when removing the cros_ec device,
> so we can unload and reload the driver properly.
> 
> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Vincent Palatin <vpalatin@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> 
> Changes in v3:
> - [2/8] Add Acked-by Vincent Palatin.
> - [2/8] Add Reviewed-by Andy Shevchenko.
> 
> Changes in v2:
> - [2/8] Remove the free_irq in cros_ec_remove.
> 
>  drivers/mfd/cros_ec.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
