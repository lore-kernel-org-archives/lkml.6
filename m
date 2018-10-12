Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF24C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DF420868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DvNmxBZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DF420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeJLREU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:04:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbeJLREU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FaQZQvzyhN6HM+DyBoCBUy7XOPd23nBPtvj1f2zuv3Q=; b=DvNmxBZ63aZNy/CTTSecIw57n
        QPY/1e+bmh3BikdAg/dpS8CJsX9YRjPUMPq8E+ZznmVeWkNm6H7Ikc+3CK0OgcsSkJkzfP9F/k+sf
        3m8KIZUnVjCt5svDX7L08H/0t9RaxNDIbvxbOOrp3UWfCWELnsAKCqzwNatEEI1jJQFqKb8UFiCuU
        g/ftxPre02C9rhlFxT8H2ueEnrMgfZVM/K1Y0mhMJT/O4ETG1qiZCBrPSh2lizhLgeHaUoB35J2a5
        QDlQ4Q5qgf0N1ApvS527FAUrWZjE7T21fd4WdtVP5fmX14ERRY9SFnnomUMCKu7LDY1pkj03ySWQR
        MmqWrVR8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAtoL-0000Pk-Ez; Fri, 12 Oct 2018 09:32:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25C9B20292D10; Fri, 12 Oct 2018 11:32:43 +0200 (CEST)
Date:   Fri, 12 Oct 2018 11:32:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        John Garry <john.garry@huawei.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH] docs/completion.txt: Fix a couple of punctuation nits
Message-ID: <20181012093243.GR9848@hirez.programming.kicks-ass.net>
References: <1539183392-239389-1-git-send-email-john.garry@huawei.com>
 <20181011152910.GA8191@bombadil.infradead.org>
 <20181011154143.GB9867@hirez.programming.kicks-ass.net>
 <87bm80wcbj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm80wcbj.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 09:46:56PM +0300, Jani Nikula wrote:
> On Thu, 11 Oct 2018, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Oct 11, 2018 at 08:29:10AM -0700, Matthew Wilcox wrote:
> >> On Wed, Oct 10, 2018 at 10:56:32PM +0800, John Garry wrote:
> >> > This patch fixes a couple of punctuation nits which can make the document
> >> > more correct and readable.
> >> > 
> >> > Also missing "()" are added to some function references for consistency.
> >> 
> >> While there's nothing wrong here, any chance you want to try converting
> >> it to .rst and adding it to the overall index?  It looks a lot like
> >> rst already.
> >
> > I, on principle, will not touch rst files. They are inferior to txt files.
> 
> $ git shortlog --author=Zijlstra  -- Documentation/scheduler/
> 
> It does not look like you touch txt files either.

True; I prefer comments in the code. I did however write some text on
atomics the other day, see Documentation/atomic_{t,bitops}.txt.
