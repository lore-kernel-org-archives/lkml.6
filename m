Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AIpwx48I4/s+AWESUDDanfNDGs8rvHrX0oAc+URHFyZbOdsvThX87GTsrrrrXUk0I60z5Rn4CAHX
ARC-Seal: i=1; a=rsa-sha256; t=1524061978; cv=none;
        d=google.com; s=arc-20160816;
        b=LYMdNb78VfUiK2/6OubWvyQvgdWj0s2skZujrjRqA/CDn21WjsXslzhKPdw/WijQfo
         IsVcCyHjaulRq83BQ0z/MpO97qWbwUjyK6u6OHmQoo5iZP6R/dYfkJMlS/xHvtv/GIXk
         eABo0iGojSA3zRbEKTYo5RM+wI7AHWT6i/sTq4s0RLvKSF4DC44JeoRZ+U0+tFYcUTXR
         PsIWDS5rlVbrNyDg8OtZLLd/2KP3vadnUU667gf0xZHIyv0UJTSnSwBEGn4FK1iptnsV
         BWJQicQMIhminB6u3M6MKRYOJvj56UxUS3l6hkIRdfIyQHOrOb1bJDSRi6Gy6iftwPEw
         zZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=bsTvMRelnsfqZfrdLI1SSHFRwYovVepa/7OiZzNPvmc=;
        b=adebMX1UlnC8D0QoSM0wSjgkv3ZdGY9FRI+A1GyfUgqXkro4JpvtKz9hJ0Kof4UspY
         ncsCdfLSAXBvhQPRLbiJYo9QWnhzUClOZ9pEiUk1kwwFRqZ9ua+mMJ5mkIoU/tXPYN7I
         dTAoSHkihhEiHCOoOfetZJb/r9InLSD+1wUFSdzqsucHkIUO1/zBBMH3l9Q33JxGZ8q0
         OtzgUyi6wfcNQe4/VnnEvVn8pPNRh4fndzAgm0U7v0ZfP3do2W2pG/HxnqGfoHz229K5
         cZeJTD1sEwNaivLpgZVFeIhy5feMFR9qDtQ7ZFeQ1yEIgi4nwuQfeZtg4Y67xMJckUSy
         Jggg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEA32183C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <6ff697e8-cd20-e551-da13-b614cc39f900@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-8-jae.hyun.yoo@linux.intel.com> <20180416181423.t4vf7sugv6z3aw5h@rob-hp-laptop>
 <aee4e04c-885f-b1d8-9e85-9e741551342f@linux.intel.com> <287e0fd9-b631-2602-2785-7b8aaed7a6b9@linux.intel.com>
 <6ff697e8-cd20-e551-da13-b614cc39f900@linux.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 18 Apr 2018 09:32:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLcxEnCOywTtU14G4=6A5m6G=KH3oi8m1VxKSEdxuv-ww@mail.gmail.com>
Message-ID: <CAL_JsqLcxEnCOywTtU14G4=6A5m6G=KH3oi8m1VxKSEdxuv-ww@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] Documentation: dt-bindings: Add documents for
 PECI hwmon client drivers
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>, Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Fengguang Wu <fengguang.wu@intel.com>,
	Greg KH <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
	Haiyue Wang <haiyue.wang@linux.intel.com>, James Feist <james.feist@linux.intel.com>,
	Jason M Biils <jason.m.bills@linux.intel.com>, Jean Delvare <jdelvare@suse.com>,
	Joel Stanley <joel@jms.id.au>, Julia Cartwright <juliac@eso.teric.us>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Milton Miller II <miltonm@us.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Stef van Os <stef.van.os@prodrive-technologies.com>,
	Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, Linux HWMON List <linux-hwmon@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385139320717723?=
X-GMAIL-MSGID: =?utf-8?q?1598094813646640279?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 3:40 PM, Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
> On 4/16/2018 4:51 PM, Jae Hyun Yoo wrote:
>>
>> On 4/16/2018 4:22 PM, Jae Hyun Yoo wrote:
>>>
>>> On 4/16/2018 11:14 AM, Rob Herring wrote:
>>>>
>>>> On Tue, Apr 10, 2018 at 11:32:09AM -0700, Jae Hyun Yoo wrote:
>>>>>
>>>>> This commit adds dt-bindings documents for PECI cputemp and dimmtemp
>>>>> client
>>>>> drivers.
>>>>
>>>>
>
> [...]
>
>>>>> +Example:
>>>>> +    peci-bus@0 {
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <0>;
>>>>> +        < more properties >
>>>>> +
>>>>> +        peci-dimmtemp@cpu0 {
>>>>
>>>>
>>>> unit-address is wrong.
>>>>
>>>
>>> Will fix it using the reg value.
>>>
>>>> It is a different bus from cputemp? Otherwise, you have conflicting
>>>> addresses. If that's the case, probably should make it clear by showing
>>>> different host adapters for each example.
>>>>
>>>
>>> It could be the same bus with cputemp. Also, client address sharing is
>>> possible by PECI core if the functionality is different. I mean, cputemp and
>>> dimmtemp targeting the same client is possible case like this.
>>> peci-cputemp@30
>>> peci-dimmtemp@30
>>>
>>
>> Oh, I got your point. Probably, I should change these separate settings
>> into one like
>>
>> peci-client@30 {
>>      compatible = "intel,peci-client";
>>      reg = <0x30>;
>> };
>>
>> Then cputemp and dimmtemp drivers could refer the same compatible string.
>> Will rewrite it.
>>
>
> I've checked it again and realized that it should use function based node
> name like:
>
> peci-cputemp@30
> peci-dimmtemp@30
>
> If it use the same string like 'peci-client@30', the drivers cannot be
> selectively enabled. The client address sharing way is well handled in PECI
> core and this way would be better for the future implementations of other
> PECI functional drivers such as crash dump driver and so on. So I'm going
> change the unit-address only.

2 nodes at the same address is wrong (and soon dtc will warn you on
this). You have 2 potential options. The first is you need additional
address information in the DT if these are in fact 2 independent
devices. This could be something like a function number to use
something from PCI addressing. From what I found on PECI, it doesn't
seem to have anything like that. The 2nd option is you have a single
DT node which registers multiple hwmon devices. DT nodes and drivers
don't have to be 1-1. Don't design your DT nodes from how you want to
partition drivers in some OS.

Rob
