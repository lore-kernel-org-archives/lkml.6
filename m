Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x226vAqMZ4yUv+oH0zuOOx1UjPViUgUD1WNUsulP8wM3qRsRE+6Opvxx8wIN7eV825Tb36VQB
ARC-Seal: i=1; a=rsa-sha256; t=1519464778; cv=none;
        d=google.com; s=arc-20160816;
        b=zDjyf09Cbzmo0ZUy5R7pif5LvLLh8mwhAGpJkKtwZJKqQUBc0vvdG9L6MHeuovNHHV
         TnLMdR208UWXay7qJfYTm0ZMDDor/ijp10rO3DJhUJyPfGTVjxDCaSMbYKNglBMkp7Kz
         ufgP2+tUGObzeGgy8VNW053TUsz9LCG6P/T+i8axT6CNU6T6B60K7NsBwSGV8+0eocsC
         WnN3mbUQuFMivmFn+VdRgZ6pkw0lvOQfCXEAWt8kpYgQB56DQC9NfGhpkZr+eQROn8vx
         vRvS+2sChYqs6wNnRG+sOVu07rNsKBn4EoJoJgDoH7+0AlZ63/Kq8kuSmLjOXzcu1kzz
         cQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=F2EcZbJdqyu3yRwJqy2BOS3avdhsgrxrxJ+8nMADdLA=;
        b=kcqZytfZdUXZsStnBqWcPycBlUITVhQXB2XQ5RFi81AoJjQCiQn9HofBCWoF4LjPIT
         4oRcKdyImj/+BwPpiA5PlpnDHvqGPo1eGZ/lBmqQYo+XcRfXHMWVziqrqaXfxXXePftl
         TsKUnVdL0fhM8A100YqGODhV+ZKFMqGab3hEHR87mxE3exRmqKoPY+kqnimm8nsxTNTo
         WMNHnwEmuXwaZSEg7KBPa0sXde20heF+aOgBClRJrc6alRLWimdqXrFjSxew5+ctJRME
         kPL8t9ywAWd9nVTDF/kFLZvrDNv46bhnGC6tF58vVMWRopOYPp9iBVIu/USvpXV7WcdW
         aBhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,386,1515484800";
   d="scan'208";a="22764187"
Subject: Re: [PATCH v2 7/8] [PATCH 7/8] drivers/hwmon: Add a generic PECI
 hwmon client driver
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Guenter Roeck <linux@roeck-us.net>,
 joel@jms.id.au, andrew@aj.id.au, Arnd Bergmann <arnd@arndb.de>,
 Greg KH <gregkh@linuxfoundation.org>, jdelvare@suse.com,
 benh@kernel.crashing.org, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-8-jae.hyun.yoo@linux.intel.com>
 <20180221182608.GA11635@roeck-us.net>
 <618f34cd-ee43-d8e4-4fb0-3c23bf03835f@linux.intel.com>
 <20180221214859.GA30263@roeck-us.net>
 <576a50c6-c302-654c-ceb3-aaf820b7738a@linux.intel.com>
 <20180222003720.GA25250@lunn.ch>
 <b506b4b1-7e7d-abd6-bac2-c45e7c1e0aae@linux.intel.com>
 <CANiq72mjsfJRzfFmhbL7dnih_0=2pFoJDTrmi35x0yLmKrSBFA@mail.gmail.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <85f66284-2e18-2a74-1e7b-9378353ab43e@linux.intel.com>
Date: Sat, 24 Feb 2018 01:32:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CANiq72mjsfJRzfFmhbL7dnih_0=2pFoJDTrmi35x0yLmKrSBFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027891482896135?=
X-GMAIL-MSGID: =?utf-8?q?1593274299490551317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/23/2018 4:00 PM, Miguel Ojeda wrote:
> On Thu, Feb 22, 2018 at 2:29 AM, Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>> On 2/21/2018 4:37 PM, Andrew Lunn wrote:
>>>>
>>>> But even with this change, it still needs to use delayed creation
>>>> because BMC side kernel doesn't know how many DIMMs are populated on
>>>> a remote server before the remote server completes its memory
>>>> training and testing in BIOS, but it needs to check the remote
>>>> server's CPU temperature as immediate as possible to make
>>>> appropriate thermal control based on the remote CPU's temperature to
>>>> avoid any critical thermal issue. What would be a better solution in
>>>> this case?
>>>
>>>
>>> You could change this driver so that it supports one DIMM.  Move the
>>> 'hotplug' part into another driver which creates and destroys
>>> instances of the hwmon DIMM device as the DIMMS come and go.
>>>
>>> Also, do you need to handle CPU hotplug? You could split the CPU
>>> temperature part into a separate hwmon driver? And again create and
>>> destroy devices as CPUs come and go?
>>>
>>>          Andrew
>>>
>>
>> That seems like a possible option. I'll rewrite the hwmon driver again like
>> that.
>>
>> Thanks for the good idea. :)
> 
> By the way, in the rewrite, please try to avoid the create*workqueue()
> functions (they are deprecated :).
> 
> Cheers,
> Miguel
> 

Hi Miguel,

Thanks for letting me know that. I'll replace that with 
alloc_workqueue(). :)

Regards,
Jae

>>
>> Jae
