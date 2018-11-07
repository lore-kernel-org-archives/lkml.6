Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A00DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD31B20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD31B20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbeKGSs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:48:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47196 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbeKGSs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:48:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8593A78;
        Wed,  7 Nov 2018 01:18:58 -0800 (PST)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6571A3F718;
        Wed,  7 Nov 2018 01:18:58 -0800 (PST)
Received: from cmarinas by mbp with local (Exim 4.89)
        (envelope-from <catalin.marinas@arm.com>)
        id 1gKJzD-0001Qu-A4; Wed, 07 Nov 2018 09:18:55 +0000
Date:   Wed, 7 Nov 2018 09:18:55 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     will.deacon@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH]  arm64: fix commit style in the comments
Message-ID: <20181107091855.ps5pumxp7djtfz3k@localhost>
References: <1541605151-6757-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541605151-6757-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 11:39:11PM +0800, Peng Hao wrote:
> Use git commit description style 'commit <12+ chars of sha1>
> ("<title line>")' in the comments.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  arch/arm64/kernel/sys32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
> index 0f8bcb7..8317a5a 100644
> --- a/arch/arm64/kernel/sys32.c
> +++ b/arch/arm64/kernel/sys32.c
> @@ -40,8 +40,8 @@
>  	 * arbitrary binaries may rely upon it, so we must do the same.
>  	 * For more details, see commit:
>  	 *
> -	 * 713c481519f19df9 ("[ARM] 3108/2: old ABI compat: statfs64 and
> -	 * fstatfs64")
> +	 * commit 713c481519f19df9 ("[ARM] 3108/2: old ABI compat: statfs64
> +	 * and fstatfs64")

Seriously, how does this help? It already states "see commit:" on the
previous line.

-- 
Catalin
