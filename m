Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeEOIxG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:53:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36367 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbeEOIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:52:50 -0400
Message-ID: <1526374356.3494.14.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx51-zii-rdu1: limit usbh1 to full-speed
From: Lucas Stach <l.stach@pengutronix.de>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Chris Healy <cphealy@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Marco Franchi <marcofrk@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 15 May 2018 10:52:36 +0200
In-Reply-To: <20180515084502.17148-1-nikita.yoush@cogentembedded.com>
References: <20180515084502.17148-1-nikita.yoush@cogentembedded.com>
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

Am Dienstag, den 15.05.2018, 11:45 +0300 schrieb Nikita Yushchenko:
> On RDU1, imx51 usbh1 interface is either not used, or used via
> external
> block that breaks USB2 signalling.
> 
> To keep things working if high-speed device gets connected to that
> block, use ChipIdea feature to limit port to full speed.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx51-zii-rdu1.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index 36a63ae52e48..c26f053f29b0 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -603,6 +603,7 @@
>  	phy_type = "ulpi";
>  	fsl,usbphy = <&usbh1phy>;
>  	disable-over-current;
> +	maximum-speed = "full-speed";
>  	vbus-supply = <&reg_5p0v_main>;
>  	status = "okay";
>  };
