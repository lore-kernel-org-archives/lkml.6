Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932354AbeCOQlh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:41:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36016 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751458AbeCOQlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:41:35 -0400
Subject: Re: [PATCH v7 3/3] dts: arm64: Add mailbox binding for hi3660
To: Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Ruyi Wang <wangruyi@huawei.com>
References: <1521130058-24796-1-git-send-email-leo.yan@linaro.org>
 <1521130058-24796-4-git-send-email-leo.yan@linaro.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5AAAA22E.5030009@hisilicon.com>
Date: Thu, 15 Mar 2018 16:41:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1521130058-24796-4-git-send-email-leo.yan@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 2018/3/15 16:07, Leo Yan wrote:
> From: Kaihua Zhong <zhongkaihua@huawei.com>
> 
> Add DT binding for mailbox driver.
> 
> Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
> Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>

Fine to me. Thanks!
Acked-by: Wei Xu <xuwei5@hisilicon.com>

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 63d4f9d..3788448 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -298,6 +298,14 @@
>  			#reset-cells = <2>;
>  		};
>  
> +		mailbox: mailbox@e896b000 {
> +			compatible = "hisilicon,hi3660-mbox";
> +			reg = <0x0 0xe896b000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <3>;
> +		};
> +
>  		dual_timer0: timer@fff14000 {
>  			compatible = "arm,sp804", "arm,primecell";
>  			reg = <0x0 0xfff14000 0x0 0x1000>;
> 
