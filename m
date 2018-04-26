Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756647AbeDZVl1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:41:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60844 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756258AbeDZVl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:41:26 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Hans Verkuil <hans.verkuil@cisco.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: adv7511: fix spelling of driver name in Kconfig
Date: Fri, 27 Apr 2018 00:41:39 +0300
Message-ID: <1577204.ITjXg41EEb@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180426213644.29318-1-peda@axentia.se>
References: <20180426213644.29318-1-peda@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch.

On Friday, 27 April 2018 00:36:44 EEST Peter Rosin wrote:
> Could perhaps prevent some confusion.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/adv7511/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/Kconfig
> b/drivers/gpu/drm/bridge/adv7511/Kconfig index 592b9d2ec034..944e440c4fde
> 100644
> --- a/drivers/gpu/drm/bridge/adv7511/Kconfig
> +++ b/drivers/gpu/drm/bridge/adv7511/Kconfig
> @@ -1,5 +1,5 @@
>  config DRM_I2C_ADV7511
> -	tristate "AV7511 encoder"
> +	tristate "ADV7511 encoder"
>  	depends on OF
>  	select DRM_KMS_HELPER
>  	select REGMAP_I2C


-- 
Regards,

Laurent Pinchart
