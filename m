Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+va1Y8kq1cRC1iOwuBG9C3UPWpuT8LikK92jaGMOla/g0SsQ1rptDjUJFyL1UHqZCiNyuN
ARC-Seal: i=1; a=rsa-sha256; t=1524088631; cv=none;
        d=google.com; s=arc-20160816;
        b=IbT9SnkAEmgY2TBsl+hYeofabUSoTAhsqfbdlC8bXqu8DbTJnNmPBkCpjIAZIRCuei
         aB+7Gzr5Xjp/d6tOJw7P/LZkxInIQc3AwaLtkNRCsNBtnRw2sAtDxgF5VOYu63HDl/l1
         WbaO1WgA1IWjITuNaAL/zbKezwKmMWaXUZ3ztBBb292EG4tkC6/jaNMjUp2bm+yUH913
         ZimxGWSiiClTmeP1NZ5QKqk5raJ1dH3aipx80H2Kde192aWFXJ0bu59e/jotrb06ZqDF
         XBIPPjYwsMytR4vent/pgI2Juy5DVTidqONVWeQbwkI7tjIp7zgjzLpL/871KjOJt4i/
         IUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Cmn/hwnL0LiIC7T4dqsY9BYN660XfAzOVXKDBpdo4sM=;
        b=aAnjLzd/FNEhc3JKpSRmLzEqpGcYd9RADgaIgX+0yyFxNGiihMhzCl3CWJBI9oH37V
         16U7JFAtOWsciuQlyxtx0S9PzxXVhegntOI2A4G0EPemTRzqdrEWgmGu2elAQOqwOISz
         qsSNCWjslFEvLDJ9KNGx1x6qGFi3FGd99swUphRykxYkGFZhNRBuKvYlPQ2HXhD403sv
         O/agsE4X7++VHM7AopJI980u56VkGQzLf7e7VkRWs/UBwtKO5wUsZla7cTckla6qrwHT
         SyyHwE1JiNcUmNHbdyTt7+MTXeE7SaCPfLE3DoEdqaHys4vviRdemM3VYlR5U4wVnqI1
         xw1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,466,1517904000";
   d="scan'208";a="33630149"
Subject: Re: [PATCH v3 07/10] Documentation: dt-bindings: Add documents for
 PECI hwmon client drivers
To: Rob Herring <robh@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
 Andrew Lunn <andrew@lunn.ch>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Fengguang Wu <fengguang.wu@intel.com>, Greg KH <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Haiyue Wang
 <haiyue.wang@linux.intel.com>, James Feist <james.feist@linux.intel.com>,
 Jason M Biils <jason.m.bills@linux.intel.com>,
 Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
 Julia Cartwright <juliac@eso.teric.us>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stef van Os <stef.van.os@prodrive-technologies.com>,
 Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>,
 Vernon Mauery <vernon.mauery@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 Linux HWMON List <linux-hwmon@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-8-jae.hyun.yoo@linux.intel.com>
 <20180416181423.t4vf7sugv6z3aw5h@rob-hp-laptop>
 <aee4e04c-885f-b1d8-9e85-9e741551342f@linux.intel.com>
 <287e0fd9-b631-2602-2785-7b8aaed7a6b9@linux.intel.com>
 <6ff697e8-cd20-e551-da13-b614cc39f900@linux.intel.com>
 <CAL_JsqLcxEnCOywTtU14G4=6A5m6G=KH3oi8m1VxKSEdxuv-ww@mail.gmail.com>
 <1f2a86ff-b902-1d1d-488a-807ac1dd20cc@linux.intel.com>
 <CAL_JsqLpuNj4kQ8oXB0kxOsS7ww9Jk-oq4tJrroDKkLRTPrjSA@mail.gmail.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <884d3c16-84e8-e38a-731a-313ba7105176@linux.intel.com>
