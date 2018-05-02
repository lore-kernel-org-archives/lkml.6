Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeEBOV1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:21:27 -0400
Received: from www62.your-server.de ([213.133.104.62]:53323 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeEBOVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:21:21 -0400
Subject: Re: arch/x86/net/bpf_jit_comp conflicts. was: [tip:x86/cleanups]
 x86/bpf: Clean up non-standard comments, to make the code more readable
To: Alexei Starovoitov <ast@fb.com>, peterz@infradead.org,
        edumazet@google.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, bp@alien8.de, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de,
        linux-tip-commits@vger.kernel.org, netdev@vger.kernel.org
References: <tip-5f26c50143f58f256535bee8d93a105f36d4d2da@git.kernel.org>
 <44202670-ed43-366b-caf2-f72863ee7c6a@iogearbox.net>
 <7741d4cc-2d1d-9831-e0ce-38afdd41f0a1@fb.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7b7cf2b1-d27f-ecce-4258-a7b4b5d8d7f4@iogearbox.net>
Date: Wed, 2 May 2018 16:21:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <7741d4cc-2d1d-9831-e0ce-38afdd41f0a1@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28/2018 12:16 AM, Alexei Starovoitov wrote:
> On 4/27/18 5:13 AM, Daniel Borkmann wrote:
>> On 04/27/2018 01:00 PM, tip-bot for Ingo Molnar wrote:
>>> Commit-ID:  5f26c50143f58f256535bee8d93a105f36d4d2da
>>> Gitweb:     https://git.kernel.org/tip/5f26c50143f58f256535bee8d93a105f36d4d2da
>>> Author:     Ingo Molnar <mingo@kernel.org>
>>> AuthorDate: Fri, 27 Apr 2018 11:54:40 +0200
>>> Committer:  Ingo Molnar <mingo@kernel.org>
>>> CommitDate: Fri, 27 Apr 2018 12:42:04 +0200
>>>
>>> x86/bpf: Clean up non-standard comments, to make the code more readable
>>>
>>> So by chance I looked into x86 assembly in arch/x86/net/bpf_jit_comp.c and
>>> noticed the weird and inconsistent comment style it mistakenly learned from
>>> the networking code:
>>>
>>>  /* Multi-line comment ...
>>>   * ... looks like this.
>>>   */
>>>
[...]
>>> No change in functionality.
>>
>> Thanks for the cleanup, looks fine to me!
> 
> same here. thanks for the cleanup!
> 
>>> ( In case this commit causes conflicts with pending development code
>>>   I'll be glad to help resolve any conflicts! )
>>
>> Any objections if we would simply route this via bpf-next tree, otherwise
>> this will indeed cause really ugly merge conflicts throughout the JIT with
>> pending work.

Since no one hollered I've cherry picked this into bpf-next tree so that
upcoming BPF work can be rebased on top of this, thanks Ingo!

> right. would be much better to route this patch via bpf-next.
> Though all the changes are cleanups in comments I'm pretty sure
> they will conflict with other changes we're doing.
> 
> Ingo,
> could you please drop this patch from tip tree and resend it to us?
> I cannot find the original patch in any public mailing list.
> Only in tip-bot notification.
> 
> Personally I don't care whether bpf jit code uses networking
> or non-networking style of comments, but will be happy to enforce
> non-networking for this file in the future, since that seems to be the
> preference.
> 
> Thanks
