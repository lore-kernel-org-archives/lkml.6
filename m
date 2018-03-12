Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbeCLEfj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 00:35:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37301 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeCLEfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 00:35:36 -0400
X-Google-Smtp-Source: AG47ELs+0weMBcSiVnxxZ5X+XBRxxtec01x6WGc+61YuctQdZh3jZ4c/WGEeE+8ngfOSxwG8wVqdBQ==
Date: Mon, 12 Mar 2018 10:05:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] ARM: dts: gemini: Remove "cooling-{min|max}-level"
 for gpio-fan node
Message-ID: <20180312043533.GU6842@vireshk-i7>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <01ddf0ac8962feb63e8871a2c2c3498c763f649b.1518166039.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ddf0ac8962feb63e8871a2c2c3498c763f649b.1518166039.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-02-18, 14:28, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> gpio-fan cooling device is found by referring to the
> "gpio-fan,speed-map" instead.
> 
> Remove the unused properties from the gpio-fan node.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/gemini-dlink-dns-313.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> index 08568ce24d06..727d16eb02d9 100644
> --- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> +++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> @@ -78,8 +78,6 @@
>  		gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>,
>  			<&gpio0 12 GPIO_ACTIVE_HIGH>;
>  		gpio-fan,speed-map = <0 0>, <3000 1>, <6000 2>;
> -		cooling-min-level = <0>;
> -		cooling-max-level = <2>;
>  		#cooling-cells = <2>;
>  	};
>  

@Linus: Can you please pick this one for 4.17 ?

-- 
viresh
