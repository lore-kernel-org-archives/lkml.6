Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3578680-1523895155-2-14416696319168961137
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
    1523895154; b=ENo/zK342XglkeLbBSETgft2DP5htRJxruwOZyZGe1rgqewni6
    uhzVf6vN9IcAPcCVtdX+qspn26R37bW1wIxOwZw6IviaAQPpzKNtv0EwO/rZTNbt
    Xn0pBfbKUTvXww/9BJq3Mo2+2ki3/tjmQGviZKD9PG5ClZmTM2980Tlad7kZgL0J
    BjporW6PRDloQaYpPLTOjZXIsTCen50WUmnglOLKRVWYcqmOc0W2emfYCLUoZp1j
    4jJyxPqRDRHIzb6uzY1lVQRzJTqQR/SIJhRjVBX2e9oIkR/wdtxG9P6HAoSnBGRV
    06hr0blZ5/FOPc5qTMuzSzsn6Yv4F/O7E/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523895154;
    bh=6pHwXzLpvTeXJcCQgNyntXoML2pyQSjBPaWoB5OMG5s=; b=XmAXFEWXA2v3
    o+pZ7AVPYbaUne+PAeflN4bZe9MJ+g74ffiBNodJf1lLcnscJEoULUH0DOCigozk
    lwsaqWYfb3Bn9hUEXkM/updevJ8MVfzJT3bjZLrg0jh9xjQRyQSZ1K/LdCmnHoW2
    4Qaq0J/0wq9tSWLRQnUzDuj+VBdSOR6ZOrNg2kSiamOXSrrXrn7k9g33ztOf4pYs
    z6StjnepKh+84GTbaSAC2F+vtRBVffYasCqFW+Uk3iaK/M8IPXJmvWh83qgMLHWe
    qiUydtKnViThzCudxoVFYJG/Q7YcVkE0P8K+OEH4xDUn/LOVbls8Crccf8/gtOfx
    cbsSKW8lCg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfCWASYOQFBVEu8VlNt7xJ3rAgBULE0aC65MZ3tsSWtmlgFrKMUYe9TU8kQvp4ZdUOSE8tJiUH3Yb1pJ7klORMD6xeKqV4z+7eTE+6MfkHeH81lgc+UCd
    J9ll/WJGIgV8vLSs+hBsrzlHoshgSLT4EhnbjTHBvk7OkSimcCSw5czt8qURdBYvyNOKT7/sumZr3594ofP+qiZA/g1HasYXhWnMJ1m4hv5ei8amFWcBetpv
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=9sTnvuhUAMdiOQ-S_tAA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeDPQMa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752221AbeDPQM2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:12:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AD1217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 12:12:24 -0400
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
Message-ID: <20180416121224.2138b806@gandalf.local.home>
In-Reply-To: <20180416160200.GY2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
        <20180409001936.162706-15-alexander.levin@microsoft.com>
        <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
        <20180415144248.GP2341@sasha-vm>
        <20180416093058.6edca0bb@gandalf.local.home>
        <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
        <20180416113629.2474ae74@gandalf.local.home>
        <20180416160200.GY2341@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 16:02:03 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> One of the things Greg is pushing strongly for is "bug compatibility":
> we want the kernel to behave the same way between mainline and stable.
> If the code is broken, it should be broken in the same way.

Wait! What does that mean? What's the purpose of stable if it is as
broken as mainline?

-- Steve
