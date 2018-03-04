Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeCDT7h (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 14:59:37 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:42404 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbeCDT7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 14:59:35 -0500
X-Google-Smtp-Source: AG47ELtCKw5E+dsZ7yPD+Khc4gmqrShU0RBfSshZqT6OYnDJf8fyd95Qj6egDIHeFFia/LGcEzbJXw==
Date: Sun, 4 Mar 2018 11:59:30 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: andy.gross@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org,
        evgreen@chromium.org, dianders@chromium.org, marc.zyngier@arm.com
Subject: Re: [PATCH v5 4/4] arm64: dts: sdm845: Add serial console support
Message-ID: <20180304195930.GQ93895@bjorns-mbp-2.lan>
References: <20180222061208.2031-1-rnayak@codeaurora.org>
 <20180222061208.2031-5-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222061208.2031-5-rnayak@codeaurora.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21 Feb 22:12 PST 2018, Rajendra Nayak wrote:
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
[..]
> +			qup_uart2: serial@a84000 {
> +				compatible = "qcom,geni-debug-uart";
> +				reg = <0xa84000 0x4000>;
> +				reg-names = "se-phys";
> +				clock-names = "se-clk";

This was changed to "se" in v3 of the GENI patchset, with that this
boots nicely again.

Regards,
Bjorn
