Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946737AbeCBQET (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:04:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42632 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1946722AbeCBQER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:04:17 -0500
Subject: Re: [PATCH 05/10] ARM64: dts: hi6220: Remove
 "cooling-{min|max}-level" for CPU nodes
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <68740229a7397336ae92bad65f69a58c91819c37.1518166039.git.viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-kernel@vger.kernel.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5A9975EA.3010306@hisilicon.com>
Date: Fri, 2 Mar 2018 16:03:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <68740229a7397336ae92bad65f69a58c91819c37.1518166039.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.47]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 2018/2/9 8:58, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> a CPU cooling device is found by referring to the cpufreq table instead.
> 
> Moreover, the entries are incorrect here as min level is 4 and the max
> level is 0.
> 
> Remove the unused properties from the CPU nodes.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Applied into hisilicon dt tree.
Thanks!

BR,
Wei

>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 6a180d1926e8..fca8e4ee98e7 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -88,8 +88,6 @@
>  			next-level-cache = <&CLUSTER0_L2>;
>  			clocks = <&stub_clock 0>;
>  			operating-points-v2 = <&cpu_opp_table>;
> -			cooling-min-level = <4>;
> -			cooling-max-level = <0>;
>  			#cooling-cells = <2>; /* min followed by max */
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>  			dynamic-power-coefficient = <311>;
> 
