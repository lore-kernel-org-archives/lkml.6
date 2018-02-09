Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeBIJEO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:04:14 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41425 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbeBIJEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:04:07 -0500
X-Google-Smtp-Source: AH8x227U4KYcB0dfK5Z7jln63jTf6wlbQSMKuaCLjUONscWM/4aSYkkJq7A+g+Wc/0ITZvaHq4YUPA==
Subject: Re: [PATCH 08/10] ARM64: dts: meson: Remove "cooling-{min|max}-level"
 for gpio-fan node
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-amlogic@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <24b53440922491982c781a3eb032b04c167d733d.1518166039.git.viresh.kumar@linaro.org>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <3237154b-18a9-9e8b-1e5f-a7ce261fe3ae@baylibre.com>
Date: Fri, 9 Feb 2018 10:04:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <24b53440922491982c781a3eb032b04c167d733d.1518166039.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2018 09:58, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> gpio-fan cooling device is found by referring to the
> "gpio-fan,speed-map" instead.
> 
> Remove the unused properties from the gpio-fan node.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 658215c9822c..8ee4a693c438 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -59,8 +59,6 @@
>  				      1 1
>  				      2 2
>  				      3 3>;
> -		cooling-min-level = <0>;
> -		cooling-max-level = <3>;
>  		#cooling-cells = <2>;
>  	};
>  
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
