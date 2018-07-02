Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6C8C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1455C25B4B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1455C25B4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965126AbeGBKMH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:12:07 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:41641 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964922AbeGBKME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:12:04 -0400
Received: from [IPv6:2001:983:e9a7:1:211d:3901:19f1:80d] ([IPv6:2001:983:e9a7:1:211d:3901:19f1:80d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id ZvoNf6MskEJtcZvoOfvJZA; Mon, 02 Jul 2018 12:12:02 +0200
Subject: Re: [PATCH v11 10/10] arch: sh: migor: Use new renesas-ceu camera
 driver
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com,
        geert@glider.be, mchehab@kernel.org, festevam@gmail.com,
        sakari.ailus@iki.fi, robh+dt@kernel.org, mark.rutland@arm.com,
        pombredanne@nexb.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-sh@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1519295846-11612-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519295846-11612-11-git-send-email-jacopo+renesas@jmondi.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <3a262281-2f47-af79-970a-c8ec5ac82778@xs4all.nl>
Date:   Mon, 2 Jul 2018 12:11:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1519295846-11612-11-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOukHhbYx6XN8IJ2lUVC/ASy/zWKXaDxMsoBH/C/yeQlv+JpBIrJJ937FGZ0pjqUlO7kMX4Gt3iZuIMfb1D4/Uqgj51aPYPnryx8GSxqhlulEptsfyjl
 Q1WVysoPb/P54SHnEUM/fuNX0gtqf1bARiBaE+gT2TJ1DOnoOBNA7dP4OCaPe+upbkCMGQTWSB94XHXPsgrQyF4fPBHddFIviM6+sJGtrR1IPcbxjvd0H1BV
 58gQTkyOI6qDJxAlUVjCiYv4Txif4tvJdetcbCKgj35n47YM0iFsZY0omXJbKvBT5H24r/QS+eTpC5zfwzlzDSc/iv+3Bo+k2eWKxDv9G0KbyLy7C5DKk0Lo
 G6m+hQlcsuAysaSRevWt3oo91yT97CX3q6i8xMU0abKe3LUyB4XVFUnI1BUlE8QZF5cfCjSXdUOjz26wcETzqHtVFvKlkSaNUWpca6BIrCiGBwBqizkoLDbe
 xJfvOfT6IUoHbvJNlhpDx+tV5AT9/r/Qgyh4wV2zZGtWoQCg2LGHI12kxaYaxu6Le5Nxa4ZiZ0hcf8F29iB874V3QzkyvZUq9bikgnPkDakFhXxPpmZGfLs1
 3TEUd40O9pxwefAN2SNxQtv37a2ilIUYJYZZ4M5YqKmMwzQjvhaLxOTVp5Tq3M/PwQaSA53SsoEnEdx6D3QPd7rMMPkS4by18+EwrW2tN81ZmxMFs+HnttLQ
 GYVfA/OblaywqeaDjhqUr0n+pNVA53MKZHT1GZf5t63iv8EpKTXBSpXeZswL6HFGdZkozw91+dDs2gmcuiKdIj7H0+XTXZrv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/18 11:37, Jacopo Mondi wrote:
> Migo-R platform uses sh_mobile_ceu camera driver, which is now being
> replaced by a proper V4L2 camera driver named 'renesas-ceu'.
> 
> Move Migo-R platform to use the v4l2 renesas-ceu camera driver
> interface and get rid of soc_camera defined components used to register
> sensor drivers and of platform specific enable/disable routines.
> 
> Register clock source and GPIOs for sensor drivers, so they can use
> clock and gpio APIs.
> 
> Also, memory for CEU video buffers is now reserved with membocks APIs,
> and need to be declared as dma_coherent during machine initialization to
> remove that architecture specific part from CEU driver.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
> ---
>  arch/sh/boards/mach-migor/setup.c      | 225 +++++++++++++++------------------
>  arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   2 +-
>  2 files changed, 101 insertions(+), 126 deletions(-)
> 
> diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
> index 0bcbe58..271dfc2 100644
> --- a/arch/sh/boards/mach-migor/setup.c
> +++ b/arch/sh/boards/mach-migor/setup.c
> @@ -1,17 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Renesas System Solutions Asia Pte. Ltd - Migo-R
>   *
>   * Copyright (C) 2008 Magnus Damm
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
>   */
> +#include <linux/clkdev.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/input.h>
>  #include <linux/input/sh_keysc.h>
> +#include <linux/memblock.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/mfd/tmio.h>
> @@ -23,10 +22,11 @@
>  #include <linux/delay.h>
>  #include <linux/clk.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/machine.h>
>  #include <linux/videodev2.h>
>  #include <linux/sh_intc.h>
>  #include <video/sh_mobile_lcdc.h>
> -#include <media/drv-intf/sh_mobile_ceu.h>
> +#include <media/drv-intf/renesas-ceu.h>
>  #include <media/i2c/ov772x.h>
>  #include <media/soc_camera.h>

You left a stray soc_camera.h include here.

Can you make a patch that removes this and verify that everything compiles?

I also see CONFIG_SOC_CAMERA in several arch/sh/configs/*_defconfig files.
Should those be updated?

Regards,

	Hans

