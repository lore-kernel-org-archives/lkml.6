Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF63C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6062E20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6062E20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeLEPds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:33:48 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:33779 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbeLEPdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:33:46 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id E46B613F8DB;
        Wed,  5 Dec 2018 16:33:37 +0100 (CET)
Subject: Re: [PATCH v3 0/9] Regenerate arm64 defconfig for current kernel
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     arm-soc <arm@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
Message-ID: <4344b70b-41fb-5ca0-281e-d4b5500b6256@free.fr>
Date:   Wed, 5 Dec 2018 16:33:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 01:54, Marc Gonzalez wrote:

> Hello ARM maintainers,
> 
> v3: Keep CRYPTO_DEV_FSL_DPAA2_CAAM in patch 7/9
> 
> v2: Improve commit message for a few patches
> 
> The set of Kconfig options slowly changes with every kernel version.
> This patch series regenerates the arm64 defconfig for v4.20
> No functional change intended, except adding PINCTRL_MTK_MOORE to
> keep PINCTRL_MT7622, and adding FSL_MC_BUS and FSL_MC_DPIO to
> keep CRYPTO_DEV_FSL_DPAA2_CAAM.
> 
> Marc Gonzalez (9):
>   arm64: defconfig: Regenerate for v4.20
>   arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
>   arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
>   arm64: defconfig: Drop USB_ULPI_BUS and USB_CHIPIDEA_ULPI
>   arm64: defconfig: Replace PINCTRL_MT7622 with PINCTRL_MTK_MOORE
>   arm64: defconfig: Drop redundant SND_SOC_ROCKCHIP_I2S
>   arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO
>   arm64: defconfig: Change SCSI_UFS_HISI=m
>   arm64: defconfig: Drop redundant sound codec options
> 
>  arch/arm64/configs/defconfig | 108 ++++++++++++++++++++-----------------------
>  1 file changed, 49 insertions(+), 59 deletions(-)

Arnd, Olof,

Would you take this series for 4.21-rc1?

Regards.
