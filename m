Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx48YIRyAxZqs6FfnELOW1U0a8a3YzElQtvF0DMsIlnAaBtUMXhBpHWZXsmN4A+bWOq+mXB4Z
ARC-Seal: i=1; a=rsa-sha256; t=1524069959; cv=none;
        d=google.com; s=arc-20160816;
        b=y9ScBhhi25Dvk46gCdrpaJG0OvSl0XBQYIdrde9v3yRBMikWLhAM9E0/LHwQc87p3e
         urm74TpmawL8fv87vlq2lcAoF8l76CyR8UZ6XgxvlzHw50M+4iUSjV6UPJSsxjh/hsFp
         n5T8VbDSU1SY+R84ejLwQa7LTkhNnbYoUEr/QN/BlvhK5LYRiolDVaQsBp+/c3HTYm5V
         cdsaEDDxKWh5nulTQgEXABbxZSPuK3bif/yqInpx/cOhijJGIkDDOI7xTjdF4CIR6oqH
         8/NpAXuo0Fp2Wj4Og+/B7n1qQYo04EhC8A/3fCV+XDQt708441Nw+ZbWTqTAQdalUM6w
         Mi6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=HCIYGiTj164u5mT2HZhCcwnQSewrnLembcLs+oPMxUE=;
        b=iPlDIPxjLopyP6YVx6KS27Zp1Lvpyx9obg68rjEP3FKOAOiS3Kf0xUyhzvdQbmsvhC
         nMcI8kDJ5PA0woFs0CzV3yU4fkNBT7L7PyWaBWQ250/1ZeQ4x/g4LD6SbQN4UtwG66mc
         YBGQrgGwaR1dlVytukFMkINgOcPrKCEPXJqA8sjcyZEAf42Q8mveoFoD1czAaMBCmHTq
         PqScVNH7sElHxdYCHfyIhaOu5QKnVLFYeMxLN0JTdDQbJQq4zv85C9+XTD+YhoWe+RIW
         zBxdGgRuakrkgCM5Ks2evrh5/oC5yr4uwx9WWt2XE+WCmZSiuOAy9zYQT/ZHLOLm6Gaq
         Z6/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,466,1517904000";
   d="scan'208";a="33564808"
Subject: Re: [PATCH v3 04/10] Documentations: dt-bindings: Add a document of
 PECI adapter driver for Aspeed AST24xx/25xx SoCs
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
 <20180410183212.16787-5-jae.hyun.yoo@linux.intel.com>
 <20180416181035.rcjvt4rlrwaj5yxf@rob-hp-laptop>
 <53ff5b2b-eba8-8311-64a9-abd4bc72226d@linux.intel.com>
 <CAL_Jsq+1wC-KhXPeCSNhCeCih6=CatJbyumO51ucD17Rt7qofw@mail.gmail.com>
 <f07623c4-5f0c-4ab1-f761-44bd702bbdf0@linux.intel.com>
 <584aca6c-c87a-ff7a-2fdc-3c742236be60@linux.intel.com>
 <CAL_Jsq+9YDv04Gu=WODdqb6wD4fk6=-fFw_3skU79UC8OW0jZA@mail.gmail.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <7ff3b23c-7dc8-865f-4069-c53642aaf1ab@linux.intel.com>
Date: Wed, 18 Apr 2018 09:45:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+9YDv04Gu=WODdqb6wD4fk6=-fFw_3skU79UC8OW0jZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385135853793781?=
X-GMAIL-MSGID: =?utf-8?q?1598103181894164460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/18/2018 6:59 AM, Rob Herring wrote:
> On Tue, Apr 17, 2018 at 5:06 PM, Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>> On 4/17/2018 11:16 AM, Jae Hyun Yoo wrote:
>>>
>>> On 4/17/2018 6:16 AM, Rob Herring wrote:
>>>>
>>>> On Mon, Apr 16, 2018 at 6:12 PM, Jae Hyun Yoo
>>>> <jae.hyun.yoo@linux.intel.com> wrote:
>>>>>
>>>>> On 4/16/2018 11:10 AM, Rob Herring wrote:
>>>>>>
>>>>>>
>>>>>> On Tue, Apr 10, 2018 at 11:32:06AM -0700, Jae Hyun Yoo wrote:
>>>>>>>
>>>>>>>
>>>>>>> This commit adds a dt-bindings document of PECI adapter driver for
>>>>>>> Aspeed
>>>>>>> AST24xx/25xx SoCs.
>>>>
>>>>
>>>> [...]
>>>>
>>>>>>> +- clocks            : Should contain clock source for PECI
>>>>>>> controller.
>>>>>>> +                     Should reference clkin.
>>>>>>> +- clock_frequency   : Should contain the operation frequency of PECI
>>>>>>> controller
>>>>>>> +                     in units of Hz.
>>>>>>> +                     187500 ~ 24000000
>>>>>>
>>>>>>
>>>>>>
>>>>>> This is the frequency of the bus or used to derive it? It would be
>>>>>> better to specify the bus frequency instead and have the driver
>>>>>> calculate its internal freq. And then use "bus-frequency" instead.
>>>>>>
>>>>>
>>>>> I agree with you. Actually, it is being used for operation frequency
>>>>> setting
>>>>> of PECI controller module in SoC so it's different from the meaning of
>>>>> "bus-frequency". I'll change it to "operation-frequency".
>>>>
>>>>
>>>> No, now you've gone from a standard property name to something custom.
>>>> Why do you need to set the frequency in DT if it is not related to the
>>>> interface frequency?
>>>>
>>>> Rob
>>>>
>>>
>>> Actually, the interface frequency is affected by the operation frequency
>>> but there is no description of its relationship in datasheet. I'll check
>>> again about the detail to ASPEED chip vendor and will use
>>> 'bus-frequency' if available.
>>>
>>
>> I investigated it more deeply. Basically, by the spec, PECI bus speed
>> cannot be set as a fixed speed. A PECI bus can have a wide speed range
>> from 2Kbps to 2Mbps which is dynamically set by a handshaking sequence
>> between an originator and clients called 'timing negotiation' in spec.
>> This timing negotiation behavior happens on every single transaction so the
>> bus speed also can vary on every transactions. So I'm thinking a custom
>> property name for it, 'peci-clk-frequency' if it is acceptable.
> 
> Okay, seems bus-frequency is not appropriate here. So use
> 'clock-frequency' (note the '-' not '_' as that is the standard
> property).
> 
> Rob
> 

Thanks! I'll use 'clock-frequency' for it.

Jae
