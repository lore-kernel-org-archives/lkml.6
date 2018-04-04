Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2795407-1522801354-2-17643427821093455421
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522801354; b=VhKYxZCPmwP9Ztu+hqnxXvbIjWjpUO/0osdKP+tpR5TqM5oDji
    i1TKbWaZaQKvssL0BPM9idxeedJNvTlk/By6DY+kyhQxzohIRQA7SKNkIio6UZfw
    36rMDxwvItxpKTbC90n0+vuO5tig7d/G83YwgXK23HQAZFl8bEaF0ABeAXvNUPuq
    UA+yokeXbcwlGTn9Cmgnd8jrYv5Nu0kPbrvf3DhP59qBOYlZ3F7HLUtKER5//Xi0
    hY/oNODc7aD8NQIz0Askwczn+yjByGW3FGUYg29mC6qQ2Onz9PjIxGR8DgKpDLuR
    jgBllYAL1Gnc1p8sNpSX8wN51LsBGz5S2Rlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=fm2; t=1522801354; bh=sX2XHPTXMGn9CkXZPdaXk0A0HVCUEn
    gytmUbsOF2W4M=; b=R6/EMjhgSMBiG5j4Jc+L6RgK4f21cTXJbRo5gOwkjyJ9L+
    RLHjEbvIvH/dcpsvpbPXHJ2CZ2rIJxAnrmjP7O30QYy91DvsN9Hv2q3FRCDKPTqT
    578p8ImtGMeEoUZv1NYnu5OjlM/4lH0sgCJ31k2nH4tCq3PQ2OB4QDP4kbOGg8GJ
    HslhzK/g3TBbjpFUW42w/99cZeXv5zmHtM1+ASXUHx/fvXq3ZLXQtP708c9150a2
    tJk8EQA/2ddVnI3MFXWOGNZw4fp1eaPgctv1giCaQPHjBMplFThIlNeQQNrtvqsl
    QYLnkq5Pv+EngFnK36e72/yGJdUqAzSxwiBTtPBg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC6UEOkT9yqJE0oooYvrv0Wt+EMMAE4VcOMKjtLypHLSQgKHMUNQR+aXGw5vJZBZlolqu4uISHbzQ4iesftipfQOcxUwJNIjWnxnK1Uz04VbLg40zgtB
    3G/zpYW16nPaoKYy8jsPo1IOMxLNghLdb+44E4Db6YBH21F3X0G0q7JsT6aDZjKJHet1xNdEMXwmovg5EbXiSjgO47UjG3dWxxsrpJEeaMbQVPN1COTym4CJ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=dd6OhZ_i_D-i0Ki8aCgA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756169AbeDDAWb (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 20:22:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756098AbeDDAWa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Apr 2018 20:22:30 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CA+55aFzH6doC2F1xBitPRwTZtbiCO_mX+QVcJ8HQCdsdD3Vmpg@mail.gmail.com>
References: <CA+55aFzH6doC2F1xBitPRwTZtbiCO_mX+QVcJ8HQCdsdD3Vmpg@mail.gmail.com> <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org> <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk> <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com> <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com> <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com> <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com> <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com> <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com> <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com> <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com> <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gma
 il.com> <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com> <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com> <CA+55aFx9u-O81MwSq8zpb+MKaWYjYvtEcFu1NLP1_s63ED6_3Q@mail.gmail.com> <CACdnJutkO9dgz=HZpPRR9PZC=+cHh97dRUiGB+D3gruZr6U9Kg@mail.gmail.com> <CA+55aFxZN_p_cU94z7QN8=HnPanRrpRHH7UUkOBaFDSjfrivnQ@mail.gmail.com> <CACdnJutOAPTmPm6dmHiw4+8rj=M7B1SiCkPaRZLmi9-CCuRyNg@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Matthew Garrett <mjg59@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
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
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11961.1522801347.1@warthog.procyon.org.uk>
Date: Wed, 04 Apr 2018 01:22:27 +0100
Message-ID: <11962.1522801347@warthog.procyon.org.uk>
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> ...  use the kernel command line to disable things.

An attacker could then modify grub.cfg, say, and cause a reboot (or wait for
the next reboot) to disable lockdown:-/

And whilst we could also distribute a non-locked-down variant of the kernel as
an alternative, the attacker could install and boot that instead since we
can't lock package installation down very easily since it doesn't impinge
directly on the running kernel.

Unfortunately, it's hard to come up with a disablement mechanism in the kernel
that an attacker can't also make use of:-/

David
