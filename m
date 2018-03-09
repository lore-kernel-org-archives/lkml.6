Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AG47ELug48444LK/eAJE3AibhdWDJhcdy7eGiPJwVymLJj5Uvz9VJ0kVoHfxblJS8OlRKohO+kxn
ARC-Seal: i=1; a=rsa-sha256; t=1520639222; cv=none;
        d=google.com; s=arc-20160816;
        b=e2zgz/ShvQ8yLOI0TKnI0QaTkqjSn8Tr4Exy8UZMMvt48Os/uqV5Fsd8Ts3yROJqoB
         JiJnvaEdnsFU3Nrl5uQIkOR2HWhRe4Uhx824gj/gyevUYQd9IfTAPB8aIClSg/PEHk51
         AGK3wxYWIYc9EYl93Jkz/7HcAIKnsPh+gJ59uTftSb6IEjvWG/w7cMO3lP8YJuJth4HS
         m6GfYi6/X7RLiEUBl0HTFjTazKV3KghpC77xwlzDPECLmIBDRZ9+vjjJHOVdv+v+MDA2
         d9HME2rHw7mTXp6EBWJDU9tYjFEKK8oaOTK4kgxyw3X23XybMq3E6hJJHGEbhaGjlYzN
         8VXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=chq3r8shNq+28g8h+sdrplxvXAQNmt5AfepXsBwxiFo=;
        b=Tan6B3efjGVWvDNVxNdIMBMR47Zw4sPGE+gfAgMPPHj1DwLw7OpMNgFbMA7PNapMsK
         WHCZ05yU1XhTScmtYsi9kdatEEA9x58woWtWe2aGCZ/zqzTCnZuZUkt5hJ6blXh8oPBt
         TKfqUMmE4RtiVScQvb74zRc+efIfLW+PwdV7Gh4/+n0bPbXm3cJixTcAYboeCaoukaeO
         LE9fAUx0va1I/o/CjW+tLHaH1B6P6p+Fd46XV4YGUfT/L24mxO/gXmm2vSn0KRymeljq
         I64GdTkC3yHNatrUUc4Gb3ez7wZfCHjxRwZgsFJXSpR6IZbPkSQKticpJXREr/FVRarT
         Thgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,448,1515484800";
   d="scan'208";a="32702695"
Subject: Re: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
To: Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-hwmon@vger.kernel.org, andrew@lunn.ch, jdelvare@suse.com,
 arnd@arndb.de, linux-doc@vger.kernel.org, andrew@aj.id.au,
 gregkh@linuxfoundation.org, openbmc@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux@roeck-us.net, linux-arm-kernel@lists.infradead.org
References: <20180307221124.GD10438@amd>
 <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
 <20180306124002.GA13950@amd>
 <33bf6563-b220-7ff9-8b04-84e9bd781b3f@linux.intel.com>
 <OF08D8261E.8F72E5DC-ON0025824B.008218BB-0025824B.008218C6@notes.na.collabserv.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <ed44999b-c877-463e-3a20-415faaab31b2@linux.intel.com>
Date: Fri, 9 Mar 2018 15:47:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <OF08D8261E.8F72E5DC-ON0025824B.008218BB-0025824B.008218C6@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027883264098537?=
X-GMAIL-MSGID: =?utf-8?q?1594505793014423459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Milton,

Thanks for sharing your time to review this patch. Please see my answer 
inline.

Jae

On 3/9/2018 3:41 PM, Milton Miller II wrote:
> About  03/07/2018 04:12PM in some time zone, Pavel Machek wrote:
>> Subject: Re: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings:
>> Add a document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
>>
>> Hi!
>>
>>>> Are these SoCs x86-based?
>>>
>>> Yes, these are ARM SoCs. Please see Andrew's answer as well.
>>
>> Understood, thanks.
>>
>>>>> +	Read sampling point selection. The whole period of a bit time
>> will be
>>>>> +	divided into 16 time frames. This value will determine which
>> time frame
>>>>> +	this controller will sample PECI signal for data read back.
>> Usually in
>>>>> +	the middle of a bit time is the best.
>>>>
>>>> English? "This value will determine when this controller"?
>>>>
>>>
>>> Could I change it like below?:
>>>
>>> "This value will determine in which time frame this controller
>> samples PECI
>>> signal for data read back"
>>
>> I guess... I'm not native speaker, I guess this could be improved
>> some
>> more.
>>
> 
> I agree this wording is still confusing.
> 
> The problem is that the key subject, the time of the sampling, is in the descriptive clause "in which time frame".
> 
> "This value will determine the time frame in which the controller will sample"
> 
> or perhaps phrase it as saving a specific sample from the over-clock, or a phase of the clock.
> 

Yes, that looks more better. I'll change the wording as you suggested. 
Thanks a lot!

Jae

>> Best regards,
>> 									Pavel
>>
>> -- 
>> (english) http://www.livejournal.com/~pavelmachek
>> (cesky, pictures)
>> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>>
> 
> milton
> --
> Speaking for myself not IBM.
> 
