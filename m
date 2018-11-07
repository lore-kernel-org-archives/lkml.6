Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4495C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0F920892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0F920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeKHGaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:30:30 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:16400 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeKHGa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:30:29 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 97CCA19F5A3;
        Wed,  7 Nov 2018 21:58:11 +0100 (CET)
Subject: Re: [PATCH 4/9] arm64: defconfig: Drop USB_ULPI_BUS and
 USB_CHIPIDEA_ULPI
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Fabio Estevam <fabio.estevam@nxp.com>,
        Peter Chen <peter.chen@nxp.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <e01448e5-9756-00a0-b51d-dbb27fe7c717@free.fr>
Message-ID: <f47c510c-9bf4-8b3e-3904-a4caa96b738f@free.fr>
Date:   Wed, 7 Nov 2018 21:58:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <e01448e5-9756-00a0-b51d-dbb27fe7c717@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Add interested parties ]

On 07/11/2018 21:15, Marc Gonzalez wrote:

> Commit a930d8bd94d8 ("usb: chipidea: Always build ULPI code")
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  arch/arm64/configs/defconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 58741c07a6ef..6fe418d72337 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -528,7 +528,6 @@ CONFIG_USB_DWC2=y
>  CONFIG_USB_CHIPIDEA=y
>  CONFIG_USB_CHIPIDEA_UDC=y
>  CONFIG_USB_CHIPIDEA_HOST=y
> -CONFIG_USB_CHIPIDEA_ULPI=y
>  CONFIG_USB_ISP1760=y
>  CONFIG_USB_HSIC_USB3503=y
>  CONFIG_NOP_USB_XCEIV=y
> @@ -536,7 +535,6 @@ CONFIG_USB_ULPI=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_RENESAS_USBHS_UDC=m
>  CONFIG_USB_RENESAS_USB3=m
> -CONFIG_USB_ULPI_BUS=y
>  CONFIG_MMC=y
>  CONFIG_MMC_BLOCK_MINORS=32
>  CONFIG_MMC_ARMMMCI=y
> 

