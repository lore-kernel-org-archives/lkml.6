Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeDJVKM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 17:10:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751546AbeDJVKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 17:10:11 -0400
Subject: Re: [PATCH] memory-model: fix cheat sheet typo
To: paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
References: <1523292618-10207-1-git-send-email-pbonzini@redhat.com>
 <20180409184258.GP3948@linux.vnet.ibm.com>
 <20180410203214.GA19606@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8cbda122-6aa3-365b-fd09-52dca0644cbd@redhat.com>
Date: Tue, 10 Apr 2018 23:10:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180410203214.GA19606@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 22:32, Paul E. McKenney wrote:
> On Mon, Apr 09, 2018 at 11:42:58AM -0700, Paul E. McKenney wrote:
>> On Mon, Apr 09, 2018 at 06:50:15PM +0200, Paolo Bonzini wrote:
>>> "RWM" should be "RMW", and that's more or less the extent to which I
>>> can claim to change the document. :)  In particular, "Self" is not
>>> documented and the difference between "Self" and "SV" is not clear
>>> to me.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> Applied, though without the questions.  ;-)
>>
>> "Self" is for things like smp_load_acquire() and smp_store_release()
>> that order themselves against later and earlier accesses, respectively.
>> This ordering applies to later/earlier access to all variables, not
>> just the one that smp_load_acquire()/smp_store_release() accessed.
>> In contrast, things like smp_mb() order only other accesses, not
>> themselves.  Or at least it is impossible to proves whether or not they
>> order themselves because they are not separately visible to other CPUs.
>>
>> "SV" is "same variable", which applies to pretty much anything that
>> accesses a variable, but not to things like smp_mb() which do not.
>>
>> Does that help?
> 
> On the perhaps naive assumption that silence means assent, how about
> the following patch?

Silence meant "I tried thinking of a patch myself, and hadn't come up
yet with a fully satisfactory one"; that's some kind of assent I guess. :)

Your patch is certainly an improvement!

Thanks,

Paolo

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 818e46e8db6cacb099b8640b7f2945a3151c00ab
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Tue Apr 10 13:24:19 2018 -0700
> 
>     tools/memory-order: Improve key for SELF and SV
>     
>     The key for "SELF" was missing completely and the key for "SV" was
>     a bit obtuse.  This commit therefore adds a key for "SELF" and improves
>     the one for "SV".
>     
>     Reported-by: Paolo Bonzini <pbonzini@redhat.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
> index c0eafdaddfa4..d502993ac7d2 100644
> --- a/tools/memory-model/Documentation/cheatsheet.txt
> +++ b/tools/memory-model/Documentation/cheatsheet.txt
> @@ -26,4 +26,5 @@ Key:	C:	Ordering is cumulative
>  	DR:	Dependent read (address dependency)
>  	DW:	Dependent write (address, data, or control dependency)
>  	RMW:	Atomic read-modify-write operation
> -	SV	Same-variable access
> +	SELF:	Orders self, as opposed to accesses both before and after
> +	SV:	Orders later accesses to the same variable
> 
