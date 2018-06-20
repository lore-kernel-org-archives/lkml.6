Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E130C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7452083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7452083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754278AbeFTPnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:43:49 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41328 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752827AbeFTPnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:43:47 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11-v6so1178pff.8;
        Wed, 20 Jun 2018 08:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RdJis9MEOCOFhEg/sFyEVTQj8Alxh+QMitZs/orqUAo=;
        b=hxqzeXiPXg9Y7sMCZYfkAnxL+dMaWjKFhWY1WOgzU+hRRbaywhLFiRV1li0gAkC3dU
         0q/0CvPvJnrwr+ICwo37q+kAPlfQRNUgfJkXpjnn/5r13o5ThzYUyYi/WEmD4IundUFB
         K4iq7B5VZJFE96e/ea17spZ2a18DL+sd9mZnBIG0og5oStMQAd0i1i0CZPYuNcRKa+Dd
         p4dKxlzzUlEJCqckJbArjszjivfxjXVtG0tIhPwE4JMn8T4tZBPUA5a2wBogsRilbQFb
         6MxhCEy1r0omsWnqd6o9Nr9IZMafrafpXKL1+Io0c/cEc2y0UxWZe8c9PjGz4LXA5Pc/
         gamQ==
X-Gm-Message-State: APt69E2/PyI2Izdu5T61gvl+RgSj6lcob/yVHbK5I80MkQooTn8ehG2Z
        7HvhlPGES8PQ5idMayOIIQ==
X-Google-Smtp-Source: ADUXVKLB3K/W3iE4Wjjus284feTYbhCisoQBo9sIBWEH+qrXz7W85bG4pukOpxwabYLeajhlhbCM1w==
X-Received: by 2002:a62:8b9b:: with SMTP id e27-v6mr23413556pfl.82.1529509426441;
        Wed, 20 Jun 2018 08:43:46 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id k9-v6sm3919055pgs.49.2018.06.20.08.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 08:43:45 -0700 (PDT)
Date:   Wed, 20 Jun 2018 09:43:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/5] dt-bindings: clock: renesas,r9a06g032-sysctrl:
 documentation
Message-ID: <20180620154344.GA32205@rob-hp-laptop>
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528973829-25493-3-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528973829-25493-3-git-send-email-michel.pollet@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 11:56:31AM +0100, Michel Pollet wrote:
> The Renesas R9A06G032 SYSCTRL node description.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  .../bindings/clock/renesas,r9a06g032-sysctrl.txt   | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt

One nit, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
> new file mode 100644
> index 0000000..f6cb5e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
> @@ -0,0 +1,44 @@
> +* Renesas R9A06G032 SYSCTRL
> +
> +Required Properties:
> +
> +  - compatible: Must be:
> +    - "renesas,r9a06g032-sysctrl"
> +  - reg: Base address and length of the SYSCTRL IO block.
> +  - #clock-cells: Must be 1
> +  - clocks: References to the parent clocks:
> +	- external 40mhz crystal.
> +	- external (optional) 32.768khz
> +	- external (optional) jtag input
> +	- external (optional) RGMII_REFCLK
> +  - clock-names: Must be:
> +        clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
> +
> +Examples
> +--------
> +
> +  - SYSCTRL node:
> +
> +	sysctrl: system-controller@4000c000 {
> +		compatible = "renesas,r9a06g032-sysctrl";
> +		reg = <0x4000c000 0x1000>;
> +		status = "okay";

Don't show status in examples.

> +		#clock-cells = <1>;
> +
> +		clocks = <&ext_mclk>, <&ext_rtc_clk>,
> +				<&ext_jtag_clk>, <&ext_rgmii_ref>;
> +		clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
> +	};
> +
> +  - Other nodes can use the clocks provided by SYSCTRL as in:
> +
> +	#include <dt-bindings/clock/r9a06g032-sysctrl.h>
> +	uart0: serial@40060000 {
> +		compatible = "snps,dw-apb-uart";
> +		reg = <0x40060000 0x400>;
> +		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +		clocks = <&sysctrl R9A06G032_CLK_UART0>;
> +		clock-names = "baudclk";
> +	};
> -- 
> 2.7.4
> 
