Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966976AbeBNJqn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:46:43 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:55809 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966503AbeBNJql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:46:41 -0500
X-Google-Smtp-Source: AH8x227/dQ2JREPv8t1Y3n4aWj4rMK6sMjg++TuMjswb7Uc4YqWZx1PaR1Pfob+fnlLd5Cgg3++dxi+FG8O7QdGls4Y=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQaEJFH7Y+XsGEWDbrDkXTt35Yqd5DBmk0hpd6bggy+hQ@mail.gmail.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFp3dPjsEeyrKAbW_duErCS+xYD0K8zhcRPCY65eRNtMqg@mail.gmail.com>
 <20180207191152.kvqrugblst2cko3c@ninjato> <CAPDyKFoxp7p0atQTV=PoQ7Bwt0fOs2aEq1KJHPtrq+zA3eFYgw@mail.gmail.com>
 <CAK7LNAQaEJFH7Y+XsGEWDbrDkXTt35Yqd5DBmk0hpd6bggy+hQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Feb 2018 10:46:39 +0100
Message-ID: <CAPDyKFrCc-rFs_u_sSd=YN5SKFnE-vmjJabb+Sycynv2Q43ngQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] mmc: tmio: another batch of TMIO MMC fixes and cleanups
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 February 2018 at 10:43, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Ulf,
>
>
> 2018-02-14 18:36 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 7 February 2018 at 20:11, Wolfram Sang <wsa@the-dreams.de> wrote:
>>>
>>>> I picked patch5 and patch6, as those seemed trivial. Unless there is a
>>>> rc9, let's aim for 4.17 for the rest.
>>>
>>> I can't find the branch where you picked these patches? I wanted to use
>>> it to apply the rest of the patches. They don't seem to fit on v4.15
>>> or current linus/master. Can you share this branch?
>>
>> You need to check again. :-)
>>
>> Patches up and to patch6 is already in Linus' tree v.16rc1, those I
>> carried for quite a while on my next branch before sending them in the
>> PR to Linus.
>>
>>>
>>> I will do reviewing now "visually". But please wait until I tested them
>>> before applying.
>>
>> I am eager to apply those patches you already have reviewed (to
>> patch14), as those mostly seemed rather trivial and should be nice
>> cleanups.
>>
>> Do you mind me going ahead, then you can continue and review/test the rest?
>>
>
>
> If you move forward, please fix-up the commit log of the patch 11.
> (https://patchwork.kernel.org/patch/10170007/)
>
>
> Documentation/devicetree/bindings/mmc/tmio_mmc.txt
>
>   ->
>
> Documentation/devicetree/bindings/mmc/mmc.txt

Thanks for the reminder. Yes I can amend the patch, no worries.

Kind regards
Uffe
