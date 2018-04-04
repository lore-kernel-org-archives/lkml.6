Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-470151-1522858713-2-3602626339400012249
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522858713; b=nL+7ciFcJ2y/WTpYIToCmibYgjEOS9CnVC+gqUv7TKinvGBD9w
    BoXc2Wyjzt9dwjcwoxcPTGNgUwLCcRl7JzcAYcFwkcylliRf4F0KYAzuUc8YO+Lv
    9oSH7c5MFfaGtDwAg2+zxGZ1n0QfbmmbmBrqh8ItqjGFV7syiiXCstuufR+AbNvB
    N+V6U0oGCgV4H/5bJRImz9sw7a19M8rHYASYHpQEvjs9AkX8OqoFdGQHQd2Zt7aA
    pAgAvM5Qg4XewYeRYnOtjMHgHG4D0tNFKj2WWIWuXEMXYbdINlEv9N1017x/fROS
    032c3var9t2iC0LXZe2s9/kDV/W3RjmIuGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522858713; bh=OMHBlGyCWYPzfLIRJFQ79lJd8OWn9W
    a3kA/NIspwXzQ=; b=f6LoWBDG6JZyxakPjO314TxtZPLY7abua7srpy3aF3dX/x
    +XAd7a+vBOnVoHeAeDCNDFfAPvD2RMkcK1mGTkyj2c6IZsTeQi+i2+ydoabOBPFv
    sBIU47vlJt/VIaVQf2FkDgLxWChOkbxzdCkCIIt/qikPtUvePIgvbJCHMuCNGNjV
    FgCSwWBr+d8yKddNXyT/m6sM/PpgmR8uON87hnNg+aJHG+XmPgnfUNhJz1myrNFs
    uBYXLBkDjsszdWOwXyOpOV17SM3sBk7tF/7lQUaJQSAndjQ2axhAs+TxHaXBGwGz
    W6go/A8nzeabq/XALuFYxV4J3r7AXsXNHCwa77bA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=e1feq56P x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=e1feq56P x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNjdhumwzJROxmM2TiS/WMTWtjaiI2tcdPHF7Mcqj0YEW08F8Hmi0oW+C8wxRlFCBmJxJ7F9lHnn+GiYerkl1+tuRIARTZccRS7Z/SKVvn4UZpMpft/m
    pVIq+IS3rMo9/ZW9KUQ0rgDUanmGf+mk65D0oXK/XAz+X0tG/mqcWCWOM2fuL/PnLKL+4XUJRIg7xe4/XZoyG0pW5HJPogmjwuEpr7EdPz6kYxSiOLqg4zPc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=j87TC4YKJwhpk3vXH88A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbeDDQSW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 12:18:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752269AbeDDQSV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Apr 2018 12:18:21 -0400
Date: Wed, 4 Apr 2018 18:18:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: mingo@redhat.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] locking/qrwlock: Give priority to readers with irqs
 disabled to prevent deadlock
Message-ID: <20180404161818.GJ4043@hirez.programming.kicks-ass.net>
References: <152285543936.4080.5025412328012618076.stgit@localhost.localdomain>
 <20180404153534.GI4043@hirez.programming.kicks-ass.net>
 <3c9b507c-c6bb-3e13-2a82-f3504626d016@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c9b507c-c6bb-3e13-2a82-f3504626d016@virtuozzo.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 06:51:08PM +0300, Kirill Tkhai wrote:
> On 04.04.2018 18:35, Peter Zijlstra wrote:
> > On Wed, Apr 04, 2018 at 06:24:39PM +0300, Kirill Tkhai wrote:
> >> The following situation leads to deadlock:
> >>
> >> [task 1]                          [task 2]                         [task 3]
> >> kill_fasync()                     mm_update_next_owner()           copy_process()
> >>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
> >>   send_sigio()                    <IRQ>                             ...
> >>    read_lock(&fown->lock)         kill_fasync()                     ...
> >>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
> >>
> >> Task 1 can't acquire read locked tasklist_lock, since there is
> >> already task 3 expressed its wish to take the lock exclusive.
> >> Task 2 holds the read locked lock, but it can't take the spin lock.
> >>
> >> The patch makes queued_read_lock_slowpath() to give task 1 the same
> >> priority as it was an interrupt handler, and to take the lock
> > 
> > That re-introduces starvation scenarios. And the above looks like a
> > proper deadlock that should be sorted by fixing the locking order.
> 
> We can move tasklist_lock out of send_sigio(), but I'm not sure
> it's possible for read_lock(&fown->lock).

So the scenario is:

CPU0			CPU1				CPU2

spin_lock_irqsave(&fa->fa_lock);
			read_lock(&tasklist_lock)
							write_lock_irq(&tasklist_lock)
read_lock(&tasklist_lock)
			<IRQ>
			  spin_lock_irqsave(&fa->fa_lock);


Right? (where the row now signifies time)

That doesn't seem to include fown->lock, you're saying it has an
identical issue?

> Is there another solution? Is there reliable way to iterate do_each_pid_task()
> with rcu_read_lock()?

Depends on what you call reliable :-), Yes you can use
do_each_pid_task() with RCU, but as always you're prone to see tasks
that are dead and miss tasks that just came in.

If that is sufficient for the signal muck, dunno :/ Typically signals
use sighand lock, not tasklist_lock.
