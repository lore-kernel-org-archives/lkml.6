Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF5EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF4420684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF4420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438008AbeKWCfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:35:55 -0500
Received: from foss.arm.com ([217.140.101.70]:52764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732450AbeKWCfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:35:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A97741684;
        Thu, 22 Nov 2018 07:55:57 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 705ED3F575;
        Thu, 22 Nov 2018 07:55:55 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: renesas: r8a7796: Add CMT device nodes
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1540542307-63158-1-git-send-email-biju.das@bp.renesas.com>
 <1be47ef6-1a92-e032-12c1-1deae5b67960@linaro.org>
 <OSBPR01MB210312547BBCBBC9FC01A616B8D80@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <67cf2385-9379-f02a-36fd-b2e07dfd5497@linaro.org>
 <TYAPR01MB2111A4092907D265493DDF3FB8D80@TYAPR01MB2111.jpnprd01.prod.outlook.com>
 <dbc5f62d-aff0-8c6a-e957-e7dea15cc002@linaro.org>
 <OSBPR01MB21030159FAA26E6C8FE492FFB8DB0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <a82d3315-7608-3ff8-eaa1-e2a2c05c0694@linaro.org>
 <OSBPR01MB21034E0B1AE2304A9A17DE50B8DB0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <84b6bc0e-486d-e9f4-7579-0d6b513c15ba@linaro.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <814448ed-f3dd-4e71-9e78-c08d2a9b01a7@arm.com>
Date:   Thu, 22 Nov 2018 15:55:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <84b6bc0e-486d-e9f4-7579-0d6b513c15ba@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 15:30, Daniel Lezcano wrote:
> 
> Added Marc Zyngier in Cc.

Thanks for looping me in.

> 
> On 22/11/2018 16:16, Biju Das wrote:
>> Hello Daniel,
>>
>> Thanks for the feedback.
>>
>>>>> Subject: Re: [PATCH] arm64: dts: renesas: r8a7796: Add CMT device
>>>>> nodes
>>>>>
>>>>> On 19/11/2018 16:50, Biju Das wrote:
>>>>>> Hi Daniel,
>>>>>>
>>>>>> Thanks for the feedback.
>>>>>>
>>>>>>>>> Subject: Re: [PATCH] arm64: dts: renesas: r8a7796: Add CMT device
>>>>>>>>> nodes
>>>>>>>>>
>>>>>>>>> On 26/10/2018 10:25, Biju Das wrote:
>>>>>>>>>> This patch adds CMT{0|1|2|3} device nodes for r8a7796 SoC.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
>>>>>>>>>> ---
>>>>>>>>>> This patch is tested against renesas-dev
>>>>>>>>>>
>>>>>>>>>> I have executed on inconsistency-check, nanosleep and
>>>>>>>>>> clocksource_switch selftests on this arm64 SoC. The
>>>>>>>>>> inconsistency-check and nanosleep tests are working fine.The
>>>>>>>>>> clocksource_switch asynchronous test is failing due to
>>>>>>>>>> inconsistency-check
>>>>>>>>> failure on "arch_sys_counter".
>>>>>>>>>>
>>>>>>>>>> But if i skip the clocksource_switching of "arch_sys_counter",
>>>>>>>>>> the asynchronous test is passing for CMT0/1/2/3 timer.
>>>>>>>>>>
>>>>>>>>>> Has any one noticed this issue?
>>>>>>>>>
>>>>>>>>> So now that you mention that, I've been through the
>>>>>>>>> clocksource_switch on another ARM64 platform (hikey960) and
>>>>>>>>> disabled the
>>>>>>>>> ARM64_ERRATUM_858921 config option. I can see the same issue.
>>>>>>>>>
>>>>>>>>> Is this option set on your config ?
>>>>>>>>
>>>>>>>> No.  As per  " config ARM64_ERRATUM_858921", it is "Workaround for
>>>>>>> Cortex-A73 erratum 858921"
>>>>>>>>
>>>>>>>> Our SoC is 2xCA-57 + 4 x CA-53.  Does  it impact CA-57 + CA_53?

Erratum 858921 is strictly an A73 thing, and neither A57 nor A53 suffer
from this issue. If you're seeing something that looks similar, that's
probably because the integration of the global counter is less than
perfect (insert massive understatement here), similar to the way it is
broken with FSL's A008585 erratum.

>>>>>>>
>>>>>>> Dunno :/
>>>>>>>
>>>>>>>> Any way I will enable this config option and will provide you the
>>> results.
>>>>>>>
>>>>>>> Ok, thanks!
>>>>>>
>>>>>> The following config is enabled by default on upstream
>>>>>> kernel(4.20-rc3) CONFIG_ARM_ARCH_TIMER_EVTSTREAM=y
>>>>>> CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND=y
>>>>>> CONFIG_FSL_ERRATUM_A008585=y
>>>>>> CONFIG_HISILICON_ERRATUM_161010101=y
>>>>>> CONFIG_ARM64_ERRATUM_858921=y
>>>>>>
>>>>>> For a quick testing,  I have activated the erratum using the
>>>>>> property
>>>>> "fsl,erratum-a008585" on device tree.
>>>>>> With this I confirm the issue is fixed.
>>>>>>
>>>>>> I have  some questions on this.
>>>>>> 1) Based  on the test result ,do you think renesas soc also
>>>>>> impacted by the
>>>>> ARM64_ERRATUM_858921?
>>>>>> 2) Is there any way to find, is this Erratum actually causing the
>>>>> asynchronous test to fail?
>>>>>
>>>>> I guess, you can hack the __fsl_a008585_read_reg macro and check if
>>>>> the invalid condition is reached.
>>>>>
>>>>> This thread https://lkml.org/lkml/2018/5/10/773 will give you all the
>>>>> answers you are looking for (well very likely).
>>>>>
>>>>> Let me know if it helped.
>>>>
>>>> In our case , Delta: 174760 ns
>>>>
>>>> 1530553351:205762284
>>>> 1530553351:205762404
>>>> --------------------
>>>> 1530553351:205951226
>>>> 1530553351:205776466
>>>> --------------------
>>>>
>>>> I have tried the workaround for ARM64_ERRATUM_858921, that also fixes
>>> the issue.
>>>>
>>>> But all the workaround disables ARM64 VDSO. How do we conclude that is
>>> it VDSO issue or ARM64_ERRATUM issue?

