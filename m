Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbeEBIOD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:14:03 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7114 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750947AbeEBIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 04:14:00 -0400
Subject: Re: [PATCH 0/4] Add STM32 timers to stm32mp157c
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <robh+dt@kernel.org>
CC: <mcoquelin.stm32@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <4173223f-3790-2f53-8ed7-3d7fdecc0e76@st.com>
Date: Wed, 2 May 2018 10:13:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice,

On 04/17/2018 03:45 PM, Fabrice Gasnier wrote:
> This series adds support for STM32 timers to stm32mp157c. These
> timers can act PWM, trigger and/or encoder.
> Populate stm32mp157c SOC and ed1/ev1 boards.
> 
> Fabrice Gasnier (4):
>    ARM: dts: stm32: add timers support to stm32mp157c
>    ARM: dts: stm32: add PWM pins used on stm32mp157c-ev1 board
>    ARM: dts: stm32: add PWM and triggers on stm32mp157c-ev1 board
>    ARM: dts: stm32: enable timer trigger 6 on stm32mp157c-ed1
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi |  27 +++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts     |   7 +
>   arch/arm/boot/dts/stm32mp157c-ev1.dts     |  36 ++++
>   arch/arm/boot/dts/stm32mp157c.dtsi        | 283 ++++++++++++++++++++++++++++++
>   4 files changed, 353 insertions(+)
> 

Series applied on stm32-next.
Note that I modified pinctrl patch to fix DTC warnings when make W=12 is 
used.

Regards
Alex
