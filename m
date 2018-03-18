Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754848AbeCRXt5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 19:49:57 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35655 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754783AbeCRXtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 19:49:49 -0400
X-Google-Smtp-Source: AG47ELvZhQAqOmhmjT8CRFm8tyy6R+a/7k9wOazeUKBe7qIZYWGGw/td/l4jG2ZacSySRrunHWbE1g==
Subject: Re: [PATCH v1 09/19] arm: dts: mt7623: add related clock properties
 to cpu[1-3] nodes
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <8cfae2c1d9464cf82e431a6e0c7c275c46133578.1519378872.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a24cd8dc-76ef-e57a-0f6e-7305e1946a23@gmail.com>
Date: Mon, 19 Mar 2018 00:49:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8cfae2c1d9464cf82e431a6e0c7c275c46133578.1519378872.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/23/2018 11:16 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Complement the missing clock properties cpu[1-3] should depend on.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org

Pushed to v4.16-next/dts32

Thanks!

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
> 
