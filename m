Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeCLOMC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:12:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55752 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCLOMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:12:01 -0400
X-Google-Smtp-Source: AG47ELsUXf1WOSvC4MBHz3reuHDG7ch64WqMszw7T+Stqz6IA7+SafB8lSxlk8jjUCXe/DQPdI8sWA==
Date: Mon, 12 Mar 2018 14:11:58 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/3] mfd: rave-sp: Add code to print firmware versions
Message-ID: <20180312141158.fggtyyfci2a4l6hi@dell>
References: <20180308173756.13787-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180308173756.13787-1-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Mar 2018, Andrey Smirnov wrote:

> Add code that would query and print out bootloader and application
> firmware version info.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> Changes since [v1]:
> 
> 	- Removed unused deving from the middle of 'struct rave_status'
> 
> [v1] https://lkml.kernel.org/r/20180226150739.13457-1-andrew.smirnov@gmail.com
> 
>  drivers/mfd/rave-sp.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
