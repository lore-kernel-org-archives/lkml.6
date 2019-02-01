Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD46AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51FE207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfBAQhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:37:46 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726486AbfBAQhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:37:45 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id B9C8FD0510ED6E051F4D;
        Fri,  1 Feb 2019 16:37:44 +0000 (GMT)
Received: from [127.0.0.1] (10.202.226.46) by lhreml702-cah.china.huawei.com
 (10.201.108.43) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 16:37:44 +0000
Subject: Re: [PATCH][RESEND] arm64: dts: hikey: Add DMA entries for Bluetooth
 UART
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ryan Grachek <ryan@edited.us>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <1548275437-6022-1-git-send-email-john.stultz@linaro.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <87f70896-70b4-48c9-f189-fd8e387f2dcc@hisilicon.com>
Date:   Fri, 1 Feb 2019 16:37:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548275437-6022-1-git-send-email-john.stultz@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 1/23/2019 8:30 PM, John Stultz wrote:
> Add dma0 references for bluetooth uart to enable dma
> for bt transfers.
> 
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Applied to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index aec9e37..fa15a08 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -319,6 +319,8 @@
>  			clock-names = "uartclk", "apb_pclk";
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func1 &uart1_cfg_func2>;
> +			dmas = <&dma0 8 &dma0 9>;
> +			dma-names = "rx", "tx";
>  			status = "disabled";
>  		};
>  
> 

