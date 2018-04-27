Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-599759-1524855437-2-18347897467500307163
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
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524855436; b=kRqvDZaxtEIh62UZeX/eVhx7IGqX9C5aW7Qmbv3HkD+kNmjg+o
    NBKyuC8yd/cbm85y+w+rkNeP2jteW8k5c3pfQaex4flrLDQP5CANKnlRVfWEH/0w
    qxJ6NwrgzEjyG9hFauBpW1mSmkA49aTj3XB5n2esJgEwnFbHiZsarVHnbHWa9ePm
    G9wdfxHL6VlZHWMV62DOnfgfSBubmMiwh3/qyqjNfK7FhNaEkqFnABxr/3ZBwd2C
    VfxIofkQwt2KMDJ8f/6Mr3yZzln/Zx8acpXzVse9sr7isWHHJg5RpLPEfxm3F//O
    nSUGwZq3nh8dL8pQn773qOH9ACA5QL0J1VFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524855436; bh=x0DKP/sQpe6/L6B05/9VjMIOp4lhOT
    OQLEh525e+eV8=; b=Gi9EgpFNDb7h5m/sEJKBvMo8VYRrmQethZ9lEIATweBBLB
    LOjHZJhqy+ZPRsNClHx677r4RvsYbp4oa7oIXwlXzi3Ps3FwsSTlxD4g+fQt35Yf
    Uz9DjEO9yRYmtXQY8A1LyGhb46kqwnT7Zn6czRNbNJ5bfs7d204KTUUmtSw0IuV9
    nyXnGitE4Y8rcDHylU5Gb0DlPYf+piyRgvEnAoyuyArd3y2nMUjmwzCQg8xZOWPe
    Gm8XATuwXe60U1enhYcqIqNy3tnRSfjhogS1lWe4yHCIUiI7VY4f2iJKwGgfd93f
    Qd9VHbOR4xg9/cj1IhKlT4dir4rqA4EgynBqU2Rg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=EPOnhnOW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=EPOnhnOW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDx4aVB1n4uLRBYsRDXYBc62ER1ZZtg1Z1bVhdqOfGRX13ZMVopwquVcqdL3idGqZVkGUznXheCQ6Vln2J5L1cswNYbibUBEIBShDF5lHLWQmHdl46qM
    zlk33uLl8J8A9bULQUcFMfUHrnQGvz+4IJuAG4C2s58izeFDDiGDhbXa/iPqtOidl4vYh8IB9pf5OzMjHE9A5GuiUaUdT3w8SWOfjik9yXIx+zb+sjpuCVst
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=_GXSruvPN1n8Sqp-vdMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758298AbeD0S5N (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 14:57:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758069AbeD0S5M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Apr 2018 14:57:12 -0400
Date: Fri, 27 Apr 2018 11:57:08 -0700
From: Matthew Wilcox <willy@infradead.org>
To: David Rientjes <rientjes@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: don't show nr_indirectly_reclaimable in /proc/vmstat
Message-ID: <20180427185708.GA2444@bombadil.infradead.org>
References: <20180425191422.9159-1-guro@fb.com>
 <20180426200331.GZ17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804261453460.238822@chino.kir.corp.google.com>
 <99208563-1171-b7e7-a0d7-b47b6c5e2307@suse.cz>
 <alpine.DEB.2.21.1804271139500.152082@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804271139500.152082@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 11:41:31AM -0700, David Rientjes wrote:
> On Fri, 27 Apr 2018, Vlastimil Babka wrote:
> 
> > It was in the original thread, see e.g.
> > <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
> > 
> > However it will take some time to get that in mainline, and meanwhile
> > the current implementation does prevent a DOS. So I doubt it can be
> > fully reverted - as a compromise I just didn't want the counter to
> > become ABI. TBH though, other people at LSF/MM didn't seem concerned
> > that /proc/vmstat is an ABI that we can't change (i.e. counters have
> > been presumably removed in the past already).
> > 
> 
> What prevents this from being a simple atomic_t that gets added to in 
> __d_alloc(), subtracted from in __d_free_external_name(), and read in 
> si_mem_available() and __vm_enough_memory()?

I'd think you'd want one atomic_t per NUMA node at least ...
