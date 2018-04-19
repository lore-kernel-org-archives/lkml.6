Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3352333-1524150272-2-6724050033014577210
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
    1524150272; b=fY1t4Ymg+6FViKJKjVoEnAB+TQl5MOW3b/gx5GRk3ETZlvaZJB
    t+C/M5KIxcfp/jBOKGF9KGbUFVI2u30Jo4Llm87JUufmEP844iWDDNXT75W9O1n7
    bYoqqmvSlfT1KpWjRVx2x+x8slJ5R5/Auel45ErRv5oK2I3P94MRGuq3v3OYEMT3
    q0uLpqRV2LlZxbH9yheGp41nD3s5ZFCfdQc7NL0ogst7Znp+yEG19Z9gwx6fO0bF
    IVHrqrs5xR82o8PfEeLL7Fk2GwaHDWuDQwYcLWSDcVkqF2njpUgJTCqwImzLF6h4
    /OQu25S05R9ioIz89kr12H0arTnjuj/AfYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524150272;
    bh=J2bkM5r/pb346LmFZg9HQqtjrC4dwuECXBOrWh19rD8=; b=Uc2Eo2wHSMg/
    9HyFFO0kauMJ6+JvUZwvMY16EPCw7ZTscTc/qcvLgyWcgpzRuM3Tp4Ql5irwjyiG
    Q7vLpccnyldHGXJNtvs63+y3O5gLcamq3utOgSGnfIgT5F8XnbjrStpo4I0jBptB
    BIT5O/ZcKjPQNTzVBbBSQQFDtku8n5nyuJHErdJGnox22R1BwjedyrBrtcpWAtHS
    vF229wRCtLO0HcTeg9/L9ySj3dV2aiwwGjdA/QWgrtCIm+cBAg9UuE0jA1J2/cE2
    d4dzqlTR2sT/6rUvcuZDHXjL7gDpj4jHUufajopnqM8OBoeHXzF4Vn0eUuujJQNT
    34WXN1ezwA==
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
X-CM-Envelope: MS4wfIxYh7/aBUUpJfWCWXgh6ecuV0Bx0nrAKDjzrY3wPDyHNYUr1G0fSTf8yAdXHahFNL9HbmtFy2GxUwYb/zOBXyeo3GcUr3rr3Nn7MotXFDGMjgIlOxTE
    Unv2Perb61KvMr4VJaLauBqexgAN4NmFCaHocou5Ly9QHIuLANtl0cuJZW4HhIjfad0HNwwEDZZMajasnzbAy+wBmaTFFafwWvOMvNSowxqOXSiZwLU7XxUg
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=N659UExz7-8A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=w-zqg_c3mILBhyfpDY4A:9 a=pILNOxqGKmIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeDSPEa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 11:04:30 -0400
Received: from mx1.yrkesakademin.fi ([85.134.45.194]:14878 "EHLO
        mx1.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeDSPE3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 11:04:29 -0400
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
To: Greg KH <gregkh@linuxfoundation.org>,
        Thomas Backlund <tmb@mageia.org>
CC: Sasha Levin <Alexander.Levin@microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home> <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home> <20180416161911.GA2341@sasha-vm>
 <7d5de770-aee7-ef71-3582-5354c38fc176@mageia.org>
 <20180419135943.GC16862@kroah.com>
From: Thomas Backlund <tmb@mageia.org>
Message-ID: <6425991f-7d7f-b1f9-ba37-3212a01ad6cf@mageia.org>
Date: Thu, 19 Apr 2018 18:04:26 +0300
MIME-Version: 1.0
In-Reply-To: <20180419135943.GC16862@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-WatchGuard-Spam-ID: str=0001.0A0C0202.5AD8AFFD.0165,ss=2,re=0.000,recu=0.000,reip=0.000,cl=2,cld=1,fgs=0
X-WatchGuard-Spam-Score: 2, suspect; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.194
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Den 19.04.2018 kl. 16:59, skrev Greg KH:
> On Thu, Apr 19, 2018 at 02:41:33PM +0300, Thomas Backlund wrote:
>> Den 16-04-2018 kl. 19:19, skrev Sasha Levin:
>>> On Mon, Apr 16, 2018 at 12:12:24PM -0400, Steven Rostedt wrote:
>>>> On Mon, 16 Apr 2018 16:02:03 +0000
>>>> Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>>>>
>>>>> One of the things Greg is pushing strongly for is "bug compatibility":
>>>>> we want the kernel to behave the same way between mainline and stable.
>>>>> If the code is broken, it should be broken in the same way.
>>>>
>>>> Wait! What does that mean? What's the purpose of stable if it is as
>>>> broken as mainline?
>>>
>>> This just means that if there is a fix that went in mainline, and the
>>> fix is broken somehow, we'd rather take the broken fix than not.
>>>
>>> In this scenario, *something* will be broken, it's just a matter of
>>> what. We'd rather have the same thing broken between mainline and
>>> stable.
>>>
>>
>> Yeah, but _intentionally_ breaking existing setups to stay "bug compatible"
>> _is_ a _regression_ you _really_ _dont_ want in a stable
>> supported distro. Because end-users dont care about upstream breaking
>> stuff... its the distro that takes the heat for that...
>>
>> Something "already broken" is not a regression...
>>
>> As distro maintainer that means one now have to review _every_ patch that
>> carries "AUTOSEL", follow all the mail threads that comes up about it, then
>> track if it landed in -stable queue, and read every response and possible
>> objection to all patches in the -stable queue a second time around... then
>> check if it still got included in final stable point relase and then either
>> revert them in distro kernel or go track down all the follow-up fixes
>> needed...
>>
>> Just to avoid being "bug compatible with master"
> 
> I've done this "bug compatible" "breakage" more than the AUTOSEL stuff
> has in the past, so you had better also be reviewing all of my normal
> commits as well :)
> 

Yeah, I do... and same goes there ... if there is a known issue, then 
same procedure... Either revert, or try to track down fixes...


> Anyway, we are trying not to do this, but it does, and will,
> occasionally happen.  Look, we just did that for one platform for
> 4.9.94!  And the key to all of this is good testing, which we are now
> doing, and hopefully you are also doing as well.

Yeah, but having to test stuff with known breakages is no fun, so we try 
to avoid that

--
Thomas
