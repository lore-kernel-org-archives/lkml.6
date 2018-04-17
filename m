Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2152363-1523980360-2-15132545001448897037
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523980360; b=uZabtilRNdNyZGLWvLjtrO4C/WPE/B4txo26beu2hWAW1SGOTO
    IVzD/pYDkCEfIo1llWddEus3b8J+Eyt0b5zCOpEPTLVZTK5+li+/9YsAybHFWHhK
    /9GqmoUvnt/vmRwjOp4SvHiQiv873t9ODMEOQPbmLEH8GIMKGZlDF0cOcoP85T5e
    U4sbLpnG03HNZFHOgYsiYV7pBsmQgtFq5nCumPJ9DW2E5r435St7ZkE3hSHsCIVR
    xm/5xLJJTn1dfoCqkPQC01Pz6QUAoPY0XIgYMj7v453AcSo9gIWUOneIYDhe/Ib1
    vEKhXRN+LXf5AUI5kJ7AswNKykz4lQSt2HHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1523980360; bh=/NSvsntRRDT03WgwKTbIxJ/d0uT11ngUvt7g36C
    kQhM=; b=NjMvmwDGdcAmkYK0VbVjGBa9HIfPz7EZuGH/2gBUZ4mv080E8lvt1QO
    Ph+v8QTZasznLD2vKdYeb1TsMbFYj3qdXUHUCKoUDoSl8zPTdAOIZxqnQTOVrmRL
    VwTmf9JnbDwG3lRuSAjkzFMiJjsIu+RPAGgnqK9Xek042kL6MDMYW/kkXROm0O/H
    l4Vo4wKEPEoKrz9Vx6AEcOYMUHfv/HURIowjt5LMnAsqWrIxbvjLdsnpFET4y3f3
    tCW5WY2cJfbp8sghIIVtbapNwOzCKzDANtu2apHk8w2wzDDMNmnQwP2S+/Ho1Aw1
    MrpSHKupk1mAbEC82nfY4azcM6Osgmw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfGJQuRq3q1wZG7TbK9YiEo1vDOHgusJpXYbTbP/3eFJXIsThsBMTb57GblZhxgG5OwMgiXx2Eta1hbw+SNc92oqjNVipE1CN4wfeE2VEEQa3cSdWtQke
    YmRc3ztg4U5OW6eOy1ZVJ9c5RxuZfkfZIt1gpmZ7aIPFmje8FXWQCGX/UdW1zPgw9GNPqx8RgS1dZOPJjcVO1NmlHVbORrD/4NB1gyHT8+d8W15Upb3aJKAb
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=fFhGZ2y5-E8OVpWU7VIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeDQPwi (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 11:52:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:35698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752658AbeDQPwi (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 11:52:38 -0400
Date: Tue, 17 Apr 2018 17:52:30 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
cc: Michal Hocko <mhocko@kernel.org>, Greg KH <greg@kroah.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
In-Reply-To: <20180417145531.GW2341@sasha-vm>
Message-ID: <nycvar.YFH.7.76.1804171742450.28129@cbobk.fhfr.pm>
References: <20180416171607.GJ2341@sasha-vm> <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm> <20180416203629.GO2341@sasha-vm> <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm> <20180416211845.GP2341@sasha-vm> <nycvar.YFH.7.76.1804162326210.28129@cbobk.fhfr.pm>
 <20180417103936.GC8445@kroah.com> <20180417110717.GB17484@dhcp22.suse.cz> <20180417140434.GU2341@sasha-vm> <20180417143631.GI17484@dhcp22.suse.cz> <20180417145531.GW2341@sasha-vm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 17 Apr 2018, Sasha Levin wrote:

> How do I get the XFS folks to send their stuff to -stable? (we have
> quite a few customers who use XFS)

If XFS (or *any* other subsystem) doesn't have enough manpower of upstream 
maintainers to deal with stable, we just have to accept that and find an 
answer to that.

If XFS folks claim that they don't have enough mental capacity to 
create/verify XFS backports, I totally don't see how any kind of AI would 
have.

If your business relies on XFS (and so does ours, BTW) or any other 
subsystem that doesn't have enough manpower to care for stable, the proper 
solution (and contribution) would be just bringing more people into the 
XFS community.

To put it simply -- I don't think the simple lack of actual human 
brainpower can be reasonably resolved in other way than bringing more of 
it in.

Thanks,

-- 
Jiri Kosina
SUSE Labs
