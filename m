Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeENLt7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:49:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44436 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbeENLt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:49:57 -0400
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: armada-xp-98dx: Add NAND pinctrl information
References: <20180504030638.31521-1-chris.packham@alliedtelesis.co.nz>
        <20180504030638.31521-2-chris.packham@alliedtelesis.co.nz>
Date: Mon, 14 May 2018 13:49:43 +0200
In-Reply-To: <20180504030638.31521-2-chris.packham@alliedtelesis.co.nz> (Chris
        Packham's message of "Fri, 4 May 2018 15:06:38 +1200")
Message-ID: <87mux2319k.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,
 
 On ven., mai 04 2018, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Add pin control information for the NAND interface on the Armada
> 98DX3236 and variants.
>


Applied on mvebu/dt

Thanks,

Gregory


> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> index 9a589abd0379..099dc2520082 100644
> --- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> @@ -312,6 +312,19 @@
>  &pinctrl {
>  	compatible = "marvell,98dx3236-pinctrl";
>  
> +	nand_pins: nand-pins {
> +		marvell,pins = "mpp20", "mpp21", "mpp22",
> +			       "mpp23", "mpp24", "mpp25",
> +			       "mpp26", "mpp27", "mpp28",
> +			       "mpp29", "mpp30";
> +		marvell,function = "dev";
> +	};
> +
> +	nand_rb: nand-rb {
> +		marvell,pins = "mpp19";
> +		marvell,function = "nand";
> +	};
> +
>  	spi0_pins: spi0-pins {
>  		marvell,pins = "mpp0", "mpp1",
>  			       "mpp2", "mpp3";
> -- 
> 2.17.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
