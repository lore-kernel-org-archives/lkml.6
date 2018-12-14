Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C010C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF3D20879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF3D20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeLNKhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:37:23 -0500
Received: from foss.arm.com ([217.140.101.70]:48684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbeLNKhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:37:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B622BA78;
        Fri, 14 Dec 2018 02:37:22 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 86B8A3F614;
        Fri, 14 Dec 2018 02:37:22 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id C8CFC1AE087D; Fri, 14 Dec 2018 10:37:21 +0000 (GMT)
Date:   Fri, 14 Dec 2018 10:37:21 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: replace arm64-obj-* in Makefile with obj-*
Message-ID: <20181214103721.GC1872@edgewater-inn.cambridge.arm.com>
References: <1544760112-5378-1-git-send-email-yamada.masahiro@socionext.com>
 <20181214095155.GA1872@edgewater-inn.cambridge.arm.com>
 <CAK7LNATTGxopJJsj=sakmqxwpyETgG7ToS8tm4kLcF2jekNcFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATTGxopJJsj=sakmqxwpyETgG7ToS8tm4kLcF2jekNcFw@mail.gmail.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 07:35:57PM +0900, Masahiro Yamada wrote:
> Hi Will,
> 
> On Fri, Dec 14, 2018 at 6:54 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > Hi Masahiro,
> >
> > On Fri, Dec 14, 2018 at 01:01:52PM +0900, Masahiro Yamada wrote:
> > > Use the standard obj-$(CONFIG_...) syntex. The behavior is still the
> > > same.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > >
> > >  arch/arm64/kernel/Makefile | 59 +++++++++++++++++++++++-----------------------
> > >  1 file changed, 29 insertions(+), 30 deletions(-)
> >
> > I'm fine with this patch, but I think I'd prefer to apply it at -rc1 so
> > we don't end up with lots of silly conflicts in the Makefile for any new
> > files added during the merge window.
> >
> > Is that ok with you?
> 
> Sure!

Brill. Please poke me again in January if it hasn't landed by then ;)

Will
