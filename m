Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2804109-1522800916-2-17614407391965715120
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522800915; b=w45m8bbwL/tbPNDC/u6XllnWZ8LCkUy/nZ4zD2lC6Bi+Dtf1KA
    vJ5sqK1jQ7OIhl07KnXwXrsWV4fQSIudtELmYcYfq36iWCrXA5oXy5efbGoW5fEV
    HxnVQeRTEGfmQCLyN5XhZ8PIbZTkfc5LlXPCEMEltIZsmuhlmZzozK/nxRLVNInU
    2+Lr/MIfjY6yuHP4rfV7eLlMyZRxpszX9qZWiuW8F0XXu7HpUyLSV7Bza2lggWc+
    I5ZqbuV+dC2jK1HJmrVKW6a3ZTlGdT4Zw+8CWXa0zYIyr5+y+iEyoKdULLUW/9fj
    PwCgFY+kYtK4x9zBZtPm8MNC2Jdb2oRQUhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522800915; bh=2Tj6rOTf0hhsroD7AwMp0G67L708Im0hM4B/pSVRQi
    o=; b=f9xitBD4/1Iw2+oWgzKbVWTqw5Km548rhiMMUmVXK1YsuZY+lWYXGSR+F/
    GM4ZlT4A+FJKTCZMol4k20mR0bf05RBmq+ZLp2igcRUci1yJ0gz6pEOuMWJ/t9Fp
    aflabqPtLjio1IShjp33C5asft077WB9/fRZKAoOfCqxuJmjhuAW5X6SMLXZRiy/
    Tq7NeD3p0K//bDkphXfh8p7Y2YhqVcm6bLhuOsxIUnp2eksF5Dm7YN5DCq+rQNUU
    p/zyTC34Gf/yS3gi2YQeFw8ehrQEd8M1HRJdzo2bv/B8ieIVwhdvqdqi7LZ0mlPo
    vbXnZCUURGdcCglv2Hjc6Gx9bqkA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y1qrPTew x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pu9zvZwv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mpp2HIq0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y1qrPTew x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pu9zvZwv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mpp2HIq0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHgbB9K0sld2M23JkHd1tYDdHsHdIKC0eqp92c777Ly1ifap6t/9KjErWV/U8SuUv6UB59XdiyeKLigfpLSxw8PO22u6BIEcdozoOr0VH6xSZrTqnUll
    akwQUIufAOOGhug3C70ohK6O8urFvLXTwM6VLfZ1B6mwaR/f2lGJNrPquYMBKvHYD+B6Q2mH8emV5kIre4AyKHhdtcuO5LqeVd8nwI6IZiG/xPLsZNoNLAV2
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=BRpfWaHyv08uyVvP-_AA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756009AbeDDAPN (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 20:15:13 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39747 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754966AbeDDAPL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 20:15:11 -0400
X-Google-Smtp-Source: AIpwx48oVLoOXDA+jXmQRwBMgYkhWS/iQwg//AFHdXC6pQ/yJ4WGFjJ3waKC8otuOj82Y1ON5Q+LUCirIcrvje6pdC4=
MIME-Version: 1.0
In-Reply-To: <CACdnJuvFqXGLsAv1Km3MmdssHBfuH5-C_vG3A4eq4Yuj0HhFBA@mail.gmail.com>
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
 <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com>
 <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com>
 <CACdnJuvqQQ+hidokY5GA7g-yrAs5-358it0cs+m_d4RFDMuB_w@mail.gmail.com>
 <CA+55aFwJBGCr-anrdV9N63fUH4V_QJqgr0_fJyHhH=fuqGAoog@mail.gmail.com> <CACdnJuvFqXGLsAv1Km3MmdssHBfuH5-C_vG3A4eq4Yuj0HhFBA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 17:15:09 -0700
X-Google-Sender-Auth: seTIHpaoucqkbwHdl9tYGO6t8do
Message-ID: <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Matthew Garrett <mjg59@google.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Apr 3, 2018 at 5:10 PM, Matthew Garrett <mjg59@google.com> wrote:
>
>> Exactly like EVERY OTHER KERNEL CONFIG OPTION.
>
> So your argument is that we should make the user experience worse? Without
> some sort of verified boot mechanism, lockdown is just security theater.
> There's no good reason to enable it unless you have some mechanism for
> verifying that you booted something you trust.

Wow. Way to snip the rest of the email where I told you what the
solution was. Let me repeat it here, since you so conveniently missed
it and deleted it:

>> Or, like a lot of other kernel options, maybe have a way to just
>> disable it on the kernel command line, and let the user know about it.
>>
>> That would still be better than disabling secure boot entirely in your
>> world view, so it's (a) more convenient and (b) better.

Matthew, it's simply not worth continuing talking with you.

I'll just not pull this crap, and vendors that you convince to do
stupid things have only themselves to blame.

You clearly have an agenda, and are not willing to look at arguments
against your idiotic choices.

                 Linus
