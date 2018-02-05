Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeBEGLA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:11:00 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41830 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbeBEGJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:09:40 -0500
X-Google-Smtp-Source: AH8x224V0EeCBTVczN4N03MGg1a+kUpmv/WQhPlxI00++YO+0GW/59clfME1hxoTrLj/6S4KDbqCjA==
Date: Mon, 5 Feb 2018 00:09:38 -0600
From: Rob Herring <robh@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        fabio.estevam@nxp.com, linux-kernel@vger.kernel.org,
        wakasugi.jb@om.asahi-kasei.co.jp, shengjiu.wang@nxp.com,
        mihai.serban@gmail.com, cosmin.samoila@nxp.com, linux-imx@nxp.com,
        daniel.baluta@gmail.com
Subject: Re: [PATCH v2 2/2] ASoC: ak5558: Add bindings for AK5558 ADC
Message-ID: <20180205025914.jy4wdan3gibyyzxe@rob-hp-laptop>
References: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com>
 <1517588406-3295-3-git-send-email-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517588406-3295-3-git-send-email-daniel.baluta@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 06:20:06PM +0200, Daniel Baluta wrote:
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/ak5558.txt | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
> new file mode 100644
> index 0000000..61c85568
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ak5558.txt
> @@ -0,0 +1,23 @@
> +AK5558 8 channel differential 32-bit delta-sigma ADC
> +
> +This device supports I2C mode only.
> +
> +Required properties:
> +
> +- compatible : "asahi-kasei,ak5558"
> +- reg : The I2C address of the device for I2C.
> +
> +Optional properties:
> +
> +- reset-gpios: A GPIO specifier for the GPIO controlling
> +	the power down & reset pin.
> +
> +Example:
> +
> +&i2c {
> +	ak5558: ak5558@10 {

adc@10

> +		compatible = "asahi-kasei,ak5558";
> +		reg = <0x10>;
> +		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> +	};
> +};
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
