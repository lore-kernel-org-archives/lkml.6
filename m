Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeB1Bzo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 20:55:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43402 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751521AbeB1Bzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 20:55:43 -0500
Subject: Re: [linux-sunxi] [PATCH v2 3/4] ARM: dts: add pwm status for r40.
To: hao5781286@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, maxime.ripard@free-electrons.com
References: <20180225135225.GA14544@arx-s1>
Cc: linux@armlinux.org.uk, Claudiu.Beznea@microchip.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <0fd023da-214a-c4ef-63f7-0cc41ca716bf@arm.com>
Date: Wed, 28 Feb 2018 01:54:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180225135225.GA14544@arx-s1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the subject line should mention the BananaPi M2 Ultra board.

Otherwise this looks good, although I wonder if this should somehow
mention "LCD-PWM" (in the commit message?), since this is how this pin
is described in the BananaPi GPIO documentation for this board.
And it seems to be dedicated for this purpose here.

Cheers,
Andre.

On 25/02/18 13:52, hao_zhang wrote:
> This patch adds pwm status for r40.
> 
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> index 8c5efe2..e4eb074 100644
> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> @@ -196,6 +196,12 @@
>  	status = "okay";
>  };
>  
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_ch0_pin>;
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pb_pins>;
> 
