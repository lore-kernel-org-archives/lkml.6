Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD218C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EEA2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yRWm9Z6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EEA2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbeJKXJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:09:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52372 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeJKXJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DYC6KjLQ3iB05Qw3MrUP4p5roecY+skehscAHp87U2E=; b=yRWm9Z6oXAfp0eBQolRy6XdwU
        0Qp8JFP6EIMOgEwx17gafX/p7LLq97vXr+fD2cm1i+pN6yXWddCTfD93G0heWBK91e6dyEUi1M2g/
        Bm4cWW3DHzCCtrlAPeEHfSWnFrVuxmK/p3Nr5Pax+Xc5OPn4VqHcBNiOVtYW77Kbbmh7gfFsBdNPE
        6Aqu/2UjvpS4kU3P63A+xIxsTN6INrD7nzlg1AvswiVeNe3ZIYj/sTtiAcs7baEtQeTYO73TgtqI/
        K/81q1mSEMzBigH4BgnFhWw9wHOg5n+aq52PbtwyYbXJmM+giEibNJxUn9JmiU8n0yUr59KbJUvjF
        OSUf8q5DQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAd5t-0004pP-Er; Thu, 11 Oct 2018 15:41:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF1B02027E1A2; Thu, 11 Oct 2018 17:41:43 +0200 (CEST)
Date:   Thu, 11 Oct 2018 17:41:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Garry <john.garry@huawei.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH] docs/completion.txt: Fix a couple of punctuation nits
Message-ID: <20181011154143.GB9867@hirez.programming.kicks-ass.net>
References: <1539183392-239389-1-git-send-email-john.garry@huawei.com>
 <20181011152910.GA8191@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011152910.GA8191@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 08:29:10AM -0700, Matthew Wilcox wrote:
> On Wed, Oct 10, 2018 at 10:56:32PM +0800, John Garry wrote:
> > This patch fixes a couple of punctuation nits which can make the document
> > more correct and readable.
> > 
> > Also missing "()" are added to some function references for consistency.
> 
> While there's nothing wrong here, any chance you want to try converting
> it to .rst and adding it to the overall index?  It looks a lot like
> rst already.

I, on principle, will not touch rst files. They are inferior to txt files.
