Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbeEADVP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 23:21:15 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44529 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753480AbeEADVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 23:21:13 -0400
X-Google-Smtp-Source: AB8JxZpjeHQyfwST1fgYHQg8cBTHCm1bY9Zp27vQyJ62yQN4kCmb37sjuXnqGiz7luJo57+T1yoJrA==
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Lee Jones'" <lee.jones@linaro.org>,
        "'Daniel Thompson'" <daniel.thompson@linaro.org>,
        "'Bartlomiej Zolnierkiewicz'" <b.zolnierkie@samsung.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>
Cc: "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        "'Inki Dae'" <inki.dae@samsung.com>
References: <20180430172945.20938-1-krzk@kernel.org> <20180430172945.20938-2-krzk@kernel.org>
In-Reply-To: <20180430172945.20938-2-krzk@kernel.org>
Subject: Re: [PATCH 2/2] backlight: Remove ld9040 driver
Date: Mon, 30 Apr 2018 23:21:10 -0400
Message-ID: <000301d3e0fb$747627f0$5d6277d0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGcZ66bP0vnb7M+C77ud7ncAJyjdAGemmOrpHwyjxA=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Monday, April 30, 2018 1:30 PM
> To: Lee Jones <lee.jones@linaro.org>; Daniel Thompson
> <daniel.thompson@linaro.org>; Jingoo Han <jingoohan1@gmail.com>;
> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>; linux-
> kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; linux-
> fbdev@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>; Marek Szyprowski
> <m.szyprowski@samsung.com>; Inki Dae <inki.dae@samsung.com>
> Subject: [PATCH 2/2] backlight: Remove ld9040 driver
> 
> The driver for LD9040 AMOLED LCD panel was superseded with DRM driver
> panel-samsung-ld9040.c.  It does not support DeviceTree and respective
> possible user (Exynos4210 Universal C210) is DeviceTree-only and uses
> DRM version of driver..
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/video/backlight/Kconfig        |   8 -
>  drivers/video/backlight/Makefile       |   1 -
>  drivers/video/backlight/ld9040.c       | 811
-----------------------------
> ----
>  drivers/video/backlight/ld9040_gamma.h | 202 --------
>  4 files changed, 1022 deletions(-)
>  delete mode 100644 drivers/video/backlight/ld9040.c
>  delete mode 100644 drivers/video/backlight/ld9040_gamma.h

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

[.....]
