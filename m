Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B065CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8155020840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389355AbfAPKMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:12:31 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50589 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389243AbfAPKMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:12:31 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gjiBL-0004pE-VS; Wed, 16 Jan 2019 11:12:23 +0100
Message-ID: <1547633543.4339.30.camel@pengutronix.de>
Subject: Re: [PATCH v3] arm64: defconfig: Add i.MX8MQ boot necessary configs
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 16 Jan 2019 11:12:23 +0100
In-Reply-To: <1547631712-24544-1-git-send-email-abel.vesa@nxp.com>
References: <1547631712-24544-1-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 16.01.2019, 09:41 +0000 schrieb Abel Vesa:
> Enable all the i.MX8MQ configs necessary to boot.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> 
> Changes since v2:
>  * run savedefconfig to order the newly added configs
> 
>  arch/arm64/configs/defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig
> b/arch/arm64/configs/defconfig
> index 032912e..6e5af25 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -323,6 +323,8 @@ CONFIG_SERIAL_MESON_CONSOLE=y
>  CONFIG_SERIAL_SAMSUNG=y
>  CONFIG_SERIAL_SAMSUNG_CONSOLE=y
>  CONFIG_SERIAL_TEGRA=y
> +CONFIG_SERIAL_IMX=y
> +CONFIG_SERIAL_IMX_CONSOLE=y
>  CONFIG_SERIAL_SH_SCI=y
>  CONFIG_SERIAL_MSM=y
>  CONFIG_SERIAL_MSM_CONSOLE=y
> @@ -371,6 +373,7 @@ CONFIG_SPI_SPIDEV=m
>  CONFIG_SPMI=y
>  CONFIG_PINCTRL_SINGLE=y
>  CONFIG_PINCTRL_MAX77620=y
> +CONFIG_PINCTRL_IMX8MQ=y
>  CONFIG_PINCTRL_IMX8QXP=y
>  CONFIG_PINCTRL_IPQ8074=y
>  CONFIG_PINCTRL_MSM8916=y
> @@ -628,6 +631,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
>  CONFIG_COMMON_CLK_S2MPS11=y
>  CONFIG_CLK_QORIQ=y
>  CONFIG_COMMON_CLK_PWM=y
> +CONFIG_CLK_IMX8MQ=y
>  CONFIG_CLK_IMX8QXP=y
>  CONFIG_TI_SCI_CLK=y
>  CONFIG_COMMON_CLK_QCOM=y
> @@ -661,6 +665,7 @@ CONFIG_RPMSG_QCOM_GLINK_RPM=y
>  CONFIG_RPMSG_QCOM_GLINK_SMEM=m
>  CONFIG_RPMSG_QCOM_SMD=y
>  CONFIG_RASPBERRYPI_POWER=y
> +CONFIG_IMX_GPCV2_PM_DOMAINS=y
>  CONFIG_QCOM_COMMAND_DB=y
>  CONFIG_QCOM_GENI_SE=y
>  CONFIG_QCOM_GLINK_SSR=m
