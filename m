Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3215632-1527026881-2-13740216846856448112
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
    1527026880; b=jJWCII/nrEgDtNuQaqNvvp819yG0Tjc5epnI7qCPp4yTmLzAvs
    x9EcNAv9YtU5GP9oTTEEVCbqEaFNbS4TGDybZyypObTYHQoV5QsbzKV/ClMhTfG0
    7oRp0eEtYuGq7p7PcVZ3ab+TnHANnC/eRoMW1kk2NJC1LsAzB9X/RSn/XxVImGjF
    YHNfsB+0PVvDQZo/3nGBblrbLKAF11zg6Y3F6xVy+5BEK/U9uRUtFERq6F/9dxM9
    BcZDKavCs4lxshRvbn4FfYoW2ewl0Idu9sBLsBMtuLL27fmr/ud8JdfQ0xlp9QLx
    eACE3ht2sPqO7zO7NRNqd6V3bAPyCdFDOkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527026880; bh=MVV42o6vBu0c3F/qAfmlbTDc0XddXp
    jrfsOrasfyPRY=; b=BTdVLR1HIT+fZN8pWq1w0T6cb6gOwBHdi55EBMVpIo5DMG
    o+nXNafnK71tjXZcnpHoNDJg+6Gt6sDEa5C55nN9JI/6bAVxI3sv72HH4Qq2WUV+
    Yn6DMwmWIj59owA3Z3ISTy+5lRS0H8bWquPOpT2bjNJBfwtbHhq1feyZkxE6zG0P
    nucFnxCqXAISJXhYrY/iZhNyaZdJWXiatyZOQQZ8fI7+aPStYqFPPelFju2bYd5Y
    DPLoqM+jxo8XSXm0EBcqa8ICoGXVi5ZjJN1qCfglQdq5XC9L79lYUpxUAcrFEh7H
    CrMhojSF0v7dtwI2kuZQaQVg+DXRxRTFMnECvHcA==
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
X-CM-Envelope: MS4wfHu6cSnxFOWQIQN02vU5mWFn4Wyj+03fVdsC86g4r7lggk+xo9oW/0o1id1jJfsITyT1RMr0dMfPIXJwKcgDgx7uJWsfwtp6KiZSyIpesOYtJ8T9pbUq
    /gqbI9YAIUPpgrN65+0+ZtPFlzlraEkuNyAFyxD/FqLjOOzy9w5Z1SAhoOY6PZdL2DqLFok8O01BZwFTSuH5/mt7ww7iJdOhQ0l0OrefJ0DLp2AL6B1Qdx69
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Za2ujYBjTRcH6WKBI0kA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbeEVWHw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 18:07:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49806 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeEVWHu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 18:07:50 -0400
Date: Tue, 22 May 2018 23:07:48 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: aio poll and a new in-kernel poll API V12
Message-ID: <20180522220748.GF30522@ZenIV.linux.org.uk>
References: <20180522113108.25713-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522113108.25713-1-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 01:30:37PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds support for the IOCB_CMD_POLL operation to poll for the
> readyness of file descriptors using the aio subsystem.  The API is based
> on patches that existed in RHAS2.1 and RHEL3, which means it already is
> supported by libaio.  To implement the poll support efficiently new
> methods to poll are introduced in struct file_operations:  get_poll_head
> and poll_mask.  The first one returns a wait_queue_head to wait on
> (lifetime is bound by the file), and the second does a non-blocking
> check for the POLL* events.  This allows aio poll to work without
> any additional context switches, unlike epoll.

I can live with that, modulo bug in #8 (see reply to that one).  There's
some nitpicking, but that can be dealt with in followups.
