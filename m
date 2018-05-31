Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755197AbeEaNau (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:30:50 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:21609 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755006AbeEaNaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:30:46 -0400
Subject: Re: [PATCH v2 3/6] clk: ti: dra7: Add clkctrl clock data for the mcan
 clocks
To: Faiz Abbas <faiz_abbas@ti.com>, Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <bcousson@baylibre.com>,
        <tony@atomide.com>, <paul@pwsan.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-4-faiz_abbas@ti.com>
 <20180531040350.GA25132@rob-hp-laptop>
 <e7e3ade1-76b7-f216-ece5-bd64a55cede6@ti.com>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <678ef467-a235-91db-8bae-f249ad98eac8@ti.com>
Date: Thu, 31 May 2018 16:29:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e7e3ade1-76b7-f216-ece5-bd64a55cede6@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/18 13:14, Faiz Abbas wrote:
> Hi,
> 
> On Thursday 31 May 2018 09:33 AM, Rob Herring wrote:
>> On Wed, May 30, 2018 at 07:41:30PM +0530, Faiz Abbas wrote:
>>> Add clkctrl data for the m_can clocks and register it within the
> ...
>>>   
>>> diff --git a/include/dt-bindings/clock/dra7.h b/include/dt-bindings/clock/dra7.h
>>> index 5e1061b15aed..d7549c57cac3 100644
>>> --- a/include/dt-bindings/clock/dra7.h
>>> +++ b/include/dt-bindings/clock/dra7.h
>>> @@ -168,5 +168,6 @@
>>>   #define DRA7_COUNTER_32K_CLKCTRL	DRA7_CLKCTRL_INDEX(0x50)
>>>   #define DRA7_UART10_CLKCTRL	DRA7_CLKCTRL_INDEX(0x80)
>>>   #define DRA7_DCAN1_CLKCTRL	DRA7_CLKCTRL_INDEX(0x88)
>>> +#define DRA7_ADC_CLKCTRL	DRA7_CLKCTRL_INDEX(0xa0)
>>
>> ADC and mcan are the same thing?
>>
> 
> The register to control MCAN clocks is called ADC_CLKCTRL, Yes.

Is there any reason for this or is that just a documentation bug?

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
