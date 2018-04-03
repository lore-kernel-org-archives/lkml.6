Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2795407-1522799754-2-2794200628868290225
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522799754; b=hLZ0cqKQiMAEvN5GQpkx/QmZlA4vbM8OAvukb1kMeYJ2zYl/nx
    Gfie50XNYHWPc1cCyjsl/aZChlUaKi1groFkzddK/4WFYJDw8Re2qcIoboKWzRfg
    y+vzB8ZZDk4egwdawMvTrFn3vLfPiTCXxujJk5Ud+MNLx29N0IEX0/vUAjzUUe0P
    V8KviU3an81DIZGwrPxWy13B7ERfCNaNDENZHARDHXEvMDKCWoVoPrMGXDbptn5J
    +EG9JVlKz1ELTo/RT0oPSNJqnmKgluryvxRORipE1zzDyYS/V4ZcPJ6T9khbN4gc
    bgDrOMzesTt2OktZVEPBpIvYMyhxF00Ei/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522799754; bh=rgpsUlULuhD3cDQTT9k0j4xFS50YstySXGBjVPqJBN
    o=; b=a5vBs4bz4v8+wgDLjVAWNrK9iese6IbUHRr0X4Z1z8K/wo7+1NJOXln1Pv
    sJa04P+AxDGvYXyS4yLHxnS1inslY7kk9xFNUj2lLHwcZUg991uC2Vqoxbme4Bjs
    9gLzcmZoe0+QHPf7ACT9q2tsxz7OOOvC/L7Camr5sHdpxGjSWN83rLGYlfcTcGXz
    XFPMypSCwGX47KKQxK3D/R40r6k0xEyYqVwHJjSoadNmbnvZUKx9N+qJ2k/Itw7j
    SxDGcqX/FS+ECsIoU78qCG1DgF/9dHfJKhAHENBoYVX+cG42NmsnqIE6i6jqQKqi
    6ebBYdoKStkMbra6yw8jCOpNsJ6g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zt2XR1D/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NqaaFZCS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F/UtDgYS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zt2XR1D/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NqaaFZCS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F/UtDgYS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHrIo9lGpUi+VcUgPaBry0nVmtvUKSlhatlE/0JY2ljv+bqjcvb1klKlJ4fP3l1aQ62qys+8SWck/xeHhupgqP8t+TO0TXiOqQQd8YzkAqodHKnbDxZ+
    hpoyItTqIyEhGPyI+JcPnyKXQxOW5g+NSVPP+Y2fosARnZILIq9BcdO8MATkLsm3X9Cq67ewaOEA/LdXKzW5xWP+DgCcZUkLUpOB6sYlkAf2UWm/W25rXV94
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=60fo_C7FFo6Kya6h5fsA:9
    a=qsljupCW5dLd2LgE:21 a=9XHcvDE9bdiSc2Rr:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeDCXzv (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 19:55:51 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35772 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeDCXzt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 19:55:49 -0400
X-Google-Smtp-Source: AIpwx49a39aGqdvbDAtLGaBS3ciPPYI5cDMPcr0kKFoFm+yreVptdJ41NOXGCFsR8zNhoiX7c6F88kcw30YmoDyRbfM=
MIME-Version: 1.0
In-Reply-To: <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com>
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
 <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com> <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 16:55:47 -0700
X-Google-Sender-Auth: SxDQ3zdf_D8qAYXtve7XlUi364E
Message-ID: <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com>
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

On Tue, Apr 3, 2018 at 4:45 PM, Matthew Garrett <mjg59@google.com> wrote:
>> Be honest now. It wasn't generally users who clamored for it.
>
> If you ask a user whether they want a system that lets an attacker replace
> their kernel or one that doesn't, what do you think their answer is likely
> to be?

Goddamnit.

We both know what the answer will be.

And it will have *nothing* to do with secure boot.

So *you* be honest now.

Because you clearly aren't.

Seriously. Go ask that question to a random person:

 "Do you want a system that lets an attacker replace their kernel or
one that doesn't?"

and don't ask anything else.

Do you really think they'll answer "no, I don't want an attacker to
replace my kernel, but only if I booted with secure boot"?

Honestly, now.

> Again, what is your proposed mechanism for ensuring that off the shelf
> systems can be configured in a way that makes this possible?

If you think lockdown is a good idea, and you enabled it, then IT IS ENABLED.

No idiotic "secure boot or not" garbage.

Because secure boot or not isn't *relevant*.

Christ, we already have things like

 - CONFIG_STRICT_KERNEL_RWX

 - CONFIG_STRICT_DEVMEM

 - CONFIG_HARDENED_USERCOPY

 - CONFIG_MODULE_SIG_ALL (and friends)

and absolutely *NONE* of them depend on whether the kernel was booted
with secure boot or not.

And I claim that it would be completely idiotic and broken if they did.

And - not entirely unrelated - I claim that it is COMPLETELY IDIOTIC
AND BROKEN to make some new "lockdown" option depend on it.

Comprende?

Really. Your arguments make no sense. They are all fundamentally
broken for the simple reason that all your "but secure boot implies
XYZ" are pure and utter bullshit, because all your arguments are valid
whether secure boot happened or not.

See? Secure boot has *NOTHING* do to with anything.  It has nothing to
do with loading only signed kernel modules. It has nothing to do with
your lockdown patches.

Either lockdown is good or not. It's that simple. But the goodness has
nothing to do with secure boot.

              Linus
