Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932584AbeCLQpu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:45:50 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40436 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbeCLQpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:45:35 -0400
X-Google-Smtp-Source: AG47ELv9DjtsK7jpp5thUfwDWE86i6fLydGjV3XJH3GBnxgncH+wrg/R6OqA82CFXlPunVs6oIeN4g==
Date: Mon, 12 Mar 2018 09:45:32 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Craig Tatlor <ctatlor97@gmail.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: msm8974: castor: Correct typo in touchscreen
 compatible string
Message-ID: <20180312164532.GA1016@minitux>
References: <20180312160734.5606-1-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312160734.5606-1-ctatlor97@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12 Mar 09:07 PDT 2018, Craig Tatlor wrote:

> This was mistakenly pulled from the downstream tree.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

Thanks Craig,

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
> index e87f2c99060d..d85311a0422c 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts
> @@ -491,7 +491,7 @@
>  		pinctrl-0 = <&i2c8_pins>;
>  
>  		synaptics@2c {
> -			compatible = "syna,rmi-i2c";
> +			compatible = "syna,rmi4-i2c";
>  			reg = <0x2c>;
>  
>  			interrupt-parent = <&msmgpio>;
> -- 
> 2.16.1
> 
