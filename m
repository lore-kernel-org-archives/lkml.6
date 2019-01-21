Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7CAC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC742084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfAURfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:35:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39948 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfAURfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:35:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A998F15AB;
        Mon, 21 Jan 2019 09:34:59 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 761273F614;
        Mon, 21 Jan 2019 09:34:58 -0800 (PST)
Date:   Mon, 21 Jan 2019 17:34:55 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Stephen Bates <sbates@raithlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/2] arm64: mm: make use of new memblocks_present() helper
Message-ID: <20190121173455.GI29504@arrakis.emea.arm.com>
References: <20190109202100.6968-1-logang@deltatee.com>
 <20190109202100.6968-3-logang@deltatee.com>
 <20190110141503.GA31328@fuggles.cambridge.arm.com>
 <e272894e-31b6-2698-b6f5-5321b6853263@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e272894e-31b6-2698-b6f5-5321b6853263@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 09:51:52AM -0700, Logan Gunthorpe wrote:
> On 2019-01-10 7:15 a.m., Will Deacon wrote:
> > On Wed, Jan 09, 2019 at 01:21:00PM -0700, Logan Gunthorpe wrote:
> >> Cleanup the arm64_memory_present() function seeing it's very
> >> similar to other arches.
> >>
> >> memblocks_present() is a direct replacement of arm64_memory_present()
> >>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> ---
> >>  arch/arm64/mm/init.c | 20 +-------------------
> >>  1 file changed, 1 insertion(+), 19 deletions(-)
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Did you want us to take this via the arm64 tree?
> 
> Yes please.

Patch 2/2 queued for 5.1. Thanks.

-- 
Catalin
