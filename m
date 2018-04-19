Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3458146-1524153089-2-4894990548721950747
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524153088; b=Q7AVxk8iUqbWiZPvVsHTp2QHJBEThHJBbRBVl1o3OqNPZeTsbG
    02zJWPa8lMw9F/x6cpIx7W7iNt9+xRulWWBmwQ7pgyWI8MzlWJeRrdf06p492tCe
    tw+lb7j0Npp8Vs1rekN6D4ui88VS7xBpBVDgm41i2VniE3uJy78OPgTQmR5VARWB
    +fFr7JHA0Tpwbwdd32Dw2/hNI8ge31Rl8Q/zqgW8xZipQhBo17FZoNrfhtEDay84
    N8fmjj0f5YvVaHQ8cmNmNTf7NOt4B4GkEBWSn/IqGuLwIwveLPgpbAccauwsO0xA
    O/v+KaYBdvhVC4PgN94CmEUSqNE0SPUOXGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524153088; bh=VkrdqWbFVhDhc+5Dq3On1Zn9WIGW0PQ8zRMnMWMFl/
    c=; b=HiA/kPcBWznEvD8kIHhwEF3MYI3WIK6zW0Na5n/s4QSqeg/RFdp7xTQgpZ
    8lzD2HqZvHjTGBv83PakApl79cOuCqwK/cH7Dla4CqdzNkrmoN3Oo7qj8NfhTvy0
    X+0AaAV4fny/zppkDG0c1R0lrxTpeu3WGocJWVmjCZJe3dw5daeWOMWlsATjiDXE
    djopKiVVEQohi9piqCd9vb3bYhOdplb/0uT3nKWtLNZaL0bvtgWF+jgS3WSKwhWk
    uW5iWT0Vb4uZ7ytS8yRFI8e1EbSh24wZgdtBbeiZCF6+OYU6rSMzUNLZ2DNitk0d
    ILDPVWmxuYxXm2Br+hiRJgJUGW5Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Vo3s9H+o x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NxZbpiq3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Vo3s9H+o x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NxZbpiq3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKMFrifxnMUgza01Bl4ARUpOcWDBiPDGI4rgoeZYhq8bL8FWNHne2PaCvJeV8nxOQVbvsBGJfex2naESK4GWaItjggwA0TGvMvU2RzhTScGs0dmP6iS6
    Fmgh4e9K/7jEpOy4SJWjwhZxnuGzoLeYF7vbCp9TgUcuCVdiBSJC/rtfXZWkADNSvjY/yfiwhdmd3ERRxhxyBll3cL9eaWxfriSYpG7QDCr8I8BL9Vu+/ytl
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VUfPOBp7AAAA:8 a=VwQbUJbxAAAA:8 a=oM7PcXJ99-fy6KmUrIwA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=h9p_k6br8ecoN9AbG9pA:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeDSPvZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 11:51:25 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42505 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753251AbeDSPvY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 11:51:24 -0400
X-Google-Smtp-Source: AB8JxZo2/ANMPCi/soAEwZVYhs8/O51+ROWA9vubIIMjBCVhZxyGn2lKKQ8TtETcv3j93nVg07KwOyKHF21zg/AtRj0=
MIME-Version: 1.0
In-Reply-To: <CAKCAbMiaX31mpfEMRQrQbPO+kTfowA6=_KhBSs56=zZ1s0aXhw@mail.gmail.com>
References: <20180419143737.606138-1-arnd@arndb.de> <20180419143737.606138-2-arnd@arndb.de>
 <CAKCAbMiaX31mpfEMRQrQbPO+kTfowA6=_KhBSs56=zZ1s0aXhw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 17:51:23 +0200
X-Google-Sender-Auth: jkfyb8ndsFgLuuaCuScy46_CIBE
Message-ID: <CAK8P3a0psMUhA-wzNmTnrcgrhmHY=n-u9kp23aEKVQ9wxcf3zg@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] y2038: asm-generic: Extend sysvipc data structures
To: Zack Weinberg <zackw@panix.com>
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 5:30 PM, Zack Weinberg <zackw@panix.com> wrote:
> On Thu, Apr 19, 2018 at 10:37 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> Most architectures now use the asm-generic copy of the sysvipc data
>> structures (msqid64_ds, semid64_ds, shmid64_ds), which use 32-bit
>> __kernel_time_t on 32-bit architectures but have padding behind them to
>> allow extending the type to 64-bit.
>>
>> Unfortunately, that fails on all big-endian architectures, which have the
>> padding on the wrong side. As so many of them get it wrong, we decided to
>> not bother even trying to fix it up when we introduced the asm-generic
>> copy. Instead we always use the padding word now to provide the upper
>> 32 bits of the seconds value, regardless of the endianess.
>>
>> A libc implementation on a typical big-endian system can deal with
>> this by providing its own copy of the structure definition to user
>> space, and swapping the two 32-bit words before returning from the
>> semctl/shmctl/msgctl system calls.
>
> This seems generally like a sound approach, but I need to ask whether
> any of the structures involved can ever appear in a sendmsg() control
> message (that is, in the data pointed to by msg_control), or an
> AF_NETLINK message, or any other situation where the kernel
> communicates a structured message of arbitrary size to user space or
> vice versa.  libc can't munge those messages, because new message
> types can be added faster than libc can keep up with them, and because
> I/O primitives like sendmsg() generally aren't allowed to allocate
> arbitrarily-large scratch buffers.

I'm fairly sure that the sysvipc data structures are entirely distinct from
the structures that get passed over sockets, so the question of socket
data is unrelated to this series and will be addressed in a separate
series.

To give some background on what needs to be done for sockets, the
only incompatibility I'm aware of are socket timestamps that
get enabled with SO_TIMESTAMP, SO_TIMESTAMPNS or
SO_TIMESTAMPING and get passed from kernel to user space
as SCM_TIMESTAMP/SCM_TIMESTAMPNS/SCM_TIMESTAMPING
cmsg data.

We already have code for handling 32-bit compat applications
on 64-bit kernels, but that cannot work for 32-bit applications
if the kernel has no idea whether the application uses 32-bit or
64-bit time_t, and we don't have a function like in_compat_syscall()
that we can use to find that out.

Our plan here is to change asm/socket.h to have three additional
timestamp flags that correspond to the existing SO_TIMESTAMP*
flags but signify that user space expects the new structure layout
(which is compatible with the existing layout on 64-bit kernels).
For each flag, the kernel then defines a wrapper that (on 32-bit
user space) looks like

#define SO_TIMESTAMP (sizeof(time_t) > sizeof(__kernel_long_t) ? \
             SO_TIMESTAMP_TIME64 : SO_TIMESTAMP_OLD)

Any application asking for SO_TIMESTAMP_OLD will get the
traditional behavior, while applications that are built with a
64-bit time_t will pass SO_TIMESTAMP_TIME64 into
setsockopts, causing the kernel to use the new behavior.
In 64-bit tasks, we probably want to define both to have existing
behavior even though one would never see the new macro.

         Arnd
