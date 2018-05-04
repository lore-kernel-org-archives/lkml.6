Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-856742-1525477989-2-11057684464835456823
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525477988; b=EQMk8A2W5DXElsmDG5Bw2tl71JR4fEwhm2B0tIMBQTLT3d10Vr
    2Pe6tQWexVn46/bdYvxxqojZLk8aHlSVZaWvblAp3xP9jismYhNw5yHqM5bPhf0o
    cvOSM4saMbaSMT+GoslnuI5TEYmS/RHEJ6/2OzNW8vhmrsSNszje3ISm6l2UlKNb
    /t8sst80Asz4E5+hWkOqU8+YQQBapyu6llemjhSM+1Fiq/QeQzoHkLGERNDvjoNc
    xvqkymCtkaAdJENQIh+YLmi8vNOmbS1aN8S5fKY1ZrBuGq+Ocd+8XoZfJ2tXP4Lj
    SAFfFDgz/BV+t53TaAHDUjcWYIXLK0JNvSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525477988; bh=ikhEBQEZYOec3YIXOUZkwgOJOVNAnF7bU/6voAfwOS
    c=; b=DfOSTAXicTr3FgySLQRjilmzrahjJLbN9HF/AKsL4CmIIVNgBzVz90v3dq
    XxEMks7CNL8/OLosrpMhfQPxFLwiRbn3mfcGyy/iZNA2FuaohRImiJxv6NtcZ9By
    XucA88yEBlsbwH3VyVlCR4sx/M6DNlzrXN/tYrKXYKnZAwvrnHkh3hOtC2tw84Ui
    fZJx4zjNrWUgC6eyu2RcX9WgephP2pHQ+PmNKt7GqrN5mYl9F81q7cCXom9Vluor
    OWw8q2U/ewgeTLP2kV1CTxhTB9gnRd0jiluQgHKCUbQMtRuIxra76fT9XjKBl09B
    ZCmhN84aTaajkNX4DeGEuljCCF4Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=PTp3hqGg x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=JYdPz7z+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=PTp3hqGg x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=JYdPz7z+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPkz+H61LoR4LLMt3Hoh7cPHgkIsMoxc4mxW88Pe5llKvWHd1HcgekLWK1qx8VkFBrQBTtT8tluK/m91ORp51pVJ4Gnm0PPn+barajU3IIgLRGmDxXrp
    LVIUJlvTYptdqjyXZK7iyd1M3FsyuNO14/r3Ac6BIGSX4F7qvqJNgLtVn2q6aNsPLycgkV54Xz47E3AH8cjIcj+E2mAx1HSvrAjwUbM7A9VkfoAQXeF7cGU0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=eB6aYJjhE4MpiEEyx-gA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeEDXxG (ORCPT <rfc822;linux@kroah.com>);
        Fri, 4 May 2018 19:53:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43284 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeEDXxF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 May 2018 19:53:05 -0400
X-Google-Smtp-Source: AB8JxZpgC/qkEraY/SpJfa2cUge20P9wkx0MGEndY6PmgUKBnh8SUynzW76EhW+Y0pVQAQ8WiRf2Gyfbg+1phZqnZy8=
MIME-Version: 1.0
In-Reply-To: <20180504132432.GA30458@jamesdev>
References: <20180502215107.GA9884@saruman> <CAK8P3a2y2EA1g099DXOHkfevQb=6zuWmVOq9C_wVTQ8zrAMx8w@mail.gmail.com>
 <20180504132432.GA30458@jamesdev>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 4 May 2018 19:53:04 -0400
X-Google-Sender-Auth: qYL0jqhWVMIwwebPTbFPvDv-iWQ
Message-ID: <CAK8P3a1BvG+jHAmQu2j-_Gmmxc4s_KbccUGP0jvPGq6L+vtjdw@mail.gmail.com>
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

On Fri, May 4, 2018 at 9:24 AM, James Hogan <jhogan@kernel.org> wrote:
> On Thu, May 03, 2018 at 06:40:07PM -0400, Arnd Bergmann wrote:
>> On Wed, May 2, 2018 at 5:51 PM, James Hogan <jhogan@kernel.org> wrote:
>>
>> While I haven't looked at the individual changes, I wonder whether
>> it would be useful to make this new ABI use 64-bit time_t from
>> the start, using the new system calls that Deepa and I have been
>> posting recently.
>
> Personally I'm all for squeezing as much API cleanup in as possible
> before its merged, though obviously there'll be a point when the ABI may
> need to be frozen, at which point we'll mostly have to accept what we
> have within reason.
>
>> There are still a few things to be worked out:
>> only the first of four sets of syscall patches is merged so far,
>> and we have a couple of areas that will require further ABI changes
>> (sound, sockets, media and maybe a couple of smaller drivers),
>> so it depends on the overall timing. If you would otherwise merge
>> the patches quickly, then it may be better to just follow the existing
>> 32-bit architectures and add the 64-bit entry points when we do it
>> for everyone.
>
> I think it'll likely be a couple of cycles before it gets merged anyway.
> There's still work to do, and limited resources.

Ok, let's plan on getting the 64-bit time_t ABIs in place early enough
then. We will likely have very similar timing for the upcoming rv32
ABI on arch/riscv.

         Arnd
