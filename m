Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeBZENN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 23:13:13 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45237 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbeBZENK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 23:13:10 -0500
X-Google-Smtp-Source: AH8x227Db71RAOaVUojBmZgZuU+6WZoUa7ptsM8osCxjU/m1gKUQEfOE5F3+3mDmTgGDqYxVd4rWzA==
Date: Mon, 26 Feb 2018 09:43:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: sean.wang@mediatek.com
Cc: robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 09/19] arm: dts: mt7623: add related clock properties
 to cpu[1-3] nodes
Message-ID: <20180226041307.GI26947@vireshk-i7>
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <8cfae2c1d9464cf82e431a6e0c7c275c46133578.1519378872.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cfae2c1d9464cf82e431a6e0c7c275c46133578.1519378872.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-18, 18:16, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Complement the missing clock properties cpu[1-3] should depend on.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  arch/arm/boot/dts/mt7623.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index da56c54..5cf93a4 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -94,6 +94,9 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a7";
>  			reg = <0x1>;
> +			clocks = <&infracfg CLK_INFRA_CPUSEL>,
> +				 <&apmixedsys CLK_APMIXED_MAINPLL>;
> +			clock-names = "cpu", "intermediate";
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clock-frequency = <1300000000>;
>  		};
> @@ -102,6 +105,9 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a7";
>  			reg = <0x2>;
> +			clocks = <&infracfg CLK_INFRA_CPUSEL>,
> +				 <&apmixedsys CLK_APMIXED_MAINPLL>;
> +			clock-names = "cpu", "intermediate";
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clock-frequency = <1300000000>;
>  		};
> @@ -110,6 +116,9 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a7";
>  			reg = <0x3>;
> +			clocks = <&infracfg CLK_INFRA_CPUSEL>,
> +				 <&apmixedsys CLK_APMIXED_MAINPLL>;
> +			clock-names = "cpu", "intermediate";
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clock-frequency = <1300000000>;
>  		};

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
