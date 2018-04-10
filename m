Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-232218-1523382363-2-16587420394719146669
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523382362; b=vUfctzOT4KumqG5IDBBEUWEYTCJB8E/d/ELRkRPF3/nc1gGGnT
    Egpyz6PIpxTCyAVuVLiyHuddOw0R5Nmwb5C7+qUxf43jIpS48hN/w+castf73BZz
    z81bqaC/T+Uf3koytB698L2nMkYuMtF13WemIwvkvEDMcjx1IMdRCio6W4Rruisx
    PHpSYtAwP+rPUQdz2SNjSTb/nzKIyAECAWuB3tjnuAcoXVFKBGTOu5WPlyphu7VF
    NpDakTpbrHrx9+c8EmX9NjafZjHTGxNG3BIqYcDBu6SyJWvCwAipWxX59oE2VF6Y
    iL33oNoJWdGzMkFh7MbplPCeuhTYm7SKIxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1523382362; bh=nDFUwvBoBJtjx30z1nm+sKhCoroapBZMkQpR07K
    YLeU=; b=OAK/NKUbnzacrjXVm459WIiHgGcub6FhivTndz6CS/D3Esm3VKotnyb
    b3wxNQsP3NoefNRkl0Z0ipLhHUgcLW6WCbMREYdX/p1Lu9syjFekDu8MsQddvKwq
    z6K4z1eOI/nCuWwztqZRh4XeWXZ8BsXzXYrjhiDGS0hVQ9w1j9ZjyrGWHVPGQY9N
    srkujHq0mRXSfCxjYkmAj+shaGPbOGtm9KOY7H0m3z7+v0Vb09U8Zc4SAbw3Bazh
    Fz4UYi+hgvUYD6dv1OLWifubgOEUX9KxjUz09qSw9vn/DhgtAUrX+AP0ohlwEjDv
    Hv/7wKsdK3VotaIiKAc0FFPZVfHtP+Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAEZ6Vzm6tQ0m6p+LYrX3NI80rtbS/3mA0e0Bjs3MxFq+h9dvne9KGjOZQM42ul45e4r2j3lIZzrM5KjFLLfZZJPODqkaSHZdJCRpDhaqRLr+d7tyYO0
    oVtYj1WP1pI3w5iDQUDbDOj5j8wRfFsB21U+shJE7Ep/hicvd+n2R5juxQHdZ8QgccNnkCJFDoLhh19Be+2R1j6jeF8neaYoH18gElA+s3NGP8TOe35ecxUJ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=khwyK8DuSVkA:10
    a=Kd1tUaAdevIA:10 a=-2blf9DlxA8Q1G1JMr8A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeDJRqB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 13:46:01 -0400
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:37322 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751589AbeDJRqA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 13:46:00 -0400
Date: Tue, 10 Apr 2018 12:45:56 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: Eric Dumazet <eric.dumazet@gmail.com>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a
 constructor
In-Reply-To: <20180410173841.GD3614@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1804101244290.29559@nuc-kabylake>
References: <20180410125351.15837-1-willy@infradead.org> <fee8a8bc-3db5-a66a-33cb-0729143ba615@gmail.com> <20180410165054.GC3614@bombadil.infradead.org> <alpine.DEB.2.20.1804101228170.29384@nuc-kabylake> <20180410173841.GD3614@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfP/bjkeDFg7P81g6/kNz/8v2v7EpXbc1ECdczd+gAPnfYJbQk2shovJQ0F6PSebJX6RrJjGvsbgp8NNQBuZKxhzKnilWK5ykLjXw4a9UQxOLWlbxvjV2
 gyUV9XqErrk1TIwaGeqRLdWUZMcGuFnThzBzgNKC01v/7viPWKhvM/vJadmdBeTkoYvptUmq+/VCx6X2cJhj3yCfaWPqXdmJsBKX4F7od3bkgQThpoLFT7Q8
 zU03uGGEqKWizTXUKqI+RKbBbHNgwN4sTnn+jTdGJ+UfwwrLrx0kjtO75kcVgy8JeNIKOpQrW9v8ls6XgbjRl2zFJ0ownLIdumDVIGyj29hxtFIFH8xFS+Hw
 xEVEC4V4KR8joO4xY3smaS1hk11pIchOihXUaBoR7aAZ/0JAD6bbgAowJli3HYOqbjf9IAnNCu7XOrG4El2ntXpv4OzOvjLoPPL1xZUke3bQ2xDyEu4K1881
 lYOGnySg1M7DaMB6/AD9/Cz7O6NBFzJb2/dT0ls5kPCNkDJ994NZLghfBB0tYdNn3xDdddirpe9bXmPjHQhdajKGPM4B+FNkachxXg==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 10 Apr 2018, Matthew Wilcox wrote:

> > How do you envision dealing with the SLAB_TYPESAFE_BY_RCU slab caches?
> > Those must have a defined state of the objects at all times and a constructor is
> > required for that. And their use of RCU is required for numerous lockless
> > lookup algorithms in the kernhel.
>
> Not at all times.  Only once they've been used.  Re-constructing them
> once they've been used might break the rcu typesafety, I suppose ...
> would need to examine the callers.

Objects can be freed and reused and still be accessed from code that
thinks the object is the old and not the new object....
