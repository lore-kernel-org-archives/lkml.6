Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeBIJpL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:45:11 -0500
Received: from gloria.sntech.de ([95.129.55.99]:36860 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbeBIJpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:45:09 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <briannorris@chromium.org>, groeck@chromium.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yakir Yang <ykk@rock-chips.com>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: introduce pclk_vio_grf in eDP device node
Date: Fri, 09 Feb 2018 10:45:03 +0100
Message-ID: <2524920.mM517gbyb6@phil>
In-Reply-To: <20180207163150.16332-1-enric.balletbo@collabora.com>
References: <20180207163150.16332-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 7. Februar 2018, 17:31:48 CET schrieb Enric Balletbo i Serra:
> From: Yakir Yang <ykk@rock-chips.com>
> 
> The pclk_vio_grf supply power for VIO GRF IOs, if it is disabled,
> driver would failed to operate the VIO GRF registers.
> 
> The clock is optional but one of the side effects of don't have this clk
> is that the Samsung Chromebook Plus fails to recover display after a
> suspend/resume with following errors:
> 
>     rockchip-dp ff970000.edp: Input stream clock not detected.
>     rockchip-dp ff970000.edp: Timeout of video streamclk ok
>     rockchip-dp ff970000.edp: unable to config video
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

as you said in IRC that his should also fix the failures when rockchip-drm
is build as module, I've applied this patch as fix for 4.16


Thanks
Heiko
