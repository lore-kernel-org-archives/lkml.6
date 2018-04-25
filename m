Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524671772-2-18132740259364082343
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
    1524671771; b=BjDsg3kndc7fF85lV2Ub8v/1Ivuyqh0afi8QafrrYxVqhDDk7f
    U46X0rWk6yOvnGDCZMlRWemfduRwAy7CyGbxJgVSS174fgge3oNpYgW4PjToAxbT
    JDB2C2xa3PvOJ8DuhHiAqa4nUJVzkXw6iO/GSiGsK0Sd8X4q0Af/uXhoWlFqrOJA
    NJbqLrTplFKcYcrBf+gwo1R8auseF0+vSLab1Ptk9nfX3aIFiDOoeH+xI7UQQsMe
    vwNGkJCznueA3XNb6eDhIHK72estKHxQKRpBLYkesHm1nTiVnM05CWLJrl/Of0yN
    Ia2CUuXG+cW0PFffPE6LOIz1cN1EqNPcQi/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524671771; bh=Ax/Cr7iTQS6Nq9Afr35f65fVprOAzC
    JmSS9kGVCmIZU=; b=kLPtYisMMYmlQi7i7x/QRzDze1lAqGRfPz2U4akxBxCYlu
    3dXZigQ7rTlItLZ0IKu7esnJ5dc288alWfxHeXvey06b4G6GLa96Az3j5/03hTzd
    2/EkQvsZibVYyrRHpo6lGshYmwt6qL2+CDGJLPkeWRIgAFwwCUxpPVExEz2XccNB
    bDkTt1H7LgmyaJLfCEBZ78O8jW9OPD14cT4dYVfg+ij418BkpHYFHwTKcJ4Vww1b
    hFwHXbS+qFgz/nwr/5z86r4hnTaT/V57k9+SBRrEjghIu0l1QFWXN9y6qiwKJGf5
    bDDkXzgEW1xEGKqFZyJqTwYiZIP2tmLyUGwTLctQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=JDwcT3LO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=JDwcT3LO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNeNRi65lRNxgBd0Usin8S+L1MiRmv5ntKHfR4Quc1mb71yutbS/NaUKDYJNF2ix1A857kpL7kMbJZerQR0mo5ORR66Q3G6/zKH3jDBtMg6VvViO+hoR
    P6ZtZ2yzYGE5JLGO27eJPqZfhBQ7Ki8DHiXCXjdgqA1Tp9GNnFEsaUagrAVxFmo2urLzqw8EpQbO8KzDXvpX723nG68b3oycdKxqpIzEOxpRpBhjhVPblFoQ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Dah4fHVq6oToOtOQUJcA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755451AbeDYPzv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:55:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755168AbeDYPzt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:55:49 -0400
Date: Wed, 25 Apr 2018 08:55:39 -0700
From: Matthew Wilcox <willy@infradead.org>
To: vinayak menon <vinayakm.list@gmail.com>
Cc: Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
Message-ID: <20180425155539.GB8546@bombadil.infradead.org>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-2-guro@fb.com>
 <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
 <20180411135624.GA24260@castle.DHCP.thefacebook.com>
 <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
 <20180412145702.GB30714@castle.DHCP.thefacebook.com>
 <CAOaiJ-=JtFWNPqdtf+5uim0-LcPE9zSDZmocAa_6K3yGpW2fCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOaiJ-=JtFWNPqdtf+5uim0-LcPE9zSDZmocAa_6K3yGpW2fCQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 05:43:39PM +0530, vinayak menon wrote:
> One such case I have encountered is that of the ION page pool. The page pool
> registers a shrinker. When not in any memory pressure page pool can go high
> and thus cause an mmap to fail when OVERCOMMIT_GUESS is set. I can send
> a patch to account ION page pool pages in NR_INDIRECTLY_RECLAIMABLE_BYTES.

Why not just account them as NR_SLAB_RECLAIMABLE?  I know it's not slab, but
other than that mis-naming, it seems like it'll do the right thing.
