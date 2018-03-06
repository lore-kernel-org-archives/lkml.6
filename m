Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754059AbeCFR01 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:26:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753962AbeCFRYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:24:18 -0500
Subject: Re: Re[v2]: Use of GCC plugin instead ISO C
To: Progyan Bhattacharya <bprogyan@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1518941218.12663.1.camel@gmail.com>
 <7bd655df-39a1-2098-0d1c-256c0900b7ed@infradead.org>
 <1519310261.20003.1.camel@acm.org> <1519890640.7987.0.camel@acm.org>
 <5b4d0708-c375-02b0-9014-9400992addf8@infradead.org>
 <1520342938.6596.1.camel@acm.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d3ce60f9-7838-a98b-c807-fa0603544f9d@infradead.org>
Date: Tue, 6 Mar 2018 09:24:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520342938.6596.1.camel@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2018 05:28 AM, Progyan Bhattacharya wrote:
> On Thu, 2018-03-01 at 13:42 -0800, Randy Dunlap wrote:
>> If you would build with V=1 and capture all of the output (lots of
>> it!) to a file,
>> you could search it for "pedantic" to see where/why it is used.
>>
>> I have no idea about the permission problem that you quoted above.
> 
> Sorry for the misunderstanding!
> Here is the full build log for
> 
>     make V=1
> 

Thanks. I don't see a problem there except for the final line.

First, please make sure that this file does not already exist before starting
a build:  /home/progyan/Programs/Linux/tools/objtool/.objtool-in.o.cmd


Then I will look at this more if you will send me your kernel .config file and
the exact command(s) that you use to run the build.

thanks,
-- 
~Randy
