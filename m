Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeEBQTB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:19:01 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:61409 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751011AbeEBQS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:18:58 -0400
Subject: Re: [PATCH v2 0/5] Add STM32F7 I2C Support on STM32MP157C
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1524476911-19056-1-git-send-email-pierre-yves.mordret@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <31786b0e-28cb-3bde-6d5e-03466dbbda8c@st.com>
Date: Wed, 2 May 2018 18:10:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524476911-19056-1-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/23/2018 11:48 AM, Pierre-Yves MORDRET wrote:
> 
> This patch adds STM32MP157C I2C support on STM32MP157C with configs and device
> tree.
> In the same way I2C4 is enabled for STM32MP157C ED1 Daughter bord.
> I2C2/5 is enabled on STM32MP157C EV1 Daughter board on Evaluation board.
> ---
>    Version history:
>       v1:
>          * Initial
>       v2:
>          * Disambiguate subjects
> ---
> 
> Pierre-Yves MORDRET (5):
>    ARM: multi_v7_defconfig: Add STM32F7 I2C support
>    ARM: dts: stm32: Add STM32F7 I2C support for STM32MP157C SoC
>    ARM: dts: stm32: Add I2Cs pin control on STM32MP157C
>    ARM: dts: stm32: Add I2C4 support for STM32MP157C-ED1
>    ARM: dts: stm32: Add I2C2/5 support for STM32MP157C-EV1
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 40 ++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts     |  8 ++++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts     | 17 +++++++
>   arch/arm/boot/dts/stm32mp157c.dtsi        | 77 +++++++++++++++++++++++++++++++
>   arch/arm/configs/multi_v7_defconfig       |  1 +
>   5 files changed, 143 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
