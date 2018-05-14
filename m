Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeENJ4X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:56:23 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:26402 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbeENJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:56:22 -0400
Subject: Re: [PATCH] MAINTAINERS: add entry for LEGO MINDSTORMS EV3
To: David Lechner <david@lechnology.com>, <linux-kernel@vger.kernel.org>
CC: Sebastian Reichel <sre@kernel.org>
References: <20180512220544.24016-1-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <893d9dad-d5a6-215e-ee1b-f31458f6794e@ti.com>
Date: Mon, 14 May 2018 15:25:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180512220544.24016-1-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 May 2018 03:35 AM, David Lechner wrote:
> This adds an entry to MAINTAINERS for LEGO MINDSTORMS EV3 (an ARM-based
> robotics platform). The files listed are exclusive to this device. Add
> me as reviewer so that I will be cc'ed for any changes to these files.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index df6e9bb2559a..2e057e0138b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7960,6 +7960,13 @@ S:	Maintained
>  F:	Documentation/misc-devices/eeprom
>  F:	drivers/misc/eeprom/eeprom.c
>  
> +LEGO MINDSTORMS EV3
> +R:	David Lechner <david@lechnology.com>
> +S:	Maintained
> +F:	arch/arm/boot/dts/da850-lego-ev3.dts
> +F:	Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
> +F:	drivers/power/supply/lego_ev3_battery.c
> +
>  LEGO USB Tower driver
>  M:	Juergen Stuber <starblue@users.sourceforge.net>
>  L:	legousb-devel@lists.sourceforge.net
> -- 
> 2.17.0
> 