The VDSO is just a userspace proxy for the counter, and nothing else. If
the counter is broken, we have no choice but to disable the VDSO and get
everyone on the slow path.

>>>
>>> May be disable all errata and set vdso_default to false?
>>>
>>> [ ... ]
>>>
>>> -static bool vdso_default = true;
>>> +static bool vdso_default = false;
>>>
>>> [ ... ]
>>
>> I have disabled the  activation of errata from device tree and set vdso_default=false.
>> With this also it works fine. So looks like arm64 vdso is the issue in our case.

That doesn't make much sense, as all it means is that you take an extra
trap to access the exact same data.

>>
>> Do you agree with the conclusion?
> 
> I agree we have an element to investigate the issue. That is very
> specific to this timer and a good knowledge of the internals is required.
> 
> Certainly Marc Zyngier or Mark Rutland can help here.
> 
>> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
>> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>> [    0.000000] arch_timer: cp15 timer(s) running at 8.32MHz (virt).
>> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x1eb398c07, max_idle_ns: 440795202503 ns
>> [    0.000004] sched_clock: 56 bits at 8MHz, resolution 120ns, wraps every 2199023255503ns

Now that is a bit more interesting: How is this kernel booted? The fact
that is uses the virtual timer and not the physical one makes me think
that it is booted at EL1 instead of EL2. The £100 question is whether
CNTVOFF_EL2 is consistently set to the same value across CPUs.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
