Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3526227-1524154809-2-14493420583686508994
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
    1524154809; b=fYvFxr3RCIsldvNxWkm++ntbxOgJi5isDyqEW8eCM2fotIeXrC
    l+RA3OJEAYGK3XWnYvxGshGo3erg04ulFv85yim5hS4IfxnyRWJhR4hfxXCQJvma
    MxWPqFY9fbAz9jGySCGYLuL1mhc3L/Lc9cC8O0w5OI8/rMQAgjguBdPcTzdrKhcu
    zCpiG1O9oO+dXgPWFrbxk+ecQzcJuulHSUJKy2yc2aSEBg7m6HiOmZNolB1t1Y52
    vFWYlRCg16fosBS64n7Tm0I2mRtXsurZgaBkR1LeR3d0Aph4Czc02GjR8qTRAzSQ
    8uMy5UTIXHf5mrVzTXDXe+t0vgLPyxMVe6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524154809;
    bh=G7OjkxLkXMEbUyHfEqsCIWdM+6K95PRwnphR+ed7C0E=; b=HCc+Ar74t6c8
    9h5CFHFbUwW9OlSCGQwMDk0XnUS/ohbA2OCDdLjUzg8V2EdmoIFnEEJbMsfHBDnE
    T1BJlOsDP/ZDVEJRhSvfcnkRAd2n1c/mlCOmwbDxnqMOp+BdGXClpZ6A2MDkw+jb
    +T81NalEHN0qNzwdJI5+PTn4B84+M9fmkJpVs0O2kXDM0RmPACubpjzcbiBSrCoA
    tGudmjFxGfxRTgYKseJccMu1eUo73AO+zpOGDs0jshzcVIWdwvcfShI/iwBDEP2P
    CDxGiIW6jZDgeVfAU83ZzPNVpN2BYADA0NzRaHUnilrInt7sOZHfHZMWleDvwSRy
    50Q7Vf/63w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mageia.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mageia.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfP6vM0KjzLyqJSJn2zraqyIVjc1yXOyiRBQWVFvJHlwUlum35NFojy8nB71o/6G5ccfFlkZFMdFuurW3ev+I/LtXtzw5DJxbLUQ2WL2SESErwKVTD5ll
    UuoLhSCXXvtSCH9TF6QC2cwi/z5GZj4WRlhJL5dymnv6NfaDeFzcbuyfbizp7mczQPVPw8fF0uSra3/ex+URaxXyUZP7AmFH5c8t0ZVIHFlELlJDHZaDxAv0
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=N659UExz7-8A:10 a=Kd1tUaAdevIA:10
    a=LlYrDT8sDmr8iR-d_9cA:9 a=pILNOxqGKmIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753654AbeDSQUH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 12:20:07 -0400
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:52623 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753511AbeDSQUG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 12:20:06 -0400
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Thomas Backlund <tmb@mageia.org>
CC: Greg KH <gregkh@linuxfoundation.org>,
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
References: <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home> <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home> <20180416161911.GA2341@sasha-vm>
 <7d5de770-aee7-ef71-3582-5354c38fc176@mageia.org>
 <20180419135943.GC16862@kroah.com>
 <6425991f-7d7f-b1f9-ba37-3212a01ad6cf@mageia.org>
 <20180419150954.GC2341@sasha-vm>
From: Thomas Backlund <tmb@mageia.org>
Message-ID: <0714b77f-d659-3c8b-8225-f435d7c08ae7@mageia.org>
Date: Thu, 19 Apr 2018 19:20:03 +0300
MIME-Version: 1.0
In-Reply-To: <20180419150954.GC2341@sasha-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-WatchGuard-Spam-ID: str=0001.0A0C0206.5AD8C1B6.01C5,ss=2,re=0.000,recu=0.000,reip=0.000,cl=2,cld=1,fgs=0
X-WatchGuard-Spam-Score: 2, suspect; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.195
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Den 19.04.2018 kl. 18:09, skrev Sasha Levin:
> On Thu, Apr 19, 2018 at 06:04:26PM +0300, Thomas Backlund wrote:
>> Den 19.04.2018 kl. 16:59, skrev Greg KH:
>>> Anyway, we are trying not to do this, but it does, and will,
>>> occasionally happen.  Look, we just did that for one platform for
>>> 4.9.94!  And the key to all of this is good testing, which we are now
>>> doing, and hopefully you are also doing as well.
>>
>> Yeah, but having to test stuff with known breakages is no fun, so we
>> try to avoid that
> 
> Known breakages are easier to deal with than unknown ones :)


well, if a system worked before the update, but not after...
Guess wich one we want...


> 
> I think that that "bug compatability" is basically a policy on *which*
> regressions you'll see vs *if* you'll see a regression.
> 


No. Intentionally breaking known working code in a stable branch is 
never ok.

As I said before... something that never worked is not a regression,
but breaking a previously working setup is...

That goes for security fixes too... there is not much point in a 
security fix, if it basically turns into a local DOS when the system 
stops working...

People will just boot older code and there you have it...


> We'll never pull in a commit that introduces a bug but doesn't fix
> another one, right? So if you have to deal with a regression anyway,
> might as well deal with a regression that is also seen on mainline, so
> that when you upgrade your stable kernel you'll keep the same set of
> regressions to deal with.
> 


Here I actually like the comment Linus posted about API breakage earlier 
in this thread...

<quote>
If you break user workflows, NOTHING ELSE MATTERS.

Even security is secondary to "people don't use the end result,
because it doesn't work for them any more".
</quote>

_This_ same statement should be aknowledged / enforced in stable trees 
too IMHO...

Because this is what will happend...

simple logic... if it does not work, the enduser will boot an earlier 
kernel... missing "all the good fixes" (including security ones) just
because one fix is bad.

For example in this AUTOSEL round there is 161 fixes of wich the enduser
never gets the 160 "supposedly good ones" when one is "bad"...


How is that a "good thing" ?


And trying to tell those that get hit "this will force upstream to fix 
it faster, so you get a working setup in some days/weeks/months..." is
not going to work...


Heh, This even reminds me that this is just as annoying as when MS
started to "bundle monthly security updates" and you get 95% installed
just to realize that the last 5% does not work (or install at all) and
you have to rollback to something working thus missing the needed
security fixes...

Same flawed logic...

Thnakfully we as distro maintainers can avoid some of the breakage for 
our enduses...

--
Thomas
