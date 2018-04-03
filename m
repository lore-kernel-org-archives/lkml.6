Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755352AbeDCJTC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:19:02 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41580 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755253AbeDCJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:18:59 -0400
X-Google-Smtp-Source: AIpwx48admxhnoNdEZXvYrhn9WZLua34G0UuVN36OA8zxjQcNuJ+xA6gZp42K4S0qzegnxKE7Pfpdg==
Date: Tue, 3 Apr 2018 10:18:53 +0100
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
Subject: Re: [RESEND PATCH v6 2/5] dt-bindings: pwm-backlight: add PWM delay
 proprieties.
Message-ID: <20180403091853.4uk2ncyorczl625u@dell>
References: <20180328170327.5395-1-enric.balletbo@collabora.com>
 <20180328170327.5395-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180328170327.5395-2-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018, Enric Balletbo i Serra wrote:

> Hardware needs a delay between setting an initial (non-zero) PWM and
> enabling the backlight using GPIO. The post-pwm-on-delay-ms specifies
> this delay in milli seconds. Hardware also needs a delay between disabing
> the backlight using GPIO and setting PWM value to 0. The pwm-off-delay-ms
> is this delay in milli seconds.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Based on the original Huang Lin <hl@rock-chips.com> work.
> Changes since v5:
>  - Add Acked-by: Thierry Reding <thierry.reding@gmail.com>
>  - CC DT mainling list (for some reason dropped at some point, my
>    fault)
> Changes since v4:
>  - Rebase on top of mainline.
> Changes since v3:
>  - Replace us for ms.
>  - Add Acked-by: Pavel Machek <pavel@ucw.cz>
> Changes since v2:
>  - Use separate properties (Rob Herring)
> Changes since v1:
>  - As suggested by Daniel Thompson
>    - Do not assume power-on delay and power-off delay will be the same
> ---
>  Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
