Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbeBUJf1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:35:27 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33957 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbeBUJfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:35:25 -0500
Message-ID: <1519205712.22130.10.camel@pengutronix.de>
Subject: Re: [PATCH v4] MAINTAINERS: add Freescale pin controllers
From: Lucas Stach <l.stach@pengutronix.de>
To: Stefan Agner <stefan@agner.ch>, linus.walleij@linaro.org,
        aisheng.dong@nxp.com, fabio.estevam@nxp.com, shawnguo@kernel.org,
        kernel@pengutronix.de
Cc: joe@perches.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date: Wed, 21 Feb 2018 10:35:12 +0100
In-Reply-To: <20180220225546.15987-1-stefan@agner.ch>
References: <20180220225546.15987-1-stefan@agner.ch>
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

Am Dienstag, den 20.02.2018, 23:55 +0100 schrieb Stefan Agner:
> Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as maintainer
> and the Pengutronix kernel team as reviewer.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93a12af4f180..ac007ea02d54 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10926,6 +10926,17 @@ L:	linux-gpio@vger.kernel.org
>  S:	Supported
>  F:	drivers/pinctrl/pinctrl-at91-pio4.*
>  
> +PIN CONTROLLER - FREESCALE
> +M:	Dong Aisheng <aisheng.dong@nxp.com>
> +M:	Fabio Estevam <festevam@gmail.com>
> +M:	Shawn Guo <shawnguo@kernel.org>
> +M:	Stefan Agner <stefan@agner.ch>
> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> +L:	linux-gpio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pinctrl/freescale/
> +F:	Documentation/devicetree/bindings/pinctrl/fsl,*
> +
>  PIN CONTROLLER - INTEL
>  M:	Mika Westerberg <mika.westerberg@linux.intel.com>
>  M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
