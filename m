Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeCTQJm convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:09:42 -0400
Received: from mx6-out12.antispamcloud.com ([95.211.2.203]:60452 "EHLO
        mx6-out12.antispamcloud.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750991AbeCTQJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:09:36 -0400
Subject: Re: [PATCH v2] clk: Add driver for the si544 clock generator chip
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <mark.rutland@arm.com>
References: <1521114608-21967-1-git-send-email-mike.looijmans@topic.nl>
 <20180318125219.ar7f2n4o73ljz6vg@rob-hp-laptop>
 <ec813ab3-88db-f6e3-eca1-b6ea58936fcf@topic.nl>
 <152149373621.242365.4815290210815209160@swboyd.mtv.corp.google.com>
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <f25eb71c-efd9-f842-1a98-76c86b03a34a@topic.nl>
Date: Tue, 20 Mar 2018 08:15:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152149373621.242365.4815290210815209160@swboyd.mtv.corp.google.com>
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
X-AntiSpamCloud-Outgoing-Evidence: SB/global_tokens (0.00186813345452)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5igHSQsGAuHmztjbPM+z1GZ602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOySBiUVAo7M+WU0lEyRRks5TYi2bf0F0JzgUQ/o6tR7CqzWZcG3+8VDA+u9tO7Q9ThGo
 SHui8jrsxBy73VfBjyHd9zket87YkZhSuW+FByytHYsgUaCH9CJeM/EHUClzDfOX9X6VTmkHaMQE
 iPBJZEo88NSOR4kX7juDHxfqL3yvWJJSMDV+rzwLvyOpGnZREkrg4emgNvFUYuEJbq27C6RLn/nj
 N5eSj526f3kLYY1TlmB3D9Os16slzqI0SUuM5O100ESNyDHK94FBrDb2uP8EybI1sOftHmSKUCHC
 vcq0WQSODLaUhqVPVuBXQbUHrGoAf614mmPaiDcqTnM3XcD/njnbw9qNrr4SBGbAD4axdMPVq96i
 2WCiml3f86Qj697pGo89PvllAFUxz4uLrVuJt5FxcU9zxyqQvC+ErY55gfF+W0yJJnzcYL6x+8K5
 vrmXL8rNdlxvESmUUBjYdbgxTcKP6wm5LuZTl5BXKnyr4lGmqQl/1K2vOw5WI7Qnpb4jLSEpMa7P
 s2JknfPsiZoEkC4p6ub0lMDXu5jHKgmeLKPFRdvGVz6FathkOrvSVdrtItr3uBzqAPuBJFUGX0Sk
 jNGSztCKJQCzw949hTosmCP4WV3nCh+GGC4GXSn5HxkDJRaaICR2rDamAVeZMV4D7fKzXHKOS7ep
 Lutw5JLMWWsJPa2dD9/5mA8B+sM44BqZR3KVQgqF/fPYYAfEfsjduO2NWkKs32LwYBA/cs216yYB
 Vn2d3CMXlDDkZyVJzBdx4vA/Ax59LItxve3I+Zr50GUDEX74d9BKJ9EQBUuHXOWTNe7V3DRZwGi/
 g5L8wOJFcTvhKYpNUmbSRVyXNgb3Y80OmAux3oN13+ztUznekDQ2/c1nWGbAfmLn55lXtfVy/32k
 9Xczl/Hb5pY7z0SfXZhoGQBtnNteePnkImg5MJSSfS+9CiY42UnlGJDOq8Q7CUn5JHVrOcliIN5E
 Rsw3ClTXlSfQV8rvfnHgqk4U8ar4sO9kYmr7/nmchPR9G7oNEkr9G9yb/CAxYzNOLUSwmMLQUkMT
 udtuP9IAptb98t3Xj/LzZ5s/OJg1L2asZ6HO21dPpxPhMFfON8bpbNepD69fIbA0MjJYCR9epGql
 9jihx+Za/cV70jOJzN2r4A==
X-Report-Abuse-To: spam@quarantine2.antispamcloud.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

﻿On 19-03-18 22:08, Stephen Boyd wrote:
> Quoting Mike Looijmans (2018-03-19 08:04:15)
>> On 18-03-18 13:52, Rob Herring wrote:
>>> On Thu, Mar 15, 2018 at 12:50:08PM +0100, Mike Looijmans wrote:
>>>> +Required properties:
>>>> + - compatible: One of "silabs,si514a", "silabs,si514b" "silabs,si514c" according
>>>> +               to the speed grade of the chip.
>>>> + - reg: I2C device address.
>>>> + - #clock-cells: From common clock bindings: Shall be 0.
>>>> +
>>>> +Optional properties:
>>>> + - clock-output-names: From common clock bindings. Recommended to be "si544".
>>>
>>> What's the point if there is only 1 clock output?
>>
>> I have a board with 6 of these chips, and the clock registration fails if they
>> don't have unique names. Providing a clock-output-names property was the
>> easiest way around it.
>>
>> Should I just omit the line or change the wording to reflect the above or is
>> there a better solution (maybe I can use the DT node name as clock name in the
>> driver, will look into that)
> 
> I would leave clock-output-names for now. One day we can get off of
> strings in CCF. Soon perhaps.
> 
>>
>>>
>>>> +
>>>> +Example:
>>>> +    si544: clock-generator@55 {
>>>
>>> clock-controller@55 is the standard node name.
>>
>> I'll change and post patch v3
>>
> 
> I made some comments on v1. Please fold those into v3.


Thanks, found them on patchwork, somehow they didn't end up in my mailbox.

Comments are clear, will incorporate them, I only have trouble with your 
remark on the DT documentation "Can this reference stuff go to the bottom of 
this document?". I copied the style from the other documents in the same 
directory, I'm slightly puzzled about where the reference part should go now.



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
