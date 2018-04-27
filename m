Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758865AbeD0RNU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:13:20 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:16961 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758271AbeD0RNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:13:17 -0400
Subject: Re: [PATCH v6 5/7] remoteproc/davinci: use octal permissions for
 module_param()
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180417173038.25510-1-brgl@bgdev.pl>
 <20180417173038.25510-6-brgl@bgdev.pl>
From: Suman Anna <s-anna@ti.com>
Message-ID: <0bd29608-fe2c-50c8-3f8c-eb1b2f001a6d@ti.com>
Date: Fri, 27 Apr 2018 12:11:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417173038.25510-6-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 12:30 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Checkpatch recommends to use octal perms instead of S_IRUGO.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Looks like you missed by Acked-by from v3, so adding it back

Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index f134192922e0..b668e32996e2 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -25,7 +25,7 @@
>  #include "remoteproc_internal.h"
>  
>  static char *da8xx_fw_name;
> -module_param(da8xx_fw_name, charp, S_IRUGO);
> +module_param(da8xx_fw_name, charp, 0444);
>  MODULE_PARM_DESC(da8xx_fw_name,
>  		 "Name of DSP firmware file in /lib/firmware (if not specified defaults to 'rproc-dsp-fw')");
>  
> 
