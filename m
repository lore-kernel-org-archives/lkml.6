Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeEPQpC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 12:45:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:33872 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750772AbeEPQpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 12:45:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,406,1520924400";
   d="scan'208";a="41458079"
Subject: Re: [PATCH 03/15] x86/split_lock: Handle #AC exception for split lock
 in kernel mode
To: Fenghua Yu <fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
 <1526323945-211107-4-git-send-email-fenghua.yu@intel.com>
 <03909bf6-2dc5-f5e4-d6bc-a4ebaf20709d@intel.com>
 <20180515172115.GB244301@romley-ivt3.sc.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Alan Cox <alan@linux.intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <9a64587d-7b04-7445-9434-4e39ff66ceb9@intel.com>
Date: Wed, 16 May 2018 09:44:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515172115.GB244301@romley-ivt3.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 10:21 AM, Fenghua Yu wrote:
> On Tue, May 15, 2018 at 08:51:24AM -0700, Dave Hansen wrote:
>> On 05/14/2018 11:52 AM, Fenghua Yu wrote:
>>> +#define	delay_ms	1
>>
>> That seems like a dangerously-generic name that should not be a #define
>> anyway.
> 
> Sure. I will change it to
> #define split_lock_delay_ms	1

Why not:

static unsigned int reenable_split_lock_delay_ms = 1;

?

>>> +/* Will the faulting instruction be re-executed? */
>>> +static bool re_execute(struct pt_regs *regs)
>>> +{
>>> +	/*
>>> +	 * The only reason for generating #AC from kernel is because of
>>> +	 * split lock. The kernel faulting instruction will be re-executed.
>>> +	 */
>>> +	if (!user_mode(regs))
>>> +		return true;
>>> +
>>> +	return false;
>>> +}
>>
>> This helper with a single user is a bit unnecessary.  Just open-code
>> this and move the comments into the caller.
> 
> In this patch, this helper is only used for checking kernel mode.
> Then in patch #11, this helper will add checking user mode code.
> It would be better to have a helper defined and called.

Then introduce the helper later, or call this out in a comment or the
patch description, please.

>>> +/*
>>> + * #AC handler for kernel split lock is called by generic #AC handler.
>>> + *
>>> + * Disable #AC for split lock on this CPU so that the faulting instruction
>>> + * gets executed. The #AC for split lock is re-enabled later.
>>> + */
>>> +bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
>>> +{
>>> +	unsigned long delay = msecs_to_jiffies(delay_ms);
>>> +	unsigned long address = read_cr2(); /* Get the faulting address */
>>> +	int this_cpu = smp_processor_id();
>>
>> How does this end up working?  This seems to depend on this handler not
>> getting preempted.
> 
> Maybe change the handler to:
> 
> this_cpu = task_cpu(current);
> Then disable split lock on this_cpu.
> Re-enable split lock on this_cpu (already in this way).
> 
> Does this sound better?

Actually, as I look at it, interrupts *are* still disabled here, so you
are OK.  But, you can do a local_irq_enable() once you get all of the
per-cpu state settled and go to start handling the fault if you are
going to do anything that takes an appreciable amount of time.

>>> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
>>> index 03f3d7695dac..c07b817bbbe9 100644
>>> --- a/arch/x86/kernel/traps.c
>>> +++ b/arch/x86/kernel/traps.c
>>> @@ -61,6 +61,7 @@
>>>  #include <asm/mpx.h>
>>>  #include <asm/vm86.h>
>>>  #include <asm/umip.h>
>>> +#include <asm/cpu.h>
>>>  
>>>  #ifdef CONFIG_X86_64
>>>  #include <asm/x86_init.h>
>>> @@ -286,10 +287,21 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
>>>  			  unsigned long trapnr, int signr)
>>>  {
>>>  	siginfo_t info;
>>> +	int ret;
>>>  
>>>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
>>>  
>>>  	/*
>>> +	 * #AC exception could be handled by split lock handler.
>>> +	 * If the handler can't handle the exception, go to generic #AC handler.
>>> +	 */
>>> +	if (trapnr == X86_TRAP_AC) {
>>> +		ret = do_split_lock_exception(regs, error_code);
>>> +		if (ret)
>>> +			return;
>>> +	}
>>
>> Why are you hooking into do_error_trap()?  Shouldn't you just be
>> installing do_split_lock_exception() as *the* #AC handler and put it in
>> the IDT?
> 
> Split lock is not the only reason that causes #AC. #AC can be caused
> by user turning on AC bit in EFLAGS, which is just cache line misalignment
> and is different from split lock.
> 
> So split lock is sharing the handler with another #AC case and can't
> be installed seperately from previous #AC handler, right?

There are lots of exceptions that use do_error_trap().  I'm suggesting
that you make an IDT entry for X86_TRAP_AC that does not use
do_error_trap() since you need something different in there now.

See:

> #define DO_ERROR(trapnr, signr, str, name)                              \
> dotraplinkage void do_##name(struct pt_regs *regs, long error_code)     \
> {                                                                       \
>         do_error_trap(regs, error_code, str, trapnr, signr);            \
> }
> 
> DO_ERROR(X86_TRAP_DE,     SIGFPE,  "divide error",              divide_error)
> DO_ERROR(X86_TRAP_OF,     SIGSEGV, "overflow",                  overflow)
> DO_ERROR(X86_TRAP_UD,     SIGILL,  "invalid opcode",            invalid_op)
> DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,  "coprocessor segment overrun",coprocessor_segment_overrun)
> DO_ERROR(X86_TRAP_TS,     SIGSEGV, "invalid TSS",               invalid_TSS)
> DO_ERROR(X86_TRAP_NP,     SIGBUS,  "segment not present",       segment_not_present)
> DO_ERROR(X86_TRAP_SS,     SIGBUS,  "stack segment",             stack_segment)
> DO_ERROR(X86_TRAP_AC,     SIGBUS,  "alignment check",           alignment_check)

Look at do_general_protection(), for instance.
