Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754754AbeC0R3K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:29:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40693 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeC0R3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:29:06 -0400
X-Google-Smtp-Source: AIpwx48ByY6NVmdtikCJGnKe053CTdvc06zEX3SsoHo/gyfjGWf3hgbCiCc26Ny+deVo65RQblVV9A==
Date: Tue, 27 Mar 2018 10:29:17 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com,
        richardcochran@gmail.com
Subject: Re: [PATCH v5 10/13] ARM: dts: ipq4019: Add
 qcom-ipq4019-ap.dk07.1-c2 board file
Message-ID: <20180327172917.GM1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-11-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521800336-19266-11-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:

> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/Makefile                      |  1 +
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts | 26 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ae7f214..3b65e30 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -750,6 +750,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-ipq4019-ap.dk04.1-c1.dtb \
>  	qcom-ipq4019-ap.dk04.1-c3.dtb \
>  	qcom-ipq4019-ap.dk07.1-c1.dtb \
> +	qcom-ipq4019-ap.dk07.1-c2.dtb \
>  	qcom-ipq8064-ap148.dtb \
>  	qcom-msm8660-surf.dtb \
>  	qcom-msm8960-cdp.dtb \
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> new file mode 100644
> index 0000000..c1e909c
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +
> +#include "qcom-ipq4019-ap.dk07.1.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1-C2";

compatible

Apart from that you have my

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
