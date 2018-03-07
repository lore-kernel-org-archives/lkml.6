Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933937AbeCGQax (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:30:53 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40014 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933665AbeCGQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:30:49 -0500
X-Google-Smtp-Source: AG47ELutvm4JqLAGJTckFeH/yfLDHd7XHu+SjizReO8nPwrFoM1NpiER1u4pVUYC1hyB1hY/yUI+TA==
Date: Wed, 7 Mar 2018 16:30:45 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv5 1/5] dt-bindings: mfd: motorola-cpcap: document
 audio-codec
Message-ID: <20180307163045.cwufiv2xhi4fdxo2@dell>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-2-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180223200254.25685-2-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018, Sebastian Reichel wrote:

> This adds the DT binding for the audio-codec sub-module found
> inside the Motorola CPCAP PMIC.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  .../devicetree/bindings/mfd/motorola-cpcap.txt     | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
> index 15bc885f9df4..82c3a7140660 100644
> --- a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
> +++ b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
> @@ -12,6 +12,30 @@ Required properties:
>  - spi-max-frequency	: Typically set to 3000000
>  - spi-cs-high		: SPI chip select direction
>  
> +Optional subnodes:
> +
> +The sub-functions of CPCAP get their own node with their own compatible values,
> +which are described in the following files:
> +
> +- Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
> +- Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
> +- Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> +- Documentation/devicetree/bindings/phy/phy-cpcap-usb.txt
> +- Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
> +- Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
> +- Documentation/devicetree/bindings/leds/leds-cpcap.txt
> +- Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt

Nit: Best to use relative path names here (hint: DT docs might not
live in there kernel forever).

Other than that:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