Date: Wed, 18 Apr 2018 14:57:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLpuNj4kQ8oXB0kxOsS7ww9Jk-oq4tJrroDKkLRTPrjSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385139320717723?=
X-GMAIL-MSGID: =?utf-8?q?1598122761184473244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/18/2018 2:28 PM, Rob Herring wrote:
> On Wed, Apr 18, 2018 at 3:28 PM, Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>> On 4/18/2018 7:32 AM, Rob Herring wrote:
>>>
>>> On Tue, Apr 17, 2018 at 3:40 PM, Jae Hyun Yoo
>>> <jae.hyun.yoo@linux.intel.com> wrote:
>>>>
>>>> On 4/16/2018 4:51 PM, Jae Hyun Yoo wrote:
>>>>>
>>>>>
>>>>> On 4/16/2018 4:22 PM, Jae Hyun Yoo wrote:
>>>>>>
>>>>>>
>>>>>> On 4/16/2018 11:14 AM, Rob Herring wrote:
>>>>>>>
>>>>>>>
>>>>>>> On Tue, Apr 10, 2018 at 11:32:09AM -0700, Jae Hyun Yoo wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> This commit adds dt-bindings documents for PECI cputemp and dimmtemp
>>>>>>>> client
>>>>>>>> drivers.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>
>>>> [...]
>>>>
>>>>>>>> +Example:
>>>>>>>> +    peci-bus@0 {
>>>>>>>> +        #address-cells = <1>;
>>>>>>>> +        #size-cells = <0>;
>>>>>>>> +        < more properties >
>>>>>>>> +
>>>>>>>> +        peci-dimmtemp@cpu0 {
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> unit-address is wrong.
>>>>>>>
>>>>>>
>>>>>> Will fix it using the reg value.
>>>>>>
>>>>>>> It is a different bus from cputemp? Otherwise, you have conflicting
>>>>>>> addresses. If that's the case, probably should make it clear by
>>>>>>> showing
>>>>>>> different host adapters for each example.
>>>>>>>
>>>>>>
>>>>>> It could be the same bus with cputemp. Also, client address sharing is
>>>>>> possible by PECI core if the functionality is different. I mean,
>>>>>> cputemp and
>>>>>> dimmtemp targeting the same client is possible case like this.
>>>>>> peci-cputemp@30
>>>>>> peci-dimmtemp@30
>>>>>>
>>>>>
>>>>> Oh, I got your point. Probably, I should change these separate settings
>>>>> into one like
>>>>>
>>>>> peci-client@30 {
>>>>>        compatible = "intel,peci-client";
>>>>>        reg = <0x30>;
>>>>> };
>>>>>
>>>>> Then cputemp and dimmtemp drivers could refer the same compatible
>>>>> string.
>>>>> Will rewrite it.
>>>>>
>>>>
>>>> I've checked it again and realized that it should use function based node
>>>> name like:
>>>>
>>>> peci-cputemp@30
>>>> peci-dimmtemp@30
>>>>
>>>> If it use the same string like 'peci-client@30', the drivers cannot be
>>>> selectively enabled. The client address sharing way is well handled in
>>>> PECI
>>>> core and this way would be better for the future implementations of other
>>>> PECI functional drivers such as crash dump driver and so on. So I'm going
>>>> change the unit-address only.
>>>
>>>
>>> 2 nodes at the same address is wrong (and soon dtc will warn you on
>>> this). You have 2 potential options. The first is you need additional
>>> address information in the DT if these are in fact 2 independent
>>> devices. This could be something like a function number to use
>>> something from PCI addressing. From what I found on PECI, it doesn't
>>> seem to have anything like that. The 2nd option is you have a single
>>> DT node which registers multiple hwmon devices. DT nodes and drivers
>>> don't have to be 1-1. Don't design your DT nodes from how you want to
>>> partition drivers in some OS.
>>>
>>> Rob
>>>
>>
>> Please correct me if I'm wrong but I'm still thinking that it is
>> possible. Also, I did compile it but dtc doesn't make a warning. Let me
>> show an another use case which is similar to this case:
> 
> I did say *soon*. It's in dtc repo, but not the kernel copy yet.
> 
>> In arch/arm/boot/dts/aspeed-g5.dtsi
>> [...]
>> lpc_host: lpc-host@80 {
>>          compatible = "aspeed,ast2500-lpc-host", "simple-mfd", "syscon";
>>          reg = <0x80 0x1e0>;
>>          reg-io-width = <4>;
>>
>>          #address-cells = <1>;
>>          #size-cells = <1>;
>>          ranges = <0x0 0x80 0x1e0>;
>>
>>          lpc_ctrl: lpc-ctrl@0 {
>>                  compatible = "aspeed,ast2500-lpc-ctrl";
>>                  reg = <0x0 0x80>;
>>                  clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>>                  status = "disabled";
>>          };
>>
>>          lpc_snoop: lpc-snoop@0 {
>>                  compatible = "aspeed,ast2500-lpc-snoop";
>>                  reg = <0x0 0x80>;
>>                  interrupts = <8>;
>>                  status = "disabled";
>>          };
>> }
>> [...]
>>
>> This is device tree setting for LPC interface and its child nodes.
>> LPC interface can be used as a multi-functional interface such as
>> snoop 80, KCS, SIO and so on. In this use case, lpc-ctrl@0 and
>> lpc-snoop@0 are sharing their address range from their individual
>> driver modules and they can be registered quite well through both
>> static dt or dynamic dtoverlay. PECI is also a multi-functional
>> interface which is similar to the above case, I think.
> 
> This case too is poor design and should be fixed as well. Simply put,
> you can have 2 devices on a bus at the same address without some sort
> of mux or arbitration device in the middle. If you have a device/block
> with multiple functions provided to the OS, then it is the OS's
> problem to arbitrate access. It is not a DT problem because OS's can
> vary in how they handle that both from OS to OS and over time.
> 
> Rob
> 

If I change it to a single DT node which registers 2 hwmon devices using
the 2nd option above, then I still have 2 devices on a bus at the same
address. Does it also make a problem to the OS then?

Jae
