Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3155680-1527026732-2-11951110901239667408
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
    1527026731; b=L8EU0MOCIOMLdmOUkiqode8hIm0Z9Ms7TAZEbdL0SPuowhzB/w
    gqAAt81jwX+xd30HVKtsDj380PR2rIWPdY52kUcYlWKdXZn2K9xALqam3hHjyO5n
    z2lcjFKGZVu17kO+EBBSJrvrIp0glZFzobNpuzLxldjcAIkamugfvBzeF7RrUTgz
    sccx3exSQ+ttI9fCP0E1BC9EIVafceEr9y24N31h3ZgKUPgfhphieIT1oScN7gY+
    5+7z+dA1fm/aI4Ut2t5U2FhQw7uc64wQ1Ls1+wHofHZEXDlKpnoiqjAnoZOhM95O
    wtjOf2Rt/pNx7sPnAdrgjBnOJEwSoeqSBxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527026731; bh=NEpuWn2Inc+YyDKz5znhwXjMPnRfoH
    eDTPWo9u5hf8M=; b=cjIHTvHOqEwlKi1U00fB+Zz/gunw4XlEDEzQtWmBEXZziU
    30ZogrBIEkHR3/rJyTVELoO6mDDvtPeSKPrV3qC2jKxNKR5JFayohxAZblYj0b8+
    wR2LeGDAldBOJY1cS6BnafByf41kQc8UGyt27leNFyywdpuj0RiXABDwjVrdj2ku
    PZiWqIemZSf4CchkyjAixkG8A3DLdLhj/BdXUglxCwIce8ZpLsmFYNkambUeNfZg
    cVujVzulOdU6FyvS6mn6eh8LYUZaSotlFxLPLaxfKu9QsSvjiXt3dAEvEd6tzZKO
    EPZVsXpczH8TUhEAeACq0fHXjRPTMOB1S6sIkKEw==
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
X-CM-Envelope: MS4wfFbdmWkC+l73Bu9Y9aVIMWRlTJUYuJ8lLtoVgOVF9wl5urSYTEGkvFIZdQyStP0KHyXdvrZ0YhPanLNVjFtGfZ8X0rEqAVUa+XZQzmkzOYWmTbz0JZji
    uQh7BbR4AmYiv0sJjq1Rm3fWsCPfvNXW0nKwTdLfAM8k3sxRL0CGBfcDAQHF0ZhCE0aO8+eBg16Ds5yBfEJdHMjvZp4sfnv4Jj9Z3CHSNthafmfLSYPFzhbp
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=fZE9nHwt18G7crPm19MA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeEVWF3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 18:05:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49708 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753023AbeEVWF2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 18:05:28 -0400
Date: Tue, 22 May 2018 23:05:24 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/31] aio: implement IOCB_CMD_POLL
Message-ID: <20180522220524.GE30522@ZenIV.linux.org.uk>
References: <20180522113108.25713-1-hch@lst.de>
 <20180522113108.25713-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522113108.25713-9-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 01:30:45PM +0200, Christoph Hellwig wrote:

> +static inline void __aio_poll_complete(struct poll_iocb *req, __poll_t mask)
> +{
> +	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
> +
> +	fput(req->file);
> +	aio_complete(iocb, mangle_poll(mask), 0);
> +}

Careful.

> +static int aio_poll_cancel(struct kiocb *iocb)
> +{
> +	struct aio_kiocb *aiocb = container_of(iocb, struct aio_kiocb, rw);
> +	struct poll_iocb *req = &aiocb->poll;
> +	struct wait_queue_head *head = req->head;
> +	bool found = false;
> +
> +	spin_lock(&head->lock);
> +	found = __aio_poll_remove(req);
> +	spin_unlock(&head->lock);

What's to guarantee that req->head has not been freed by that point?
Look: wakeup finds ->ctx_lock held, so it leaves the sucker on the
list, removes it from queue and schedules the call of __aio_poll_complete().
Which gets executed just as we hit aio_poll_cancel(), starting with fput().

You really want to do aio_complete() before fput().  That way you know that
req->wait is alive and well at least until iocb gets removed from the list.

> +	req->events = demangle_poll(iocb->aio_buf) | POLLERR | POLLHUP;

EPOLLERR | EPOLLHUP, please.  The values are equal to POLLERR and POLLHUP on
all architectures, but let's avoid misannotations.

> +	spin_lock_irq(&ctx->ctx_lock);
> +	list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
> +
> +	spin_lock(&req->head->lock);
> +	mask = req->file->f_op->poll_mask(req->file, req->events);
> +	if (!mask)
> +		__add_wait_queue(req->head, &req->wait);

ITYM
	if (!mask) {
		__add_wait_queue(req->head, &req->wait);
		list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
	}
What's the point of exposing it to aio_poll_cancel() when it has
never been on waitqueue?
