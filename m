Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2654882-1522795576-2-7520037994876962993
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522795575; b=ua4YyrAtQ0CWsThXhRXclXDY4w7g8Hmr8iITgMdvLCdFO3lIWV
    ESUq1BUBHeQmJdeSLPL27msDrZdl+CzJclILSErJ77aTwleh2Y6MlV8+IlSJNK7V
    yq3CsDHpoasH6TolzcnYmQT33ITG6yGkFdW3YiI6STd7i2bL/1fSVzV1Qv1qAhFV
    xdbh0klnS5krFaIUm8OmFsIorcYXjTx+y8OOUUdcR+MBaylq7vZfzmFYjLpSlijw
    HSPLqdXcZhrcF2hWlffQ826dN4VSUl61QzVWtfI158rOWJYYHWQQlPk3qoPze84S
    08LHhRVaU6mPNsEtXFendCnn6kMNmzl2ZibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522795575; bh=FIdxc1n+ltPGvbnc1/b0xFRDrShzAu7wQmh1IzTpex
    I=; b=Tryv+pZxp1kKIlbwqjlBHfqOc2GajUynNzo4tegeXvSQaavXlVxDdH91UM
    65in+QH442FxaK8c1qj/lLTu7MG/yLwK0+BBGaNE0b+bhxeJy3P8I5QLAdMFj21m
    xFMYRN94HbVdYu0I36zsNjW8RD2zyPc3Tp+6HN6pIYn6nk/2G94EJrg++r6lb+PF
    va6a8/KjCHT11leC9RoWDdyVdKxFUxvlUVkoj1WXS5ec7EWDr9TKJI7jzNZKpaLi
    9zlAjkGCp7qDvi3ntP3w9ObTLMDdS9a4sjObBLq2yvlUPf/SBpCxH8yyfqyhFGAH
    QskJty67XJLIHi72/TbvwILYEIvg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DdWOLeEH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sehAQkM2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KDL8SUuv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DdWOLeEH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sehAQkM2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KDL8SUuv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBn8GUFBNiYVp20gpU/dBDwYjMcR1w1X79Aj3btGnLYJfVTquNw1UppKz+2hzu2hhek8i5H/WMD5Nnq257QRgmwSCdyPci+yg7T8nXGmKWVM8rqSNFMW
    CJigb7Lf8EvjZsCWWiXA+cmdKJcUBYxNP6iOzwhormtMDO1RjV6bEkhg0zKtRLvtRY17OeM1gms5J0b31QJZxA+cv3E8Fna+NnVt05DNT+X/YYhMtLRwLSXh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ULXg6YdNCMnvFr52ilcA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbeDCWqO (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 18:46:14 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34059 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753584AbeDCWqM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 18:46:12 -0400
X-Google-Smtp-Source: AIpwx4/f1xPUsP3Kkkd3og82tJL4zb3BDHo9pCmwplTEYO+pqejPBd4DJhPa3giKB0xd028/wlG0ERkrlmW/kDQh4Jo=
MIME-Version: 1.0
In-Reply-To: <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 15:46:11 -0700
X-Google-Sender-Auth: npfKf-c6k8wxTMi3tjgPTALGwM8
Message-ID: <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Andy Lutomirski <luto@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 3:39 PM, Andy Lutomirski <luto@kernel.org> wrote:
>
> Sure.  I have no problem with having an upstream kernel have a
> lockdown feature, although I think that feature should distinguish
> between reads and writes.  But I don't think the upstream kernel
> should apply a patch that ties any of this to Secure Boot without a
> genuine technical reason why it makes sense.

So this is where I violently agree with Andy.

For example, I love signed kernel modules. The fact that I love them
has absolutely zero to do with secure boot, though. There is
absolutely no linkage between the two issues: I use (self-)signed
kernel modules simply because I think it's a good thing in general.

The same thing is true of some lockdown patch. Maybe it's a good thing
in general. But whether it's a good thing is _entirely_ independent of
any secure boot issue. I can see using secure boot without it, but I
can very much also see using lockdown without secure boot.

The two things are simply entirely orthogonal. They have _zero_
overlap. I'm not seeing why they'd be linked at all in any way.

               Linus
