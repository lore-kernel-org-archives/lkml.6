Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754818AbeDWKxQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:53:16 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37324 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754766AbeDWKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:53:13 -0400
X-Google-Smtp-Source: AIpwx4+MyDojDkq33OkWoBrniGHi/M9J5ACKjv5JQULsDOzd65LMU6TKhvJlB6prcQJHUMmvDsa4lmlI492mXxPoTYA=
MIME-Version: 1.0
In-Reply-To: <20180419104019.24406-1-enric.balletbo@collabora.com>
References: <20180419104019.24406-1-enric.balletbo@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Apr 2018 12:53:12 +0200
Message-ID: <CAPDyKFr_NPNqCmyD0XHa=vy_--kOCzgwUjNqkvXO0uUOdFM=tQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] devfreq: rk3399_dmc: improve rk3399_dmc driver and
 it's documentation
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, Linux PM <linux-pm@vger.kernel.org>,
        Derek Basehore <dbasehore@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@google.com>, groek@google.com,
        kernel@collabora.com, Elaine Zhang <zhangqing@rock-chips.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lin Huang <hl@rock-chips.com>, Jeffy Chen <jeffy.chen@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 April 2018 at 12:40, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Dear all,
>
> These patches is an attempt to improve a little bit the rk3399_dmc
> driver and it's documentation in order to have all in a better shape for
> a future work I am doing. My final intention is add ddrfreq support for
> rockchip drm driver, but the patches for this are still
> work-in-progress. So let's start with this first patchset that is
> basically some fixes/improvements for the rk3399_dmc driver.

I didn't get cc:ed the series, but only the last part, which makes it
bit hard to get the full context.

Moreover, it would be good if you explained a bit more on what the
above series actually does and why. Also I don't get why is the PM
domain changes is in the series, as this seems to be about devfreq.

My point is, if you want me to review, please try to be more precise
so I know what to review.

>
> Best regards,
>
> Enric Balletbo i Serra (3):
>   dt-bindings: clock: add DDR3 standard speed bins.
>   devfreq: rk3399_dmc: remove wait for dcf irq event.
>   dt-bindings: devfreq: rk3399_dmc: remove interrupts as is not
>     required.
>
> Lin Huang (2):
>   devfreq: rk3399_dmc: do not print error when get supply and clk defer.
>   devfreq: rk3399_dmc: register devfreq notification to dmc driver.
>
> Nick Milner (1):
>   dt-bindings: devfreq: rk3399_dmc: improve binding documentation.
>
>  .../bindings/devfreq/rk3399_dmc.txt           | 204 +++++++++---------
>  drivers/devfreq/rk3399_dmc.c                  | 106 +--------
>  drivers/soc/rockchip/pm_domains.c             |  31 +++
>  include/dt-bindings/clock/ddr.h               |  34 +++
>  include/soc/rockchip/rk3399_dmc.h             |  63 ++++++
>  5 files changed, 238 insertions(+), 200 deletions(-)
>  create mode 100644 include/dt-bindings/clock/ddr.h
>  create mode 100644 include/soc/rockchip/rk3399_dmc.h
>
> --
> 2.17.0
>

Kind regards
Uffe
