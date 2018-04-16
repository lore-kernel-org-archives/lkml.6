Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3848786-1523903732-2-12887262114337431143
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
    1523903731; b=WT3eXtrVQ4bXYhfxYJcUbdPpXCNmx9Kmj8c1zr1twjXpTTlIq/
    lLzy4myq4ttZSmx6gk7HtaUX0/luNZmvGL/ZVaCj9B2aKjOYBFAHHB42yTlj4B2G
    9jgbEz+FZGPlg9A0PmVQ+ofUtc3unnNi7neadJp2wKlRKxhBotW/crtYHChuiybn
    NnSS6AgICVq5cm3T0IcCFnmoFarffZiasR+uki0W9OuW29DcQIVAGV19TeGDOnOj
    BOwKLVqIIFaQ2wZenJKvvJ25mc2nlJFMFtMcigptSS9Nk8vdrcBroQZA9IhsjAPc
    y2brqG76PUDVjBQ7hyg9vnZVuDLh+OR6gTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523903731;
    bh=OTo7FPBU2OO1/vMKn9jjt31UrDonG6GURMFkUR3FIWo=; b=elX5ungqezZR
    vTK3mOjLZntmjMcdJtx13bKPf2GrjTZqeElELJ5qc3EwI/bpMAFtnnskGg7lzNe9
    x4bSO6iEL+SxQ36k1XDSAdJslJ2SxFmcO2tb7afe+1nGvcYwEmVQLdhlIV+upkE4
    R+jKFNeP0IWqN8qTvu3XxTojlj0bw7hONWgu6MP4nWIgXEo8vwSD0cSb4+6rpRR7
    UdcWFThRHX+9q7XskNoxGpnN/3Z1deAj8+kmjW1/03ol2Lczx+E0IlgJf6DUML4w
    MVpspi43gh6P3DGaAPNng7/hg/uS47D8tSDeC3xUF+UhQsNOzjo2duWp53kd2jhU
    ukZFHnir3g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfD4CIZRWJiKhUa2akTqTDJzOIBPSWy+eh++YSSbOf02NOWDL0QRGYDmwqYCdeHZQKp80HlnMewDd82j6xde1Ti2iGKU9HNoflZ0v36A3HwkUcw08iQb0
    ba7moD5iLC63MrbjZwuJzU1Kv4CTjVdtnIkVvLgEuEaQ0ZeyTNyGuM3Ew8wxH2C81N8kZj6QmaSd5L2Ancr/D2kKSfLEExNsU5JSiSmLTfL2JwkTOj9Foxrn
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=nF9IjXwTPBD-gk7rRaIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeDPSfQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 14:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753049AbeDPSfO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 14:35:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41D22175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 14:35:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Pavel Machek <pavel@ucw.cz>,
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
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416143510.79ba5c63@gandalf.local.home>
In-Reply-To: <20180416181715.GM2341@sasha-vm>
References: <20180415144248.GP2341@sasha-vm>
        <20180416093058.6edca0bb@gandalf.local.home>
        <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
        <20180416153031.GA5039@amd>
        <20180416155031.GX2341@sasha-vm>
        <20180416160608.GA7071@amd>
        <20180416161412.GZ2341@sasha-vm>
        <20180416170501.GB11034@amd>
        <20180416171607.GJ2341@sasha-vm>
        <20180416134423.2b60ff13@gandalf.local.home>
        <20180416181715.GM2341@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 18:17:17 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> I thought we agreed that this is bad? We wanted users to be closer to
> mainline, and we can't do it without bringing -stable closer to mainline
> as well.

I guess the question comes down to, what do the users of stable kernels
want? For my machines, I always stay one or two releases behind
mainline. Right now my kernels are on 4.15.x, and will probably jump to
4.16.x the next time I upgrade my machines. I'm fine with something
breaking every so often as long as it's not data corruption (although I
have lots of backups of my systems in case that happens, just a PITA to
fix it). I only hit bugs on these boxes probably once a year at most in
doing so. But I mostly do what other kernel developers do and that
means the bugs I would mostly hit, other developers hit before their
code is released.

Thus, if stable users are fine with being regression compatible with
mainline, then I'm fine with it too.

-- Steve
