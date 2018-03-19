Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932608AbeCSKfN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:35:13 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38186 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932354AbeCSKfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:35:11 -0400
X-Google-Smtp-Source: AG47ELs00GvcOAjnhlHhbHDCQbdM4pZpqb+P2uvXY0XaegtwnGcbqhHzKJmBlexAVrfzn1jNMv0/pA==
Subject: Re: [PATCH v1 02/19] dt-bindings: cpufreq: mediatek: use - instead of
 _ in examples
To: Sean Wang <sean.wang@mediatek.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <fd1fc4c6760ab8fcbf7518df1cecf3837ab18d2c.1519378871.git.sean.wang@mediatek.com>
 <20180226041336.GJ26947@vireshk-i7> <1521427861.13211.8.camel@mtkswgap22>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <1eafba31-0d0b-89d9-fb66-c4ba5ca6b56f@gmail.com>
Date: Mon, 19 Mar 2018 11:35:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521427861.13211.8.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On 03/19/2018 03:51 AM, Sean Wang wrote:
> 
> Hi, Matthias
> 
> I'm worried you missed the patch which already got both tags Reviewed-by
> from Rob and Acked-by: Viresh and thus I thought it
> should be ready for your tree.
> 

Yes, sorry I missed this one. Fortunately it is not critical, can you please add
it to v2.

I suppose you realized that I didn't take any from 12/19 onwards, especially 14,
15 and 17, because they have many conflicts with previous patches in the series.

Sorry for the inconvenience.
Matthias

> For the other patches in the same series, I will have v2 to refine them
> according to these suggestions and comments in v1 and let them easy to
> review.
> 
> Really thanks for your effort!
> 	
> 	Sean
> 
> 
> On Mon, 2018-02-26 at 09:43 +0530, Viresh Kumar wrote:
>> On 23-02-18, 18:16, sean.wang@mediatek.com wrote:
>>> From: Sean Wang <sean.wang@mediatek.com>
>>>
>>> It should be good that no use "_" is in examples. Consequently,
>>> those nodes in certain files which have an inappropriate name containing
>>> "_" are all being replaced with "-".
>>>
>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: linux-pm@vger.kernel.org
>>> Cc: devicetree@vger.kernel.org
>>> ---
>>>  Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
>>> index d36f07e..38cfbb5 100644
>>> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
>>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
>>> @@ -26,7 +26,7 @@ Optional properties:
>>>  
>>>  Example 1 (MT7623 SoC):
>>>  
>>> -	cpu_opp_table: opp_table {
>>> +	cpu_opp_table: opp-table {
>>>  		compatible = "operating-points-v2";
>>>  		opp-shared;
>>>  
>>> @@ -86,7 +86,7 @@ Example 1 (MT7623 SoC):
>>>  	};
>>>  
>>>  Example 2 (MT8173 SoC):
>>> -	cpu_opp_table_a: opp_table_a {
>>> +	cpu_opp_table_a: opp-table-a {
>>>  		compatible = "operating-points-v2";
>>>  		opp-shared;
>>>  
>>> @@ -131,7 +131,7 @@ Example 2 (MT8173 SoC):
>>>  		};
>>>  	};
>>>  
>>> -	cpu_opp_table_b: opp_table_b {
>>> +	cpu_opp_table_b: opp-table-b {
>>>  		compatible = "operating-points-v2";
>>>  		opp-shared;
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
> 
> 
