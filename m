Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934507AbeBMQLL convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:11:11 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:58377 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933698AbeBMQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:11:10 -0500
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: armada: netgear-rn*: fix rtc node name
References: <20180210064130.6422-1-alexandre.belloni@bootlin.com>
Date: Tue, 13 Feb 2018 17:11:08 +0100
In-Reply-To: <20180210064130.6422-1-alexandre.belloni@bootlin.com> (Alexandre
        Belloni's message of "Sat, 10 Feb 2018 07:41:30 +0100")
Message-ID: <87h8qkq38j.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,
 
 On sam., févr. 10 2018, Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> The node name should be generic and must not contain the part number.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied on mvebu/dt

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 2 +-
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts | 2 +-
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> index b1a96e95e921..d2225bd4a76f 100644
> --- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> @@ -103,7 +103,7 @@
>  
>  				status = "okay";
>  
> -				isl12057: isl12057@68 {
> +				isl12057: rtc@68 {
>  					compatible = "isil,isl12057";
>  					reg = <0x68>;
>  					wakeup-source;
> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> index d67e7aa42b54..b73cae836bc1 100644
> --- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> @@ -105,7 +105,7 @@
>  
>  				status = "okay";
>  
> -				isl12057: isl12057@68 {
> +				isl12057: rtc@68 {
>  					compatible = "isil,isl12057";
>  					reg = <0x68>;
>  					wakeup-source;
> diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> index 40c6fe21e720..e66fe80cf279 100644
> --- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> +++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> @@ -115,7 +115,7 @@
>  					reg = <0x4c>;
>  				};
>  
> -				isl12057: isl12057@68 {
> +				isl12057: rtc@68 {
>  					compatible = "isil,isl12057";
>  					reg = <0x68>;
>  					wakeup-source;
> -- 
> 2.16.1
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
