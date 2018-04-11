Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3216147-1523476608-5-3953403524307641407
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523476608; b=KJY4h9GbHrmzlcUkOZ0+2ei6jooAkT3ldTBDXW6ZQMwIXay9zd
    XtwaDA47HGOetf4eWfO0ojPGaOJL8LWKDeAkDRa1d5qh3CuvgXObNBqKLboefV83
    e6OkqsTNetvvpe02X+RzKSnCUsxDZJlPUiBvfz3yDx6RQmYFw84eJoriX9HHcisG
    WIDqLM4PKwmnzHNOCguNz/Bd/GRl6NtdjERVfA+XiLpWICzUByOzWl8sjB3QkM0T
    sDNVPa/Qk268+ir6Y/Fza3EI+Ayb2LGg4W/XraiR8hPlekDdUyCbw9lqzFtWpWQL
    Q6661sFUL+Quyq1viZC0GlMZ2z2bIsL93Y3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523476608; bh=VX2zlGYxl7474wIbAZtt4V7m7Rkue1
    uMHZTwXoTAtJ4=; b=eASt7y0LGsXRWiIWl7IiTifhdN8R8TjbZLIGNCIV4ZdxxO
    1QhWCdHK86KloRf62l9Si2TCrdgIxfZGulXQEtxhF8OzJySnIv62yjIob/ud1lFq
    ag1g+WbdUAuFzyUgmKuOf7BZ9P1WCLr4gMMZDERxbG4yt5iCXj9IKeadfouh+vVW
    nS/Ab7RFOVjetCRqJeaJxV04ezOykKK06mmVLkPzgKMmCJbafWMAi5Nh4FKOR0DP
    0Gtsy/trSJLqEJyx2QCNpllmxxeyPrMP0Uv671gB5Vswh/94+UMeL537D3+INFzT
    +2Gi5UOq3GpSV0SRuLKKRZZzo02gSs0bfreP5iaA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKG9QFN8BG7EIoH8/AFnzvXrMwCCrz2yo3HKkWhfEiGqUxtSFuvS3hukj8/lHBd55jEnifi+yzfpknucAuxTNZSBrmJ8ay/ag2g3pQbw7AF2Oqi3Asih
    cmFAhASWrls1L6a57UT8D2APUv+KyJplJFDJJokKnEXQAFgmJk0vWfazCi55fqzo/do5JIFZxfdsrrGW5OY70QwwlBQaImyI2SkMOY+oGPptJzaKWbRZZX2r
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=inoG4m36AAAA:8 a=VwQbUJbxAAAA:8
    a=WI3pO64IuleTNIoDHFMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=_Qgj-RFg6mImvLaOgLPg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756621AbeDKT4Z (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:56:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754702AbeDKT4Y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 15:56:24 -0400
Date: Wed, 11 Apr 2018 21:56:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 01/24] Add the ability to lock down access to the running
 kernel image
Message-ID: <20180411195615.GA6979@kroah.com>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
 <6a37b428-d9fb-12d5-8d36-8a032984af8c@infradead.org>
 <CANiq72n=b3ghgHzknhY=fNP9=f8fi8OuW7OPQHXQGJH_aWrT-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72n=b3ghgHzknhY=fNP9=f8fi8OuW7OPQHXQGJH_aWrT-w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 08:50:00PM +0200, Miguel Ojeda wrote:
> On Wed, Apr 11, 2018 at 7:37 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 04/11/2018 09:24 AM, David Howells wrote:
> >
> >> diff --git a/security/lock_down.c b/security/lock_down.c
> >> new file mode 100644
> >> index 000000000000..f35ffdd096ad
> >> --- /dev/null
> >> +++ b/security/lock_down.c
> >> @@ -0,0 +1,65 @@
> >> +/* Lock down the kernel
> >> + *
> >> + * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
> >> + * Written by David Howells (dhowells@redhat.com)
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> >> + * modify it under the terms of the GNU General Public Licence
> >> + * as published by the Free Software Foundation; either version
> >> + * 2 of the Licence, or (at your option) any later version.
> >
> > fsf.org spells that Licence word as License. :)
> 
> Given this is a new file, simply use the SPF identifier on top.

checkpatch.pl should now check for this as well.
