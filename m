Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbeB1FHA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 00:07:00 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33662 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeB1FG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 00:06:57 -0500
X-Google-Smtp-Source: AG47ELs6mua+p/AJAJsEIqeBvT0piSSZ+QQjbMYOfbcvzrKcs/7K8YxVXBAHEnNji2ZSPulrcGyw2g==
Date: Wed, 28 Feb 2018 13:06:39 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Xu YiPing <xuyiping@hisilicon.com>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org,
        mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com,
        will.deacon@arm.com, xuejiancheng@hisilicon.com, wenpan@hisilicon.com,
        zhangfei.gao@linaro.org, guodong.xu@linaro.org, zhongkaihua@huawei.com,
        chenjun14@huawei.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzhuangluan@hisilicon.com,
        xuezhiliang@hisilicon.com, kevin.wangtao@hisilicon.com
Subject: Re: [PATCH v3 3/3] arm64: dts: Hi3660: Add binding for stub clock
Message-ID: <20180228050639.GA20745@leoy-ThinkPad-T440>
References: <1510910852-2175-1-git-send-email-xuyiping@hisilicon.com>
 <1510910852-2175-4-git-send-email-xuyiping@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510910852-2175-4-git-send-email-xuyiping@hisilicon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Fri, Nov 17, 2017 at 05:27:32PM +0800, Xu YiPing wrote:
> From: Kaihua Zhong <zhongkaihua@huawei.com>
> 
> Add DT binding for Hi3660 stub clock driver.
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Kai Zhao <zhaokai1@hisilicon.com>
> Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
> Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
> Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>

Could you help to pick up this patch? Thanks!

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 451b6bf..cbbc7f1 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -293,6 +293,13 @@
>  			#mbox-cells = <3>;
>  		};
>  
> +		stub_clock: stub_clock@e896b500 {
> +			compatible = "hisilicon,hi3660-stub-clk";
> +			reg = <0x0 0xe896b500 0x0 0x0100>;
> +			#clock-cells = <1>;
> +			mboxes = <&mailbox 13 3 0>;
> +		};
> +
>  		dual_timer0: timer@fff14000 {
>  			compatible = "arm,sp804", "arm,primecell";
>  			reg = <0x0 0xfff14000 0x0 0x1000>;
> -- 
> 1.9.1
> 
