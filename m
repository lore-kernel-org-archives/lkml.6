Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx48Ot2jVEuuBywyCjDsO9JlrNRSobKURcjRyDL/zbdqNlkZwgqZU2p5ZleAQ2x/nfvlaXSLQ
ARC-Seal: i=1; a=rsa-sha256; t=1524587207; cv=none;
        d=google.com; s=arc-20160816;
        b=KrucJcBK3vU7sv3fYQgzzYBVyiVQGLhpFDPDfKce/Ec88Tf2s5yDF//dQCM2KW8No1
         f36n3yZiBSOSy1RgiqFivfNL6ktQUcfA8UAGWXkGHw5onvjIUbmzdRwPPUejDf15AvY/
         Qx5lUW06+NkXwyfM+q0cZPUSOCNYCX20lvBdrq/vbQIrwDmGGOx5U100CmYLECZ4XiNs
         0QJwJnoa5xoJnws2saxEv2PbbA0Y6obhNVc3UjMlxe1ouq7UBCSSk3e+ohSbfr9/cAlU
         1dJkv8Qt/VMlOnzb6viy0S9reTCT+jcTFr+PUaa60OZgUC+xQZLSYY7aZRB+JP6LSjMw
         gGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=+nARaNEy8/np9CPBooNeBL98iAh7OV8sVa7pNGGsYG0=;
        b=eLdaPpEkrrhVlvQgCkHRC7Wq54/WyGSDw2HoOo44OA6XVwnQJ5ZZjZeNXDgRNtnKXt
         7Za72QxN+7UvzP95kYuuEekbn32t2059NNruYmieOnWRjPevVkGMMtMSzPLzI0456Wq2
         0P3DY4xS0v3480W7iPv46bGRNd0jlhLFm9LfwloMpDgy0tuuV+ZRYAZk7HJQtaXLTT+x
         vR6tJJhifGuX1glAUF6nYFwVfu5kOHqWgl/bVwtqzCMWQZV2F4DI2MN1aRhuLrNr4O7K
         YCcm0YeXwdDFXfR2UZ4GbtCFCRTcSX4Bzn1H96UEUiENpu49iSwc/tAbQkOPAOXooR4j
         4rLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="53285316"
Subject: Re: [PATCH v3 09/10] drivers/hwmon: Add PECI hwmon client drivers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
 Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
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
 Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-10-jae.hyun.yoo@linux.intel.com>
 <1524585397.21176.502.camel@linux.intel.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <c62f1c9a-1eae-49d9-2fde-c65452d5f0e6@linux.intel.com>
Date: Tue, 24 Apr 2018 09:26:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1524585397.21176.502.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385144123845129?=
X-GMAIL-MSGID: =?utf-8?q?1598645555667389666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andy,

Thanks a lot for your review. Please check my inline answers.

On 4/24/2018 8:56 AM, Andy Shevchenko wrote:
> On Tue, 2018-04-10 at 11:32 -0700, Jae Hyun Yoo wrote:
> 
>>   drivers/hwmon/peci-cputemp.c  | 783
>> ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/hwmon/peci-dimmtemp.c | 432 +++++++++++++++++++++++
> 
> Does it make sense one driver per patch?
> 

Yes, I'll separate it into two patches.

>> +#define CLIENT_CPU_ID_MASK    0xf0ff0  /* Mask for Family / Model
>> info */
> 
>> +struct cpu_gen_info {
>> +	u32 type;
>> +	u32 cpu_id;
>> +	u32 core_max;
>> +};
>>
> 
>> +static const struct cpu_gen_info cpu_gen_info_table[] = {
>> +	{ .type = CPU_GEN_HSX,
>> +	  .cpu_id = 0x306f0, /* Family code: 6, Model number: 63
>> (0x3f) */
>> +	  .core_max = CORE_MAX_ON_HSX },
>> +	{ .type = CPU_GEN_BRX,
>> +	  .cpu_id = 0x406f0, /* Family code: 6, Model number: 79
>> (0x4f) */
>> +	  .core_max = CORE_MAX_ON_BDX },
>> +	{ .type = CPU_GEN_SKX,
>> +	  .cpu_id = 0x50650, /* Family code: 6, Model number: 85
>> (0x55) */
>> +	  .core_max = CORE_MAX_ON_SKX },
>> +};
> 
> Are we talking about x86 CPU IDs here?
> If so, why x86 corresponding headers, including intel-family.h are not
> used?
> 

Yes, that would make more sense. I'll include the intel-family.h and 
will use these defines instead:
INTEL_FAM6_HASWELL_X
INTEL_FAM6_BROADWELL_X
INTEL_FAM6_SKYLAKE_X

Thanks,

Jae
