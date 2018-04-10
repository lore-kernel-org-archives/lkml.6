Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968727-1523368951-2-4704478686014757939
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523368950; b=Po6pu2BioxBHChIVfNBugQ8349YRZimyVeyUe+UGkc5yL1S0V9
    BrvQAFObVE+mEs5DI1IPyrjFVVljp5ePjn5dwO8NkzxiXazqFVJ+TT+0nUo1PPjh
    2w2+RFr6IbYUBeKHlGRvF8DHYx3+h9qwsk/zI/mxv6jKU/RR2YJD6oxGxj0ePIU+
    OU1gFL6tOE3UH1Q/WC8u3jaE/XD98iImMSiVks4SIWsKRjyUhIYr2skEt5AICk4v
    ieAM/qaW3u7PR88YTkOAYEP6jb5Rw4m8Ne1DOGSXOa211LBoWmhbL/Ls0iACYUuz
    2puFbdDtJv7uaTi2q9kRaR9LtI+SCU3FNhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523368950; bh=CbBgsf5jPJcjKbwp58UWYbss/bsKFB
    xXj6W22XKb6pc=; b=S3jJ0yG2FUnFXIeNKXifFwxUCXVa1+l5m6mS0JaI0TGo7x
    tlzSZLl/zPqqcM4eYFvSLXDkIE8+fxKPKoZC+8+eEqIATRJPjXdgG5Qdw8xR9RWq
    0wUL2WdTwiLalgYjWGWSth5I2of5/CluaFKM2HdtGgK1aRDZp5zQ61KlR6IVXJY1
    Ru6Nf7s6wx1tYQy2kIAg3Lrve5K36nMhxHVh+TPKnhXxtrJPHsxVH+wOu/ON2eib
    4RzqoZPB+Ji5ltDIvFvyJm5+lyPoz05fcw0AKziJFBeyfAE33ZdEwcFUdLiBJUSS
    Bef7hjxCHCqqdE4pR+vpfHzLumHzWsXCvp8KACtQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FhfWuNW1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=FhfWuNW1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK2Q+cJMkQGIQ7vlkE0a4DSHk/0bVrTrNYR0Xic8PZQnDFfyOmGu3KtFUAvXU5FceNX5B5eDN8YtZz5GJMqSZqsIT7s8Y3E044Z/04kotmf7Rt01MALG
    qfdP0nNbQubor5pRcPFoA+y8LAOUdauJjAc15Uo1gRGgPbG8SgvmBlSdJoN2gstJQjpSaCI54yJob2D1eGqJrW2g/bTdyNirJ9pGZrxoSgXdS0OuHJKYe6XU
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=2G1Xa9Tf9hHkUzBVobIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbeDJOC3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 10:02:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbeDJOC2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 10:02:28 -0400
Date: Tue, 10 Apr 2018 07:02:23 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Minchan Kim <minchan@kernel.org>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org, jaegeuk@kernel.org
Subject: Re: [PATCH 2/2] page cache: Mask off unwanted GFP flags
Message-ID: <20180410140223.GE22118@bombadil.infradead.org>
References: <20180410125351.15837-1-willy@infradead.org>
 <20180410125351.15837-2-willy@infradead.org>
 <20180410134545.GA35354@rodete-laptop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410134545.GA35354@rodete-laptop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 10:45:45PM +0900, Minchan Kim wrote:
> On Tue, Apr 10, 2018 at 05:53:51AM -0700, Matthew Wilcox wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> > 
> > The page cache has used the mapping's GFP flags for allocating
> > radix tree nodes for a long time.  It took care to always mask off the
> > __GFP_HIGHMEM flag, and masked off other flags in other paths, but the
> > __GFP_ZERO flag was still able to sneak through.  The __GFP_DMA and
> > __GFP_DMA32 flags would also have been able to sneak through if they
> > were ever used.  Fix them all by using GFP_RECLAIM_MASK at the innermost
> > location, and remove it from earlier in the callchain.
> > 
> > Fixes: 19f99cee206c ("f2fs: add core inode operations")
> 
> Why this patch fix 19f99cee206c instead of 449dd6984d0e?
> F2FS doesn't have any problem before introducing 449dd6984d0e?

Well, there's the problem.  This bug is the combination of three different
things:

1. The working set code relying on list_empty.
2. The page cache not filtering out the bad flags.
3. F2FS specifying a flag nobody had ever specified before.

So what single patch does this patch fix?  I don't think it really matters.
