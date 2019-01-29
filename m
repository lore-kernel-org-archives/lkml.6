Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D2DC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC85020844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfA2I2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:28:53 -0500
Received: from mx.socionext.com ([202.248.49.38]:16351 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfA2I2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:28:52 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Jan 2019 17:28:50 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 425071800E1;
        Tue, 29 Jan 2019 17:28:50 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 29 Jan 2019 17:28:50 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id ABCFF40221;
        Tue, 29 Jan 2019 17:28:49 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 8DECB1217C2;
        Tue, 29 Jan 2019 17:28:49 +0900 (JST)
Subject: Re: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline
 description
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
 <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
 <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com>
 <154356579701.88331.5043467509900444879@swboyd.mtv.corp.google.com>
 <f5917f71-f15b-a92d-649c-e3f5f5f10698@socionext.com>
 <CAL_Jsq+dnKht3TwCh1qB1H4pYFhQJmSN0nAayU+=PJLAvq0bbQ@mail.gmail.com>
 <90b00858-6e9e-8f7c-f6d4-b35e5daa6eee@socionext.com>
 <CAL_JsqJ=FRfzVFiOJ0wvoV5iZV+Gx3ft9pGyhb-GoKnOAQgPtQ@mail.gmail.com>
 <daa5f00a-1d9c-69b0-ed2d-8ff6a64251cc@socionext.com>
 <20190122115010.ziopujojh6hkxyag@e5254000004ec.dyn.armlinux.org.uk>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <2bf9d327-580b-afb6-f872-701dde249b22@socionext.com>
Date:   Tue, 29 Jan 2019 17:28:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190122115010.ziopujojh6hkxyag@e5254000004ec.dyn.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/01/22 20:50, Russell King - ARM Linux admin wrote:
> On Tue, Jan 22, 2019 at 08:36:03PM +0900, Sugaya, Taichi wrote:
>> Hi
>>
>> On 2018/12/04 22:32, Rob Herring wrote:
>>> On Tue, Dec 4, 2018 at 5:30 AM Sugaya, Taichi
>>> <sugaya.taichi@socionext.com> wrote:
>>>>
>>>> Hi
>>>>
>>>> On 2018/12/04 0:49, Rob Herring wrote:
>>>>> On Mon, Dec 3, 2018 at 1:42 AM Sugaya, Taichi
>>>>> <sugaya.taichi@socionext.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 2018/11/30 17:16, Stephen Boyd wrote:
>>>>>>> Quoting Sugaya, Taichi (2018-11-29 04:24:51)
>>>>>>>> On 2018/11/28 11:01, Stephen Boyd wrote:
>>>>>>>>> Quoting Sugaya Taichi (2018-11-18 17:01:07)
>>>>>>>>>>       create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
>>>>>>>>>>
>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
>>>>>>>>>> new file mode 100644
>>>>>>>>>> index 0000000..f5d906c
>>>>>>>>>> --- /dev/null
>>>>>>>>>> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
>>>>>>>>>> @@ -0,0 +1,12 @@
>>>>>>>>>> +Socionext M10V SMP trampoline driver binding
>>>>>>>>>> +
>>>>>>>>>> +This is a driver to wait for sub-cores while boot process.
>>>>>>>>>> +
>>>>>>>>>> +- compatible: should be "socionext,smp-trampoline"
>>>>>>>>>> +- reg: should be <0x4C000100 0x100>
>>>>>>>>>> +
>>>>>>>>>> +EXAMPLE
>>>>>>>>>> +       trampoline: trampoline@0x4C000100 {
>>>>>>>>> Drop the 0x part of unit addresses.
>>>>>>>>
>>>>>>>> Okay.
>>>>>>>>
>>>>>>>>
>>>>>>>>>> +               compatible = "socionext,smp-trampoline";
>>>>>>>>>> +               reg = <0x4C000100 0x100>;
>>>>>>>>> Looks like a software construct, which we wouldn't want to put into DT
>>>>>>>>> this way. DT doesn't describe drivers.
>>>>>>>> We would like to use this node only getting the address of the
>>>>>>>> trampoline area
>>>>>>>> in which sub-cores wait.  (They have finished to go to this area in previous
>>>>>>>> bootloader process.)
>>>>>>>
>>>>>>> Is this area part of memory, or a special SRAM? If it's part of memory,
>>>>>>> I would expect this node to be under the reserved-memory node and
>>>>>>> pointed to by some other node that uses this region. Could even be the
>>>>>>> CPU nodes.
>>>>>>
>>>>>> Yes, 0x4C000100 is a part of memory under the reserved-memory node. So
>>>>>> we would like to use the SRAM ( allocated 0x00000000 ) area instead.
>>>>>> BTW, sorry, the trampoline address of this example is simply wrong.  We
>>>>>> were going to use a part of the SRAM from the beginning.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> So should we embed the constant value in source codes instead of getting
>>>>>>>> from
>>>>>>>> DT because the address is constant at the moment? Or is there other
>>>>>>>> approach?
>>>>>>>>
>>>>>>>
>>>>>>> If it's constant then that also works. Why does it need to come from DT
>>>>>>> at all then?
>>>>>>
>>>>>> We think it is not good to embed constant value in driver codes and do
>>>>>> not have another way...
>>>>>> Are there better ways?
>>>>>
>>>>> If this is just memory, can you use the standard spin-table binding in
>>>>> the DT spec? There are some requirements like 64-bit values even on
>>>>> 32-bit machines (though this gets violated).
>>>>
>>>> The spin-table seems to be used on only 64-bit arch. Have it ever worked
>>>> on 32-bit machine?
>>>
>>> Yes.
>>>
>>>> And I would like not to use it because avoid violation.
>>>
>>> The issue now that I remember is cpu-release-addr is defined to always
>>> be a 64-bit value while some platforms made it a 32-bit value.
>>> 'cpu-release-addr' is also used for some other enable-methods.
>>
>> I have a question about the spin-table.
>> The code "smp_spin_table.c" is only in "arch/arm64/kernel" directory so can
>> not be compiled in arm-v7 arch. That means the spin-table can not be used
>> arm-v7 arch..? , or is there the way to compile the code in arm-v7 arch?
> 
> Why do you think you need it?  Do you have no way to control individual
> CPUs?
> 
> We are going through a process in 32-bit eliminating the "spin table"
> stuff from platforms.
> 

Not always necessary to us and considering the history I think it is not 
suitable to use the spin-table.
I try to use another way.

