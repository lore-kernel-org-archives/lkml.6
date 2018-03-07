Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934069AbeCGQGO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:06:14 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41760 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933479AbeCGQGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:06:13 -0500
X-Google-Smtp-Source: AG47ELtO+8SBj6rMzzp6yekALcGnH6tdMuJYxkAd48qKHl4+CfAatWQ23jPbgRTIQW15UP3tTboijg==
Date: Wed, 7 Mar 2018 16:06:09 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@google.com>
Subject: Re: [PATCH v3 7/8] mfd: cros_ec_i2c: add ACPI module device table
Message-ID: <20180307160609.ujf3kns2waqbwors@dell>
References: <20180226102606.15093-1-enric.balletbo@collabora.com>
 <20180226102606.15093-8-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226102606.15093-8-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Enric Balletbo i Serra wrote:

> From: Wei-Ning Huang <wnhuang@google.com>
> 
> Add ACPI module device table for matching cros-ec devices to load the
> cros_ec_i2c driver automatically.
> 
> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> Acked-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> 
> Changes in v3:
> - [7/8] Add the Reviewed-by Andy Shevchenko.
> - [7/8] Avoid commas in terminator entries.
> 
> Changes in v2:
> - [7/8] Add the Reviewed-by Gwendal.
> 
>  drivers/mfd/cros_ec_i2c.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
