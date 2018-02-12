Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeBLKs2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:48:28 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46185 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbeBLKs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:48:27 -0500
Message-ID: <1518432502.2744.5.camel@pengutronix.de>
Subject: Re: [PATCH] MAINTAINERS: add Freescale pin controllers
From: Lucas Stach <l.stach@pengutronix.de>
To: Stefan Agner <stefan@agner.ch>, linus.walleij@linaro.org,
        aisheng.dong@nxp.com, fabio.estevam@nxp.com, shawnguo@kernel.org,
        kernel@pengutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Mon, 12 Feb 2018 11:48:22 +0100
In-Reply-To: <20180210153204.12728-1-stefan@agner.ch>
References: <20180210153204.12728-1-stefan@agner.ch>
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

Am Samstag, den 10.02.2018, 16:32 +0100 schrieb Stefan Agner:
> Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as maintainer
> and Sascha as reviewer.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 82ad0eabce4f..fb672dfc519d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10768,6 +10768,17 @@ L:	linux-gpio@vger.kernel.org
>  S:	Supported
>  F:	drivers/pinctrl/pinctrl-at91-pio4.*
>  
> +PIN CONTROLLER - FREESCALE
> +M:	Dong Aisheng <aisheng.dong@nxp.com>
> +M:	Fabio Estevam <festevam@gmail.com>
> +M:	Shawn Guo <shawnguo@kernel.org>
> +M:	Stefan Agner <stefan@agner.ch>
> +R:	Sascha Hauer <kernel@pengutronix.de>

I'm fine with the patch, but it might make sense to clarify this a bit:
the kernel@ address is really the whole Pengutronix kernel team, not
just Sascha. Using this address is totally fine if you expect comments
on patches, as it gives them a quite wide exposure inside of PTX.

Regards,
Lucas

> +L:	linux-gpio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pinctrl/freescale/*
> +F:	Documentation/devicetree/bindings/pinctrl/fsl,*
> +
>  PIN CONTROLLER - INTEL
>  M:	Mika Westerberg <mika.westerberg@linux.intel.com>
>  M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
