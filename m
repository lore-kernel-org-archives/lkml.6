Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3377482-1527036339-2-688607164164345919
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
    1527036338; b=eSoI+n4vy8uIzNKPllcD5UXECE2dostk0kOklMMzubVMrR8y3b
    yychYTuUwMHzIyXNfasruIgMrZSUDYBJGl8FIsL/2bAeyguWLc7W7fNIaQzFu6Tr
    U6LQqr3hr7V5J8gkKbi1VKAIvNYYvysqsuhaGLxF8pFkKuEBCoErVDHy6KRvNDq8
    Eq4QB8wd/2LVSfcocyk+iX/ggjaFnuHuzC7/CqBuMNiRBq0VvKv7ZIMqoQzYC/wn
    ad9xbIHY8kTUK2hbIb1FMeX+2RBW5qfTM0AH6o1EHOnDr2B55C9gkq/VIWwXfHOo
    1KeWdVMeltkK1H/VNhAvRThl6HfqJra7Vm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527036338; bh=PdagYvl/R8biZHfBVuCxxFcoSb26ia
    DpTUv9r1Rgbb4=; b=h1fCnaUg2tQ810z+q1HZ4WtWd4f1nNGHkMcY3f0+OAo0oL
    iRIrStO9H+xC7vAUvlyWZXiLAFaR9GBmMx6zszFJGVBBwWI2Ej94lIrjDVPcr5jB
    DYksqoeSCm5p2sE93vLjaTZbgDvwSzoswS/UbEohsmz68VJ9qs01VgUDGUWHR+ZR
    ASrCoLnTbitZ0QUOCd2sYEeGfFNbVLRsjvAdz3nS8aS32sPlwEYIK2C+jVbRHzSt
    zLlykq92HBMMrpPULzOmM+QhoTOVBsTyMAbnWbaT2Jj3ACPmCnu+3hcXKNz5Wwq2
    YtwjbuWUpl9WeCBhIVoKx/dAd4hrssMTEuFeThYw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfJK/CuWomlOiKDtKxtJOanpevSNyEtBmLjDhXWl3S7aRa9KTiKHRKV+4IRXGkpxlQOrNQ5NGYGdK6rmcDfAT7mOSp0mx0CY/W3+nzVkTDDDLBn5iN8vW
    2w7G0p96C9c8zad5qJ6u8NLT3clLkvkypRalyVV6Cuqvbi4sLwkkJbmDsIxfmcHB1kbm6pJ/+YUXpTqTA2uv+dfkOt5/4JNyDRgbI/DFb1sXB0nMURczi/aH
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ODbiBEhV3UD02n3PdMoA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbeEWApf (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 20:45:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52902 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753576AbeEWApf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 20:45:35 -0400
Date: Wed, 23 May 2018 01:45:30 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/31] aio: implement IOCB_CMD_POLL
Message-ID: <20180523004530.GG30522@ZenIV.linux.org.uk>
References: <20180522113108.25713-1-hch@lst.de>
 <20180522113108.25713-9-hch@lst.de>
 <20180522220524.GE30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522220524.GE30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 11:05:24PM +0100, Al Viro wrote:
> > +{
> > +	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
> > +
> > +	fput(req->file);
> > +	aio_complete(iocb, mangle_poll(mask), 0);
> > +}
> 
> Careful.
> 
> > +static int aio_poll_cancel(struct kiocb *iocb)
> > +{
> > +	struct aio_kiocb *aiocb = container_of(iocb, struct aio_kiocb, rw);
> > +	struct poll_iocb *req = &aiocb->poll;
> > +	struct wait_queue_head *head = req->head;
> > +	bool found = false;
> > +
> > +	spin_lock(&head->lock);
> > +	found = __aio_poll_remove(req);
> > +	spin_unlock(&head->lock);
> 
> What's to guarantee that req->head has not been freed by that point?
> Look: wakeup finds ->ctx_lock held, so it leaves the sucker on the
> list, removes it from queue and schedules the call of __aio_poll_complete().
> Which gets executed just as we hit aio_poll_cancel(), starting with fput().
> 
> You really want to do aio_complete() before fput().  That way you know that
> req->wait is alive and well at least until iocb gets removed from the list.

Oh, bugger...

wakeup
	removed from queue
	schedule __aio_poll_complete()

cancel
	grab ctx->lock
	remove from list
work
	aio_complete()
		check if it's in the list
		it isn't, move on to free the sucker
cancel
	call ->ki_cancel()
	BOOM

Looks like we want to call ->ki_cancel() *BEFORE* removing from the list,
as well as doing fput() after aio_complete().  The same ordering, BTW, goes
for aio_read() et.al.

Look:
CPU1:	io_cancel() grabs ->ctx_lock, finds iocb and removes it from the list.
CPU2:	aio_rw_complete() on that iocb.  Since the sucker is not in the list
anymore, we do NOT spin on ->ctx_lock and proceed to free iocb
CPU1:	pass freed iocb to ->ki_cancel().  BOOM.

and if we have fput() done first (in aio_rw_complete()) we are vulnerable to
CPU1:	io_cancel() grabs ->ctx_lock, finds iocb and removes it from the list.
CPU2:	aio_rw_complete() on that iocb. fput() done, opening us to rmmod.
CPU1:	call ->ki_cancel(), which points to freed memory now.  BOOM.
