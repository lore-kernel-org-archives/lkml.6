Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754174AbeDBGbE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:31:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45878 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754124AbeDBGbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:31:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD24C601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=varada@codeaurora.org
Date: Mon, 2 Apr 2018 12:00:45 +0530
From: Varadarajan Narayanan <varada@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com, richardcochran@gmail.com
Subject: Re: [PATCH v5 06/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1
 board file
Message-ID: <20180402063044.GA15767@codeaurora.org>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-7-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521800336-19266-7-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 03:48:49PM +0530, Sricharan R wrote:
> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/Makefile                      |  1 +
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
> 

NAND, BAM and SPI work fine.

Tested-by: Varadarajan Narayanan <varada@codeaurora.org>

-Varada

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38..b6c62c6 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -747,6 +747,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-apq8084-ifc6540.dtb \
>  	qcom-apq8084-mtp.dtb \
>  	qcom-ipq4019-ap.dk01.1-c1.dtb \
> +	qcom-ipq4019-ap.dk04.1-c1.dtb \
>  	qcom-ipq8064-ap148.dtb \
>  	qcom-msm8660-surf.dtb \
>  	qcom-msm8960-cdp.dtb \
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
> new file mode 100644
> index 0000000..526b7f8
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +
> +#include "qcom-ipq4019-ap.dk04.1.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C1";
> +
> +	soc {
> +		dma@7984000 {
> +			status = "ok";
> +		};
> +
> +		qpic-nand@79b0000 {
> +			pinctrl-0 = <&nand_pins>;
> +			pinctrl-names = "default";
> +			status = "ok";
> +		};
> +	};
> +};
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
