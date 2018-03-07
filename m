Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934016AbeCGQy4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:54:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52746 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933922AbeCGQx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:53:26 -0500
X-Google-Smtp-Source: AG47ELuqeB7+ayTaOBjo10tL4q+Npw99HPx0cVPWPFzFvH0oNVApVQnyRu2kVuc4SipSWEXlvEfkWQ==
Date: Wed, 7 Mar 2018 16:53:22 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>
Subject: Re: [PATCH 1/2] backlight: Add RAVE SP backlight driver
Message-ID: <20180307165322.dpp2a3wz3cjh7wbj@dell>
References: <20180307024011.25033-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180307024011.25033-1-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Mar 2018, Andrey Smirnov wrote:

> This driver provides access to RAVE SP backlight control
> functionality.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Aleksander Morgado <aleksander@aleksander.es>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/video/backlight/Kconfig             |  6 +++
>  drivers/video/backlight/Makefile            |  1 +
>  drivers/video/backlight/rave-sp-backlight.c | 82 +++++++++++++++++++++++++++++

>  include/linux/mfd/rave-sp.h                 |  1 +

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
