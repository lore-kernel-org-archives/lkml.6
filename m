Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeDRScI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:32:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57576 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752645AbeDRScG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:32:06 -0400
Subject: Re: [PATCH v2] docs: kernel-parameters.txt: Fix whitespace
To: Thymo van Beers <thymovanbeers@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180416214939.GA11304@thinkpad>
 <31612fbd-6624-140a-ed92-04b8f0bd5f64@infradead.org>
 <20180418181635.GA24031@thinkpad>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f1c6c111-c9bb-e3d0-f76f-15705c96ac0f@infradead.org>
Date: Wed, 18 Apr 2018 11:32:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418181635.GA24031@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/18 11:16, Thymo van Beers wrote:
> On Mon, Apr 16, 2018 at 03:03:47PM -0700, Randy Dunlap wrote:
>> On 04/16/18 14:49, Thymo van Beers wrote:
>>> Some lines used spaces instead of tabs at line start.
>>> This can cause mangled lines in editors due to inconsistency.
>>>
>>> Replace spaces for tabs where appropriate.
>>>
>>> Signed-off-by: Thymo van Beers <thymovanbeers@gmail.com>
>>> ---
>>> Changes in v2:
>>>   - Rebase against docs-next
>>>   - Fix indentation modifications
>>>
>>>  Documentation/admin-guide/kernel-parameters.txt | 136 ++++++++++++------------
>>>  1 file changed, 68 insertions(+), 68 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 3487be79847c..f625f65c286f 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>
>> Most of the patch is OK IMO, but not the intel_pstate part:
>> The 2-space extra indents work fine here, while the extra tab makes a lot of the
>> lines go beyond the 80-column mark.
>>
>>> @@ -1650,39 +1650,39 @@
>>>  			0	disables intel_idle and fall back on acpi_idle.
>>>  			1 to 9	specify maximum depth of C-state.
>>>  
>>> -	intel_pstate=  [X86]
>>> -		       disable
>>> -		         Do not enable intel_pstate as the default
>>> -		         scaling driver for the supported processors
>>> -		       passive
>>> -			 Use intel_pstate as a scaling driver, but configure it
>>> -			 to work with generic cpufreq governors (instead of
>>> -			 enabling its internal governor).  This mode cannot be
>>> -			 used along with the hardware-managed P-states (HWP)
>>> -			 feature.
>>> -		       force
>>> -			 Enable intel_pstate on systems that prohibit it by default
>>> -			 in favor of acpi-cpufreq. Forcing the intel_pstate driver
>>> -			 instead of acpi-cpufreq may disable platform features, such
>>> -			 as thermal controls and power capping, that rely on ACPI
>>> -			 P-States information being indicated to OSPM and therefore
>>> -			 should be used with caution. This option does not work with
>>> -			 processors that aren't supported by the intel_pstate driver
>>> -			 or on platforms that use pcc-cpufreq instead of acpi-cpufreq.
>>> -		       no_hwp
>>> -		         Do not enable hardware P state control (HWP)
>>> -			 if available.
>>> -		hwp_only
>>> -			Only load intel_pstate on systems which support
>>> -			hardware P state control (HWP) if available.
>>> -		support_acpi_ppc
>>> -			Enforce ACPI _PPC performance limits. If the Fixed ACPI
>>> -			Description Table, specifies preferred power management
>>> -			profile as "Enterprise Server" or "Performance Server",
>>> -			then this feature is turned on by default.
>>> -		per_cpu_perf_limits
>>> -			Allow per-logical-CPU P-State performance control limits using
>>> -			cpufreq sysfs interface
>>> +	intel_pstate=	[X86]
>>> +			disable
>>> +				Do not enable intel_pstate as the default
>>> +				scaling driver for the supported processors
>>> +			passive
>>> +				Use intel_pstate as a scaling driver, but configure it
>>> +				to work with generic cpufreq governors (instead of
>>> +				enabling its internal governor).  This mode cannot be
>>> +				used along with the hardware-managed P-states (HWP)
>>> +				feature.
>>> +			force
>>> +				Enable intel_pstate on systems that prohibit it by default
>>> +				in favor of acpi-cpufreq. Forcing the intel_pstate driver
>>> +				instead of acpi-cpufreq may disable platform features, such
>>> +				as thermal controls and power capping, that rely on ACPI
>>> +				P-States information being indicated to OSPM and therefore
>>> +				should be used with caution. This option does not work with
>>> +				processors that aren't supported by the intel_pstate driver
>>> +				or on platforms that use pcc-cpufreq instead of acpi-cpufreq.
>>> +			no_hwp
>>> +				Do not enable hardware P state control (HWP)
>>> +				if available.
>>> +			hwp_only
>>> +				Only load intel_pstate on systems which support
>>> +				hardware P state control (HWP) if available.
>>> +			support_acpi_ppc
>>> +				Enforce ACPI _PPC performance limits. If the Fixed ACPI
>>> +				Description Table, specifies preferred power management
>>> +				profile as "Enterprise Server" or "Performance Server",
>>> +				then this feature is turned on by default.
>>> +			per_cpu_perf_limits
>>> +				Allow per-logical-CPU P-State performance control limits using
>>> +				cpufreq sysfs interface
>>>  
>>>  	intremap=	[X86-64, Intel-IOMMU]
>>>  			on	enable Interrupt Remapping (default)
>>> @@ -2027,7 +2027,7 @@
>>>  			* [no]ncqtrim: Turn off queued DSM TRIM.
>>>  
>>>  			* nohrst, nosrst, norst: suppress hard, soft
>>> -                          and both resets.
>>> +			and both resets.
>>
>> I would leave that line above indented like the one after "rstonce" below.
>>
>>>  
>>>  			* rstonce: only attempt one reset during
>>>  			  hot-unplug link recovery
>>
>>
>> -- 
>> ~Randy
> 
> Okay, thanks for your feedback.
> 
> I reindented intel_pstate as you said and I can still see the whole
> description for the 'advanced' option is going past the 80-column mark.
> 
> I'll leave it indented with two spaces for this patch.
> If you wish I can make a separate patch that addresses 80-column overrun
> for intel_pstate.
> 
> I'll indent the nohrst,... section like rstonce.
> 
> Does that sound good to you?

Yes, it does.  Go for it!

thanks,
-- 
~Randy
