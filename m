Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934628AbeCHBwB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:52:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51710 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCHBwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:52:00 -0500
Subject: Re: [PATCH] bloat-o-meter: fix typo in help
To: Matteo Croce <mcroce@redhat.com>, linux-kernel@vger.kernel.org
Cc: Matt Mackall <mpm@selenic.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20180214174718.4445-1-mcroce@redhat.com>
 <CAGnkfhx-1AsoaJcZ9JYrSsQgMAWjznGTWGmSPs9fEjVe3+SOLQ@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b406d029-4a2b-5396-e48b-10bdc1bc2b96@infradead.org>
Date: Wed, 7 Mar 2018 17:51:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGnkfhx-1AsoaJcZ9JYrSsQgMAWjznGTWGmSPs9fEjVe3+SOLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2018 03:39 PM, Matteo Croce wrote:
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

Acked-by: Randy Dunlap <rdunlap@infradead.org>


Andrew or Masahiro?

thanks,
-- 
~Randy
