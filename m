Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2009890-1522775770-2-16017048677201066458
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522775770; b=YjrCYDlOrNDl6O3cNYcAYqGvS0NmIJaG0RFK5USZI/Hbl10dgn
    8WP5dEiiutMrn67USVJJDvQc7Ka2DZXC3BI938+K3lsdzMjNNv+i9CWsLXvhc24T
    KwpupmrDpNoe2q8HZs8YUdzP4gao8sG1olpqgCRUlF8lQI1FxJsTjSZ+yP0g/t38
    /q5oPFnCqhXgteywTjDNoK5ZUn9y1/A8u2tXQ3jxBtyDhnioLvOzfcMKMysj0IAT
    FI2OtGL2+gYLWm63tgUKU0z1mjHqIpmhJyiY0BDtpNJWD4CFl5f3V3t0qBBEW42z
    rPkR9ucSYMS9yJjAyB6cMKvlr4EBdp2Om4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=fm2; t=1522775770; bh=Yjue1u5PGffA9VLUVzM+OcairImS9a
    spARWzOHZ1RYE=; b=WNTk39u7qx1WgkqvmMX5F4+pkaupUtrN+g2+I/98O16kGV
    6cwisCqagaUDp4AVuB9gV6LAMDYttuyQKelbUTDEmMEZisnUOdvUtxP1NFvv2V56
    NlE2cHNn3WcdrObfBUyh8uINjEdYFPMx/EjuEUoqgk+vcX5VKdw+Ajy9/O9HNBcC
    0SCmFL0SrBAu/IQn9163n+JPcbv/Q1vZRigPgJWZ+JCouvkjXdS+5JnErHu12nyu
    RiS5uSeF9K3aCJmCmIjAqF+Gx9DTdTqAHnfeur65Utke+++Ku2bQgOkt4PMuAWO8
    NIOA9Aa1GyAqXafaYtjKyNqirAQzbVu22huy0IUA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLvwlafQLXIGIzP+QWujTwT4uSIPz+l+RTYg8H7KfzRphZEfo9NlxMvDAin70Tp8qYg8nxYXk+uy3B+DxGWat/V7fqdwJ8c8Nt2zwn2itqX+B3IF/HK6
    jLXZN4UWvOCMn/UF/PxqgoZukpGM2go965y1Ubd1JGTAiznLoJvTzscQ1nhbDN5RaaUBTU0X+scE5qjaYeRbKSESlIIeSFeixIGrCpR7xA0O6VF6u5K1W32x
    ago/kviZMsCsmNDR3i4+JQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=7VSRE2rH4YmskADEd5wA:9 a=P0ELJTqWlJsHCflP:21
    a=jCqz7uQiBDtoupMY:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeDCRQJ (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 13:16:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751376AbeDCRQH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 13:16:07 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
References: <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com> <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org> <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk> <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com> <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: dhowells@redhat.com, Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9757.1522775763.1@warthog.procyon.org.uk>
Date: Tue, 03 Apr 2018 18:16:03 +0100
Message-ID: <9758.1522775763@warthog.procyon.org.uk>
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andy Lutomirski <luto@kernel.org> wrote:

> > A kernel that allows users arbitrary access to ring 0 is just an
> > overfeatured bootloader. Why would you want secure boot in that case?
> 
> To get a chain of trust.

You don't have a chain of trust that you can trust in that case.

David
