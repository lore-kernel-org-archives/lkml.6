Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeCEPbo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:31:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41705 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbeCEPbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:31:42 -0500
Message-ID: <1520263858.4095.10.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] ARM: dts: imx51-zii-rdu1: Add node for RAVE SP
 device
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Mon, 05 Mar 2018 16:30:58 +0100
In-Reply-To: <20180301192007.29278-2-andrew.smirnov@gmail.com>
References: <20180301192007.29278-1-andrew.smirnov@gmail.com>
         <20180301192007.29278-2-andrew.smirnov@gmail.com>
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

Am Donnerstag, den 01.03.2018, 11:20 -0800 schrieb Andrey Smirnov:
> With MFD and watchdog drivers for RAVE SP device support added by
> 538ee27290fa ("mfd: Add driver for RAVE Supervisory Processor") and
> c3bb33345721 ("watchdog: Add RAVE SP watchdog driver") add
> corresponding DT node for RDU.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx51-zii-rdu1.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index 5306b78de0ca..84ad5ceefecc 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -568,6 +568,15 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart3>;
>  	status = "okay";
> +
> +	rave-sp {
> +		compatible = "zii,rave-sp-rdu1";
> +		current-speed = <38400>;
> +
> +		watchdog {
> +			compatible = "zii,rave-sp-watchdog";
> +		};
> +	};
>  };
>  
>  &usbh1 {
