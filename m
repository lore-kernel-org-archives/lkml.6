Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeEADUe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 23:20:34 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:39473 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbeEADUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 23:20:32 -0400
X-Google-Smtp-Source: AB8JxZpiuhb2mceFyVhu/HIi6AS/cCm0EdCcW234hYnHp+/OXiDdsoil9SdYm1NsPJCE3+9CQe0u4g==
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Lee Jones'" <lee.jones@linaro.org>,
        "'Daniel Thompson'" <daniel.thompson@linaro.org>,
        "'Bartlomiej Zolnierkiewicz'" <b.zolnierkie@samsung.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>
Cc: "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        "'Inki Dae'" <inki.dae@samsung.com>
References: <20180430172945.20938-1-krzk@kernel.org>
In-Reply-To: <20180430172945.20938-1-krzk@kernel.org>
Subject: Re: [PATCH 1/2] backlight: Remove s6e63m0 driver
Date: Mon, 30 Apr 2018 23:20:29 -0400
Message-ID: <000201d3e0fb$5be60250$13b206f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGcZ66bP0vnb7M+C77ud7ncAJyjdKSJJtlw
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 30, 2018 1:30 PM, Krzysztof Kozlowski wrote:
> 
> The driver for S6E63M0 AMOLED LCD panel is not used.  It does not
> support DeviceTree and respective possible users (S5Pv210 Aquila and
> Goni boards) are DeviceTree-only.
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/video/backlight/Kconfig         |   8 -
>  drivers/video/backlight/Makefile        |   1 -
>  drivers/video/backlight/s6e63m0.c       | 857
----------------------------
> ----

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

[.....]
