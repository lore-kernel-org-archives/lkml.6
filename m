Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934211AbeCGPwY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:52:24 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38042 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933970AbeCGPwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:52:21 -0500
X-Google-Smtp-Source: AG47ELunqxdyvlBrFN1Y3yM8fEz3rUIIsW5+dEITMfLb3ZFcMV3nejChEZY/yuXjq1UhiX7QK1o5Kw==
Date: Wed, 7 Mar 2018 15:52:18 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH v3 1/8] mfd: cros_ec: fail early if we cannot identify
 the EC
Message-ID: <20180307155218.vxykivgzfef4bjjp@dell>
References: <20180226102606.15093-1-enric.balletbo@collabora.com>
 <20180226102606.15093-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226102606.15093-2-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Enric Balletbo i Serra wrote:

> From: Vincent Palatin <vpalatin@chromium.org>
> 
> If we cannot communicate with the EC chip to detect the protocol version
> and its features, it's very likely useless to continue. Else we will
> commit all kind of uninformed mistakes (using the wrong protocol, the
> wrong buffer size, mixing the EC with other chips).
> 
> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> Acked-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mfd/cros_ec.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
