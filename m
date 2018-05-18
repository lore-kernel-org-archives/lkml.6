Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeERJtW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:49:22 -0400
Received: from foss.arm.com ([217.140.101.70]:46422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752136AbeERJtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:49:20 -0400
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
To: Stefan Wahren <stefan.wahren@i2se.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Cc: Ingo Molnar <mingo@redhat.com>, linux-rpi-kernel@lists.infradead.org,
        Eric Anholt <eric@anholt.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180517131727.29263-1-eric@anholt.net>
 <1412187220.62585.1526572780332@email.1und1.de>
 <alpine.DEB.2.21.1805171233500.7984@macbook-air>
 <307323036.63872.1526576126537@email.1und1.de>
 <20180517180758.GK12198@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1805171422450.8529@macbook-air>
 <alpine.DEB.2.21.1805171530080.8529@macbook-air>
 <0a643984-1586-8c56-6627-430f0c2a4ba8@gmail.com>
 <d6b6f632-2051-a239-3e44-4750f2ac89d5@arm.com>
 <1863838560.56771.1526636258081@email.1und1.de>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <6097533d-5c77-0bba-a974-53ff65663dd3@arm.com>
Date: Fri, 18 May 2018 10:49:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1863838560.56771.1526636258081@email.1und1.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/18 10:37, Stefan Wahren wrote:
> Hi Marc,
> 
>> Marc Zyngier <marc.zyngier@arm.com> hat am 18. Mai 2018 um 10:07 geschrieben:
>>
>> I have a pretty simple series[1] which I used to profile 32bit guests on
>> an arm64 KVM host. Nobody really cared about it because running a 32bit
>> kernel on 64bit HW is a bit odd, to say the least, and I'm probably the
>> only one actually running 32bit VMs.
>>
>>> FWIW, Broadcom STB chips, even when 64-bit capable or often used with an
>>> 32-bit ARM kernel, so having the ARMv8 PMUs work under a 32-bit ARM
>>> kernel would be great. The downstream solution we have sued thus far is
>>> to find the closest compatible string to represent those, which is not
>>> great...
>> Ah, so you're *really* doing that? I'm not going to ask why, I'm scared
>> of the answer... ;-)
>>
>> Anyway, I can repost that series if that will prevent people from having
>> that kind of silly hacks.
> 
> yes please. But there is a minor nit: some patches introduce new files without SPDX tags.
I'm shocked! ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
