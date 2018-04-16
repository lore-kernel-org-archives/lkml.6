Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4150847-1523914132-2-5727290771576129114
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
    1523914132; b=bPIvZre3fCUZiOeHypwxZ+kQbYB1mC7kMcJ6FGlMdyBKITLUWC
    BPp9bm1VlJmkHGVv2Tf8oycycLIKIMDsnjhmHYmpfpHrVaIRDswLcTtu8prQBG4f
    yISOv0qHOeuqm8oRtaCcP8NDj+pSTw3u0j2Esv/nCOdQqvXpA9wE7hMkv2geSkQB
    B54XxC7pWyxM0qIV6omgdR/v+d4OKPPnWGWdj5wbScM8VWZm5IK4tMcbQP9F47Kw
    0QLFsLL+nGWk+xT+1sVeUMOG0una6rKbaLAm101F4rW4D02qaJt3o2ux6DthY+zT
    smu8ZYMuKwBhqD3Wcynny8mO4HW37BhNLMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1523914132; bh=5rHhCxf1BFZch9jIwi3yunu9NfcajUGD3773XrU
    x3tA=; b=scEfxzjcneVdvkGr+39ItxxgpIOvDkJPInxAyKc92aibaG2RPtzGkjW
    yACG8aTMcXn9iZsM3laTtqGVq3Fz70GSO6b+499MyUV9xf+PY9jf2uOR79Cq3Mg+
    UJTnyh+hLyxWDxW2+j8WHglJpDH7FaJc8iHLU3V6eqHid59NUDSKNmFTteFEi1Jp
    5PK2Jiv26jTn3WYRH4RnNsF3TB7SKObZD/Lz26N/r1y5XdiVTUavrJYNfFm3rRoo
    8nwxR0qCWFgQKUfI7Upkk1ReXLgjnfKDCZaPZc2kfSO5d9qR5vWr1u9rgPqCqyO1
    Ctc4+ivJzP067suVneDXp14InMGQhSg==
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
X-CM-Envelope: MS4wfH0gJ6iMnQeLUhVgaJoXdYIkEA+Xu5xHyRta4Wao+NFegYvxM6cwmODwqVsPnn6DM7bhJrej8qUW0sf8h6R2dNXQwqsm8509uWpKqDRRoiMYDyO3c3j9
    PrhJt9pMaditcGsFnbqGz3gPqLh6wDRG2+BFptPwpGVp1drCSanGB+W1HitbhKqm/2ReiUYLlJ0ZiqNSoy1z2DsjwybyHskbMrkhS8FZ/4gFJe1lBOefCBkR
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=GVrBacTm6F0A6pnvK8QA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbeDPV2v (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 17:28:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:33509 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbeDPV2u (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 17:28:50 -0400
Date: Mon, 16 Apr 2018 23:28:44 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
cc: Pavel Machek <pavel@ucw.cz>,
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
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
In-Reply-To: <20180416211845.GP2341@sasha-vm>
Message-ID: <nycvar.YFH.7.76.1804162326210.28129@cbobk.fhfr.pm>
References: <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com> <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm> <20180416160608.GA7071@amd> <20180416161412.GZ2341@sasha-vm> <20180416170501.GB11034@amd> <20180416171607.GJ2341@sasha-vm>
 <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm> <20180416203629.GO2341@sasha-vm> <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm> <20180416211845.GP2341@sasha-vm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018, Sasha Levin wrote:

> I agree that as an enterprise distro taking everything from -stable
> isn't the best idea. Ideally you'd want to be close to the first
> extreme you've mentioned and only take commits if customers are asking
> you to do so.
> 
> I think that the rule we're trying to agree upon is the "It must fix
> a real bug that bothers people".
> 
> I think that we can agree that it's impossible to expect every single
> Linux user to go on LKML and complain about a bug he encountered, so the
> rule quickly becomes "It must fix a real bug that can bother people".

So is there a reason why stable couldn't become some hybrid-form union of

- really critical issues (data corruption, boot issues, severe security 
  issues) taken from bleeding edge upstream
- [reviewed] cherry-picks of functional fixes from major distro kernels 
  (based on that very -stable release), as that's apparently what people 
  are hitting in the real world with that particular kernel

?

Thanks,

-- 
Jiri Kosina
SUSE Labs
