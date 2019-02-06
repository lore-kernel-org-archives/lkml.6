Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B00C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3632A2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfBFMTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:19:14 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52326 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfBFMTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:19:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 545F9EBD;
        Wed,  6 Feb 2019 04:19:13 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDCB73F557;
        Wed,  6 Feb 2019 04:19:11 -0800 (PST)
Subject: Re: [PATCH 18/19] arm64: switch copyright boilerplace to SPDX in
 dma-mapping.c
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-19-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <36d02302-8525-e538-1d9d-3adcc08a01ea@arm.com>
Date:   Wed, 6 Feb 2019 12:19:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114094159.27326-19-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2019 09:41, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Robin Murphy <robin.murphy@arm.com>

> ---
>   arch/arm64/mm/dma-mapping.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index fffba9426ee4..bdfb4e985a69 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -1,20 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
> - * SWIOTLB-based DMA API implementation
> - *
>    * Copyright (C) 2012 ARM Ltd.
>    * Author: Catalin Marinas <catalin.marinas@arm.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
>   #include <linux/gfp.h>
> 
