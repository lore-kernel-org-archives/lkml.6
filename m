Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753712AbeC0REq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:04:46 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:41492 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbeC0REk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:04:40 -0400
X-Google-Smtp-Source: AIpwx4+24iSXiNpmiEJSH3u7DpQo5k6NhoijvvPtfUV99yPofoPzf7uQnswlS37qtwsj4zepd4tWYg==
Date: Tue, 27 Mar 2018 10:04:50 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com,
        richardcochran@gmail.com
Subject: Re: [PATCH v5 05/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
Message-ID: <20180327170450.GH1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-6-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521800336-19266-6-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> +	soc {
> +		pinctrl@1000000 {
> +			serial_0_pins: serial0_pinmux {

Please, no underscores in the node name.

> +				mux {

Fyi, you can put the pinctrl properties directly into the state node,
omitting the "mux" level.

> +					pins = "gpio16", "gpio17";
> +					function = "blsp_uart0";
> +					bias-disable;
> +				};
> +			};
> +

Apart from this the patch looks good.

Regards,
Bjorn
