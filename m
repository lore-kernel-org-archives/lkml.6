Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbeEVWpy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 18:45:54 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:42796 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753139AbeEVWpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 18:45:51 -0400
X-Google-Smtp-Source: AB8JxZqURHlwkh427mEMP3FlQP673BBo/YH19+J/Irhk1Wa3TdYboY8jt+c6m7yY3FwXJdx3COhLUw==
Date: Tue, 22 May 2018 17:45:49 -0500
From: Rob Herring <robh@kernel.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>,
        kernel@collabora.com, Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 02/10] dt-bindings: devfreq: rk3399_dmc: Add
 rockchip,pmu phandle.
Message-ID: <20180522224549.GA26650@rob-hp-laptop>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
 <20180514211610.26618-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514211610.26618-3-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:16:02PM +0200, Enric Balletbo i Serra wrote:
> The Rockchip DMC (Dynamic Memory Interface) needs to access to the PMU
> general register files to know the DRAM type, so add a phandle to the
> syscon that manages these registers.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
