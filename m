Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeCWN4V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752640AbeCWN4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:56:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6742168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=dinguyen@kernel.org
Subject: Re: [PATCH] arm: dts: socfpga: fix GIC PPI warning
To: Philipp Puschmann <pp@emlix.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180323092215.1307-1-pp@emlix.com>
From: Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <3b6eabf8-1d6b-7a58-03b1-3bff14c4127e@kernel.org>
Date: Fri, 23 Mar 2018 08:56:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323092215.1307-1-pp@emlix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/23/2018 04:22 AM, Philipp Puschmann wrote:
> Fixes the warning "GIC: PPI13 is secure or misconfigured" by
> changing the interrupt type from level_low to edge_raising
> 
> Signed-off-by: Philipp Puschmann <pp@emlix.com>
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 595eb4f1a761..e9417551d7ea 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -815,7 +815,7 @@
>  		timer@fffec600 {
>  			compatible = "arm,cortex-a9-twd-timer";
>  			reg = <0xfffec600 0x100>;
> -			interrupts = <1 13 0xf04>;
> +			interrupts = <1 13 0xf01>;
>  			clocks = <&mpu_periph_clk>;
>  		};

Applied, thanks!

Dinh
