Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeBTWzN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:55:13 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:53958 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeBTWzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:55:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Feb 2018 23:55:10 +0100
From: Stefan Agner <stefan@agner.ch>
To: linus.walleij@linaro.org, aisheng.dong@nxp.com, fabio.estevam@nxp.com,
        shawnguo@kernel.org, kernel@pengutronix.de
Cc: joe@perches.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: add Freescale pin controllers
In-Reply-To: <20180220225130.14468-1-stefan@agner.ch>
References: <20180220225130.14468-1-stefan@agner.ch>
Message-ID: <97f4bb7e07c1d69a81aceee511d5ff73@agner.ch>
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.02.2018 23:51, Stefan Agner wrote:
> Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as maintainer
> and the Pengutronix kernel team as reviewer.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93a12af4f180..621f3ec7e85e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10926,6 +10926,17 @@ L:	linux-gpio@vger.kernel.org
>  S:	Supported
>  F:	drivers/pinctrl/pinctrl-at91-pio4.*
>  
> +PIN CONTROLLER - FREESCALE
> +M:	Dong Aisheng <aisheng.dong@nxp.com>
> +M:	Fabio Estevam <festevam@gmail.com>
> +M:	Shawn Guo <shawnguo@kernel.org>
> +M:	Stefan Agner <stefan@agner.ch>
> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> +L:	linux-gpio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pinctrl/freescale/*

Oops, missed to remove the asterisk. Will resend v4.

--
Stefan

> +F:	Documentation/devicetree/bindings/pinctrl/fsl,*
> +
>  PIN CONTROLLER - INTEL
>  M:	Mika Westerberg <mika.westerberg@linux.intel.com>
>  M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
