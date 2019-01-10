Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676D1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E5A214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfAJOPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:15:10 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36586 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbfAJOPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:15:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DD351596;
        Thu, 10 Jan 2019 06:15:09 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 215663F5AF;
        Thu, 10 Jan 2019 06:15:07 -0800 (PST)
Date:   Thu, 10 Jan 2019 14:15:03 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH 2/2] arm64: mm: make use of new memblocks_present() helper
Message-ID: <20190110141503.GA31328@fuggles.cambridge.arm.com>
References: <20190109202100.6968-1-logang@deltatee.com>
 <20190109202100.6968-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109202100.6968-3-logang@deltatee.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:21:00PM -0700, Logan Gunthorpe wrote:
> Cleanup the arm64_memory_present() function seeing it's very
> similar to other arches.
> 
> memblocks_present() is a direct replacement of arm64_memory_present()
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/mm/init.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Did you want us to take this via the arm64 tree?

Will
