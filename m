Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeBEHFD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 02:05:03 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:19287 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeBEHEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 02:04:55 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w1574dLq027218
X-Nifty-SrcIP: [209.85.217.182]
X-Google-Smtp-Source: AH8x227dd/ng4rL08/xiIHAe49zI5zDsTDSGiiiok3+pTzXrQAoB8bH9mg6CGjjixBKxDLhFo4l2wqI5aO6eeECSOl4=
MIME-Version: 1.0
In-Reply-To: <1517812899.3118.372.camel@oracle.com>
References: <cover.a7e2d48abd08947a9bb46ef5d18a8f33066cc40d.1516356501.git-series.knut.omang@oracle.com>
 <c271ba8f99393585d69db71f40db3c01c44769e4.1516356501.git-series.knut.omang@oracle.com>
 <1517812899.3118.372.camel@oracle.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 5 Feb 2018 16:03:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8QG947WpFn6bCnNVLj=x7jbAyLKVRS429wP+1jYbOUA@mail.gmail.com>
Message-ID: <CAK7LNAS8QG947WpFn6bCnNVLj=x7jbAyLKVRS429wP+1jYbOUA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] runchecks: Generalize make C={1,2} to support
 multiple checkers
To: Knut Omang <knut.omang@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        =?UTF-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Tom Saeger <tom.saeger@oracle.com>,
        Michal Marek <michal.lkml@markovi.net>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        John Haxby <john.haxby@oracle.com>,
        =?UTF-8?B?w4VzbXVuZCDDmHN0dm9sZA==?= <asmund.ostvold@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        cocci@systeme.lip6.fr, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-05 15:41 GMT+09:00 Knut Omang <knut.omang@oracle.com>:
> On Fri, 2018-01-19 at 11:14 +0100, Knut Omang wrote:
>> Add scripts/runchecks which has generic support for running
>> checker tools in a convenient and user friendly way that
>> the author hopes can contribute to rein in issues detected
>> by these tools in a manageable and convenient way.
>>
>> scripts/runchecks provides the following basic functionality:
>>
>> * Makes it possible to selectively suppress output from individual
>>   checks on a per file or per subsystem basis.
>> * Unifies output and suppression input from different tools
>>   by providing a single unified syntax and presentation for the
>>   underlying tools in the style of "scripts/checkpatch.pl --show-types".
>> * Allows selective run of one, or more (or all) configured tools
>>   for each file.
>>
>> In the Makefile system, the sparse specific setup has been replaced
>> by setup for runchecks.
>
> Hi all,
>
> - Anything more I can/need to do to bring this forward?
> - Any quiet concerns?
>
> I realize it is a subsystem crossing change,

Is it?  Only Kbuild this is related to.


> and a lot going on elsewhere,
> nevertheless I believe this is a time saver in the slightly longer run,
> as it allows automation of checking, even without a "perfect"
> code base to begin with.
>

Sorry for the delay.

I have not been able to find time to dive into the detail yet.
(Actually, I tried to do that for v2 or v3, where Python code was so dirty,
then consumed my time to figure out what the code was trying to do)


I find my concern here:
https://lkml.org/lkml/2018/1/5/497


Anyway, I will take a look again when I find some time.
You do not need to take care of the detail until I request to do so.



-- 
Best Regards
Masahiro Yamada
