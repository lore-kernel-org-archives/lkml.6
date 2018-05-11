Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeEKLZ2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:25:28 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41895 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752950AbeEKLZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:25:26 -0400
X-Google-Smtp-Source: AB8JxZrQ9oCTjToU7QfN9OU5EsMcJ5pccbmoaLbRo6ZugpjmmZij9HtSEWqKxYsHZBcJTQprQiionQ==
Date: Fri, 11 May 2018 13:25:23 +0200
From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: laurent.pinchart@ideasonboard.com, horms@verge.net.au, geert@glider.be,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77995: Add VIN4
Message-ID: <20180511112523.GK18974@bigcity.dyn.berto.se>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526032802-14376-3-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526032802-14376-3-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thanks for your work.

On 2018-05-11 12:00:01 +0200, Jacopo Mondi wrote:
> Describe VIN4 interface for R-Car D3 R8A77995 SoC.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Acked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> index 82aed7e..bdf7017 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> @@ -783,6 +783,17 @@
>  				};
>  			};
>  		};
> +
> +		vin4: video@e6ef4000 {
> +			compatible = "renesas,vin-r8a77995";
> +			reg = <0 0xe6ef4000 0 0x1000>;
> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 807>;
> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets = <&cpg 807>;
> +			renesas,id = <4>;
> +			status = "disabled";
> +		};
>  	};
>  
>  	timer {
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
