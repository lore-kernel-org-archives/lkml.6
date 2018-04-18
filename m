Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeDRHon (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:44:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53978 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbeDRHol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:44:41 -0400
Date: Wed, 18 Apr 2018 09:44:28 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/6] drm/atmel-hlcdc: fix broken release date
Message-ID: <20180418094428.6db785dc@bbrezillon>
In-Reply-To: <20180417131052.16336-7-peda@axentia.se>
References: <20180417131052.16336-1-peda@axentia.se>
        <20180417131052.16336-7-peda@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 15:10:52 +0200
Peter Rosin <peda@axentia.se> wrote:

> Bump the minor version while at it.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index 8523c40fac94..aa48f287b5ca 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -763,9 +763,9 @@ static struct drm_driver atmel_hlcdc_dc_driver = {
>  	.fops = &fops,
>  	.name = "atmel-hlcdc",
>  	.desc = "Atmel HLCD Controller DRM",
> -	.date = "20141504",

I guess I used YYYYDDMM format :-).

> +	.date = "20180409",
>  	.major = 1,
> -	.minor = 0,
> +	.minor = 1,

Don't know what the strategy is regarding date and minor version
updates. I never had to update that before, so I guess it's not
important to userspace anyway.

>  };
>  
>  static int atmel_hlcdc_dc_drm_init(struct platform_device *pdev)
