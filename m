Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966740AbeCSQ3H convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:29:07 -0400
Received: from mx6-out9.antispamcloud.com ([95.211.2.200]:55132 "EHLO
        mx6-out9.antispamcloud.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935571AbeCSQ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:28:59 -0400
Subject: Re: [PATCH v2] clk: Add driver for the si544 clock generator chip
To: Rob Herring <robh@kernel.org>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mark.rutland@arm.com>
References: <1521114608-21967-1-git-send-email-mike.looijmans@topic.nl>
 <20180318125219.ar7f2n4o73ljz6vg@rob-hp-laptop>
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <ec813ab3-88db-f6e3-eca1-b6ea58936fcf@topic.nl>
Date: Mon, 19 Mar 2018 16:04:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318125219.ar7f2n4o73ljz6vg@rob-hp-laptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: nl
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.80.121]
X-EXCLAIMER-MD-CONFIG: 9833cda7-5b21-4d34-9a38-8d025ddc3664
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
X-Originating-IP: 37.74.225.130
X-AntiSpamCloud-Domain: topic.nl
X-AntiSpamCloud-Username: 37.74.225.128/28
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=37.74.225.128/28@topic.nl
X-AntiSpamCloud-Outgoing-Class: ham
X-AntiSpamCloud-Outgoing-Evidence: SB/global_tokens (0.000210644130688)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5mMsCjyfurGK2PdbX9vo6iB602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOyT6qQhyPysRyBbUpsI8+UW3wL2Y4F0412ezGCyTUPan9zxD2r/TT39QhQuyJVSuUuNf
 vx/q3++EaOm0N9CoCHAdi2dtActm1pKPAAGnfdVyFYjqGcduWsR2an5Tkt8sHrfAvZjgXTjXZ7MY
 LJNQ9qejNBII+vIaxXscrtB35ylqKCb5mY0EJnkFodh75TOLwYQmAExtOTlY4TKB7k9w6rBYklIw
 NX6vPAu/I6kadlESS0FJF63PATL2eVHcS04DFmW5aEUGlRAKkDTqUH8H5TYEybI1sOftHmSKUCHC
 vcq0WQSODLaUhqVPVuBXQbUHrHxdmlfnhc2hWsjMoO+oxu6C9hO8yoca1J6zrwwtjs2PngJrG8Wg
 EqPaRf61WE+WQRr8SA2vFOphlp8UufB8gBiER0q90k9DQXC8Dp5Id4Jj1+w96/ss2n9PRXrBw2Il
 YfpluiiwIYYOt3H/IYSfrpFB/34O7sxKUrBQvgd/Mamd0xd9MggXQtIaBiGHzQH0GDfg9brmLwXl
 8fIYT1bRgSysVXXC8WXkg5R422zSuwOnZAHYSttyJwNs842uSNa4gwg6hKizad7L277hVYvshgtW
 PpBEjAKIA5MrjslzZiV51jgE075xvkFAnH60rOhWXGeknlV1Y4QKG1WCieNIW7LymM4V+dYvw3zg
 aX5MC+SYJ1qbadBb7YK3saylCalNJ/vg7iEFLP+SSY+Av5+AiC4EcfqLV9rmhtsb31R+nay0V37I
 2wpa/IVZ7M3zf6gVhzDx6KdSjKEeMNkjHEzjTuGppVvochjlYEOF3QQxD2+cbYViXAwKwUC5UPs5
 uH9Zr8fzMXVnayifunuDrHJ06nvTPpuFqUUQz+mM8JAD4ECWWepWvfi9+HHnlQ2/Rn/4F/9stbTq
 6V3abI6HsEHgu+KYmE2vBW6B6hgdy12C7FG77gcTn1IjCFWox3KYXqAoEMoS6VqYuV6oyjW8GweE
 5fx+pvlHhV6a5QjptwQBGybQ9yRJbq9yGGylU1WsakaemzVcu3hBExkVDzi0JOySLJOyCPvsemEk
 kH79p+0yeA3tZJ0Q4x+0GOxZvoENDONKwbWpcv7j2jxrOCLgGCCA554G/lrsafr8iMGmCVMTlGtV
 cGrPtNGJYX3VT+yZ12sm8Q==
X-Report-Abuse-To: spam@quarantine2.antispamcloud.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

﻿On 18-03-18 13:52, Rob Herring wrote:
> On Thu, Mar 15, 2018 at 12:50:08PM +0100, Mike Looijmans wrote:
>> This patch adds the driver and devicetree documentation for the
>> Silicon Labs SI544 clock generator chip. This is an I2C controlled
>> oscillator capable of generating clock signals ranging from 200kHz
>> to 1500MHz.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>> v2: Add u64 cast to ls_div_bits calculation loop
>>      When ls_div_bits is non-zero, the hs_div must always be even
>>
>>   .../devicetree/bindings/clock/silabs,si544.txt     |  25 ++
>>   drivers/clk/Kconfig                                |  10 +
>>   drivers/clk/Makefile                               |   1 +
>>   drivers/clk/clk-si544.c                            | 422 +++++++++++++++++++++
>>   4 files changed, 458 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/silabs,si544.txt
>>   create mode 100644 drivers/clk/clk-si544.c
>>
>> diff --git a/Documentation/devicetree/bindings/clock/silabs,si544.txt b/Documentation/devicetree/bindings/clock/silabs,si544.txt
>> new file mode 100644
>> index 0000000..eec1787
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/silabs,si544.txt
>> @@ -0,0 +1,25 @@
>> +Binding for Silicon Labs 544 programmable I2C clock generator.
>> +
>> +Reference
>> +This binding uses the common clock binding[1]. Details about the device can be
>> +found in the datasheet[2].
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +[2] Si544 datasheet
>> +    https://www.silabs.com/documents/public/data-sheets/si544-datasheet.pdf
>> +
>> +Required properties:
>> + - compatible: One of "silabs,si514a", "silabs,si514b" "silabs,si514c" according
>> +               to the speed grade of the chip.
>> + - reg: I2C device address.
>> + - #clock-cells: From common clock bindings: Shall be 0.
>> +
>> +Optional properties:
>> + - clock-output-names: From common clock bindings. Recommended to be "si544".
> 
> What's the point if there is only 1 clock output?

I have a board with 6 of these chips, and the clock registration fails if they 
don't have unique names. Providing a clock-output-names property was the 
easiest way around it.

Should I just omit the line or change the wording to reflect the above or is 
there a better solution (maybe I can use the DT node name as clock name in the 
driver, will look into that)

> 
>> +
>> +Example:
>> +	si544: clock-generator@55 {
> 
> clock-controller@55 is the standard node name.

I'll change and post patch v3

> 
>> +		reg = <0x55>;
>> +		#clock-cells = <0>;
>> +		compatible = "silabs,si544b";
>> +	};
> 
> Otherwise, for the binding:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 



Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
