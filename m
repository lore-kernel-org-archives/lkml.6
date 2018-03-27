Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754546AbeC0RU1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:20:27 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33475 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754044AbeC0RUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:20:24 -0400
X-Google-Smtp-Source: AIpwx48DSMX/w1UWqS4fVooWrdW8iy6fjNbseIuhJspk70cyM+OGK0KW62IP+Kv0rhI0s/a/JRr/IA==
Date: Tue, 27 Mar 2018 10:20:34 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com,
        richardcochran@gmail.com
Subject: Re: [PATCH v5 08/13] ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common
 data
Message-ID: <20180327172034.GK1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-9-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521800336-19266-9-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> +#include "qcom-ipq4019.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1";
> +	compatible = "qcom,ipq4019";

The board should set these, so you shouldn't need to specify them here.
And you should be able to find a more specific compatible for the board.

> +
[..]
> +		qpic-nand@79b0000 {
> +			status = "ok";

No pinmux for the qpic on these boards?

> +		};
> +	};
> +};

Regards,
Bjorn
