Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeBDTW6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 14:22:58 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45565 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeBDTWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 14:22:51 -0500
Date: Sun, 4 Feb 2018 20:22:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ken Lin <yungching0725@gmail.com>
Cc: shawnguo@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx: Add support for Advantech DMS-BA16
Message-ID: <20180204192246.GC24569@lunn.ch>
References: <20180204184514.2396-1-yungching0725@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180204184514.2396-1-yungching0725@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 02:45:14AM +0800, Ken Lin wrote:
> Add support for Advantech DMS-BA16 board, which use
> the Advantech BA-16 module.
> 
> Signed-off-by: Ken Lin <yungching0725@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile           |   1 +
>  arch/arm/boot/dts/imx6q-dms-ba16.dts | 154 +++++++++++++++++++++++++++++++++++
>  2 files changed, 155 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-dms-ba16.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..d97511273f30 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -428,6 +428,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-b450v3.dtb \
>  	imx6q-b650v3.dtb \
>  	imx6q-b850v3.dtb \
> +	imx6q-dms-ba16.dtb \
>  	imx6q-cm-fx6.dtb \
>  	imx6q-cubox-i.dtb \
>  	imx6q-cubox-i-emmc-som-v15.dtb \

Hi Ken

I think the intention is to keep this list sorted. So dms puts it
later, after cubox.

> @@ -0,0 +1,154 @@
> +/*
> + * Copyright 2018 Advantech Corporation
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "imx6q-ba16.dtsi"
> +
> +/ {
> +	model = "Advantech DMS-BA16";
> +	compatible = "fsl,imx6q-dms-ba16", "fsl,imx6q";

This looks wrong. I would expect "advantech,imx6q-dms-ba16".

     Andrew
