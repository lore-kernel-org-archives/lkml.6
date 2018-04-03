Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389914-1522789308-2-12300181671020708421
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522789307; b=cOrsFlCrIKHLI8FLOTh5XvZJXtHC/uRvNpsae5h+PIvHhMfrz+
    xH9dzTvlO7NKq1y8LADVus5XZw7BGMR6iUgqJlXmfD7nQ3oeP+GrSS0Zsljcnn5J
    cTyuUTAhRwSmzyO+gvrtUB5h/1RT7KWIXHg8ucHBboklJLfH4nOd5GUHT+fWi5oy
    KSBXKgF+2NZUEFBdYr3AtYNJL4ZxZjZV3GRBs/6gZiJCKbli5irswJeP8SmJWqQd
    /5L2IDr6uaqFzUsKcuWaamGW4arnUbjljlzZbz7X0t+1ajSpOhCQfZrh88aUDK0E
    BX82rpKdJKbrh9LxnWmwWGBvygSMSI8on+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522789307; bh=38vzKdpvDSZFEKoMmTuAciL5Xbz7byHHqyCgD3t1v/
    Y=; b=IfFWHn3wvFJ9/O4nEBYjvQhFBh8RuJ9kncTau/YupOcekOIPjAZVEGAjf5
    XYQesErCWVSjn9NjJUZJi9lM5+t47QfeTI1eONurY8cxdetj5tRVRz+jObYffaQD
    7xFo9LuPY/G5Jyv770o39gPDbjZrDubDOa2+xC04GRbJ0u4fa7jbJhTSWEztaxh/
    ySTS6xqM7lNTEuNqNysOaLrehAEFIPhd7rIqGvbJUipDxhJ+fYrZ+g9rH34Kcs+6
    ZKfbYmc5LalaG3sE6kjBqvBqO1cfqLXHE1RzX74x4NkJhtQqHZUl2NLsg3/Y9bgn
    coIpDtPD/AS02VQvjYG1WPiw7VPQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xw47k4bb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HdAQBmeG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YgCNLsVL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xw47k4bb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HdAQBmeG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YgCNLsVL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNF25SVIqRdFN9wHcz6S7bqDRNedS+nOF0ak0YKiwPc8RgCWRd48DaRJ1Y7N4LA+UBq6kXvFn5H471WK2kkcH1gjGC55upGeTqvt+XnuH5KEVfZUJ5Bb
    cNbl6OmoQuzTUNPDlGaFM5QA5O17sqTR0EvS10+7TT0rKHbDHRGfy4n/+hPOH1UoSWrlGSviJ8aNsaNpceyKdR8Jp46Mik6WH4t8bLIfLdcrxvHIz3JwLBIA
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=Ygf0ZLhFo-NbgfMJ65wA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbeDCVBo (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 17:01:44 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43739 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbeDCVBn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 17:01:43 -0400
X-Google-Smtp-Source: AIpwx49UsEFtWRp4057Air+cym6Xzn6GOP+mFE2jEedPO0yGxiI9BaJPDAsaJ4S+F2+CFbZA5ezYRDpDcBgMqUm+ZvQ=
MIME-Version: 1.0
In-Reply-To: <CACdnJuuXOP5T-BRAwMvc7XF8S49wyvp4ZYgcU=EZkaGNgPAQig@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CA+55aFy5EPxAyqyGGaYUUyakuLbjXHiseWCkz-oNdo=Y-878tg@mail.gmail.com> <CACdnJuuXOP5T-BRAwMvc7XF8S49wyvp4ZYgcU=EZkaGNgPAQig@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 14:01:41 -0700
X-Google-Sender-Auth: BZhsph1dLf--jHKld76blJHQLl4
Message-ID: <CA+55aFzGFZT68ih446DeQbB69Fyk_wT6b7PGq0iz-gctUGQq_A@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Matthew Garrett <mjg59@google.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
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

On Tue, Apr 3, 2018 at 1:54 PM, Matthew Garrett <mjg59@google.com> wrote:
>
>> .. maybe you don't *want* secure boot, but it's been pushed in your
>> face by people with an agenda?
>
> Then turn it off, or build a self-signed kernel that doesn't do this?

Umm. So you asked a question, and then when you got an answer you said
"don't do that then".

The fact is, some hardware pushes secure boot pretty hard. That has
*nothing* to do with some "lockdown" mode.

Why do you conflate the two? That was the original question. You
replied with another question. People answered yours.

NOW ANSWER THE ORIGINAL QUESTION, DAMMIT.

             Linus
