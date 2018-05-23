Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-540074-1527100571-2-802022225901482197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527100570; b=nbA2OyYZzOqSY/iVZoAYspHdZOx6XT4ut6sfgz7IiUgcpMPz2X
    EwfCM5qqfZEieKmZ+Vm12Y6DOz1O8vVFakKzjwdAtR6+aT2f0w4p+fIlr0OUwpWD
    uqm2Xs9pqQgBeQY+HFz6e5RbjUcQwJ31tR9S/axXViqdOn4AFpaJVc8bFPCnp24t
    mjwqTgMynDMtgVXfEv0YL3tl/lV1NrOxrE47dEpMh5r+kefOU8FPBs37yWPeI8u7
    GsovVn3kzkOkX/aV7lwSONEdqpx7ZKdmvt1rtzn2x0A/tcP9v67Eb8WmvdsTakN5
    UsJfeP15auKDaHWVDvqXUR82IQtU91YXEZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527100570; bh=FJaeyXIzOyQvwBwmj5rmU4ov/2vc4Ig9vwynFFxF7j
    Q=; b=agdtrUXYWZYtceKB7DMH+SvZ2PQDp7YkOE5IH63SVptYcTDlvKT+2o5enk
    Zo6bm3GNivXAFg48d/98Y38rm/p99055EWhO5VcAs2J7Ue6om0oWQt+Q5cey9Gjw
    PP3upqYK8Igz3wJo4a6v+v7PXIJSx36/I9+PVcm2LWTUF9C5t8bxWr4Oyc8lk4wg
    QZiZrkAJEj1NrvIn1tyZHEJjb6ugXTTQQCVWCWeDgsdmwNXArRiU01K7vmneWGBz
    NvI7nViH97/7vz5rXTs3L1860NzBrobXP4IReYE9DhtnKZfAeKp0RTljIm9RliSa
    THwxsW81/dowrgkScbzFYCyEIJXQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linux-foundation.org header.i=@linux-foundation.org
    header.b=eXSr+AKW x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=IedwfJyR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linux-foundation.org header.i=@linux-foundation.org
      header.b=eXSr+AKW x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=IedwfJyR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHOedx51Kwp/ErYtLpMIRzYTtTlP0WGw/SgsCuQ6dZmngvRx+aky7roDG+htNaDTNoBCv7Gxkhx8yLalb/9dEVD66dfeIc+ZKGVkaRWDITLRLzXWGX3t
    4Acd1Hx4CKiqpSb3zeUlQOAlgQukSx22yxnUGumdeaNg83dKBS/wepHU/GgqqEmVv3QYUzcmJD6XoT0JxTRCKNzxE9P5CHwP8bAfITUSf4L8ZK6bP33jy3Ui
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=R4ayLD03AAAA:8 a=VwQbUJbxAAAA:8 a=BdHN3yHV9vKkkjd-hp0A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=qJlm0-shE6CLU_iKUWNr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933638AbeEWSgI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 14:36:08 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:35814 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933291AbeEWSgH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 14:36:07 -0400
X-Google-Smtp-Source: AB8JxZoihGfVVHEXdEs+ajy6Xe39VfjrCTlY+H4T9dV76ek3BxUoL2FnMcjdLpgbRJVN/4NbYrwVzEvz+cJ0yOeAxdA=
MIME-Version: 1.0
References: <20180523172500.anfvmjtumww65ief@linux-n805>
In-Reply-To: <20180523172500.anfvmjtumww65ief@linux-n805>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 May 2018 11:35:55 -0700
Message-ID: <CA+55aFwAtfiMa22-OFGf1dNR8CNzSKjjLLj5UL-HqgapV7Tf1A@mail.gmail.com>
Subject: Re: semantics of rhashtable and sysvipc
To: Davidlohr Bueso <dave@stgolabs.net>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        guillaume.knispel@supersonicimagine.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 10:41 AM Davidlohr Bueso <dave@stgolabs.net> wrote:

> The second alternative would be to add a BUG_ON() if the initialization
fails
> and we get rid of all the tables_initialized hack.

I see absolutely no value in an early boot BUG_ON().

Either we know the allocation cannot fail - which is perfectly fine at
bootup, and is a common pattern - or it can fail and we need to handle it.

In neither case is the BUG_ON() appropriate.

So I'm perfectly fine with getting rid of 'tables_initialized'. But no, not
with a BUG_ON().

If you cannot guarantee that the allocation works (using __GFP_NOFAIL is
ok, for example - but it only works with small allocations), then you need
to handle the allocation failure.

I refuse to see more of the shit-for-brains kind of "I can't be bothered to
handle error cases" BUG_ON() stuff.

And I also am not in the least interested in "this cannot possibly happen"
BUG_ON() code.

One option is to make rhashtable_alloc() shrink the allocation and try
again if it fails, and then you *can* do __GFP_NOFAIL eventually.

In fact, it can validly be argued that rhashtable_init() is just buggy
as-is. The whole *point* olf that function is to size things appropriately,
and returning -ENOMEM obviously means that it didn't do its job.

               Linus
