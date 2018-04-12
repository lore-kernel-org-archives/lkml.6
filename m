Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+Oe9t2VKw+8VcXEoq6mXxoPr3ywMBrGoNOolWTaDGGQJ0nEwWGxvoDRfJLtB3rvXODr4Fq
ARC-Seal: i=1; a=rsa-sha256; t=1523562671; cv=none;
        d=google.com; s=arc-20160816;
        b=NNH0MDbckb8FuSeLlXq9eRIzTF6y5tO6VdwmHFUOc9LjvaVKECc34lCEsk8CvOoY2H
         4kpINl7uwGw8cnYwmr6VuJW1os46I2w7RCT++iIlOxTCQrVOqwhKdmio0GIOl/MO0RAQ
         7dbZEFIfd6MHEB5c1v5WXuju+oBR3Bw3nl75j9pImkTy2SMKwjch4+EktGDOokuQyEJ+
         TrvexXSzdBl3aPyFgceK+Y3MhiAoDXFmyTU0//qT9hJYE+mjpQno6zgAxb5Y64a+izaB
         FleVlb3jnf/ovQcQf3IAHfPxc7GtIVlpKIuyXk5TYDGkIhYSqAf5b+nZYoWvSdnxrD+i
         E/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=pEqCfOnSxoTza9f6MLfP8C6o2vmX/erxdy74+E/MGYA=;
        b=vs2BzQQHVTVjx9wrKCnaEAyzkty/8Tek58tMJC2/8EeFRCIYzKosIyGpJiC/kg+kGF
         LtjYrdct9bUOJ4GECEk1HuPCnf1RObXzaoKJqMgmBvbitP0tMoX0kUMK1lTOpPPs1onb
         rXvX5Y5am32/DJx/AFonK6Ehj+WqX9wSZsok3BX+VQziydT8Q4nFxtUclcjimCJxjd87
         h6jB+af1+yiWYaXLdhJh87SkVYoBYg222Mqbq8Sz43EseUFTfZQ6Vtzx6Kb83UJQnJko
         P6StIyntQ9G2E58daCIsLFTXc73BoJvNJtYfTs6QeESzbxbwTCdwDyY223s/pnZ+hnhA
         OXWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,443,1517904000";
   d="scan'208";a="42887718"
Subject: Re: [PATCH v3 09/10] drivers/hwmon: Add PECI hwmon client drivers
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
 Andrew Lunn <andrew@lunn.ch>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Fengguang Wu <fengguang.wu@intel.com>, Greg KH <gregkh@linuxfoundation.org>,
 Haiyue Wang <haiyue.wang@linux.intel.com>,
 James Feist <james.feist@linux.intel.com>,
 Jason M Biils <jason.m.bills@linux.intel.com>,
 Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
 Julia Cartwright <juliac@eso.teric.us>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stef van Os <stef.van.os@prodrive-technologies.com>,
 Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>,
 Vernon Mauery <vernon.mauery@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-10-jae.hyun.yoo@linux.intel.com>
 <20180410222800.GA8484@roeck-us.net>
 <637d7812-e567-0bc2-4f08-fbdca0ee85d8@linux.intel.com>
 <292be2d9-e572-2e06-9899-f6c2c53fdefc@roeck-us.net>
 <7b378954-1ce8-a2d2-5d09-8b6b36c048be@linux.intel.com>
 <13d4c632-a20e-3c40-066a-1e9df02a0595@roeck-us.net>
 <89c8c847-87e7-a849-e05d-d32b787e9305@linux.intel.com>
 <20180412173714.GA13496@roeck-us.net>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <34c2c925-b62c-388b-d753-15fd4a821459@linux.intel.com>
Date: Thu, 12 Apr 2018 12:51:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180412173714.GA13496@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385144123845129?=
X-GMAIL-MSGID: =?utf-8?q?1597571252348951544?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/12/2018 10:37 AM, Guenter Roeck wrote:
> On Thu, Apr 12, 2018 at 10:09:51AM -0700, Jae Hyun Yoo wrote:
> [ ... ]
>>>>>>>> +static int find_core_index(struct peci_cputemp *priv, int channel)
>>>>>>>> +{
>>>>>>>> +    int core_channel = channel - DEFAULT_CHANNEL_NUMS;
>>>>>>>> +    int idx, found = 0;
>>>>>>>> +
>>>>>>>> +    for (idx = 0; idx < priv->gen_info->core_max; idx++) {
>>>>>>>> +        if (priv->core_mask & BIT(idx)) {
>>>>>>>> +            if (core_channel == found)
>>>>>>>> +                break;
>>>>>>>> +
>>>>>>>> +            found++;
>>>>>>>> +        }
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return idx;
>>>>>>>
>>>>>>> What if nothing is found ?
>>>>>>>
>>>>>>
>>>>>> Core temperature group will be registered only when it detects at
>>>>>> least one core checked by check_resolved_cores(), so
>>>>>> find_core_index() can be called only when priv->core_mask has a
>>>>>> non-zero value. The 'nothing is found' case will not happen.
>>>>>>
>>>>> That doesn't guarantee a match. If what you are saying is correct
>>>>> there should always be
>>>>> a well defined match of channel -> idx, and the search should be
>>>>> unnecessary.
>>>>>
>>>>
>>>> There could be some disabled cores in the resolved core mask bit
>>>> sequence also it should remove indexing gap in channel numbering so it
>>>> is the reason why this search function is needed. Well defined match of
>>>> channel -> idx would not be always satisfied.
>>>>
>>> Are you saying that each call to the function, with the same parameters,
>>> can return a different result ?
>>>
>>
>> No, the result will be consistent. After reading the priv->core_mask once in
>> check_resolved_cores(), the value will not be changed. I'm saying about this
>> case, for example if core number 2 is unresolved in total 4 cores, then the
>> idx order will be '0, 1, 3' but channel order will be '5, 6, 7' without
>> making any indexing gap.
>>
> 
> And you yet you claim that this is not well defined ? Or are you concerned
> about the amount of memory consumed by providing an array for the mapping ?
> 
> Note that an indexing gap is acceptable and, in many cases, preferred.
> 

If the indexing gap is acceptable, the index search function isn't 
needed anymore. I'll fix all relating code to make that use direct 
mapping of channel -> idx then. Thanks!

> [ ... ]
> 
>>>>>>>> +
>>>>>>>> +    dev_dbg(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev),
>>>>>>>> priv->name);
>>>>>>>> +
>>>>>
>>>>> Why does this message display the device name twice ?
>>>>>
>>>>
>>>> For an example, dev_name(hwmon_dev) shows 'hwmon5' and priv->name shows
>>>> 'peci-cputemp0'.
>>>>
>>> And dev_dbg() shows another device name. So you'll have something like
>>>
>>> peci-cputemp0: hwmon5: sensor 'peci-cputemp0'
>>>
>>
>> Practically it shows like
>>
>> peci-cputemp 0-30:00: hwmon10: sensor 'peci_cputemp.cpu0'
>>
>> where 0-30:00 is assigned by peci core.
>>
> 
> And what message would you see for cpu1 ?
> 

It shows like

peci-cputemp 0-31:00: hwmon10: sensor 'peci_cputemp.cpu1'
