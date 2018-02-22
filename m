Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x2266pCVlpny46ESAxe+WhZnl432hCBPGryCoWftxsdatWjBmnal4BqI0t+oqidiQ6RbHuV9y
ARC-Seal: i=1; a=rsa-sha256; t=1519320049; cv=none;
        d=google.com; s=arc-20160816;
        b=vkU3R2GH9diZVFwJysbQ/eNVqFrUPGGZpcVCOL4w/YqEBDADlF4OWGvCRDS/NIeeLe
         R5tnPBXfzuj9Sa7jcgfJM26v/OHzFBt13JOYeFDqUFU856YZfbDXOf05zzEU2MY7Fa48
         FC5fAnPy3VmTZOyFgrn6h81U4/yoiPbxMK7fa+wxnf9FM8BQfr/2CLvigOj3NAcv1XVZ
         1Krvs2mDZp+buRVJZoR9GNsr354zSJhgG4aOKg8T5nOOGg7F2uaIVJAZS9iwYE0lToM+
         rozpB/kdCdNTpD/J+wMSg60BnlD/4V4RjVNhPiRcml1nLehfdIBWiDsmR0TyAIq3jfBm
         Uxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=UBtP9GyjEOIzZkSrvk6+T6x6FzdTRH3NSNji5SkC95s=;
        b=F20JUFBPgh99NTqnHUdZU3uYCKgkg0q2xyiclxN/Hcqd8Sd1kIJTvoahFaHNtLQV2v
         H92TvMNE5OjGhwxfgzdetUPO5C6A6xOK8J4BlVdKdlIcfm4Dk4Ry5tuIug2v25z4HZmz
         Pf72DMwpPLm/9TitoYeQA2AUyRrrdB5PaqVFO0k8sbllKvHl7lR5AU4lAYpi99FZXwdT
         QZ3dAL0Dpr6PIKYsBrZFjxjozF0OT36zZD0g63KHGWlUnVszTktDu4MKRMyIA1Jd0hT/
         rk+1doGLAGRS3xTB1bCvlyMoAWRTWeXM+9UGigoM60chfqvLmNnLG9ufoy6a/5VjC8Lj
         z/+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,378,1515484800";
   d="scan'208";a="32799172"
Subject: Re: [PATCH v2 1/8] [PATCH 1/8] drivers/peci: Add support for PECI bus
 driver core
To: Greg KH <gregkh@linuxfoundation.org>
Cc: joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de, jdelvare@suse.com,
 linux@roeck-us.net, benh@kernel.crashing.org, andrew@lunn.ch,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
 <20180221175853.GA22320@kroah.com>
 <7f152459-a232-e62a-3c34-e995f8c85d63@linux.intel.com>
 <20180222065455.GA2428@kroah.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <9bd825f4-8497-4e2a-b8ea-56888df754e7@linux.intel.com>
Date: Thu, 22 Feb 2018 09:20:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180222065455.GA2428@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027882449244386?=
X-GMAIL-MSGID: =?utf-8?q?1593122539746543427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/21/2018 10:54 PM, Greg KH wrote:
> On Wed, Feb 21, 2018 at 12:42:30PM -0800, Jae Hyun Yoo wrote:
>> On 2/21/2018 9:58 AM, Greg KH wrote:
>>> On Wed, Feb 21, 2018 at 08:15:59AM -0800, Jae Hyun Yoo wrote:
>>>> This commit adds driver implementation for PECI bus into linux
>>>> driver framework.
>>>>
>>>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>>> ---
>>>
>>> Why is there no other Intel developers willing to review and sign off on
>>> this patch?  Please get their review first before asking us to do their
>>> work for them :)
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>
>> Hi Greg,
>>
>> This patch set got our internal review process. Sorry if it's code quality
>> is under your expectation but it's the reason why I'm asking you to review
>> the code. Could you please share your time to review it?
> 
> Nope.  If no other Intel developer thinks it is good enough to put their
> name on it as part of their review process, why should I?
> 
> Again, please use the resources you have, to fix the obvious problems in
> your code, BEFORE asking the community to do that work for you.
> 
> greg k-h
> 

Okay. I'll take our internal review process again on this patch set and 
collect more credit tags before submitting v3.

Thanks for your advice!

Jae
