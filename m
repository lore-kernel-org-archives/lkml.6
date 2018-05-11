Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeEKWLf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 18:11:35 -0400
Received: from gloria.sntech.de ([95.129.55.99]:46264 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbeEKWLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 18:11:34 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Finley Xiao <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v1 11/13] dt-bindings: power: add PX30 SoCs header for power-domain
Date: Sat, 12 May 2018 00:11:24 +0200
Message-ID: <508694354.7btLQf7nsA@phil>
In-Reply-To: <1526009672-2097-1-git-send-email-zhangqing@rock-chips.com>
References: <1526009458-28579-1-git-send-email-zhangqing@rock-chips.com> <1526009672-2097-1-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,


Am Freitag, 11. Mai 2018, 05:34:32 CEST schrieb Elaine Zhang:
> According to a description from TRM, add all the power domains.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

that's a bit ambigous, having the Signed-offs like above.

Either you are the author+sender of the patch, then Finley's
Signed-off should go away ... or Finley is the author and you
are the sender, then the author of the patch should be set
correctly (--author option for git) and the Signed-offs should
switch places (= Finley first, then yours). Please fix.

This seems to be true for most patches in this series.

> ---
>  include/dt-bindings/power/px30-power.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 include/dt-bindings/power/px30-power.h
> 
> diff --git a/include/dt-bindings/power/px30-power.h b/include/dt-bindings/power/px30-power.h
> new file mode 100644
> index 000000000000..4ed482e80950
> --- /dev/null
> +++ b/include/dt-bindings/power/px30-power.h

Here I have a naming question. When looking at the vendor kernel
it looks like the px30 is largely related to the rk3326.
(rk3326.dtsi includeing the px30.dtsi)

What is the reason for basing the naming on the px30 this time? And could
we possibly keep to rkXXXX names for the basic things in the kernel, thus
keeping the pxXX as second name, like with the other px-variants before?


Thanks
Heiko
