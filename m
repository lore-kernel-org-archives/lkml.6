Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2496537-1522790814-2-3684638772452489891
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522790814; b=S+AVn8/xF5+H2UJJy27fzj79uWKmE8vxaKROykOsqisvmcunv1
    McOb5tKxr4oDzOqutQihD8REzsfVF9YuNMurIBTF12ARvCtnSJ7yU6ntUt1w+ADZ
    kXfRcxa4HPdosn3RzuJPBbDnWtyKO/P7z0O6GxflEbrFKdugSuc3IKUTCsKv4U97
    nlfHZXLZdvbq7DXz2JOsed7skkM5ZErHNE6IcSkJHTE43VulPr7NR0EpRbZDf9Lh
    55II35R3SA4aNLPNHnItfwi1ukcYJ7v904cjS+uuvyRAyMn3fj5/WBDaABF0BpPz
    9SOu/UAnF73Nvl1UimrEO46rWzgLbKuhaHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522790814; bh=8f+87y8Aiq0k624m7S93MfdziAC5sD8VvOxgl2EOzu
    E=; b=l3o9/nKudCCgZYqDtortyp3oaIfSjaLVjwrjd/wlKQ5CD5unU7LkxcRxqu
    5WJaBU96V9i4MrfPo/svxI1HPmFR+y5f4onoDwVmW5H+hzToN3x0ZTIMTJpsCj6t
    rYF/z4GcBYqEGCUpV3/XfnJ5A2kNIj/5AMb8rGo1GXj3nDCi4RFzT2BJCbOk3+8P
    77vnup1jRhRZV0avKab5X7J3562QLuuCnNOLTgxy1pCjODIfzfsUmYu3lPuipiMA
    KgBqv4LbOLPvJTKvMSedXXKQJQUjvv72bEmvRXxa7IqwcmagzZVJY7SBmNWlo8B4
    WEVqD+mLeEzj1afHHmO5wQFMKzWg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WtTl43Vq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QWRy9TNL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JzWjef6U;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WtTl43Vq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QWRy9TNL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JzWjef6U;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI67xPsgXJ91LeFCzx5lE+9bb41TtkcQ7nly/zfKqkvNkES9v5J4ncEBCr2nIzhAg5CJIaTsp0C/taNrjzb/2htnMsj5RTO1oqWclFKDLjldiK780skU
    wQKYTzj3pc+VsAcOm831kEApTHq1WxvKr6ALtO2PY8ua5dnQg4WBl4Oe45jhzY7fryMEleA5qUtxFO5FCes98BpN4k2Pl3IdibrqkniwF00nylhbFCUpJuAj
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=SklMGoooJxRu8PwLRQUA:9
    a=9eP4RILiwCrBpcd9:21 a=Iecxx01W-gD9bnaz:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeDCV0v (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 17:26:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53986 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeDCV0u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 17:26:50 -0400
X-Google-Smtp-Source: AIpwx4/pLToGBEp2ua2R0CWkOMZc+LafSMhyuqO3Vj8CCGV8TdoOThcauRRbELuA8tUWJWQSQ3Ft/1BBaYRmLHmSa8Q=
MIME-Version: 1.0
In-Reply-To: <CACdnJuvheCbuvTLyDWMQWcUytc4EvuSUaEKywfEX8Kp6qYL9dg@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CA+55aFy5EPxAyqyGGaYUUyakuLbjXHiseWCkz-oNdo=Y-878tg@mail.gmail.com>
 <CACdnJuuXOP5T-BRAwMvc7XF8S49wyvp4ZYgcU=EZkaGNgPAQig@mail.gmail.com>
 <CA+55aFzGFZT68ih446DeQbB69Fyk_wT6b7PGq0iz-gctUGQq_A@mail.gmail.com> <CACdnJuvheCbuvTLyDWMQWcUytc4EvuSUaEKywfEX8Kp6qYL9dg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 14:26:48 -0700
X-Google-Sender-Auth: adbfI3QnP-JQqEchQZuz8W_phGg
Message-ID: <CA+55aFy4ZVaar3sf7bSVYtU5sRkv18x9W8HMEwF9O9beQK4wbw@mail.gmail.com>
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

On Tue, Apr 3, 2018 at 2:08 PM, Matthew Garrett <mjg59@google.com> wrote:
>
> Secure Boot ensures that the firmware will only load signed bootloaders. If
> a signed bootloader loads a kernel that's effectively an unsigned
> bootloader, there's no point in using Secure Boot

Bullshit.

I may want to know that I'm running *my* kernel, but once that is the
case, I trust it.

In fact, I tend to trust it more than some random vendor key. You should too.

Your whole argument is FUNDAMENTALLY garbage. It's the Disney kind of
garbage. It was garbage back then, and it's garbage now.

It is also garbage for a simple technical reason: secure boot can be
hard to turn off. Sometimes "turn off" means "you just have to add
your own keys".

Yes, on x86 hardware at least at some point MS actually had the rule
that it has to be something you can turn off. That rule is apparently
not true on ARM, though.

Seriously. You sound like you're parroting some party line, not like
you are answering the actual question.

So again: why do you conflate the two issues?

If you want lockdown, fine, enable it. But what the F*CK does that
have to do with whether you had secure boot or not?

            Linus
