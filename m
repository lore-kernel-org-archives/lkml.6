Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967941AbeBOLzk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 06:55:40 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51724 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967850AbeBOLzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 06:55:38 -0500
X-Google-Smtp-Source: AH8x227uiqR2il/1XfgAK10h6K9EKzh5tWT9+k9RJqS3IC8aMRMd7yFdGjdY3P62X8dKKNfFYQk4jA==
Subject: Re: [PATCH] ARM64: dts: meson-axg: add sec_AO system controller
To: Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180215101207.19186-1-jbrunet@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <412132e7-904d-61c4-d09f-0239e07a92be@baylibre.com>
Date: Thu, 15 Feb 2018 12:55:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215101207.19186-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2018 11:12, Jerome Brunet wrote:
> add the secure AO system controller with chipid enabled
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 880e25b113c1..7f4c00216b82 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -836,6 +836,12 @@
>  				};
>  			};
>  
> +			sec_AO: ao-secure@140 {
> +				compatible = "amlogic,meson-gx-ao-secure", "syscon";
> +				reg = <0x0 0x140 0x0 0x140>;
> +				amlogic,has-chip-id;
> +			};
> +
>  			pwm_AO_ab: pwm@7000 {
>  				compatible = "amlogic,meson-axg-ao-pwm";
>  				reg = <0x0 0x07000 0x0 0x20>;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
