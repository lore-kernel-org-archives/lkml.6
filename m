Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2924715-1524138232-2-4268329429562233155
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524138232; b=Op0ue0TDLiNExTVW96rs0HZATiwLxReTTZlTR+mgMREPKMWAwG
    HNng+TnRVffNokuWGyH0hDKSgpGVL3mW8g1Xuhj7SiWbpa8DfLOMMKTf5cw11KG/
    VJZXoSyoy/VC1iH8QqydnMZ/A11OC/Lh13p0lmnU5zHJepORjCjZ1fXs8tNl/XZS
    XOL85lGGdGq0sDyTIRu2HhDToZ5BztI168gwKrhHKZv+LfmWrkrAXtMf3huFv/6P
    D70TYmjiEBgYyNsOPsAIqR7+pN/gTAdsjLHWUGWrDmElEhNxOjqflf+aPPFCZHb6
    Q5Aoi9gmmFSn+us+BGkpahdQKj7xPEv01yVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524138232;
    bh=oba+xjNEUO0l/m5HqOziKFT8Tyfqq8O92DAF5UgqRCI=; b=DcFKYuh8GzXv
    TkrOIYy2J6bzrfKunMsUwt49Fsn7FxRHwqFJB8KqMi3ZEOFGGgNGQM1wMrMUcha0
    9aPSALlQgDAfRj3XDwcSuQgqbQ/qHuGVknc8dWuMj1Oi7WlSNfdePEKv70sN9POs
    D+xO2N1p3Ssuk/stxsiNf+xW3WPxtLKAALmgIvzuVt5n5Op1fHSGZ8HIqqnBpZF0
    zmoi2jDvi2ERm3SST/GJvLzAirHiDar+WNe5+8fJj3oz4t3RbRwnDMGFSiOynSMF
    F27TW/+X8ym4WKFe+Sx+khwn4XCO6cizZig7p6WmimhiXyf3Ls6BrufL5/sXi/pv
    j6+TcPJwuw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mageia.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mageia.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mageia.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mageia.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN7psokDOuhdxFj3frWT83vQp9GEMLLliWsl/NvqcpIRptkCctF0I4wQ9di6B5ZB5DXsMz5mxSyTo+QDgbMkyEZDFc+g0dOrRW5GILUM9icKA0deXH7n
    wdrNRVjhXraI0AhYz6SlZeugwlbbMyvGlj0C477ju4XS4Gl031dmxtACa/BZVlQYK8k5jQ9I4dY3V2VR9eaFqZcDCHyNYeGLb7mP7RQB9RXsztxNq/H4ie+6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=N659UExz7-8A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=9-yfx3cIOaE3sHRa8p4A:9 a=pILNOxqGKmIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeDSLnv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 07:43:51 -0400
Received: from mx1.yrkesakademin.fi ([85.134.45.194]:42062 "EHLO
        mx1.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeDSLnu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 07:43:50 -0400
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
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
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home> <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home> <20180416161911.GA2341@sasha-vm>
From: Thomas Backlund <tmb@mageia.org>
Message-ID: <7d5de770-aee7-ef71-3582-5354c38fc176@mageia.org>
Date: Thu, 19 Apr 2018 14:41:33 +0300
MIME-Version: 1.0
In-Reply-To: <20180416161911.GA2341@sasha-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: sv
Content-Transfer-Encoding: 7bit
X-WatchGuard-Spam-ID: str=0001.0A0C0206.5AD880F6.00B3,ss=2,re=0.000,recu=0.000,reip=0.000,cl=2,cld=1,fgs=0
X-WatchGuard-Spam-Score: 2, suspect; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.194
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Den 16-04-2018 kl. 19:19, skrev Sasha Levin:
> On Mon, Apr 16, 2018 at 12:12:24PM -0400, Steven Rostedt wrote:
>> On Mon, 16 Apr 2018 16:02:03 +0000
>> Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>>
>>> One of the things Greg is pushing strongly for is "bug compatibility":
>>> we want the kernel to behave the same way between mainline and stable.
>>> If the code is broken, it should be broken in the same way.
>>
>> Wait! What does that mean? What's the purpose of stable if it is as
>> broken as mainline?
> 
> This just means that if there is a fix that went in mainline, and the
> fix is broken somehow, we'd rather take the broken fix than not.
> 
> In this scenario, *something* will be broken, it's just a matter of
> what. We'd rather have the same thing broken between mainline and
> stable.
> 

Yeah, but _intentionally_ breaking existing setups to stay "bug 
compatible" _is_ a _regression_ you _really_ _dont_ want in a stable
supported distro. Because end-users dont care about upstream breaking
stuff... its the distro that takes the heat for that...

Something "already broken" is not a regression...

As distro maintainer that means one now have to review _every_ patch 
that carries "AUTOSEL", follow all the mail threads that comes up about 
it, then track if it landed in -stable queue, and read every response 
and possible objection to all patches in the -stable queue a second time 
around... then check if it still got included in final stable point 
relase and then either revert them in distro kernel or go track down all 
the follow-up fixes needed...

Just to avoid being "bug compatible with master"

--
Thomas
