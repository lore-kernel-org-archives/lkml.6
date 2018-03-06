Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeCFONZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:13:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39877 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753308AbeCFONX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:13:23 -0500
Message-ID: <1520345600.4095.19.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] dt-bindings: input: Add binding for RAVE SP
 input driver
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Chris Healy <cphealy@gmail.com>
Date: Tue, 06 Mar 2018 15:13:20 +0100
In-Reply-To: <20180301165527.22274-2-andrew.smirnov@gmail.com>
References: <20180301165527.22274-1-andrew.smirnov@gmail.com>
         <20180301165527.22274-2-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 01.03.2018, 08:55 -0800 schrieb Andrey Smirnov:
> Add Device Tree bindings for RAVE SP input drvier - an MFD cell of
> parent RAVE SP driver (documented in
> Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).
> 
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Acked-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  .../bindings/input/zii,rave-sp-pwrbutton.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt b/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
> new file mode 100644
> index 000000000000..e14e12d27772
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
> @@ -0,0 +1,24 @@
> +Zodiac Inflight Innovations RAVE Supervisory Processor Power Button Bindings
> +
> +RAVE SP input device is a "MFD cell" device corresponding to power
> +button functionality of RAVE Supervisory Processor. It is expected
> +that its Device Tree node is specified as a child of the node
> +corresponding to the parent RAVE SP device (as documented in
> +Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
> +
> +Required properties:
> +
> +- compatible: Should be "zii,rave-sp-pwrbutton"
> +
> +Example:
> +
> > +	rave-sp {
> > +		compatible = "zii,rave-sp-rdu1";
> > +		current-speed = <38400>;
> +
> > +		pwrbutton {
> > +			compatible = "zii,rave-sp-pwrbutton";
> > +			status = "okay";
> > +		};
> > +	}
> +
