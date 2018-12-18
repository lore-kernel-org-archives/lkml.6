Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2B1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FA420874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeLRMc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:32:28 -0500
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:34701 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726505AbeLRMc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:32:27 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id AF83C181D340F;
        Tue, 18 Dec 2018 12:32:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boot64_3224bfb460f5e
X-Filterd-Recvd-Size: 3817
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Dec 2018 12:32:24 +0000 (UTC)
Message-ID: <8f03c13235ff5ad6f0ad6af59d4d7db501fb8c96.camel@perches.com>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: update list of qcom drivers
From:   Joe Perches <joe@perches.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        marc.w.gonzalez@free.fr, bjorn.andersson@linaro.org,
        kvalo@adurom.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Dec 2018 04:32:23 -0800
In-Reply-To: <d153a86748f99526e7790bfc4ef8781a2016fd51.1545126964.git.amit.kucheria@linaro.org>
References: <cover.1545126964.git.amit.kucheria@linaro.org>
         <d153a86748f99526e7790bfc4ef8781a2016fd51.1545126964.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 15:29 +0530, Amit Kucheria wrote:
> Several drivers didn't have a specific maintainer (other than the
> subsystem maintainer). Add all drivers referring to qcom or msm to the
> list of supported drivers.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -1929,20 +1929,61 @@ M:	Andy Gross <andy.gross@linaro.org>
>  M:	David Brown <david.brown@linaro.org>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> +F:	include/dt-bindings/*/qcom*
> +F:	include/linux/*/qcom*
>  F:	Documentation/devicetree/bindings/soc/qcom/
> +F:	Documentation/devicetree/bindings/*/qcom*
>  F:	arch/arm/boot/dts/qcom-*.dts
>  F:	arch/arm/boot/dts/qcom-*.dtsi
>  F:	arch/arm/mach-qcom/
> -F:	arch/arm64/boot/dts/qcom/*
> -F:	drivers/i2c/busses/i2c-qup.c
> +F:	arch/arm64/boot/dts/qcom/
> +F:	drivers/bluetooth/btqcomsmd.c
> +F:	drivers/bus/qcom*
> +F:	drivers/cpufreq/qcom*
>  F:	drivers/clk/qcom/
> +F:	drivers/clocksource/timer-qcom.c
> +F:	drivers/crypto/qcom-*
>  F:	drivers/dma/qcom/
> +F:	drivers/edac/qcom*
> +F:	drivers/extcon/extcon-qcom*
> +F:	drivers/firmware/qcom*
> +F:	drivers/hwspinlock/qcom_*
> +F:	drivers/iio/adc/qcom*
> +F:	drivers/iommu/qcom*
> +F:	drivers/iommu/msm*
> +F:	drivers/i2c/busses/i2c-qup.c
> +F:	drivers/i2c/busses/i2c-qcom-geni.c
> +F:	drivers/irqchip/qcom*
> +F:	drivers/mailbox/qcom-*
> +F:	drivers/media/platform/qcom/
> +F:	drivers/mfd/qcom*
> +F:	drivers/mfd/ssbi.c
> +F:	drivers/misc/qcom-*
> +F:	drivers/mmc/host/mmci_qcom*
> +F:	drivers/mmc/host/sdhci_msm.c
> +F:	drivers/mtd/*/qcom*
> +F:	drivers/pci/controller/dwc/pcie-qcom.c
> +F:	drivers/perf/qcom*
> +F:	drivers/pinctrl/qcom/
> +F:	drivers/phy/qualcomm/
> +F:	drivers/power/*/qcom*
> +F:	drivers/power/*/msm*
> +F:	drivers/regulator/qcom*
> +F:	drivers/reset/reset-qcom-*
> +F:	drivers/remoteproc/qcom*
> +F:	drivers/rpmsg/qcom*
> +F:	drivers/scsi/ufs/ufs-qcom.*
> +F:	drivers/slimbus/qcom*
>  F:	drivers/soc/qcom/
>  F:	drivers/spi/spi-qup.c
> +F:	drivers/spi/spi-geni-qcom.c
> +F:	drivers/spi/spi-qcom-qspi.c
> +F:	drivers/thermal/qcom/
>  F:	drivers/tty/serial/msm_serial.c
> +F:	drivers/tty/serial/qcom*
> +F:	drivers/usb/dwc3/dwc3-qcom.c
> +F:	drivers/watchdog/qcom*
>  F:	drivers/*/pm8???-*
> -F:	drivers/mfd/ssbi.c
> -F:	drivers/firmware/qcom_scm*
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git

Perhaps many of these could be consolidated like

F:	drivers/*/qcom/
F:	drivers/*/qcom*
F:	drivers/*/*/qcom/
F:	drivers/*/*/qcom
*



