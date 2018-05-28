Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939480AbeE1OzW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:55:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55276 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937213AbeE1OxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:53:15 -0400
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] arm: dts: armada: Fix "#cooling-cells" property's name
References: <cover.1527244200.git.viresh.kumar@linaro.org>
        <cover.1527244200.git.viresh.kumar@linaro.org>
        <26a0666368694db610414a85a08843435ea070a7.1527244201.git.viresh.kumar@linaro.org>
Date: Mon, 28 May 2018 16:53:04 +0200
In-Reply-To: <26a0666368694db610414a85a08843435ea070a7.1527244201.git.viresh.kumar@linaro.org>
        (Viresh Kumar's message of "Fri, 25 May 2018 16:01:47 +0530")
Message-ID: <8736ybygq7.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,
 
 On ven., mai 25 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> It should be "#cooling-cells" instead of "cooling-cells". Fix it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>


Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-385-synology-ds116.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-385-synology-ds116.dts b/arch/arm/boot/dts/armada-385-synology-ds116.dts
> index 6782ce481ac9..d8769956cbfc 100644
> --- a/arch/arm/boot/dts/armada-385-synology-ds116.dts
> +++ b/arch/arm/boot/dts/armada-385-synology-ds116.dts
> @@ -139,7 +139,7 @@
>  					      3700 5
>  					      3900 6
>  					      4000 7>;
> -			cooling-cells = <2>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		gpio-leds {
> -- 
> 2.15.0.194.g9af6a3dea062
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
