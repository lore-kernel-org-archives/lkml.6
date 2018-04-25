Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133472-1524681382-2-3110822894426844142
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524681381; b=gHugVzFm6/JwQknf7tMtjH56vpBLnReIaijWhrd5lSFG1Fk4kP
    cr2skDY5KhJAgVD5qxWQV/5joaG1qDBI5DRe/nM0KV5BNFnEw8LwlIhbrGDyP4ry
    lxgRcIwSG2fP3GrnaWVNDMEwlGEFYTFDORinTIHC6SYrwNY/4rhgPQaRjQp8P5YB
    AbvVy2iV2SDFLitLMT1X8usTyJZqYzO3ipRGiQx0QvExVCe2jjAT1GdvlnUNlFpZ
    J/vZuNOxYXkOY8W6JleCLWSd8EELzYxxzncvrOn980SG6MbD/ypBQPp63HDPHqzM
    UI+ZDmpfAo6ENL5lg5JpN1S5+VnO6dn7OcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524681381; bh=tzqhY1U4BLHnVxBXzDGgB5iVZViuB/G+wc6xttllQ2
    Y=; b=XmUdf5wz03aPNdVB51yBbG75sqdsidRuW8di6A/7Y5DcN1HTRFugSjSNMM
    WchC1f/FYsMZpNYgx9CYtQ6z4ljwnmqUvg8MdxW2nVSpEzfWnHaSbQmrhTGtWK2t
    HUi0M6EnhGEUWlMexr6hvp0yR+NqI8zXIsSH7nHNYH98LC8++b3MeNSn/PgpuoC1
    Gx7KijlyCeE82auvjMNu6X12JDl5hKhwtgcHAwX+uBiMBRYNw1Hnnt6T9QfedeW+
    cFf6u5ySMj+bxzfLiTJMzlLY2iou3ohYsfQPJqqPWRhQMd6EXj1eNQSTNniJfmOA
    9vrgSn/V6OaOt07kDs0RjM1lvZWw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VFh/ZmHY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eLS/DH/V;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VFh/ZmHY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eLS/DH/V;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAdEZiOxmPy/Ah5VXcLQmPtQxVjVjqffNShvkd9CtXKGplAm4LA0Hqh39+p/ZBGy0rtbDnnBk33g/icSHKt9aPJEo5uoRQxc4a1zV1zbNG9EtE/YQMQW
    yyTIv9syLneDV2bybZ/YjSbdHQJqDv8ysD3CSi0hZbCjO1p5wj/rAtaH4qbbnC9ByvZeIG4pVWzw6nwxZE5i+zISLRGFiWFHveF6Wjx2Rl5uPnjHLH+AE8iX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8 a=EffkCuDjhK_Xs8SyjzQA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755986AbeDYSgS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 14:36:18 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38382 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbeDYSgR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 14:36:17 -0400
X-Google-Smtp-Source: AIpwx4/nZjufJDx8proYREIlkN2WGxRH5J485XZv6llh9Wj8GSxOKXA6CmJhZla9M1K1HNg4tqa3kTCvBuishMMbTaU=
MIME-Version: 1.0
In-Reply-To: <20180425160311.2718314-3-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de> <20180425160311.2718314-3-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Apr 2018 20:36:15 +0200
X-Google-Sender-Auth: 0iMZs6m4uF7ZgsvQePf4OpE3hgA
Message-ID: <CAMuHMdVThd7nV=EsSSZ1puC6b8V85pWHDSGvJpLaeeafo-vRaw@mail.gmail.com>
Subject: Re: [PATCH 02/17] y2038: Remove newstat family from default syscall set
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        netdev <netdev@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 6:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> We have four generations of stat() syscalls:
> - the oldstat syscalls that are only used on the older architectures
> - the newstat family that is used on all 64-bit architectures but
>   lacked support for large files on 32-bit architectures.
> - the stat64 family that is used mostly on 32-bit architectures to
>   replace newstat
> - statx() to replace all of the above, adding 64-bit timestamps among
>   other things.
>
> We already compile stat64 only on those architectures that need it,
> but newstat is always built, including on those that don't reference
> it. This adds a new __ARCH_WANT_NEW_STAT symbol along the lines of
> __ARCH_WANT_OLD_STAT and __ARCH_WANT_STAT64 to control compilation of
> newstat. All architectures that need it use an explict define, the
> others now get a little bit smaller, and future architecture (including
> 64-bit targets) won't ever see it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
