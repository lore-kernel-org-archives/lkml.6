Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1234427-1524214482-2-15119367754175675884
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
    1524214482; b=POef/RwgLn5/SDtJ4QP7TaMU6uuiftuLCXNy87BKasxYfrPwtS
    r2dmFAqFAlP6eQnKa6pZB7RyHi3uNYlRZODN7aMhPqUhoyHZzK0Yd4idDEvQUaSb
    w9JrZmvq5BGVlITdmzfF4Z24Wz0HObAZ/Y59rLfRlGGFoCZ6TdlU+d7kjp4LXX7l
    geJNDOsq01DIAjoiRRF/3YYlvBw+YSMx3HSB8obAZfKI9m3MJBi5NRW4Sswtq78K
    z5tCKswbnEWqe3krGfGg8N7ube6F6NXpYnDLkDM+W7H0Uq2D63VQ9rJfeK6xVEPl
    YGzY31pmUtGZrpZcZ10Vn8DJVynJtMCYaUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524214482; bh=JXaJKYoKmmgbydDk2fgIIPfoKyiXDh8pYqzyDppjwj
    c=; b=Qs0L7rV3rJenhnhEJ35dY4XrmXkFWXWlsAN/dCNzi0gcEjTl6QZhBNFIXn
    B5hDh2RIqV3I9/3VRvzOJcGXz9fkGfN4zwqFMCfM82fFGsBRhs4Ph8R/n3tl78CW
    sqAKEBlJPHvDoyP694K6aG1GLt4htY4nuRUv/ibQTJdKvSQQ7lR0ltieWqxVHKK8
    UiQHx3zPuTSPqV0lEnoHfTaLww0bDQ1WNZeCj+hk3OvpFRYDNB233uYVLceAMmav
    qOPbDeF1LwUbZZk6s/SE0ZGRA4DXOiiJyi0jMeLqyyIYjQz5VuxAXtVlmVTkxDMP
    vzZ9CVGGUia14ZzIezL+Qy/z3EyQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BuLEFbtD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hLrLxC7g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BuLEFbtD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hLrLxC7g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDKdufpN5JSkjNX5mfUoQ018qLdGsMaxFAnBNwc6mcrtDrzBrrJQXNIIjJJVdj+MLzv6DYMmgPdE4B7yFm9odpcoib9dycuOIsB7ydJ3J9+hkf0FYevy
    IC6X72b43umDryWhCaqAGxhOG7w3la6KPxTpaSsEZQ0yXaMO1al04GFPLWFT8jwnLrYDQYH/enFPpcmaiU9O81CFUyMqcwBpnXsosu2+8O8azWKkLwFn4Aru
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=ZWjZ2FytY9Zz4HJLFpIA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbeDTIya (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 04:54:30 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35888 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754307AbeDTIy1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Apr 2018 04:54:27 -0400
X-Google-Smtp-Source: AB8JxZqtUTnZIlasdnq0AkzllUsn5TyoUokukSVbapwu1EtpHMhAZpozgWc8R9CLrCcJUFcgrjqV75t+wGAnxHWEdHA=
MIME-Version: 1.0
In-Reply-To: <87k1t2n8v5.fsf@xmission.com>
References: <20180419143737.606138-1-arnd@arndb.de> <20180419143737.606138-2-arnd@arndb.de>
 <87efjbnswr.fsf@xmission.com> <CAK8P3a196QYoM1egagMuZw4WhiwRiO83Qpj0CxoCeVQBEaj-gw@mail.gmail.com>
 <CAK8P3a2KR+0ZE5jHSmO6pSuiRPH83p75KetuQuHL1atChcTJGA@mail.gmail.com> <87k1t2n8v5.fsf@xmission.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Apr 2018 10:54:25 +0200
X-Google-Sender-Auth: tOfzH-co8L5k2AQrWlQ-PMWJMfw
Message-ID: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] y2038: asm-generic: Extend sysvipc data structures
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Albert ARIBAUD <albert.aribaud@3adev.fr>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Jeffrey Walton <noloader@gmail.com>,
        Daniel Schepler <dschepler@gmail.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>, tg@mirbsd.de,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 12:12 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> On Thu, Apr 19, 2018 at 5:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Thu, Apr 19, 2018 at 4:59 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>> I suspect you want to use __kernel_ulong_t here instead of a raw
>>>> unsigned long.  If nothing else it seems inconsistent to use typedefs
>>>> in one half of the structure and no typedefs in the other half.
>>>
>>> Good catch, there is definitely something wrong here, but I think using
>>> __kernel_ulong_t for all members would also be wrong, as that
>>> still changes the layout on x32, which effectively is
>>>
>>> struct msqid64_ds {
>>>      ipc64_perm msg_perm;
>>>      u64 msg_stime;
>>>      u32 __unused1;
>>>      /* 32 bit implict padding */
>>>      u64 msg_rtime;
>>>      u32 __unused2;
>>>      /* 32 bit implict padding */
>>>      u64 msg_ctime;
>>>      u32 __unused3;
>>>      /* 32 bit implict padding */
>>>      __kernel_pid_t          shm_cpid;       /* pid of creator */
>>>      __kernel_pid_t          shm_lpid;       /* pid of last operator */
>>>      ....
>>> };
>>>
>>> The choices here would be to either use a mix of
>>> __kernel_ulong_t and unsigned long, or taking the x32
>>> version back into arch/x86/include/uapi/asm/ so the
>>> generic version at least makes some sense.
>>>
>>> I can't use __kernel_time_t for the lower half on 32-bit
>>> since it really should be unsigned.
>>
>> After thinking about it some more, I conclude that the structure is simply
>> incorrect on x32: The __kernel_ulong_t usage was introduced in 2013
>> in commit b9cd5ca22d67 ("uapi: Use __kernel_ulong_t in struct
>> msqid64_ds") and apparently was correct initially as __BITS_PER_LONG
>> evaluated to 64, but it broke with commit f4b4aae18288 ("x86/headers/uapi:
>> Fix __BITS_PER_LONG value for x32 builds") that changed the value
>> of __BITS_PER_LONG and introduced the extra padding in 2015.
>>
>> The same change apparently also broke a lot of other definitions, e.g.
>>
>> $ echo "#include <linux/types.h>" | gcc -mx32 -E -xc - | grep -A3
>> __kernel_size_t
>> typedef unsigned int __kernel_size_t;
>> typedef int __kernel_ssize_t;
>> typedef int __kernel_ptrdiff_t;
>>
>> Those used to be defined as 'unsigned long long' and 'long long'
>> respectively, so now all kernel interfaces using those on x32
>> became incompatible!
>
> Is this just for the uapi header as seen by userspace?  I expect we are
> using the a normal kernel interface with 64bit longs and 64bit pointers
> when we build the kernel.

Yes, that patch shouldn't have changed anything in the kernel, which
continues to be built with __BITS_PER_LONG=64. I haven't
checked the vdso, which is the only bit of the kernel that gets built
with -mx32, but I assume it's fine as well.

> If this is just a header as seen from userspace mess it seems
> unfortunate but fixable.

Right. I'll fix the IPC stuff for this series to make it work with
any value of __BITS_PER_LONG on x32, but I don't plan to
do anything about the rest of x32. The patch that caused the
problem was intended as a bugfix, so we can't just revert it
without first understanding how to properly fix the original bug,
and which other interfaces have now come to rely on
__BITS_PER_LONG=32 for x32.

Adding a few other folks that have been involved in the x32
kernel support or the Debian port in the past. Maybe one of
them is motivated to figure out how to fix this properly.

       Arnd
