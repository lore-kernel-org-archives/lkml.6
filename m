Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeEDHnA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:43:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20846 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750707AbeEDHm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:42:59 -0400
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable STM32 analog & timer
 drivers
To: Arnd Bergmann <arnd@arndb.de>
CC: Fabrice Gasnier <fabrice.gasnier@st.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1525274696-11968-1-git-send-email-fabrice.gasnier@st.com>
 <cc934eb9-f9e4-3c52-7f38-413a1b63fce2@st.com>
 <CAK8P3a0maxno4S-dXoT1O5zp3NgHP2LWuGhtVoqFMMEv-tm07Q@mail.gmail.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <84f8b1bf-d6df-ca0e-cb3f-e5b7f7ded14b@st.com>
Date: Fri, 4 May 2018 09:42:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0maxno4S-dXoT1O5zp3NgHP2LWuGhtVoqFMMEv-tm07Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2018 12:12 AM, Arnd Bergmann wrote:
> On Thu, May 3, 2018 at 10:05 AM, Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>> Hi Fabrice,
>>
>> On 05/02/2018 05:24 PM, Fabrice Gasnier wrote:
>>>
>>> This enables drivers for STM32 timer, low power timer and analog hardware
>>> that can be used on STM32MP1 SoC:
>>> - Timer & LP Timer MFD core, PWM, trigger & encoder drivers
>>> - IIO ADC/DAC/DFSDM
>>> - vrefbuf regu driver (voltage reference buffer).
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>> ---
>>>    arch/arm/configs/multi_v7_defconfig | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>
>> Applied on stm32-next.
>>
>> Arnd,
>> Do you agree if I take multi_v7_defconfig related patches in my stm32 pull
>> requests ?
> 
> Yes, just make sure that all drivers that can reasonably be loadable
> modules are configured that way rather than as built-in, so a defconfig
> build doesn't become too big.

Ok. You're right, this drivers could be configured as module. We just 
need to verify impact before send it.

Regards
alex

> 
>         Arnd
> 
