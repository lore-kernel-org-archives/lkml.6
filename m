Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeBJQQ4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 11:16:56 -0500
Received: from gloria.sntech.de ([95.129.55.99]:51732 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbeBJQQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 11:16:54 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <briannorris@chromium.org>, groeck@chromium.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chris Zhong <zyw@rock-chips.com>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: add cdn-dp node for rk3399.
Date: Sat, 10 Feb 2018 17:16:45 +0100
Message-ID: <6229682.fDmaELEjz4@phil>
In-Reply-To: <20180207163150.16332-2-enric.balletbo@collabora.com>
References: <20180207163150.16332-1-enric.balletbo@collabora.com> <20180207163150.16332-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Am Mittwoch, 7. Februar 2018, 17:31:49 CET schrieb Enric Balletbo i Serra:
> From: Chris Zhong <zyw@rock-chips.com>
> 
> Add a node for the cdn DP controller which is embedded in the rk3399
> SoC.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 50 ++++++++++++++++++++++++++++++++

It looks like there is no binding document at all for cdn-dp? At least
I couldn't find one and the original series also didn't seem to include one.

And while I don't see anything problematic right with the used properties
right now, I'd think we should really have a binding and give dt-maintainers
a chance to complain, before adding devicetree nodes based on it.

I'd guess a mostly usable binding doc should already sit in the chromeos
tree, which you could base a v2 of this series on?


Thanks
Heiko
