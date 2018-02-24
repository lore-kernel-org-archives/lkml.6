Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeBXNyY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 08:54:24 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:60941 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBXNyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 08:54:22 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w1ODs2pB006582
X-Nifty-SrcIP: [209.85.217.175]
X-Google-Smtp-Source: AG47ELuE4u6S1L5H9sS6FQdue5dk4GEeGMb5ycpXulPU46F6BmbsTDqNH7STZwblKWiNkQBtXlOPdO+TqpqOa86Hjno=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KSRswP2FEV7mTMJwLe+WRDdVEUnZBOyh_XWrQu2tW07zg@mail.gmail.com>
References: <20180216202255.25307-1-ulfalizer@gmail.com> <1518815662.13169.27.camel@perches.com>
 <CAFkk2KSRswP2FEV7mTMJwLe+WRDdVEUnZBOyh_XWrQu2tW07zg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 24 Feb 2018 22:53:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjnCnPvFZEPR2YM9EsOALnPy=FeugZC_8PFrngb9AQgQ@mail.gmail.com>
Message-ID: <CAK7LNAQjnCnPvFZEPR2YM9EsOALnPy=FeugZC_8PFrngb9AQgQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Improve and extend checkpatch.pl Kconfig help text checks
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Joe Perches <joe@perches.com>, Robo Bot <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-23 10:30 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Fri, Feb 16, 2018 at 10:14 PM, Joe Perches <joe@perches.com> wrote:
>> On Fri, 2018-02-16 at 21:22 +0100, Ulf Magnusson wrote:
>>> Hello,
>>>
>>> This patchset contains some improvements for the Kconfig help text check in
>>> scripts/checkconfig.pl:
>>
>> Seems sensible enough to me.
>> Signed-off-by: Joe Perches <joe@perches.com>
>
> Will you be taking this in yourself?
>
> (Adding Masahiro on CC -- forgot when I sent the patchset.)
>
> Cheers,
> Ulf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


I am not a perl expert, but I have no objection for this series.


Thanks!




-- 
Best Regards
Masahiro Yamada
