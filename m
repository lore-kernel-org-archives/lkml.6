Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D215C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DA32146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfBHRFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:05:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54322 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbfBHRFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:05:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7E7880D;
        Fri,  8 Feb 2019 09:05:01 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 948D33F719;
        Fri,  8 Feb 2019 09:05:00 -0800 (PST)
Subject: Re: [PATCH 0/3] Remove reference of TIF_USEDFPU on arch not using it
To:     linux-kernel@vger.kernel.org
Cc:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190208170315.10762-1-julien.grall@arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <86210318-e09a-db32-3591-1dfb0f222617@arm.com>
Date:   Fri, 8 Feb 2019 17:04:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208170315.10762-1-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry I made an error in the patches sent. Please ignore this series and look 
for the "RESEND" version.

Cheers,

On 08/02/2019 17:03, Julien Grall wrote:
> Hi all,
> 
> This small patch series remove reference of TIF_USEDFPU on nds32, arm and
> arm64 as the flag is not inuse.
> 
> Cheers,
> 
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> 
> Julien Grall (3):
>    nds32: Removed unused thread flag TIF_USEDFPU
>    arm: Remove documentation about TIF_USEDFPU
>    arm64: Remove documentation about TIF_USEDFPU
> 
>   arch/arm/include/asm/thread_info.h   | 1 -
>   arch/arm64/include/asm/thread_info.h | 1 -
>   arch/nds32/include/asm/thread_info.h | 2 --
>   3 files changed, 4 deletions(-)
> 

-- 
Julien Grall
