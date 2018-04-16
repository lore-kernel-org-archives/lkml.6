Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3665621-1523896228-2-3222333847093766701
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523896227; b=CauNUHz8ZsKM/IZa4svoyIsp+kPQMQWd7SVUhuhjYeAz7Sc3Zu
    Du/x4k15L3MO3RsKfM3wJGW1ZDT0P0jL542Rqq1CZiRwUXlBf2+om2W7ZogQchtK
    BUbsgZt38SY6tLVPa3PvvUvmg5dU2/TBWJveguj3cmmaszqp35Tkud4YDsAwOfKb
    5FF5oHjbWVewNE4O7MYOjDsK6f+2bzsV4kyA/vtWCAuty6r5+s1rTL9nc4k8mUTR
    TUPh9l47flOiTXIEcG+7aBFAToo0v3OrzK0lRd418eQNzNluqo4zsylzlWbzLhBU
    nk7hjSXP9YVMFiAHqZWoW3dbY0Q1z2wqgNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523896227;
    bh=UFC/Mhoroh8eX+4FVR3g1KPXC4pT0RmYVRFKZ1tW3oI=; b=NXSEU+1dzfcP
    6SIEK+H8KDTngWQVTEeH9DROR5wci6i5bnKWMud7IRv6KAGRrApDmFN1Ax9JGxSt
    Vrf9DiBdtIEHbtnACZvL3ICTM2vQmDZ/PhponY30nf+sOgbm6CTKjeHZKeyFCFm5
    EeOcAtRrWB07vRQWoqtVnViVqjoIhG9ryVYOCDjB4kgCvi7+XocFxhhiBXZRzDBx
    8cMn8Q8y+IzrG+lfP5CungGoIsePar6KH2/voYG9ITlAXYKPy2JzoRf+CG3cVulg
    TvmVmwV19BqpE0IBbbLbpfvK6xgF57NdRoAMb+6IWR14dKBAypKObwVmtyzCSSFd
    7aqWD8VUKA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEBXt6qfUE3SAQD8Z2H635LKQkf8018CIIwwkAB/RaYpe4k4/z+kiFOJrmLGoKmZYdLdyiwcNI/f3itSI/CVeRHmOeP+YoWOWsUTMCNVMMmXPtT11CtQ
    1khRz9AZdsHE1zBL0aj7EO7sUzbkjICw61uz2r5FFhRVbqE8i/3n2Q1x0jrN53A9MAuCMHmy6Wq+yLu4ZcBB6zXwfM/mKXJHlS0re104e4pfa0mA/MjYrqE1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=4rQSDYwoswb05pR2mH0A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbeDPQaY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbeDPQaX (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:30:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E8821776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 12:30:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416123019.4d235374@gandalf.local.home>
In-Reply-To: <20180416161911.GA2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
        <20180409001936.162706-15-alexander.levin@microsoft.com>
        <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
        <20180415144248.GP2341@sasha-vm>
        <20180416093058.6edca0bb@gandalf.local.home>
        <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
        <20180416113629.2474ae74@gandalf.local.home>
        <20180416160200.GY2341@sasha-vm>
        <20180416121224.2138b806@gandalf.local.home>
        <20180416161911.GA2341@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 16:19:14 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> >Wait! What does that mean? What's the purpose of stable if it is as
> >broken as mainline?  
> 
> This just means that if there is a fix that went in mainline, and the
> fix is broken somehow, we'd rather take the broken fix than not.
> 
> In this scenario, *something* will be broken, it's just a matter of
> what. We'd rather have the same thing broken between mainline and
> stable.

Honestly, I think that removes all value of the stable series. I
remember when the stable series were first created. People were saying
that it wouldn't even get to more than 5 versions, because the bar for
backporting was suppose to be very high. Today it's just a fork of the
kernel at a given version. No more features, but we will be OK with
regressions. I'm struggling to see what the benefit of it is suppose to
be?

-- Steve
