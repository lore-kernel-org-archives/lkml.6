Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2795407-1522799995-2-14140086564872940547
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522799995; b=IdBw4Yl1P8V1I6Pr9kLcmYQLHzoWIRK6noanTybiUXI2US5XnL
    CwjompyxgsHJrT3kuNYz3GwuHEXwHZBN0zMuZ/QJrgPO/j7zsnXTLQ28Luj+aDAP
    YzqjHHpfIpqLvK9dRN/IKCCEvoZvVC0foq5Hh/yej5dpjs/ejnUEaX6m1DCYZ1WN
    yhrFL5j3WDe8oyw3hskbmvZwtnON9Erbe/4ixH0OKwOAmnAXp8JjaQ6/oknlEHvJ
    u6wD+gP45+tqoQU7Mz8x4mTZqwWie9oo3meYzfp4YqqpNGg+H2HHn8hBMF/f4uYg
    cSCrDDME/9TEKIxfAU1M9L94iEdoxhzbRO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522799995; bh=cEy7IVOg1jHC5scRnmvBM2nPIyTp5ZKPGjLbM0Jc4u
    g=; b=ff9CCKknrMiVNZJYtmXFBaAoh1BC7lJ8GcE3ZRczS59wCx/Jgc9HJ9IwFD
    N7xXhsTKsxJdmS7fqhG4hb9NTU9CKuue+SPh8Ocp9Hv/EiUfb54AX1lFavHIHL/H
    TEdUEC4hoQKY8yTnIr99sKLaxMZg5NTCn990X0EM46yOqHfPPyHvVwL9WhpRxpeB
    1L3HzrehBboW8CqV4pL7bFDS2Rcw00wd2Jcv5LOklFEOwrorJf3s9BqVdvQGZFh4
    /u6gmOV3Tv5MQ10K1je8FRTeQ37Qtr3eOOpsLvp9WkxWqly8Ykx7HffI1k7YAXJF
    gfwPAnbIPEUIjdWFRQDHUcMZAUAw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Sla2lLb3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KdesvWtO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Sla2lLb3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KdesvWtO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB2VtiOiIBcgPvSTvGYsLTNl2J6An5i6m9kVVjK7O9dsdI7Rj9Ft2DsdyKBeN/Ummic6TXyZxPPYYZAZVBobz+NaLHpuE0GsmuNvN/WBhlWxwc/RYHqe
    W2CkY9VjBOpgyRzGR1moxCoyKv1c9ffC1xkO7+8xYfs5XBOa3JfzebDDzVeUfbz2NXeHI+PINythEh9p+j1m6t/+RhT5yHmj6RyGx+mAno7t5iGhyqgLyiI3
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=4JZgvL3fMT4lvhgTAtUA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754292AbeDCX7y (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 19:59:54 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55614 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755312AbeDCX7v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 19:59:51 -0400
X-Google-Smtp-Source: AIpwx4+DcZ5gN9LkGgfoZ6Vdn08VS/gxu/zov5M58szaN0eDyr5BSVYlbtm6qBhqk3T6Hk20EVR4KjgoSktkgw8xyxg=
MIME-Version: 1.0
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
 <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com>
 <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com>
 <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
 <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
 <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com> <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com>
In-Reply-To: <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 03 Apr 2018 23:59:40 +0000
Message-ID: <CACdnJuvqQQ+hidokY5GA7g-yrAs5-358it0cs+m_d4RFDMuB_w@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: luto@kernel.org, David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 4:55 PM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:

> On Tue, Apr 3, 2018 at 4:45 PM, Matthew Garrett <mjg59@google.com> wrote:
> >> Be honest now. It wasn't generally users who clamored for it.
> >
> > If you ask a user whether they want a system that lets an attacker
replace
> > their kernel or one that doesn't, what do you think their answer is
likely
> > to be?

> Goddamnit.

> We both know what the answer will be.

> And it will have *nothing* to do with secure boot.

Right, because they care about outcome rather than mechanism. Secure Boot
is the mechanism we have to make that outcome possible.

> > Again, what is your proposed mechanism for ensuring that off the shelf
> > systems can be configured in a way that makes this possible?

> If you think lockdown is a good idea, and you enabled it, then IT IS
ENABLED.

Ok. So we can build distribution kernels that *always* have this on, and to
turn it off you have to disable Secure Boot and install a different kernel.
Or we can build distribution kernels that only have this on when you're
booting in a context that makes sense, and you can disable it by just
disabling Secure Boot (by running mokutil --disable-validation) and not
have to install a new kernel. Which outcome do you prefer?
