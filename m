Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2804109-1522800516-2-3685700322241189108
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522800515; b=IUXOrkxaLr8Ne3DJ6lnz8aU7dypVbIUv9c6lfo2H6EonzrlcEq
    xgz+SDl3q6jppLiYbp29r/exRvzknKPZEUKJNR9EbgteYh4cSamHBguKvZ20/X9u
    IwO4SezKGN/1YwPb7yc6kmtXtwqs1c4FKy9Fhg3T7lDT+gnkcWj96vLcbS4PMoyj
    vVxAL5vqyxMVCAy/H4e14Xv8YDd72xDs+mH7bXYQZnuibrvg7LYQb7llTmwcZWb8
    5JkhwRo9UQd533w5n9wqAKoFW/5HP/jZSQAF7U8APY3lhSoSSRJUe+eOqbyCIXlO
    wRVqodfcO0+YLcEmJHXNUcyjvZRL2+g53RQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522800515; bh=inUOMHU6Y0tQFId5sL8wCebmrkZW29CostpOGAzVGc
    o=; b=wDHyIqK4O0ZTfnX2YAucl56z2v+P0IZc48Q7TN020j04rDB7/ARQECvB6P
    RqW2B/mKM9+eON0bxz2mAZ5jWImYNe79iSloeWWonrzOzLN052F6ejRTascwicCf
    6VUuNqcoa7OQ3CgNAwyvtIwsboISATWz2UWNLU0Fp85h4kFLiGsPrAWvvVqhfDdy
    5X4cZiKr5+oopRhSzKJozS+onq1JdU0oyR1XzYhGnqzRSmnAa0rFTHTEUD9CJ5Xd
    OweRb5koe1fChqAB2XFYeWlNNzjMncqhGduAwtlH1UrkyrdQQHVCjYXIgHOjcyAW
    zllasSbfFvpIHsRBsDyq6nqWU13A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ouj6xCI4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tekQMCpP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VQ7AP7B5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ouj6xCI4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tekQMCpP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VQ7AP7B5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMbBF7HfB5YCV3H0Gj9iJO1dIuHq6/jVE1YfeJljCsyX43QzyK5yAm+hiYR4Uom+kpcG0wbPr4Z6fjqB30mSGrKOSHMeU0JZNt5wfY66vDnyzJNShPDo
    EC0DUwTApawUyoTwK4vglsq6uzx2RG0QGqucsGOcqMG7QoCRC3p9Ex1typdMxVQqyUF4X9e/4hsyorQeavC5gSBCUAgOc7Z6Zr+hlNnori3iSwazIK/xPgoL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=Nb-y9vz3dhY-ev5hhXwA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755746AbeDDAIe (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 20:08:34 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45433 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754966AbeDDAIc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 20:08:32 -0400
X-Google-Smtp-Source: AIpwx4+vKYuFHY8D1c4Fs0r8FAoNjnwkpelR/VHtiHpct0J0XdSXogWousBBQgmPLbaUidpfGMW4/+iq2g5V6fZbn3o=
MIME-Version: 1.0
In-Reply-To: <CACdnJutOAPTmPm6dmHiw4+8rj=M7B1SiCkPaRZLmi9-CCuRyNg@mail.gmail.com>
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
 <CA+55aFx9u-O81MwSq8zpb+MKaWYjYvtEcFu1NLP1_s63ED6_3Q@mail.gmail.com>
 <CACdnJutkO9dgz=HZpPRR9PZC=+cHh97dRUiGB+D3gruZr6U9Kg@mail.gmail.com>
 <CA+55aFxZN_p_cU94z7QN8=HnPanRrpRHH7UUkOBaFDSjfrivnQ@mail.gmail.com> <CACdnJutOAPTmPm6dmHiw4+8rj=M7B1SiCkPaRZLmi9-CCuRyNg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 17:08:30 -0700
X-Google-Sender-Auth: FV6Kf0gpbfhfVqu9axvi7UQ3QC8
Message-ID: <CA+55aFzH6doC2F1xBitPRwTZtbiCO_mX+QVcJ8HQCdsdD3Vmpg@mail.gmail.com>
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

On Tue, Apr 3, 2018 at 5:04 PM, Matthew Garrett <mjg59@google.com> wrote:
>
> How? When there are random DMA-capable PCI devices that are driven by
> userland tools that are mmap()ing the BARs out of sysfs, how do we
> simultaneously avoid breaking those devices while also preventing the
> majority of users from being vulnerable to an attacker just DMAing over the
> kernel?

.. if that ends up being a real problem, then you print a warning and
tell people to use the kernel command line to disable things.

And if it's a big and common problem, then the answer may be that
lockdown has to be entirely OFF by default, and you instead just tell
people to enable it manually with a kernel command line option.

Still better than telling them to disable/enable secure boot, which
they may or may not even be able to to.

                 Linus
