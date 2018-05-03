Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeECWMy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 18:12:54 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43222 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeECWMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 18:12:53 -0400
X-Google-Smtp-Source: AB8JxZqVvOHixhYLcbQiFS7XZz6PAUJ9/LwsHI+KSY3gaYmlqC9DvNqLUdthB/L3/75YlO1Hx0TsuCUmHHq/aSgGMbw=
MIME-Version: 1.0
In-Reply-To: <cc934eb9-f9e4-3c52-7f38-413a1b63fce2@st.com>
References: <1525274696-11968-1-git-send-email-fabrice.gasnier@st.com> <cc934eb9-f9e4-3c52-7f38-413a1b63fce2@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 3 May 2018 18:12:52 -0400
X-Google-Sender-Auth: HLKuvIVu09uPjk83pX8jIaxkVTo
Message-ID: <CAK8P3a0maxno4S-dXoT1O5zp3NgHP2LWuGhtVoqFMMEv-tm07Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable STM32 analog & timer drivers
To: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 10:05 AM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> Hi Fabrice,
>
> On 05/02/2018 05:24 PM, Fabrice Gasnier wrote:
>>
>> This enables drivers for STM32 timer, low power timer and analog hardware
>> that can be used on STM32MP1 SoC:
>> - Timer & LP Timer MFD core, PWM, trigger & encoder drivers
>> - IIO ADC/DAC/DFSDM
>> - vrefbuf regu driver (voltage reference buffer).
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>   arch/arm/configs/multi_v7_defconfig | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>
> Applied on stm32-next.
>
> Arnd,
> Do you agree if I take multi_v7_defconfig related patches in my stm32 pull
> requests ?

Yes, just make sure that all drivers that can reasonably be loadable
modules are configured that way rather than as built-in, so a defconfig
build doesn't become too big.

       Arnd
