Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933154AbeCEIoQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:44:16 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53923 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932681AbeCEIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:44:13 -0500
Subject: Re: [PATCH v2 0/6] Add mmc support for STM32F7 boards
To: <patrice.chotard@st.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lee.jones@linaro.org>
CC: <mcoquelin.stm32@gmail.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <44ed2e2c-83f1-77f5-fa70-29c5525b9ee7@st.com>
Date: Mon, 5 Mar 2018 09:43:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrice,

On 03/01/2018 11:53 AM, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> This series adds :
>   _ SDIO pins definition for STM32F7 SoCs family
>   _ add sdio1 DT entry for STM32F746 Discovery board
>   _ add sdio1 DT entry for STM32F746 Evaluation board
>   _ add sdio1 DT entry for STM32F769 Discovery board
>   _ add SDMMC2 entry in stm32f7-rcc.h
>   _ replace sdio2 hard coded value in stm32f746.dtsi
> 
> v2: _ rename sdio_pins / sdio_od_pins to sdio_pins_a / sdio_od_pins_a
>        and update board dts files accordingly.
> 
> 
> Patrice Chotard (6):
>    ARM: dts: stm32: Add sdio pins definition for stm32f7
>    ARM: dts: stm32: Enable sdio1 for stm32f746-disco
>    ARM: dts: stm32: Enable sdio1 for stm32f746-eval
>    ARM: dts: stm32: Enable sdio1 for stm32f769-disco
>    dt-bindings: mfd: Add STM32F7 SDMMC2 rcc entry
>    ARM: dts: stm32: Fix sdio2 rcc hard coded value
> 
>   arch/arm/boot/dts/stm32746g-eval.dts   | 17 ++++++++++
>   arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 62 ++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32f746-disco.dts  | 19 +++++++++++
>   arch/arm/boot/dts/stm32f746.dtsi       |  2 +-
>   arch/arm/boot/dts/stm32f769-disco.dts  | 19 +++++++++++
>   include/dt-bindings/mfd/stm32f7-rcc.h  |  1 +
>   6 files changed, 119 insertions(+), 1 deletion(-)
> 
Series applied on stm32-next.

Regards
Alex
