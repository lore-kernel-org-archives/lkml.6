Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938099AbeBUO6h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:58:37 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42525 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938088AbeBUO6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:58:32 -0500
X-Google-Smtp-Source: AH8x225clJWY4T+GQDrsFDNytvk0F71U92OlkAGCSbflLNiio80Hxrede4Dvw5oQ0oTv0YbJmLAXGQ==
Date: Wed, 21 Feb 2018 20:28:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: linus.walleij@linaro.org, afaerber@suse.de, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: gpio: Add gpio nodes for Actions S900
 SoC
Message-ID: <20180221145821.bhoxjndibp3bqfxi@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-6-manivannan.sadhasivam@linaro.org>
 <20180219203523.rhvbnym7oomzahwi@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219203523.rhvbnym7oomzahwi@rob-hp-laptop>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
On Mon, Feb 19, 2018 at 02:35:23PM -0600, Rob Herring wrote:
> On Sun, Feb 18, 2018 at 02:14:28AM +0530, Manivannan Sadhasivam wrote:
> > Add gpio nodes for Actions Semi S900 SoC.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/gpio/actions,owl-gpio.txt         | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
> > new file mode 100644
> > index 000000000000..4cd4cb7bfd1b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
> > @@ -0,0 +1,15 @@
> > +* Actions Semi OWL GPIO controller bindings
> > +
> > +- compatible      : Should be "actions,s900-gpio"
> > +- reg             : Address and range of the GPIO controller registers.
> > +- gpio-controller : Marks the device node as a GPIO controller.
> > +- #gpio-cells     : Should be <2>. The first cell is the gpio number and
> > +                    the second cell is used to specify optional parameters.
> 
> Doesn't do interrupts?
> 
Interrupt support will be added once this base driver gets in.
One step at a time ;-)

Thanks,
Mani
> > +
> > +Example:
> > +       gpio: gpio@e01b0000 {
> > +               compatible = "actions,s900-gpio";
> > +               reg = <0x0 0xe01b0000 0x0 0x1000>;
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +       };
> > -- 
> > 2.14.1
> > 
