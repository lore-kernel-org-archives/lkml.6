Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeC0PIc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:08:32 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41999 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbeC0PI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:08:29 -0400
X-Google-Smtp-Source: AG47ELv2pXfXX/gDrPVTK3tANEhilR//5dFIZ9h64Lyg/bCU5xE5xZ2fuQBC3w5tAyBcgmncfGIXDA==
Date: Tue, 27 Mar 2018 10:08:27 -0500
From: Rob Herring <robh@kernel.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 2/5] dt-bindings: pwm-backlight: add PWM delay
 proprieties.
Message-ID: <20180327150827.i7b4urmjrf2mqj3t@rob-hp-laptop>
References: <20180326095213.18362-1-enric.balletbo@collabora.com>
 <20180326095213.18362-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326095213.18362-2-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 11:52:10AM +0200, Enric Balletbo i Serra wrote:
> Hardware needs a delay between setting an initial (non-zero) PWM and
> enabling the backlight using GPIO. The post-pwm-on-delay-ms specifies
> this delay in milli seconds. Hardware also needs a delay between disabing
> the backlight using GPIO and setting PWM value to 0. The pwm-off-delay-ms
> is this delay in milli seconds.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
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

Reviewed-by: Rob Herring <robh@kernel.org> 
