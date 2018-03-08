Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934828AbeCHE1j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 23:27:39 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:58812 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933575AbeCHE1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 23:27:37 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w284RYAH026042
X-Nifty-SrcIP: [209.85.213.49]
X-Google-Smtp-Source: AG47ELv9bpXjBnbkJCnZ5qhZSu+1q2WYejEBykApqRiSxjvN9khB3g4AfyUbqCdYMX+Mr1xmg0hjjmVP1rwUBEyRlHI=
MIME-Version: 1.0
In-Reply-To: <b406d029-4a2b-5396-e48b-10bdc1bc2b96@infradead.org>
References: <20180214174718.4445-1-mcroce@redhat.com> <CAGnkfhx-1AsoaJcZ9JYrSsQgMAWjznGTWGmSPs9fEjVe3+SOLQ@mail.gmail.com>
 <b406d029-4a2b-5396-e48b-10bdc1bc2b96@infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 8 Mar 2018 13:26:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNATxeTsnPb3p4JLbanOx4uwv=gz7zQJ6dMDkqyu4mx8vZQ@mail.gmail.com>
Message-ID: <CAK7LNATxeTsnPb3p4JLbanOx4uwv=gz7zQJ6dMDkqyu4mx8vZQ@mail.gmail.com>
Subject: Re: [PATCH] bloat-o-meter: fix typo in help
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Matteo Croce <mcroce@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-08 10:51 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 03/07/2018 03:39 PM, Matteo Croce wrote:
>> On Wed, Feb 14, 2018 at 6:47 PM, Matteo Croce <mcroce@redhat.com> wrote:
>>> the bloat-o-meter script has two typos in the help, fix both.
>>>
>>> Fixes: 192efb7a1f9b ("bloat-o-meter: provide 3 different arguments for data, function and All")
>>> Signed-off-by: Matteo Croce <mcroce@redhat.com>
>>> ---
>>>  scripts/bloat-o-meter | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
>>> index 94b664817ad9..d84a5674e95e 100755
>>> --- a/scripts/bloat-o-meter
>>> +++ b/scripts/bloat-o-meter
>>> @@ -15,7 +15,7 @@ signal(SIGPIPE, SIG_DFL)
>>>  if len(sys.argv) < 3:
>>>      sys.stderr.write("usage: %s [option] file1 file2\n" % sys.argv[0])
>>>      sys.stderr.write("The options are:\n")
>>> -    sys.stderr.write("-c       cateogrize output based on symbole type\n")
>>> +    sys.stderr.write("-c       categorize output based on symbol type\n")
>>>      sys.stderr.write("-d       Show delta of Data Section\n")
>>>      sys.stderr.write("-t       Show delta of text Section\n")
>>>      sys.exit(-1)
>>> --
>>> 2.14.3
>>>
>>
>> Ping, anyone willing to review and eventually merge it?
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
>
> Andrew or Masahiro?
>
> thanks,
> --
> ~Randy

I will pick up this shortly.  Thanks!



-- 
Best Regards
Masahiro Yamada
