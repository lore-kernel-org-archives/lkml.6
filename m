Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4113313-1523373506-2-7133152116725526323
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523373505; b=tCZE9LBUsE//24XNNxXbCzy8n4pEV6W8fF4ymoOonrepAnD9Tb
    sg4GlRI6MUTZ41wUuVnNE551VeobHAG8N9yKUWQLv8TczBG6tyxz6EGq0adUQI3R
    hzdUrBrY6WrZwGuU8juYX1lCQjbSjiZel18Pj47a1Ced2p7ShO6AL524ee0ZzTqq
    S3Use9ZKXuhzPUNsTL8ZO7CXhBJKHaRFpT1/GGDGPdoU+V23EEzQgJRWcnBDQIHx
    DE/hTZZOt/I5XjIBR5wz4D3sWHc7uIEgNbj76HAQdU6L9BC7uwn/2aj5JVs3g40Z
    uUQ0+hUpuAPx3spkWeiM1lNg3hGJ/bTIXmzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523373505; bh=GM0E410he/T0weN7g4vekv+a7uKLWY
    KHbXjZ1cYq34U=; b=QWw6fHNciYOu5LPSta2aHi9T8+Diog6tmm8d8YABwZKyIb
    Qlsy8Qd3hucaPm8fZodIs3CPgu5O80bGJCaSzPyAoyg+chVp9d+nOY8Xqy/GgC8z
    XSjSw2FodvaR9hl3ElOzzoOQfJaF0pOjjhBJ2IHNrZ0aVfWF74E7MnN2LJ01K1TN
    lfWldZ/1VnWEGnSw1mS0FMc4hzxY2R2HcuZTjRbLkr1QUrE0d3p7l2G5DRuCYYI+
    /mroV0/qjBwapNwWZAOvK4vk6H4zkjWIhpsC3a77hFWrZ5GrLjuEkO7EeHaDtatA
    W8hZElBE1KzTTzeh4eia78lqZhLiF4+WEIglysvg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIK1e2rewQ6P145qYkhB3rSfTUklIAVu/U6Uy0hd/d1BtHDHvv03dOLtXySiCT9YcpuFpix+1WMqJa4tDjD16SfK7VU+5BMBuRJHiQo1ScYj5xV5vLZk
    Qx1rQkWWFERztB96kePJAD8Uw2u2QJjupX355GBq6/AbUrmt2ShrtLbcH73Dfih6gfo8SEuCDtuWQr7g0dX0ZegTW3lEamnKg9NEH36emluf5Pt/q1nHZxgy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=1xFAWjtEmyH3FZ6zVwQA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753911AbeDJPSX (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 11:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753884AbeDJPSW (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 11:18:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7AF217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Tue, 10 Apr 2018 08:18:20 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] page cache: Mask off unwanted GFP flags
Message-ID: <20180410151820.GA69325@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180410125351.15837-1-willy@infradead.org>
 <20180410125351.15837-2-willy@infradead.org>
 <20180410134545.GA35354@rodete-laptop-imager.corp.google.com>
 <20180410140223.GE22118@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410140223.GE22118@bombadil.infradead.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/10, Matthew Wilcox wrote:
> On Tue, Apr 10, 2018 at 10:45:45PM +0900, Minchan Kim wrote:
> > On Tue, Apr 10, 2018 at 05:53:51AM -0700, Matthew Wilcox wrote:
> > > From: Matthew Wilcox <mawilcox@microsoft.com>
> > > 
> > > The page cache has used the mapping's GFP flags for allocating
> > > radix tree nodes for a long time.  It took care to always mask off the
> > > __GFP_HIGHMEM flag, and masked off other flags in other paths, but the
> > > __GFP_ZERO flag was still able to sneak through.  The __GFP_DMA and
> > > __GFP_DMA32 flags would also have been able to sneak through if they
> > > were ever used.  Fix them all by using GFP_RECLAIM_MASK at the innermost
> > > location, and remove it from earlier in the callchain.
> > > 
> > > Fixes: 19f99cee206c ("f2fs: add core inode operations")
> > 
> > Why this patch fix 19f99cee206c instead of 449dd6984d0e?
> > F2FS doesn't have any problem before introducing 449dd6984d0e?
> 
> Well, there's the problem.  This bug is the combination of three different
> things:
> 
> 1. The working set code relying on list_empty.
> 2. The page cache not filtering out the bad flags.
> 3. F2FS specifying a flag nobody had ever specified before.
> 
> So what single patch does this patch fix?  I don't think it really matters.

Hope there'd be someone who does care about patch description though, IMHO,
this fixes the MM regression introduced by:
449dd6984d0e ("mm: keep page cache radix tree nodes in check") merged in v3.15,
2014.

19f99cee206c ("f2fs: add core inode operations) merged in v3.8, 2012, just
revealed this out. In fact, I've never hit this bug in old kernels.

>From the user viewpoint, may I suggest to describe what kind of symptom we're
able to see due to this bug?

Something like:

[ 7858.792946] [<ffffff80086f4de0>] __list_del_entry+0x30/0xd0
[ 7858.792951] [<ffffff8008362018>] list_lru_del+0xac/0x1ac
[ 7858.792957] [<ffffff800830f04c>] page_cache_tree_insert+0xd8/0x110
[ 7858.792962] [<ffffff8008310188>] __add_to_page_cache_locked+0xf8/0x4e0
[ 7858.792967] [<ffffff800830ff34>] add_to_page_cache_lru+0x50/0x1ac
[ 7858.792972] [<ffffff800830fdd0>] pagecache_get_page+0x468/0x57c
[ 7858.792979] [<ffffff80085d081c>] __get_node_page+0x84/0x764
[ 7858.792986] [<ffffff800859cd94>] f2fs_iget+0x264/0xdc8
[ 7858.792991] [<ffffff800859ee00>] f2fs_lookup+0x3b4/0x660
[ 7858.792998] [<ffffff80083d2540>] lookup_slow+0x1e4/0x348
[ 7858.793003] [<ffffff80083d0eb8>] walk_component+0x21c/0x320
[ 7858.793008] [<ffffff80083d0010>] path_lookupat+0x90/0x1bc
[ 7858.793013] [<ffffff80083cfe6c>] filename_lookup+0x8c/0x1a0
[ 7858.793018] [<ffffff80083c52d0>] vfs_fstatat+0x84/0x10c
[ 7858.793023] [<ffffff80083c5b00>] SyS_newfstatat+0x28/0x64

Thanks,
