Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx48C2Vhxl6952szKYKKqO0MDAGUPKtXSaWZABqAN86wtu3msVjIMQSpYiaHaCGXIFqZOv+hZ
ARC-Seal: i=1; a=rsa-sha256; t=1524083294; cv=none;
        d=google.com; s=arc-20160816;
        b=rLwDqaf2ZPf+29Qxs+aIsdLbqoW9+PbRReC0ivvzNTxdIQlsICpW4Y+rvVV8wAFRHW
         oTf1RTfOcqqe2dWnmDlgG5RZ5yFwUvfKgcKvCTRBWh4ZoUy51P/Rx9XLwA7UkR/8lPCz
         Mvc5yF1pgr7JcYtoo9saRMCRtOiLuVCL9+YM9kl9mvC8liR7byTipGTgsyd/Cl6rXrZg
         3HWVO4E4KHIiFezcVPnqU43yAcFoJR9RpNSR306rcORqr7KNQPUUTI5XsGspgNRc7wTx
         lRGyhAxsHw+BCWSGPABXOuDDeXMA3q7R7rBIDWgvsbf5NQ5j3T8Ytm2hzNOk91+pW+fE
         Sq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=64d9PBb/gj/nxA7A0cy7J3M0ovmAwqV0cnSWLwuTeb0=;
        b=PQfC0jHzKbU3fO0i+o8XkUaG2oTB51PM/nQJgKFdCHEoby9zd1ZnzNUeOQBK0nOtyh
         Nws2iF0KC+qkq3Ckdr6Ro6JnJqzJ/6j69Q9QoiAqAQkElZSMm62zzVv8YANVO4tU5pQ1
         ETgDrng34m/6uMVWIND4u+2D4OTaZ43LLGI60f/MoJC5OJRnuNgiyWPCzAdw0qRiNFmW
         PBdKrg1cdqrVIqYihuFZfvPJZW/u/WDofkTPbLTTVUW2rzEWJgk7GmmT+oHvOkYF7vsw
         gZ5PJKVxAi6qLKvJQIuZLAcpybTKPQ7hzxR6KRfAAb99SSZe8IrdxvYxiPw8OqNH44QB
         HwLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,466,1517904000";
   d="scan'208";a="33612776"
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
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <1f2a86ff-b902-1d1d-488a-807ac1dd20cc@linux.intel.com>
Date: Wed, 18 Apr 2018 13:28:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLcxEnCOywTtU14G4=6A5m6G=KH3oi8m1VxKSEdxuv-ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385139320717723?=
X-GMAIL-MSGID: =?utf-8?q?1598117164665666992?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/18/2018 7:32 AM, Rob Herring wrote:
> On Tue, Apr 17, 2018 at 3:40 PM, Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>> On 4/16/2018 4:51 PM, Jae Hyun Yoo wrote:
>>>
>>> On 4/16/2018 4:22 PM, Jae Hyun Yoo wrote:
>>>>
>>>> On 4/16/2018 11:14 AM, Rob Herring wrote:
>>>>>
>>>>> On Tue, Apr 10, 2018 at 11:32:09AM -0700, Jae Hyun Yoo wrote:
>>>>>>
>>>>>> This commit adds dt-bindings documents for PECI cputemp and dimmtemp
>>>>>> client
>>>>>> drivers.
>>>>>
>>>>>
>>
>> [...]
>>
>>>>>> +Example:
>>>>>> +    peci-bus@0 {
>>>>>> +        #address-cells = <1>;
>>>>>> +        #size-cells = <0>;
>>>>>> +        < more properties >
>>>>>> +
>>>>>> +        peci-dimmtemp@cpu0 {
>>>>>
>>>>>
>>>>> unit-address is wrong.
>>>>>
>>>>
>>>> Will fix it using the reg value.
>>>>
>>>>> It is a different bus from cputemp? Otherwise, you have conflicting
>>>>> addresses. If that's the case, probably should make it clear by showing
>>>>> different host adapters for each example.
>>>>>
>>>>
>>>> It could be the same bus with cputemp. Also, client address sharing is
>>>> possible by PECI core if the functionality is different. I mean, cputemp and
>>>> dimmtemp targeting the same client is possible case like this.
>>>> peci-cputemp@30
>>>> peci-dimmtemp@30
>>>>
>>>
>>> Oh, I got your point. Probably, I should change these separate settings
>>> into one like
>>>
>>> peci-client@30 {
>>>       compatible = "intel,peci-client";
>>>       reg = <0x30>;
>>> };
>>>
>>> Then cputemp and dimmtemp drivers could refer the same compatible string.
>>> Will rewrite it.
>>>
>>
>> I've checked it again and realized that it should use function based node
>> name like:
>>
>> peci-cputemp@30
>> peci-dimmtemp@30
>>
>> If it use the same string like 'peci-client@30', the drivers cannot be
>> selectively enabled. The client address sharing way is well handled in PECI
>> core and this way would be better for the future implementations of other
>> PECI functional drivers such as crash dump driver and so on. So I'm going
>> change the unit-address only.
> 
> 2 nodes at the same address is wrong (and soon dtc will warn you on
> this). You have 2 potential options. The first is you need additional
> address information in the DT if these are in fact 2 independent
> devices. This could be something like a function number to use
> something from PCI addressing. From what I found on PECI, it doesn't
> seem to have anything like that. The 2nd option is you have a single
> DT node which registers multiple hwmon devices. DT nodes and drivers
> don't have to be 1-1. Don't design your DT nodes from how you want to
> partition drivers in some OS.
> 
> Rob
> 

Please correct me if I'm wrong but I'm still thinking that it is
possible. Also, I did compile it but dtc doesn't make a warning. Let me
show an another use case which is similar to this case:

In arch/arm/boot/dts/aspeed-g5.dtsi
[...]
lpc_host: lpc-host@80 {
         compatible = "aspeed,ast2500-lpc-host", "simple-mfd", "syscon";
         reg = <0x80 0x1e0>;
         reg-io-width = <4>;

         #address-cells = <1>;
         #size-cells = <1>;
         ranges = <0x0 0x80 0x1e0>;

         lpc_ctrl: lpc-ctrl@0 {
                 compatible = "aspeed,ast2500-lpc-ctrl";
                 reg = <0x0 0x80>;
                 clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
                 status = "disabled";
         };

         lpc_snoop: lpc-snoop@0 {
                 compatible = "aspeed,ast2500-lpc-snoop";
                 reg = <0x0 0x80>;
                 interrupts = <8>;
                 status = "disabled";
         };
}
[...]

This is device tree setting for LPC interface and its child nodes.
LPC interface can be used as a multi-functional interface such as
snoop 80, KCS, SIO and so on. In this use case, lpc-ctrl@0 and
lpc-snoop@0 are sharing their address range from their individual
driver modules and they can be registered quite well through both
static dt or dynamic dtoverlay. PECI is also a multi-functional
interface which is similar to the above case, I think.

Thanks,

Jae
