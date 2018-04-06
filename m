Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeDFH4x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:56:53 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37381 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeDFH4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:56:51 -0400
X-Google-Smtp-Source: AIpwx4/oknOlmaaCNmTbh+ZZpBS79WGej9h/49ckmpyqELHHwmHvZhYUNARg7ILgPC53T+TcyjoEvQ==
Date: Fri, 6 Apr 2018 13:26:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: vireshk@kernel.org, shiraz.linux.kernel@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 1/2] ARM: SPEAr600: add DT description of the watchdog
Message-ID: <20180406075648.GW3572@vireshk-i7>
References: <0635969b6ef0fe528a27a8b6493cc3df770e1f60.1523000725.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0635969b6ef0fe528a27a8b6493cc3df770e1f60.1523000725.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-04-18, 09:50, Quentin Schulz wrote:
> The SPEAr600 has a built-in watchdog which already has a DT binding
> described in Documentation/devicetree/bindings/watchdog/sp805-wdt.txt.
> 
> Let's add the description of the watchdog device in the SPEAr600 Device
> Tree.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  arch/arm/boot/dts/spear600.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
> index 00166eb..d7c3096 100644
> --- a/arch/arm/boot/dts/spear600.dtsi
> +++ b/arch/arm/boot/dts/spear600.dtsi
> @@ -213,6 +213,14 @@
>  				interrupts = <6>;
>  				status = "disabled";
>  			};
> +
> +			wdt: wdt@fc880000 {
> +				compatible = "arm,sp805", "arm,primecell";
> +				reg = <0xfc880000 0x1000>;
> +				interrupt-parent = <&vic1>;
> +				interrupts = <20>;
> +				status = "disabled";
> +			};
>  		};
>  	};
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
