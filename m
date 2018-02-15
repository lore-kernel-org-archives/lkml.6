Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967926AbeBOLzY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 06:55:24 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34554 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967850AbeBOLzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 06:55:22 -0500
X-Google-Smtp-Source: AH8x227ZlTy+D4M6l1s9YMLQ5l+1jVWgZwVqvfG5Tn1OjXrws3x5F83lUsHWk+ort5slp+4mwIlTeg==
Subject: Re: [PATCH] ARM64: dts: meson-axg: fix pwm_AO_cd compatible
To: Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180215101031.18934-1-jbrunet@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <9a161f47-3e4a-d1ed-f829-d6989191583a@baylibre.com>
Date: Thu, 15 Feb 2018 12:55:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215101031.18934-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2018 11:10, Jerome Brunet wrote:
> The compatible in pwm_AO_cd is wrong and does not match anything.
> Correct this with the correct compatible string
> 
> Fixes: 4a81e5ddfb43 ("ARM64: dts: meson-axg: add PWM DT info for Meson-Axg SoC")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index a7cc9e401a92..880e25b113c1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -844,7 +844,7 @@
>  			};
>  
>  			pwm_AO_cd: pwm@2000 {
> -				compatible = "amlogic,axg-ao-pwm";
> +				compatible = "amlogic,meson-axg-ao-pwm";
>  				reg = <0x0 0x02000  0x0 0x20>;
>  				#pwm-cells = <3>;
>  				status = "disabled";
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
