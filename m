Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1E3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0FE20818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0FE20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeKHGYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:24:21 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:1588 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbeKHGYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:24:21 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 3891719F54D;
        Wed,  7 Nov 2018 21:52:02 +0100 (CET)
Subject: Re: [PATCH 5/9] arm64: defconfig: Replace PINCTRL_MT7622 with
 PINCTRL_MTK_MOORE
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <5889bd19-3717-9592-3473-bf11338007da@free.fr>
Message-ID: <af87b13d-4551-7c82-6183-f9c31d93c653@free.fr>
Date:   Wed, 7 Nov 2018 21:51:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <5889bd19-3717-9592-3473-bf11338007da@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Add interested parties ]

On 07/11/2018 21:16, Marc Gonzalez wrote:

> Commit e78d57b2f87c ("pinctrl: mediatek: add pinctrl-moore that implements
> the generic pinctrl dt-bindings")
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  arch/arm64/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6fe418d72337..725b9471b21c 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -369,7 +369,7 @@ CONFIG_PINCTRL_MSM8994=y
>  CONFIG_PINCTRL_MSM8996=y
>  CONFIG_PINCTRL_QDF2XXX=y
>  CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
> -CONFIG_PINCTRL_MT7622=y
> +CONFIG_PINCTRL_MTK_MOORE=y
>  CONFIG_GPIO_DWAPB=y
>  CONFIG_GPIO_MB86S7X=y
>  CONFIG_GPIO_PL061=y
> 

