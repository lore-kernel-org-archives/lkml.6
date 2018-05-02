Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeEBVeq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 17:34:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeEBVeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 17:34:44 -0400
Subject: Re: linux-next: Tree for May 2 (objtool bug!)
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180502165939.2375cf6a@canb.auug.org.au>
 <fb41f3ee-705e-4886-3f78-c7f88db5276d@infradead.org>
 <20180502154319.cbi47tw2fmhxlnr4@treble>
 <5ed0305b-bca8-3b50-7d33-32c5754a81fc@infradead.org>
 <20180502210625.pehvcgtlqwqznnry@treble>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c425a9ed-3700-7019-b19c-4bdfd513892f@infradead.org>
Date: Wed, 2 May 2018 14:34:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502210625.pehvcgtlqwqznnry@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 02:06 PM, Josh Poimboeuf wrote:
> On Wed, May 02, 2018 at 08:59:38AM -0700, Randy Dunlap wrote:
>> On 05/02/2018 08:43 AM, Josh Poimboeuf wrote:
>>> On Wed, May 02, 2018 at 08:37:53AM -0700, Randy Dunlap wrote:
>>>> On 05/01/2018 11:59 PM, Stephen Rothwell wrote:
>>>>> Hi all,
>>>>>
>>>>> Changes since 20180501:
>>>>>
>>>>
>>>> on x86_64 randconfig:
>>>>
>>>>   CC      fs/cifs/smbencrypt.o
>>>> drivers/char/ipmi/ipmi_ssif.o: warning: objtool: return_hosed_msg()+0x0: infinite recursion (objtool bug!)
>>>> drivers/char/ipmi/ipmi_ssif.o: warning: objtool: deliver_recv_msg()+0x0: infinite recursion (objtool bug!)
>>>
>>> Can you share the object file (or at least the .config and GCC version)?
>>>
>>
>> gcc (SUSE Linux) 4.8.5
>>
>> config and .o file are attached.
> 
> Thanks, can you verify this fixes it?

Yes, that's all good.  Thanks.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>


-- 
~Randy
