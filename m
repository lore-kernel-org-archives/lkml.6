Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeCTHeU convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751330AbeCTHeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:34:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA0C21770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Sricharan R <sricharan@codeaurora.org>, absahu@codeaurora.org,
        andy.gross@linaro.org, bjorn.andersson@linaro.org,
        catalin.marinas@arm.com, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, linux@armlinux.org.uk, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, robh@kernel.org,
        sboyd@codeaurora.org, will.deacon@arm.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521518336-5467-7-git-send-email-sricharan@codeaurora.org>
Cc: sricharan@codeaurora.org
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-7-git-send-email-sricharan@codeaurora.org>
Message-ID: <152153125818.254778.5435627269964796441@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 06/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1 board file
Date: Tue, 20 Mar 2018 00:34:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sricharan R (2018-03-19 20:58:49)
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
> new file mode 100644
> index 0000000..871ac3f
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +
> +#include "qcom-ipq4019-ap.dk04.1.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C1";
> +
> +       soc {
> +               qpic_bam: dma@7984000 {

Why the labels?

> +                       status = "ok";
> +               };
> +
> +               nand: qpic-nand@79b0000 {
> +                       pinctrl-0 = <&nand_pins>;
> +                       pinctrl-names = "default";
> +                       status = "ok";
> +               };
> +       };
> +};
