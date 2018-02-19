Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753854AbeBSUf1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:35:27 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45242 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753685AbeBSUfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:35:25 -0500
X-Google-Smtp-Source: AH8x2243YVeVYH5UAB9O4bGGAnf2mGLf3W5yY/1xASDWqmpebzwqcAwhgafKIrmfllq3dz9qKm+QZA==
Date: Mon, 19 Feb 2018 14:35:23 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linus.walleij@linaro.org, afaerber@suse.de, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: gpio: Add gpio nodes for Actions S900
 SoC
Message-ID: <20180219203523.rhvbnym7oomzahwi@rob-hp-laptop>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-6-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217204433.3095-6-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 02:14:28AM +0530, Manivannan Sadhasivam wrote:
> Add gpio nodes for Actions Semi S900 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/gpio/actions,owl-gpio.txt         | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
> new file mode 100644
> index 000000000000..4cd4cb7bfd1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
> @@ -0,0 +1,15 @@
> +* Actions Semi OWL GPIO controller bindings
> +
> +- compatible      : Should be "actions,s900-gpio"
> +- reg             : Address and range of the GPIO controller registers.
> +- gpio-controller : Marks the device node as a GPIO controller.
> +- #gpio-cells     : Should be <2>. The first cell is the gpio number and
> +                    the second cell is used to specify optional parameters.

Doesn't do interrupts?

> +
> +Example:
> +       gpio: gpio@e01b0000 {
> +               compatible = "actions,s900-gpio";
> +               reg = <0x0 0xe01b0000 0x0 0x1000>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> -- 
> 2.14.1
> 
