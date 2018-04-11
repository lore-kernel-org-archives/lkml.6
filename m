Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2932816-1523467604-2-12384214980076002633
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523467603; b=IVaxBAfWU1gtkeUi/4xiqdweAW2mpzreHnuqFh9/bvVgv55X8c
    ADZheaFUvkmYBQCivGXrn1nSa1pfX/kWrGouYxL5p/TXx4gRRC6exXplwVKpGBQk
    6Cw2iucEEnty5JR86SOY/9n0DTYpZoE49o8jgfUYprCJW8usbICJCgQiBWxw+tYF
    muzwsMjw5PCDpKdBe3EsYML7ttSUgYnA5xYpOZ2ht1YWkH0LdlBCaN4PYAvS9zd2
    7ZzLmIEUpA7zvMKyvyX/mpDptvr/3ZIpg9K0KDykKieg1uMZpksPni323JYKX6i2
    kjqWUpsVWH1SaqzDxV1Hv/lWPKQCSzc0HOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523467603;
    bh=yxbclChl5BNFNI6ifLFnc5EoyItr+z6gaRvlMqvuJHk=; b=qvfMQbF2KUHk
    1PfhKIGljYjoSLdW6QxNWJU2jWr6nLhEsKzqbGXTsf0Xj7GkBKPxqjLJ53fFQKRP
    d+r/AfX2XgH55uJsKOybk27vAxHBRHJGlqCcvU9XWpA/FJRxnhr93w5LNNTvXyWp
    ZAL/tqNamdCUm3gvoUuGbTXaDhSGU3mNcL/1g0eB/zZQhfGZnfNQciJJnAnYDM3I
    QNOAVOi+DUCLA9jzaVm3euBqJbJDT5Me5OR975nAiIyg+8dFsi/NL5T2VXStnaf0
    KiiibIkZOAysykbxZH+KqhVHibOqwzmVcK0Vp37nOac3TquXQwFzjLhhJ49FhPXK
    Si6K+jJqbQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=hN+4eOR6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=hN+4eOR6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPORXI0UXBdnweP414wCfLkqyEl4MySdWMTt/c6gxDCL+FDerO2LzeZNqHis5awlkNMLOa+Qmi27a/ljY69zCjo1vU/yW9UZJtThhQZY6uEP7eNDKAMo
    oAcaIoY586zplrrGmNuvmmJYmcYtLLVMFnavc07vZZbpOxj0a5fDrjg/Zn/3yyuPm9Cz6xKRG/752rUhXv9QZEe5U2bB0V4GAn3V86Ov5N1hqKiNpfFAcXKV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=FP58Ms26AAAA:8 a=VwQbUJbxAAAA:8
    a=9Rt4o3Z7AAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=jE01AiZSAJ7eki2zvjzZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeDKR0O (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 13:26:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeDKR0N (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 13:26:13 -0400
Subject: Re: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is locked
 down
To: David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <65f9440e-64f6-d573-62a1-f2295cb92c61@infradead.org>
Date: Wed, 11 Apr 2018 10:26:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 09:27 AM, David Howells wrote:

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> cc: acpi4asus-user@lists.sourceforge.net
> cc: platform-driver-x86@vger.kernel.org
> cc: Matthew Garrett <mjg59@srcf.ucam.org>
> cc: Thomas Gleixner <tglx@linutronix.de>
> ---
meta-comment:

I have been dinged for not spelling "cc:" as "Cc:". I really think that
either way should be acceptable.

-- 
~Randy
