Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2586296-1526801690-2-9585604256272683723
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526801689; b=Urpp4Hu4+lY9t7OeqxXcLpsvAnx+mmkOryURtzKnIteBAg4As7
    o1w5m6MoEEPAbKiVcn3+krK1jW3nCWX18EwosEteXV0rzHK/fH6mhQdf7zS2eC/+
    NHm/8cRdDCbyOWn9+DYxb1RhA9ILGdlQcPjmy8f0kOU9VYt/w1BEXhBxgtl+BFp3
    V6Jz33i4ya/YQ7e8ZRf5Y9J1yWK7bvkKOTwpezsLPhXoBPFWrlPbTsVqtkcwlw66
    Ml3ywwe/Ho4Q5466usrvgKSWeVlFVIrp/iRa20gNxjCIYsQa2ikq4RYnegi/BoLQ
    eVPRLIWcCF/WbkNs7ILe1yzUOZvxrvkDEY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526801689; bh=proHnrPNcvs7blRSXEnKLhKsUZgSEv
    bwfqIauHdVIE0=; b=XGHTDWcJt662tRzIohKyXTS7Vcw++Ge6G/iUllI8t4Vm7b
    bVKNieG5V7TxzDnwhABB10iEE79HuA1LtmMRNogA4eE0skCyt+hNHJwpDe6MN+Qs
    5tFEZOeCBdJGyaJKue1PWiEHVnQylZfLbvsG6FgD/gaQEJOGtLHT3un7SSqg24f7
    4rXzQVX/uej+sBDm8Vb1xvTVowSWpXWxDwjeksT3y33Lf/t5X5utGthKnA0Shm36
    m3pH6C+733yXIOOW1EYhDyQpYBeaLMjlgmad8uoT1SQJKBXdsoP2LCjTpIaw3yxB
    wX0cS3kMZWmRh4/9+xDOe9nNUP7fyiMppBkUvXKg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
    header.result=warn header_org.domain=linux.org.uk
    header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
      header.result=warn header_org.domain=linux.org.uk
      header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHK/71dSeZJItIxeu0RYFzE1irlTztR5DZHf6F/5+w0XRCQTi4myzgY3oaF9AHiW7OwSJd7Q35uWT2LPfZSZJo4mjN6icw3iFTy5k1RQliGHs9GG40Kz
    MaB5npu0i8vDRlIHK/GeoKLgQUehywz7tO58WE5NCMT+PgYJhsbC+MEntSy+uiM/fQWI65Zj4GOHNoSiF0DOTLvQOb0wVvXJTpQcomh/EwG0rxZSqYaG1T4Y
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=PvEgYx5T67RCxcdbrasA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750914AbeETHer (ORCPT <rfc822;greg@kroah.com>);
        Sun, 20 May 2018 03:34:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53574 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeETHeq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 20 May 2018 03:34:46 -0400
Date: Sun, 20 May 2018 08:33:39 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/32] aio: implement IOCB_CMD_POLL
Message-ID: <20180520073332.GA30522@ZenIV.linux.org.uk>
References: <20180515194833.6906-1-hch@lst.de>
 <20180515194833.6906-11-hch@lst.de>
 <20180520053219.GZ30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180520053219.GZ30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 20, 2018 at 06:32:25AM +0100, Al Viro wrote:
> > +	spin_lock_irqsave(&ctx->ctx_lock, flags);
> > +	list_add_tail(&aiocb->ki_list, &ctx->delayed_cancel_reqs);
> > +	spin_unlock(&ctx->ctx_lock);
> 
> ... and io_cancel(2) comes, finds it and inhume^Wcompletes it, leaving us to...
> 
> > +	spin_lock(&req->head->lock);
> 
> ... get buggered on attempt to dereference a pointer fetched from freed and
> reused object.

FWIW, how painful would it be to pull the following trick:
	* insert into wait queue under ->ctx_lock
	* have wakeup do schedule_work() with aio_complete() done from that
	* have ->ki_cancel() grab queue lock, remove from queue and use
the same schedule_work()

That way you'd get ->ki_cancel() with the same semantics as originally for
everything - "ask politely to finish ASAP", and called in the same locking
environment for everyone - under ->ctx_lock, that is.  queue lock nests
inside ->ctx_lock; no magical flags, etc.

The cost is schedule_work() for each async poll-related completion as you
have for fsync.  I don't know whether that's too costly or not; it certainly
simplifies the things, but whether it's OK performance-wise...

Comments?
