Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx49va2QcJC9gHgo2o7QszSVqJzSJng+o81NlMYopGpgQ4p2d75zQJt4lQrYluXMrJofPlXYo
ARC-Seal: i=1; a=rsa-sha256; t=1524002841; cv=none;
        d=google.com; s=arc-20160816;
        b=Q+lfEG47dd7guLTLP4XvJoiVrlYqkiVpOcbAlg9y6S1JTZptXHFwLgF0Ne9UOPapNb
         leP9WKyMDYXIv447F3whxh3Aw/iU8+AXRDCqPeB2tdGy5grnPaPxBzCMxcOT+L4PrrJd
         eYfv+EEYuzM53QZy7Dn57ZY5u95XCPLb/7qAbqa57Qvqg/uq6ooCBVzFbbOedA5FN6XW
         b8nz2mUBCw15UUXTnkslywSHH4WLfxHuDJbtE2+hNSMtd7XdR2dhQJDpB88BTT5a5XSZ
         imER92Z7OpMXAjt1Z8Jao7iKwoVSWxiZlkel5mY9jW2B8Iv4a4Oy1kPkg+lKdVPrQ0+T
         fetg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :arc-authentication-results;
        bh=7FMDWjbu7ViGCMcC9YdgvVaY8G1aE9hD7Qv/is2X79M=;
        b=zvPKzsJhTvXG0f+B19X5dC9QnVuhNQYkm1cOuR9yMPm21tlflsQTUz+L3SpWiD+Vic
         ArdNmZgPPLBM+k8iY9OH7KvagnV5L6gd3xGRmJqozbbow0VJ5aEQP3gThu2HPOvyvaBr
         omXhyEgoAHtpmvr/9FUyFcULdhryh5y828rCIk2gkoTVYv9lW6P23hf2LL2Vc6whHw8n
         NlAn65P0reRFL3sa2NjilYYUuToBKAtZt+DeTo64cKs7SQGuBKSxI4NlhuUnksuyF0Wa
         eXMC9Wo3WSYQRiDHTOD9iycZVQRSHaQT4RGs9D3wAQq8ZXLAto/GVdvhacSOPTJKQTg2
         MZtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="192288160"
Subject: Re: [PATCH v3 04/10] Documentations: dt-bindings: Add a document of
 PECI adapter driver for Aspeed AST24xx/25xx SoCs
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
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
Message-ID: <584aca6c-c87a-ff7a-2fdc-3c742236be60@linux.intel.com>
Date: Tue, 17 Apr 2018 15:06:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f07623c4-5f0c-4ab1-f761-44bd702bbdf0@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385135853793781?=
X-GMAIL-MSGID: =?utf-8?q?1598032803709953361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/17/2018 11:16 AM, Jae Hyun Yoo wrote:
> On 4/17/2018 6:16 AM, Rob Herring wrote:
>> On Mon, Apr 16, 2018 at 6:12 PM, Jae Hyun Yoo
>> <jae.hyun.yoo@linux.intel.com> wrote:
>>> On 4/16/2018 11:10 AM, Rob Herring wrote:
>>>>
>>>> On Tue, Apr 10, 2018 at 11:32:06AM -0700, Jae Hyun Yoo wrote:
>>>>>
>>>>> This commit adds a dt-bindings document of PECI adapter driver for 
>>>>> Aspeed
>>>>> AST24xx/25xx SoCs.
>>
>> [...]
>>
>>>>> +- clocks            : Should contain clock source for PECI 
>>>>> controller.
>>>>> +                     Should reference clkin.
>>>>> +- clock_frequency   : Should contain the operation frequency of PECI
>>>>> controller
>>>>> +                     in units of Hz.
>>>>> +                     187500 ~ 24000000
>>>>
>>>>
>>>> This is the frequency of the bus or used to derive it? It would be
>>>> better to specify the bus frequency instead and have the driver
>>>> calculate its internal freq. And then use "bus-frequency" instead.
>>>>
>>>
>>> I agree with you. Actually, it is being used for operation frequency 
>>> setting
>>> of PECI controller module in SoC so it's different from the meaning of
>>> "bus-frequency". I'll change it to "operation-frequency".
>>
>> No, now you've gone from a standard property name to something custom.
>> Why do you need to set the frequency in DT if it is not related to the
>> interface frequency?
>>
>> Rob
>>
> 
> Actually, the interface frequency is affected by the operation frequency
> but there is no description of its relationship in datasheet. I'll check
> again about the detail to ASPEED chip vendor and will use
> 'bus-frequency' if available.
> 

I investigated it more deeply. Basically, by the spec, PECI bus speed
cannot be set as a fixed speed. A PECI bus can have a wide speed range
from 2Kbps to 2Mbps which is dynamically set by a handshaking sequence
between an originator and clients called 'timing negotiation' in spec.
This timing negotiation behavior happens on every single transaction so 
the bus speed also can vary on every transactions. So I'm thinking a 
custom property name for it, 'peci-clk-frequency' if it is acceptable.

Thanks,

Jae
