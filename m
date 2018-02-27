Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeB0Fxn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 00:53:43 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:12405 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeB0Fxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 00:53:41 -0500
Subject: Re: [PATCH] ARM: omap2: set CONFIG_LIRC=y in defconfig
To: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
CC: Sekhar Nori <nsekhar@ti.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sean Young <sean@mess.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180226204105.2858838-1-arnd@arndb.de>
From: Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <6f0e6593-27c3-2df4-b0ef-f3d3e77c81de@ti.com>
Date: Tue, 27 Feb 2018 11:22:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226204105.2858838-1-arnd@arndb.de>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 27 February 2018 02:10 AM, Arnd Bergmann wrote:
> The CONFIG_LIRC symbol has changed from 'tristate' to 'bool, so we now
> get a warning for omap2plus_defconfig:
> 
> arch/arm/configs/omap2plus_defconfig:322:warning: symbol value 'm' invalid for LIRC
> 
> This changes the file to mark the symbol as built-in to get rid of the
> warning.
> 
> Fixes: a60d64b15c20 ("media: lirc: lirc interface should not be a raw decoder")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thank and regards,
Lokesh

> ---
>  arch/arm/configs/omap2plus_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 2f145c4af93a..92674f247a12 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -319,7 +319,7 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
>  CONFIG_RC_CORE=m
>  CONFIG_MEDIA_CONTROLLER=y
>  CONFIG_VIDEO_V4L2_SUBDEV_API=y
> -CONFIG_LIRC=m
> +CONFIG_LIRC=y
>  CONFIG_RC_DEVICES=y
>  CONFIG_IR_RX51=m
>  CONFIG_V4L_PLATFORM_DRIVERS=y
> 
