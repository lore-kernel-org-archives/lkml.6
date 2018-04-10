Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbeDJNEk convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:04:40 -0400
Received: from gloria.sntech.de ([95.129.55.99]:55074 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753073AbeDJNEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:04:38 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [RESEND PATCH v6 5/5] ARM: dts: rockchip: set PWM delay backlight settings for Minnie
Date: Tue, 10 Apr 2018 15:04:22 +0200
Message-ID: <217634691.qDbm1hq3Bz@phil>
In-Reply-To: <20180328170327.5395-5-enric.balletbo@collabora.com>
References: <20180328170327.5395-1-enric.balletbo@collabora.com> <20180328170327.5395-5-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 28. März 2018, 19:03:27 CEST schrieb Enric Balletbo i Serra:
> The minnie devices comes with an AUO B101EAN01 panel which is different
> from default veyron devices, thus the power on/off timing sequence is
> slightly different. The datasheet specifies a pwm delay of 200 ms, so
> update the PMW delay proprieties accordingly.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

applied for 4.18

Thanks
Heiko
