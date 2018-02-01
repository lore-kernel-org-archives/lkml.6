Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeBARIr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:08:47 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:33659 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbeBARIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:08:44 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w11H8UtU006620
X-Nifty-SrcIP: [209.85.213.53]
X-Google-Smtp-Source: AH8x225abcSII8Pb0jvqCHK97QvhYheqsKkgsul9d+DDHfYsr87/emduOYUcXupgyrupm7wyuGXVigls7BUUwLeWLXk=
MIME-Version: 1.0
In-Reply-To: <8d57e878-2195-d59a-460b-1706889eab17@infradead.org>
References: <20180131093434.20050-1-ulfalizer@gmail.com> <CAK7LNAQYT2DuGkP1s+BP8OHChgqE_o6vCwhkU0ZEsFzveb-Bhg@mail.gmail.com>
 <8d57e878-2195-d59a-460b-1706889eab17@infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 2 Feb 2018 02:07:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQP2K6FrQv9D+pGsXhvmk0BRxFmw3pv0pQzfY0Rusb5Ug@mail.gmail.com>
Message-ID: <CAK7LNAQP2K6FrQv9D+pGsXhvmk0BRxFmw3pv0pQzfY0Rusb5Ug@mail.gmail.com>
Subject: Re: [PATCH 00/11] Remove blank help texts from Kconfig files and add warning
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Paul Bolle <pebolle@tiscali.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-01 5:46 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 01/31/2018 07:27 AM, Masahiro Yamada wrote:
>> 2018-01-31 18:34 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>>> This patchset first removes all blank help texts from Kconfig files for all
>>> arches, and then makes Kconfig print a warning for blank help texts.
>>>
>>> All patches can be applied independently, but to avoid warning spam, the blank
>>> help texts ought to be removed before the warning is added.
>>>
>>> Ulf Magnusson (11):
>>>   net/sched: kconfig: Remove blank help texts
>>>   video: fbdev: kconfig: Remove blank help text
>>>   mmc: kconfig: Remove blank help text
>>>   Staging: rtl8192u: kconfig: Remove blank help text
>>>   Staging: rtl8192e: kconfig: Remove blank help text
>>>   lib/Kconfig.debug: Remove blank help text
>>>   MIPS: BCM63XX: kconfig: Remove blank help text
>>>   MIPS: kconfig: Remove blank help text
>>>   arm: vt8500: kconfig: Remove blank help text
>>>   nios2: kconfig: Remove blank help text
>>>   kconfig: Warn if help text is blank
>>
>>
>> Whole of the series, applied to linux-kbuild/kconfig.  Thanks!
>>
>
> That probably means that I am too late, but anyway:
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # series of 11 patches
>


I will add your Acked-by. Thanks!


-- 
Best Regards
Masahiro Yamada
