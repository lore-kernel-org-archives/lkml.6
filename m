Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeDPOnj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:43:39 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41025 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeDPOnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:43:37 -0400
X-Google-Smtp-Source: AIpwx48EXD9LYCxOpwb6N6ba+53/MoEShkWe9jjf4IgV9Zb0p03GQC6wg9JlHmRQYG6uwB0FnrDmPQ==
Date: Mon, 16 Apr 2018 15:43:32 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [RESEND PATCH v6 1/5] pwm-backlight: enable/disable the PWM
 before/after LCD enable toggle.
Message-ID: <20180416144332.caww5vttzrzjlnkt@dell>
References: <20180328170327.5395-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180328170327.5395-1-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018, Enric Balletbo i Serra wrote:

> Before this patch the enable signal was set before the PWM signal and
> vice-versa on power off. This sequence is wrong, at least, it is on
> the different panels datasheets that I checked, so I inverted the sequence
> to follow the specs.
> 
> For reference the following panels have the mentioned sequence:
>   - N133HSE-EA1 (Innolux)
>   - N116BGE (Innolux)
>   - N156BGE-L21 (Innolux)
>   - B101EAN0 (Auo)
>   - B101AW03 (Auo)
>   - LTN101NT05 (Samsung)
>   - CLAA101WA01A (Chunghwa)
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> ---
> Changes since v5:
>  - Add Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Changes since v4:
>  - Rebase on top of mainline.
>  - Add the acks from Daniel Thompson and Jingoo Han.
> Changes since v3:
>  - List the part numbers for the panel checked (Daniel Thompson)
> Changes since v2:
>  - Add this as a separate patch (Thierry Reding)
> Changes since v1:
>  - None
> ---
>  drivers/video/backlight/pwm_bl.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
