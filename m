Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeCGJLc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 04:11:32 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33447 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751036AbeCGJL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 04:11:29 -0500
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Lee Jones <lee.jones@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 0/6] Add mmc support for STM32F7 boards
Thread-Topic: [PATCH v2 0/6] Add mmc support for STM32F7 boards
Thread-Index: AQHTsUuS+UqUKF3X2UiZlq/99s8mF6PBSM6AgAMiYoCAAAnkgA==
Date: Wed, 7 Mar 2018 09:11:03 +0000
Message-ID: <f006750d-1fa9-4bbf-8f4d-32abee21cadd@st.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
 <44ed2e2c-83f1-77f5-fa70-29c5525b9ee7@st.com>
 <20180307083538.vicxhbu72jex7zi6@dell>
In-Reply-To: <20180307083538.vicxhbu72jex7zi6@dell>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BECE1318239103438E1B695E8C20C3AE@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w279BZPr004605

Hi Lee

On 03/07/2018 09:35 AM, Lee Jones wrote:
> On Mon, 05 Mar 2018, Alexandre Torgue wrote:
> 
>> Hi Patrice,
>>
>> On 03/01/2018 11:53 AM, patrice.chotard@st.com wrote:
>>> From: Patrice Chotard <patrice.chotard@st.com>
>>>
>>> This series adds :
>>>    _ SDIO pins definition for STM32F7 SoCs family
>>>    _ add sdio1 DT entry for STM32F746 Discovery board
>>>    _ add sdio1 DT entry for STM32F746 Evaluation board
>>>    _ add sdio1 DT entry for STM32F769 Discovery board
>>>    _ add SDMMC2 entry in stm32f7-rcc.h
>>>    _ replace sdio2 hard coded value in stm32f746.dtsi
>>>
>>> v2: _ rename sdio_pins / sdio_od_pins to sdio_pins_a / sdio_od_pins_a
>>>         and update board dts files accordingly.
>>>
>>>
>>> Patrice Chotard (6):
>>>     ARM: dts: stm32: Add sdio pins definition for stm32f7
>>>     ARM: dts: stm32: Enable sdio1 for stm32f746-disco
>>>     ARM: dts: stm32: Enable sdio1 for stm32f746-eval
>>>     ARM: dts: stm32: Enable sdio1 for stm32f769-disco
>>>     dt-bindings: mfd: Add STM32F7 SDMMC2 rcc entry
>>>     ARM: dts: stm32: Fix sdio2 rcc hard coded value
>>>
>>>    arch/arm/boot/dts/stm32746g-eval.dts   | 17 ++++++++++
>>>    arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 62 ++++++++++++++++++++++++++++++++++
>>>    arch/arm/boot/dts/stm32f746-disco.dts  | 19 +++++++++++
>>>    arch/arm/boot/dts/stm32f746.dtsi       |  2 +-
>>>    arch/arm/boot/dts/stm32f769-disco.dts  | 19 +++++++++++
>>>    include/dt-bindings/mfd/stm32f7-rcc.h  |  1 +
>>>    6 files changed, 119 insertions(+), 1 deletion(-)
>>>
>> Series applied on stm32-next.
> 
> Even the MFD patch?
> 

Yes, the MFD part has been taken by Alex.

Patrice
