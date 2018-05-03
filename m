Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3227126-1525387211-2-668729232153460556
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525387211; b=Lr/OAx9cqwv21bFFryJKjqmB8BFzmU0ZeC97oPku47T3zw39tH
    N43o+44lp45XM5ZLv1GUbZtyvR3iVyKNmhZvtkNf4pGJKbEbGO9ouz/e01hUui++
    1L/mBiptVD0PQzHA9z79L9LFqoJyObi34qf6x0t3l73VNgfknXQY4sMDz2Rg+wfu
    fNpybp03doJlyJVuf3qviDyo+4f7tZHOeuwYWeyS6G5IQuigd9grWRcWnnKIJdW0
    aZflXUnFMa+FxHgKhxJhvKDNLfPIhIxueSKJkdu1Isc94Sbl/IXWvYKTtJpXzi7D
    hBCupKYzaXruaQDwswEPdEAjD6JD3FQKLXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525387211; bh=PKnXhs05Z/cvp+tdY8NqgifaWSZch/rtjwbGXZNtkF
    w=; b=UcZ1z5UUggNmE2aK6P1i1tDfzqB7ky+Lymu+pAX6chXvlVztf7At/ttrHf
    91UhDeqZF+cQffEcONzCHMNG5xh/puRGUZKSOUn/ZW7Xg8UhMKZAEu9WNy+bUUKx
    Bvy3iWV16HCz5Hgb9jUU8qSGRGTvqtxk96PDOY12vQCkM9ojEPq7TFi/Y34rEubQ
    kv7GzfezbmzPRpRyTX8uqIvD8XEqOiGP42Yb8TiSzv8VsqPeSO3fJgINI0C3OPGu
    2SWolPu3ADM03w4PY43+0rpwAip88gWzaGVLprjanMpS5PQZrGLoAF651ApkC/MY
    vdUz0uVq8wRkftRsJSfqhG7D/Hvw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=r087GcyM x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ZjxsxV4X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=r087GcyM x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ZjxsxV4X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI5+ySDAJciCK94XIfYWsIJSKfgwK//c/zaYACR9LzMorreF8XFG1Dl/+X7GDeoRlkADXg1MuOxiQxYIpZgw7L5TgYPQOF4XBr6MwcLcgKb6lxiADx8M
    KP5dOrBlGBoqVf+t3608AJa0mYrixe/MNPxT8fcYN9wp16jtJGT0wfEV0V+rHBald3kRjHF4f8ZGQSI5bsb4jmpKk9uK61NZTPLG2G7k3TTZPcHLTAwZm0WP
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=AD2EB-NJvgJ65bpX8C0A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbeECWkJ (ORCPT <rfc822;linux@kroah.com>);
        Thu, 3 May 2018 18:40:09 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45518 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeECWkJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 May 2018 18:40:09 -0400
X-Google-Smtp-Source: AB8JxZpwC/dbzbv3DiguOedF1ndr0K3sl6t/LOnYqxFG2v7dTrICbkzY6CLxVxE575Yui8Y1C38uyo5LbEeiTOIP4DU=
MIME-Version: 1.0
In-Reply-To: <20180502215107.GA9884@saruman>
References: <20180502215107.GA9884@saruman>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 3 May 2018 18:40:07 -0400
X-Google-Sender-Auth: zGWEe4vkoxJ789wYH7_oUbrkXyI
Message-ID: <CAK8P3a2y2EA1g099DXOHkfevQb=6zuWmVOq9C_wVTQ8zrAMx8w@mail.gmail.com>
Subject: Re: Introducing a nanoMIPS port for Linux
To: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Matthew Fortune <Matthew.Fortune@mips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 5:51 PM, James Hogan <jhogan@kernel.org> wrote:

> Due to the binary incompatibility between previous MIPS architecture
> generations and nanoMIPS, and the significantly revamped compiler ABI,
> where for the first time, a single Linux kernel would not be expected to
> handle both old and new ABIs, we have decided to also take the
> opportunity to modernise the Linux user ABI for nanoMIPS, making as much
> use of generic interfaces as possible and modernising the true
> architecture specific parts.
>
> This is similar to what a whole new kernel architecture would be
> expected to adopt, but has been done within the existing MIPS
> architecture port to allow reuse of the existing MIPS code, most of
> which does not depend on these ABI specifics. Details of the proposed
> Linux user ABI changes for nanoMIPS can be found here:

While I haven't looked at the individual changes, I wonder whether
it would be useful to make this new ABI use 64-bit time_t from
the start, using the new system calls that Deepa and I have been
posting recently. There are still a few things to be worked out:
only the first of four sets of syscall patches is merged so far,
and we have a couple of areas that will require further ABI changes
(sound, sockets, media and maybe a couple of smaller drivers),
so it depends on the overall timing. If you would otherwise merge
the patches quickly, then it may be better to just follow the existing
32-bit architectures and add the 64-bit entry points when we do it
for everyone.

         Arnd
