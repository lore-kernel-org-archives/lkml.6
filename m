Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A830C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2259C2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2259C2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeKHTo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:44:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37548 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbeKHTo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:44:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EEEC80D;
        Thu,  8 Nov 2018 02:09:46 -0800 (PST)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 051753F5CF;
        Thu,  8 Nov 2018 02:09:44 -0800 (PST)
Date:   Thu, 8 Nov 2018 10:09:42 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
Message-ID: <20181108100941.f7vv5pivq24vz7kx@salmiak>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <596a4b64-e2ef-878d-0873-dd59d14c2d85@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <596a4b64-e2ef-878d-0873-dd59d14c2d85@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 09:14:57PM +0100, Marc Gonzalez wrote:
> Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Please elaborate the situation in the commit message, e.g.

  The big.LITTLE cpufreq driver has been banned for arm64 since commit:

  a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")

  ... so it can be removed from defconfig.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/configs/defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f786c95504d3..8d6878c1e794 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -107,7 +107,6 @@ CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>  CONFIG_CPUFREQ_DT=y
>  CONFIG_ACPI_CPPC_CPUFREQ=m
>  CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
> -CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
>  CONFIG_ARM_SCPI_CPUFREQ=y
>  CONFIG_ARM_TEGRA186_CPUFREQ=y
>  CONFIG_ARM_SCPI_PROTOCOL=y
> -- 
> 2.17.1
