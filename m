Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeCPKUC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:20:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752794AbeCPKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:19:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Mar 2018 15:49:29 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH v2 03/13] ARM: dts: ipq4019: Change the max opp frequency
In-Reply-To: <1521193101-4586-4-git-send-email-sricharan@codeaurora.org>
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-4-git-send-email-sricharan@codeaurora.org>
Message-ID: <77ec3dbe81448b43eb22297731bc5c96@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-16 15:08, Sricharan R wrote:
> The max opp frequency is 716MHZ. So update that.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

  Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>

> ---
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> index e38fffa..2ee71c2 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -47,7 +47,7 @@
>  				48000	1100000
>  				200000	1100000
>  				500000	1100000
> -				666000	1100000
> +				716000  1100000
>  			>;
>  			clock-latency = <256000>;
>  		};
