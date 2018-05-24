Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033883AbeEXQmb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:42:31 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:45010 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033869AbeEXQmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:42:25 -0400
X-Google-Smtp-Source: ADUXVKLlCGvHFkBmoozh5xGirdic0rEtFSRQR2Yi+Y224SBprV/rlnnaAO8KPNPdqqmSOPfURidZ+Q==
Subject: Re: [PATCH v3 2/6] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
 <1527120924-12131-3-git-send-email-ray.jui@broadcom.com>
 <20180524161628.GA28425@roeck-us.net>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <621dc488-2d8d-003b-9bd1-4de59e8d178b@broadcom.com>
Date: Thu, 24 May 2018 09:42:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180524161628.GA28425@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/2018 9:16 AM, Guenter Roeck wrote:
> On Wed, May 23, 2018 at 05:15:20PM -0700, Ray Jui wrote:
>> Update the SP805 binding document to add optional 'timeout-sec'
>> devicetree property
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>   Documentation/devicetree/bindings/watchdog/arm,sp805.txt | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
>> index 0fa3629..1debea3 100644
>> --- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
>> @@ -19,6 +19,8 @@ Required properties:
>>   
>>   Optional properties:
>>   - interrupts:  Should specify WDT interrupt number
>> +- timeout-sec: Should specify default WDT timeout in seconds. If unset, the
>> +               default timeout in the driver is 30 seconds
> 
> "... the default timeout is determined by the driver" might be better.
> If you want to mandate a default here (not sure if that is a good idea),
> I would suggest to use something like "should be 30 seconds".
> 

Okay. This can be changed to:

- timeout-sec: Should specify default WDT timeout in seconds. If unset, 
the default timeout is determined by the driver.

Please advise how to proceed with this patch series. Should I make the 
above modification and send out v4?

Thanks,

Ray

> Guenter
> 
>>   
>>   Example:
>>   	watchdog@66090000 {
>> -- 
>> 2.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
