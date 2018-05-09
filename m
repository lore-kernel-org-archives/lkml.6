Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965159AbeEIUKs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 16:10:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52755 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934932AbeEIUKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 16:10:45 -0400
X-Google-Smtp-Source: AB8JxZpIdP6qb447LhFJaDcG6LWjpezeATDIdskit84XbBdw5h+9t4TkNMdIhbgu7aXGhWF0iCqj1g==
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: Add SC27xx breathing light
 controller documentation
To: Pavel Machek <pavel@ucw.cz>, Baolin Wang <baolin.wang@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, xiaotong.lu@spreadtrum.com,
        broonie@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f393ca5a99059e7086307b99fc435777fe09018b.1525757122.git.baolin.wang@linaro.org>
 <20180509142526.GA25131@amd>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <c7e433a2-f7cf-c748-4fb8-209bfb245573@gmail.com>
Date: Wed, 9 May 2018 22:09:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509142526.GA25131@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2018 04:25 PM, Pavel Machek wrote:
> Hi!
> 
>> This patch adds the binding documentation for Spreadtrum SC27xx series
>> breathing light controller, which supports 3 outputs: red LED, green
>> LED and blue LED.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes since v1:
>>   - Change the compatible string to be one explicit SoC name.
>>   - Change the child node name.
>>   - Change to be upper case for the first character.
>> ---
>>   .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  |   41 ++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
>> new file mode 100644
>> index 0000000..b3de7fc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
>> @@ -0,0 +1,41 @@
>> +LEDs connected to Spreadtrum SC27XX PMIC breathing light controller
>> +
>> +The SC27xx breathing light controller supports to 3 outputs:
>> +red LED, green LED and blue LED. Each LED can work at normal
>> +PWM mode or breath light mode.
> 
>> +Required properties:
>> +- compatible: Should be "sprd,sc2731-bltc".
> 
> If this is for 2731, I'd say so in the title and the filename...?

Not necessarily, since apparently it is possible that other compatibles
might be added to it in the future.

> 
>> +- #address-cells: Must be 1.
>> +- #size-cells: Must be 0.
>> +- reg: Specify controller address.
> 
> the controller...
> 
>> +Required child properties:
>> +- reg: Number of LED line (could be from 0 to 2).
> 
> Uff. "Port this LED is connected to"?
> 
> With that fixed...
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> 									Pavel
> 

-- 
Best regards,
Jacek Anaszewski
