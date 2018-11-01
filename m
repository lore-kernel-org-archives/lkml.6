Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DECC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263BA2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263BA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeKBIGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:06:05 -0400
Received: from foss.arm.com ([217.140.101.70]:34874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbeKBIGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:06:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 217131596;
        Thu,  1 Nov 2018 16:01:05 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E498D3F718;
        Thu,  1 Nov 2018 16:01:04 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 354051AE0D51; Thu,  1 Nov 2018 23:01:13 +0000 (GMT)
Date:   Thu, 1 Nov 2018 23:01:13 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kdump: fix small typo
Message-ID: <20181101230112.GB24757@arm.com>
References: <20181101152531.22489-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101152531.22489-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 11:25:31AM -0400, Yangtao Li wrote:
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  arch/arm64/kernel/crash_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
> index f46d57c31443..6b5037ed15b2 100644
> --- a/arch/arm64/kernel/crash_dump.c
> +++ b/arch/arm64/kernel/crash_dump.c
> @@ -58,7 +58,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>  /**
>   * elfcorehdr_read - read from ELF core header
>   * @buf: buffer where the data is placed
> - * @csize: number of bytes to read
> + * @count: number of bytes to read

I know this is trivial, but please can you include a short commit message
saying that this brings the kerneldoc in line with the function signature?

Thanks,

Will
