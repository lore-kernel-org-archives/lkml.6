Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755384AbeDCJTQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:19:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33921 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755357AbeDCJTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:19:12 -0400
X-Google-Smtp-Source: AIpwx4+5gwaJDpW5RoO2yHGy9BFVpXsS3rbudsX1Z4RmK0u9G1Vny6+9MOK87sQ+SSRDTa2xtuj5og==
Date: Tue, 3 Apr 2018 10:19:07 +0100
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
Subject: Re: [RESEND PATCH v6 3/5] pwm-backlight: add support for PWM delays
 proprieties.
Message-ID: <20180403091907.rfupwgx4ryy66ebu@dell>
References: <20180328170327.5395-1-enric.balletbo@collabora.com>
 <20180328170327.5395-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180328170327.5395-3-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018, Enric Balletbo i Serra wrote:

> Some panels (i.e. N116BGE-L41), in their power sequence specifications,
> request a delay between set the PWM signal and enable the backlight and
> between clear the PWM signal and disable the backlight. Add support for
> the new post-pwm-on-delay-ms and pwm-off-delay-ms proprieties to meet
> the timings.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> ---
> Changes since v5:
>  - Add Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Changes since v4:
>  - Rebased on top of mainline.
>  - Added the acks from Pavel Machek, Daniel thompson and Jingoo Han
> Changes since v3:
>  - Use two named members instead of pwm_delay[] (Daniel and Pavel)
>  - Use msleep instead of usleep_range. (Pavel)
> Changes since v2:
>  - Move the pwm/enable sequence to another patch (Thierry Reding)
> Changes since v1:
>  - As suggested by Daniel Thompson
>    - Do not assume power-on delay and power-off delay will be the same
>  - Move the check of dt property to the parse dt function.
> ---
>  drivers/video/backlight/pwm_bl.c | 19 +++++++++++++++++++
>  include/linux/pwm_backlight.h    |  2 ++
>  2 files changed, 21 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
