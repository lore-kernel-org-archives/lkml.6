Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756072AbeCHQNJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:13:09 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:33059 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756024AbeCHQNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:13:07 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w28GClB7028746
X-Nifty-SrcIP: [209.85.217.169]
X-Google-Smtp-Source: AG47ELvaYk8Y5uOU2Dj2fLhq08/LLvyH/p23Zs4fKOWOC8+AeSyvfOadvVLG7uBc1ypVwwaVZvZcFeaMI7BIpAxt95k=
MIME-Version: 1.0
In-Reply-To: <CAGnkfhx-1AsoaJcZ9JYrSsQgMAWjznGTWGmSPs9fEjVe3+SOLQ@mail.gmail.com>
References: <20180214174718.4445-1-mcroce@redhat.com> <CAGnkfhx-1AsoaJcZ9JYrSsQgMAWjznGTWGmSPs9fEjVe3+SOLQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 9 Mar 2018 01:12:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQx2QOGTDD+ptYjCcq+xWj8tJM6nEpedOQUR_ner4PwCA@mail.gmail.com>
Message-ID: <CAK7LNAQx2QOGTDD+ptYjCcq+xWj8tJM6nEpedOQUR_ner4PwCA@mail.gmail.com>
Subject: Re: [PATCH] bloat-o-meter: fix typo in help
To: Matteo Croce <mcroce@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Maninder Singh <maninder1.s@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-08 8:39 GMT+09:00 Matteo Croce <mcroce@redhat.com>:
> On Wed, Feb 14, 2018 at 6:47 PM, Matteo Croce <mcroce@redhat.com> wrote:
>> the bloat-o-meter script has two typos in the help, fix both.
>>
>> Fixes: 192efb7a1f9b ("bloat-o-meter: provide 3 different arguments for data, function and All")
>> Signed-off-by: Matteo Croce <mcroce@redhat.com>
>> ---
>>  scripts/bloat-o-meter | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
>> index 94b664817ad9..d84a5674e95e 100755
>> --- a/scripts/bloat-o-meter
>> +++ b/scripts/bloat-o-meter
>> @@ -15,7 +15,7 @@ signal(SIGPIPE, SIG_DFL)
>>  if len(sys.argv) < 3:
>>      sys.stderr.write("usage: %s [option] file1 file2\n" % sys.argv[0])
>>      sys.stderr.write("The options are:\n")
>> -    sys.stderr.write("-c       cateogrize output based on symbole type\n")
>> +    sys.stderr.write("-c       categorize output based on symbol type\n")
>>      sys.stderr.write("-d       Show delta of Data Section\n")
>>      sys.stderr.write("-t       Show delta of text Section\n")
>>      sys.exit(-1)
>> --
>> 2.14.3
>>
>
> Ping, anyone willing to review and eventually merge it?
>
> Regards,
> --
> Matteo Croce
> per aspera ad upstream

Applied to linux-kbuild/fixes.  Thanks!


-- 
Best Regards
Masahiro Yamada
