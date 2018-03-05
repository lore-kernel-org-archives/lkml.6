Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbeCEW37 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:29:59 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43151 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753467AbeCEW34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:29:56 -0500
X-Google-Smtp-Source: AG47ELu3Ot+eFOt4xGLnBshgphJaYxUPeRyCP0V1QTLHZt2qm2e/20AAnB9Yk3HNTCLl4+e/fR6L2g==
Date: Mon, 5 Mar 2018 16:29:54 -0600
From: Rob Herring <robh@kernel.org>
To: Matt Porter <mporter@konsulko.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: add tda7419 audio processor binding
Message-ID: <20180305222954.chitmlvsklszods7@rob-hp-laptop>
References: <20180227225128.17815-1-mporter@konsulko.com>
 <20180227225128.17815-2-mporter@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227225128.17815-2-mporter@konsulko.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 05:51:27PM -0500, Matt Porter wrote:
> DeviceTree binding for the tda7419 audio processor.
> 
> Signed-off-by: Matt Porter <mporter@konsulko.com>
> ---
>  Documentation/devicetree/bindings/sound/tda7419.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tda7419.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/tda7419.txt b/Documentation/devicetree/bindings/sound/tda7419.txt
> new file mode 100644
> index 000000000000..919318315600
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tda7419.txt
> @@ -0,0 +1,15 @@
> +TDA7419 audio processor
> +
> +This device supports I2C only.
> +
> +Required properties:
> +
> +- compatible : "st,tda7419"
> +- reg : the I2C address of the device.

For completeness:

st,mute-gpios for MUTE pin?

vdd-supply?

> +
> +Example:
> +
> +ap: tda7419@44 {
> +	compatible = "st,tda7419";
> +	reg = <0x44>;
> +};
> -- 
> 2.11.0
> 
