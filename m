Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeAaJrI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:47:08 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42195 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753603AbeAaJq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:46:57 -0500
X-Google-Smtp-Source: AH8x2256U3V3bdG8lGvOn0dUtE0njBCVYcRseOFQ2wdZBD9HqXUdvcdzHkVZbAn5SHzhDumaNdHYwGMgMAfddZkhkzE=
MIME-Version: 1.0
In-Reply-To: <9cbe668e-fe6b-d525-176d-a1e07541f789@infradead.org>
References: <20180130192349.8420-1-ulfalizer@gmail.com> <9cbe668e-fe6b-d525-176d-a1e07541f789@infradead.org>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Wed, 31 Jan 2018 10:46:56 +0100
Message-ID: <CAFkk2KSJCDjP6e+XyXES9-zRD_2FUbR3T3sCnMhm73ei2mwJvg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Remove empty help texts from Kconfig files
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 10:00 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 01/30/2018 11:22 AM, Ulf Magnusson wrote:
>> Empty help texts are probably either a typo, a Kconfig misunderstanding, or
>> some kind of half-committing to adding a help text (in which case a TODO
>> comment would be clearer, if the help text really can't be added right away).
>> Best to flag them, IMO.
>>
>> Changes since v1:
>>
>> Forgot to send the cover letter to linux-kbuild.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
> Thanks.
>
>> Ulf Magnusson (10):
>>   net/sched: kconfig: Remove empty help texts
>>   video: fbdev: kconfig: Remove empty help text
>>   mmc: kconfig: Remove empty help text
>>   Staging: rtl8192u: kconfig: Remove empty help text
>>   Staging: rtl8192e: kconfig: Remove empty help text
>>   lib/Kconfig.debug: Remove empty help text
>>   MIPS: BCM63XX: kconfig: Remove empty help text
>>   MIPS: kconfig: Remove empty help text
>>   arm: vt8500: kconfig: Remove empty help text
>>   nios2: kconfig: Remove empty help text
>>
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
>>  10 files changed, 12 deletions(-)
>>
>
>
> --
> ~Randy

This patchset has been superseded by
https://lkml.org/lkml/2018/1/31/137, which rolls the removal of the
blank help texts and adding the new warning into a single patchset.

Cheers,
Ulf
