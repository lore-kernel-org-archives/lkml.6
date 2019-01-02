Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009FEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85C5218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfABKlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:41:01 -0500
Received: from foss.arm.com ([217.140.101.70]:57504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbfABKlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:41:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EC6EF;
        Wed,  2 Jan 2019 02:41:00 -0800 (PST)
Received: from [10.1.30.136] (e121487-lin.cambridge.arm.com [10.1.30.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EE4D3F575;
        Wed,  2 Jan 2019 02:40:58 -0800 (PST)
Subject: Re: [PATCH] arm/mm/pmsa-v8 : remove unneeded semicolon
To:     Peng Hao <peng.hao2@zte.com.cn>, linux@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1545891981-84215-1-git-send-email-peng.hao2@zte.com.cn>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <8dad8524-b8d1-cb54-0743-68dd3089de8e@arm.com>
Date:   Wed, 2 Jan 2019 10:40:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545891981-84215-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/18 6:26 AM, Peng Hao wrote:
> Remove unneeded semicolon.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  arch/arm/mm/pmsa-v8.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/pmsa-v8.c b/arch/arm/mm/pmsa-v8.c
> index 617a83d..0d7d5fb 100644
> --- a/arch/arm/mm/pmsa-v8.c
> +++ b/arch/arm/mm/pmsa-v8.c
> @@ -165,7 +165,7 @@ static int __init pmsav8_setup_ram(unsigned int number, phys_addr_t start,phys_a
>  		return -EINVAL;
>  
>  	bar = start;
> -	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);;
> +	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);
>  
>  	bar |= PMSAv8_AP_PL1RW_PL0RW | PMSAv8_RGN_SHARED;
>  	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_NORMAL) | PMSAv8_LAR_EN;
> @@ -181,7 +181,7 @@ static int __init pmsav8_setup_io(unsigned int number, phys_addr_t start,phys_ad
>  		return -EINVAL;
>  
>  	bar = start;
> -	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);;
> +	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);
>  
>  	bar |= PMSAv8_AP_PL1RW_PL0RW | PMSAv8_RGN_SHARED | PMSAv8_BAR_XN;
>  	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_DEVICE_nGnRnE) | PMSAv8_LAR_EN;
> 

Acked-by: Vladimir Murzin <vladimir.murzin@arm.com>

You need to drop it into Russell's patch system [1]

[1] http://www.armlinux.org.uk/developer/patches/

Cheers
Vladimir
