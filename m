Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162161AbeCAVmV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:42:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161761AbeCAVmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:42:20 -0500
Subject: Re: Re[v2]: Use of GCC plugin instead ISO C
To: Progyan Bhattacharya <bprogyan@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1518941218.12663.1.camel@gmail.com>
 <7bd655df-39a1-2098-0d1c-256c0900b7ed@infradead.org>
 <1519310261.20003.1.camel@acm.org> <1519890640.7987.0.camel@acm.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5b4d0708-c375-02b0-9014-9400992addf8@infradead.org>
Date: Thu, 1 Mar 2018 13:42:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519890640.7987.0.camel@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 11:50 PM, Progyan Bhattacharya wrote:
> On Thu, 2018-02-22 at 20:07 +0530, Progyan Bhattacharya wrote:
>> On Sun, 2018-02-18 at 08:47 -0800, Randy Dunlap wrote:
>>> You could try (re)building with V=1 on the "make" command line and
>>> capture
>>> the output to see where the "pedantic" is coming from.
>>
>> This is a late reply.
>> I did what you told me and the build failed at following point:
>>
>> 	/bin/sh: /home/progyan/Programs/Linux/tools/objtool/.objtool-
>> in.o.cmd: Permission denied
>>
>> I am not sure what permission it wants or what to make of it.
>>
>> Thanks in advance.

Is that a question?

I don't get or see that message.

What distro are you using? Maybe it adds some build options?

If you would build with V=1 and capture all of the output (lots of it!) to a file,
you could search it for "pedantic" to see where/why it is used.

I have no idea about the permission problem that you quoted above.

-- 
~Randy
