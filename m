Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD96FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86954218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NHU5D041"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfAYMB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:01:57 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9261 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYMB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:01:57 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4afa990000>; Fri, 25 Jan 2019 04:01:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 04:01:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 04:01:55 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 12:01:53 +0000
Subject: Re: [PATCH 1/6] dt-bindings: timer: add Tegra210 timer
To:     Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-2-josephl@nvidia.com>
 <a5fec080-d388-5362-7f44-b50f7d7e1adf@nvidia.com>
 <285bd3f7-e1c0-0767-6381-4b1d748bd6db@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <381f94c0-6c19-0f5b-df06-91353455a4c0@nvidia.com>
Date:   Fri, 25 Jan 2019 12:01:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <285bd3f7-e1c0-0767-6381-4b1d748bd6db@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548417690; bh=t07DzrGW7WngQL4dRC+GUQ+u3s6LC+S0x/oywjBdt2g=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NHU5D041YOkVhripbHyYQHmRGwKz5SuiIbN8KbI3l2EmeQr/GAfSNcDMZu4q+vknw
         GeheiRCiAs1XzsIDLa1zKkAYSI+7cP/K4siFG6IFN2x30c4jf4yuJ8HsqSmAfwCfEf
         lR2/6cVXXtO9KIkxvA1V7nYma90vw6hADx2fDmQBfxiLof/VOqQxu/9B2qXodJrYRR
         HyBXHuK2q1UJQkOpmtovxB9rxPsnO/WIpZMu0HngjY/3xAxAyx/Oc4+03rKilPI0Qb
         MYLyr/KHbiF1ASIFHeS11LrJZS3Dr1bQM0Y9eiUQASPoP7k0IKFxaGTUfRZssqmAfM
         N04l/6KPZLURA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/01/2019 03:23, Joseph Lo wrote:
> Hi Jon,
>=20
> Thanks for reviewing.
>=20
> On 1/24/19 6:30 PM, Jon Hunter wrote:
>>
>> On 07/01/2019 03:28, Joseph Lo wrote:
>>> The Tegra210 timer provides fourteen 29-bit timer counters and one
>>> 32-bit
>>> timestamp counter. The TMRs run at either a fixed 1 MHz clock rate
>>> derived
>>> from the oscillator clock (TMR0-TMR9) or directly at the oscillator
>>> clock
>>> (TMR10-TMR13). Each TMR can be programmed to generate one-shot periodic=
,
>>> or watchdog interrupts.
>>>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: devicetree@vger.kernel.org
>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>> ---
>>> =C2=A0 .../bindings/timer/nvidia,tegra210-timer.txt=C2=A0 | 25 ++++++++=
+++++++++++
>>> =C2=A0 1 file changed, 25 insertions(+)
>>> =C2=A0 create mode 100644
>>> Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
>>> b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
>>> new file mode 100644
>>> index 000000000000..ba511220a669
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
>>> @@ -0,0 +1,25 @@
>>> +NVIDIA Tegra210 timer
>>> +
>>> +The Tegra210 timer provides fourteen 29-bit timer counters and one
>>> 32-bit
>>> +timestamp counter. The TMRs run at either a fixed 1 MHz clock rate
>>> derived
>>> +from the oscillator clock (TMR0-TMR9) or directly at the oscillator
>>> clock
>>> +(TMR10-TMR13). Each TMR can be programmed to generate one-shot,
>>> periodic,
>>> +or watchdog interrupts.
>>> +
>>> +Required properties:
>>> +- compatible : "nvidia,tegra210-timer".
>>> +- reg : Specifies base physical address and size of the registers.
>>> +- interrupts : A list of 4 interrupts; one per each of TMR10 through
>>> TMR13.
>>
>> Why do we only add the interrupts for TMR10 - TMR13? What about the
>> others?
>>
>=20
> The others (TMR0-TMR9) are occupied for other usages. TMR5 is occupied
> for the watchdog timer in the upstream kernel. And others (still in
> TMR0-TMR9) are occupied for different usages in our downstream kernel.

Where is TMR5 reserved for the watchdog? I don't see this?

> And notice that only TMR10-TMR13 are running at the oscillator clock
> (clk_m). With the Tegra210 timer driver, we introduce in this series,
> which only replace the clock event device function that was originally
> owned by the arch timer (armv8 timer) and it also running at the
> oscillator clock. The sched_timer still owns by the arch timer. So the
> timer resolution will be the same. That's why we choose TMR10-TMR13 as
> the timer for Tegra210.

That maybe fine, but DT should describe the hardware and so I don't see
why we would not list all the interrupts. We can still only use TMR10-13
in the driver.

Cheers
Jon

--=20
nvpublic
