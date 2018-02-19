Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeBSKjm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:39:42 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41033 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeBSKjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:39:40 -0500
X-Google-Smtp-Source: AH8x224+I8qCqDp9/62baTLuevRDQHbMjpKnu05y+IYtkVWjgD4m99eEBpP46zEWmLSwBFcFI3UyQw==
Date: Mon, 19 Feb 2018 10:39:36 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [RESEND PATCH v5 2/5] dt-bindings: pwm-backlight: add PWM delay
 proprieties.
Message-ID: <20180219103936.vsvzbiwr3g7oqsyh@dell>
References: <20180216174034.15936-1-enric.balletbo@collabora.com>
 <20180216174034.15936-2-enric.balletbo@collabora.com>
 <20180219092247.estv4d2v6cbopx6z@dell>
 <4692672.MjQUXlf6O3@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4692672.MjQUXlf6O3@phil>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2018, Heiko Stuebner wrote:
> Am Montag, 19. Februar 2018, 10:22:47 CET schrieb Lee Jones:
> > On Fri, 16 Feb 2018, Enric Balletbo i Serra wrote:
> > 
> > > Hardware needs a delay between setting an initial (non-zero) PWM and
> > > enabling the backlight using GPIO. The post-pwm-on-delay-ms specifies
> > > this delay in milli seconds. Hardware also needs a delay between disabing
> > > the backlight using GPIO and setting PWM value to 0. The pwm-off-delay-ms
> > > is this delay in milli seconds.
> > > 
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > ---
> > > Based on the original Huang Lin <hl@rock-chips.com> work.
> > > 
> > > Changes since v4:
> > >  - Rebase on top of mainline.
> > > Changes since v3:
> > >  - Replace us for ms.
> > >  - Add Acked-by: Pavel Machek <pavel@ucw.cz>
> > > Changes since v2:
> > >  - Use separate properties (Rob Herring)
> > > Changes since v1:
> > >  - As suggested by Daniel Thompson
> > >    - Do not assume power-on delay and power-off delay will be the same
> > > 
> > >  Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > 
> > Looks like this still needs an Ack.
> > 
> > Also, you didn't supply a 0th (cover-letter) patch, so I have no idea
> > of patch history or your future intentions.
> > 
> > Are there build-time dependencies between them or can each patch be
> > merged via their respective trees without the fear of merge/build
> > failure?
> 
> When looking at the patches, there do not seem to be any build-time
> dependencies between the patch 1-3 (backlight) and 4+5 devicetree,
> so after Rob hopefully has time to look at the binding change, I'd suspect
> you take the code changes and I'll take the dts changes.

Works for me.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
