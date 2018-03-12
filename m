Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeCLIer (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:34:47 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10122 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750794AbeCLIeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:34:44 -0400
From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC: Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gabriel.fernandez.st@gmail.com" <gabriel.fernandez.st@gmail.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "Olivier BIDEAU" <olivier.bideau@st.com>
Subject: Re: [PATCH v2 00/12] Introduce STM32MP1 clock driver
Thread-Topic: [PATCH v2 00/12] Introduce STM32MP1 clock driver
Thread-Index: AQHTtv4XbPdmUfXEv0KASP6AaV1l2qPLlcKAgAClSIA=
Date: Mon, 12 Mar 2018 08:34:11 +0000
Message-ID: <13f327c2-5777-8425-9611-b9ef96f9d185@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
 <1520808064.5otv3fo1pe.astroid@resonance.none>
In-Reply-To: <1520808064.5otv3fo1pe.astroid@resonance.none>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <89D1CC6CE5D1014DBF8EA79E13E714BF@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2C8YrvQ032335

Many Thanks Mike !

Best Regards

Gabriel.


On 03/11/2018 11:42 PM, Michael Turquette wrote:
> Excerpts from gabriel.fernandez@st.com's message of March 8, 2018 8:53 
> am:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> v2:
>>   - Don't use MFD, use existing binding of STM32 RCC.
>>   - Rework Peripheral and Kernel clocks
>>   - cosmetic changes
>>
>> This patch-set introduces clock driver for STM32MP157 based on Arm 
>> Cortex-A7.
>> The driver patch is split in several patches (by kind of clock) to 
>> facilitate
>> code reviewing.
>
> Applied to clk-stm32mp1 towards v4.17.
>
> Regards,
> Mike
>
>>
>> Gabriel Fernandez (12):
>>   dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings
>>   clk: stm32mp1: Introduce STM32MP1 clock driver
>>   clk: stm32mp1: add MP1 gate for hse/hsi/csi oscillators
>>   clk: stm32mp1: add Source Clocks for PLLs
>>   clk: stm32mp1: add PLL clocks
>>   clk: stm32mp1: add Post-dividers for PLL
>>   clk: stm32mp1: add Sub System clocks
>>   clk: stm32mp1: add Kernel timers
>>   clk: stm32mp1: add Peripheral & Kernel Clocks
>>   clk: stm32mp1: add RTC clock
>>   clk: stm32mp1: add MCO clocks
>>   clk: stm32mp1: add Debug clocks
>>
>>  .../devicetree/bindings/clock/st,stm32mp1-rcc.txt  |   60 +
>>  drivers/clk/Kconfig                                |    6 +
>>  drivers/clk/Makefile                               |    1 +
>>  drivers/clk/clk-stm32mp1.c                         | 2117 
>> ++++++++++++++++++++
>>  include/dt-bindings/clock/stm32mp1-clks.h          |  254 +++
>>  5 files changed, 2438 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt
>>  create mode 100644 drivers/clk/clk-stm32mp1.c
>>  create mode 100644 include/dt-bindings/clock/stm32mp1-clks.h
>>
>> -- 
>> 1.9.1
>>
>>
