Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3621199-1521623876-2-2055691662572916154
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521623875; b=MKIsKOn+tgmXzqMRXBnl4p9jXQ8WF05FaVuFT3MXlsrhW4V
    bp1yMsivIhlFXFPD79HoKl5n8khzFoU3BXtc+xzXzjWPGgKiVdLzFMEwcsMDqSWw
    BZabbOvrmQHY8CN2nRvGqpQxU9cDcC9C0Xh1AfebNVzohgAsQavrzMdF/ez+6q7S
    Fk5pohFSoo9TgqqITcVNlqA7p87u12mDQ+BLbeeV78qo0p52sySv/TfcjrmuvW8J
    gTIRSsuZXnG0ixAlUxVgFT8ervKvBSJIqiLHoVa67FmujmfUHFhF8+A5AdL4/Ksb
    8a3L+KyiZLj0wu1QvOnwaaiO9Tt7eOsTFoNytMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623875; bh=j8wqyYqSxv9f1/p1BpP5muyv57
    MdvY10PcBqrsB6mqI=; b=A9Azy06I0RcVKJU+CZlVtWasmAXXhSLRqEIgJXcMhZ
    Gn5d6XYrzYdYge9tXF03nk3ZB2Hp1FySnGgvtEXA2DWv7wnm2/cwmZFlZ24vtnCy
    XkGHi10j6KXzNhO0oUmugcJ7jN6EOOZVf5+bBOFSPpRET7y7ELPRkJfVuxSW2d81
    hauQSbqmuz9PoQmdQs1Wu1JJKJFHH4FirTTzfnLuSOwuszCHlXvZSYiINuiTFP7v
    QxBE0aOLq1buxseR09ogcXl8VJdU9iqXpNkfQIvYx9ugIQlzgxWTtR0UK6SUbkum
    LUvyjW9ZZRnERkUgUkB7Vi9u7BMk3JADUO7XYHuHhcnA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeCUJRy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:17:54 -0400
Received: from verein.lst.de ([213.95.11.211]:41170 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751843AbeCUJRy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 21 Mar 2018 05:17:54 -0400
Date: Wed, 21 Mar 2018 10:17:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] aio: remove an outdated comment in aio_complete
Message-ID: <20180321091752.GA6983@lst.de>
References: <20180321073232.13366-1-hch@lst.de> <20180321073232.13366-3-hch@lst.de> <20180321091420.GJ14085@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321091420.GJ14085@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 10:14:20AM +0100, Greg KH wrote:
> > diff --git a/fs/aio.c b/fs/aio.c
> > index 03d59593912d..41fc8ce6bc7f 100644
> > --- a/fs/aio.c
> > +++ b/fs/aio.c
> > @@ -1088,6 +1088,8 @@ static void aio_complete(struct kiocb *kiocb, long res, long res2)
> >  	unsigned tail, pos, head;
> >  	unsigned long	flags;
> >  
> > +	BUG_ON(is_sync_kiocb(kiocb));
> 
> Is this BUG_ON even needed anymore?  Does it ever trip in any "regular"
> use, or is it only there for when a developer does something dumb?  If
> "dumb", then we should keep it, otherwise we might be able to just drop
> it.

Probably not event needed anymore.  is_sync_kiocb checks that
ki_complete is non-NULL, and aio_complete is static in aio.c now, so
it is almost impossibly to hit.
