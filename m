Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeAaUrC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:47:02 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:43717 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbeAaUrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:47:01 -0500
Subject: Re: [PATCH 00/11] Remove blank help texts from Kconfig files and add
 warning
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Paul Bolle <pebolle@tiscali.nl>
References: <20180131093434.20050-1-ulfalizer@gmail.com>
 <CAK7LNAQYT2DuGkP1s+BP8OHChgqE_o6vCwhkU0ZEsFzveb-Bhg@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8d57e878-2195-d59a-460b-1706889eab17@infradead.org>
Date: Wed, 31 Jan 2018 12:46:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQYT2DuGkP1s+BP8OHChgqE_o6vCwhkU0ZEsFzveb-Bhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/2018 07:27 AM, Masahiro Yamada wrote:
> 2018-01-31 18:34 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>> This patchset first removes all blank help texts from Kconfig files for all
>> arches, and then makes Kconfig print a warning for blank help texts.
>>
>> All patches can be applied independently, but to avoid warning spam, the blank
>> help texts ought to be removed before the warning is added.
>>
>> Ulf Magnusson (11):
>>   net/sched: kconfig: Remove blank help texts
>>   video: fbdev: kconfig: Remove blank help text
>>   mmc: kconfig: Remove blank help text
>>   Staging: rtl8192u: kconfig: Remove blank help text
>>   Staging: rtl8192e: kconfig: Remove blank help text
>>   lib/Kconfig.debug: Remove blank help text
>>   MIPS: BCM63XX: kconfig: Remove blank help text
>>   MIPS: kconfig: Remove blank help text
>>   arm: vt8500: kconfig: Remove blank help text
>>   nios2: kconfig: Remove blank help text
>>   kconfig: Warn if help text is blank
> 
> 
> Whole of the series, applied to linux-kbuild/kconfig.  Thanks!
> 

That probably means that I am too late, but anyway:

Acked-by: Randy Dunlap <rdunlap@infradead.org> # series of 11 patches

Thanks.

> 
> 
>>  arch/arm/mach-vt8500/Kconfig              | 1 -
>>  arch/mips/Kconfig                         | 1 -
>>  arch/mips/bcm63xx/boards/Kconfig          | 1 -
>>  arch/nios2/Kconfig                        | 1 -
>>  drivers/mmc/host/Kconfig                  | 1 -
>>  drivers/staging/rtl8192e/rtl8192e/Kconfig | 1 -
>>  drivers/staging/rtl8192u/Kconfig          | 1 -
>>  drivers/video/fbdev/Kconfig               | 1 -
>>  lib/Kconfig.debug                         | 1 -
>>  net/sched/Kconfig                         | 3 ---
>>  scripts/kconfig/zconf.y                   | 6 ++++++
>>  11 files changed, 6 insertions(+), 12 deletions(-)


-- 
~Randy
