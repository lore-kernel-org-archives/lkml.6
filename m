Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E50C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F586206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F586206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeJEXcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:32:23 -0400
Received: from foss.arm.com ([217.140.101.70]:55144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbeJEXcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:32:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A66D47A9;
        Fri,  5 Oct 2018 09:32:55 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1BE43F5D3;
        Fri,  5 Oct 2018 09:32:53 -0700 (PDT)
Date:   Fri, 5 Oct 2018 17:32:51 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH 3/5] arm64: mm: make use of new memblocks_present() helper
Message-ID: <20181005163248.naky3huexiiwycra@mbp>
References: <20181005161642.2462-1-logang@deltatee.com>
 <20181005161642.2462-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005161642.2462-4-logang@deltatee.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 10:16:40AM -0600, Logan Gunthorpe wrote:
> Cleanup the arm64_memory_present() function seeing it's very
> similar to other arches.
> 
> memblocks_present() is a direct replacement of arm64_memory_present()
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  arch/arm64/mm/init.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
