Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750817AbeCFFOD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 00:14:03 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:28018 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeCFFOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 00:14:01 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w265Dhsr027213
X-Nifty-SrcIP: [209.85.217.181]
X-Google-Smtp-Source: AG47ELs2/ykkFcVnbPeMV5onXzssNSK2T1g86TLBiQJFJHOesLvME7XQjYvNKQZ7vyAGDjTs+auXr8hhgs/NoQcHCNI=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KTUZYMc9poahUQMoQi=wSVnNHDt0SS8BTdRHs59m=qO4w@mail.gmail.com>
References: <20180216202255.25307-1-ulfalizer@gmail.com> <1518815662.13169.27.camel@perches.com>
 <CAFkk2KSRswP2FEV7mTMJwLe+WRDdVEUnZBOyh_XWrQu2tW07zg@mail.gmail.com>
 <CAK7LNAQjnCnPvFZEPR2YM9EsOALnPy=FeugZC_8PFrngb9AQgQ@mail.gmail.com> <CAFkk2KTUZYMc9poahUQMoQi=wSVnNHDt0SS8BTdRHs59m=qO4w@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 6 Mar 2018 14:13:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNARD1yWA4uoFh0kF5nO2BzXopW2rtx9+LKHfC7--AFjcxw@mail.gmail.com>
Message-ID: <CAK7LNARD1yWA4uoFh0kF5nO2BzXopW2rtx9+LKHfC7--AFjcxw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Improve and extend checkpatch.pl Kconfig help text checks
To: Ulf Magnusson <ulfalizer@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>, Robo Bot <apw@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+To: Andrew)

2018-03-06 13:52 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Sat, Feb 24, 2018 at 2:53 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-23 10:30 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>>> On Fri, Feb 16, 2018 at 10:14 PM, Joe Perches <joe@perches.com> wrote:
>>>> On Fri, 2018-02-16 at 21:22 +0100, Ulf Magnusson wrote:
>>>>> Hello,
>>>>>
>>>>> This patchset contains some improvements for the Kconfig help text check in
>>>>> scripts/checkconfig.pl:
>>>>
>>>> Seems sensible enough to me.
>>>> Signed-off-by: Joe Perches <joe@perches.com>
>>>
>>> Will you be taking this in yourself?
>>>
>>> (Adding Masahiro on CC -- forgot when I sent the patchset.)
>>>
>>> Cheers,
>>> Ulf
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> I am not a perl expert, but I have no objection for this series.
>>
>>
>> Thanks!
>>
>>
>>
>>
>> --
>> Best Regards
>> Masahiro Yamada
>
> *Bump*


Who is addressed by "*Bump*" ?



I think patches for checkpatch.pl
are supposed to be taken care of by Andrew.

He forwards patches to Linus.


$ git log --no-merges --pretty=fuller scripts/checkpatch.pl  | grep
'Commit:' | sort | uniq -c | sort -nr
    555 Commit:     Linus Torvalds <torvalds@linux-foundation.org>
     16 Commit:     Linus Torvalds <torvalds@woody.linux-foundation.org>
      4 Commit:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
      4 Commit:     Michael S. Tsirkin <mst@redhat.com>
      2 Commit:     Thomas Gleixner <tglx@linutronix.de>
      2 Commit:     Ingo Molnar <mingo@kernel.org>
      2 Commit:     Greg Kroah-Hartman <gregkh@suse.de>
      1 Commit:     Tobin C. Harding <me@tobin.cc>
      1 Commit:     Rob Herring <robh@kernel.org>
      1 Commit:     Petr Mladek <pmladek@suse.com>
      1 Commit:     Michal Marek <mmarek@suse.cz>
      1 Commit:     Mauro Carvalho Chehab <mchehab@s-opensource.com>
      1 Commit:     Masahiro Yamada <yamada.masahiro@socionext.com>
      1 Commit:     Lucas De Marchi <lucas.demarchi@profusion.mobi>
      1 Commit:     Jiri Kosina <jkosina@suse.cz>
      1 Commit:     Dan Williams <dan.j.williams@intel.com>
      1 Commit:     Bjorn Helgaas <bhelgaas@google.com>




-- 
Best Regards
Masahiro Yamada
