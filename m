Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeFEKLd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:11:33 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35738 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbeFEKLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:11:32 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] drm/bridge: analogix-anx78xx: Switch to SPDX identifier.
Date: Tue, 05 Jun 2018 13:11:43 +0300
Message-ID: <1896069.8N7yzJMC7C@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180605100051.4023-1-enric.balletbo@collabora.com>
References: <20180605100051.4023-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thank you for the patch.

On Tuesday, 5 June 2018 13:00:50 EEST Enric Balletbo i Serra wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/gpu/drm/bridge/analogix-anx78xx.c | 24 ++++++++---------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c
> b/drivers/gpu/drm/bridge/analogix-anx78xx.c index
> b49043866be6..54d7e7981bed 100644
> --- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
> @@ -1,19 +1,11 @@
> -/*
> - * Copyright(c) 2016, Analogix Semiconductor.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * Based on anx7808 driver obtained from chromeos with copyright:
> - * Copyright(c) 2013, Google Inc.
> - *
> - */
> +// SPDX-License-Identifier: GPL-2.0

This looks good to m.

> +// Driver for ANX78xx SlimPort transmitter.
> +//
> +// Copyright (C) 2016 Analogix Semiconductor.
> +// Copyright (C) 2016 Google, Inc.

Should the last line be 2013, not 2016 ?

> +//
> +// Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>

I don't think there's a need to convert the whole comment block to C++-style.

>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>

-- 
Regards,

Laurent Pinchart
