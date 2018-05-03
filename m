Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeECPNM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:13:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17283 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751272AbeECPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:13:04 -0400
Subject: Re: [PATCH v1 0/3] Append additional I2C instances and activate I2C1.
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1524215110-13967-1-git-send-email-pierre-yves.mordret@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <6f1259a8-f036-d3bd-a17e-d1ceb77092f2@st.com>
Date: Thu, 3 May 2018 17:12:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524215110-13967-1-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/20/2018 11:05 AM, Pierre-Yves MORDRET wrote:
> This patch intends to appends 3 additional I2C instances (2, 3 and 4).
> In the same time I2C1 is setup for both STM32F746 and STM32F769 Discovery
> boards.
> ---
>    Version history:
>       v1:
>          * Initial
> ---
> 
> Pierre-Yves MORDRET (3):
>    ARM: dts: stm32: Append additional I2Cs for STM32F746 SoC
>    ARM: dts: stm32: Add I2C1 support for STM32F769-DISCO Board
>    ARM: dts: stm32: Add I2C1 support for STM32F746-DISCO Board
> 
>   arch/arm/boot/dts/stm32f746-disco.dts |  8 ++++++++
>   arch/arm/boot/dts/stm32f746.dtsi      | 36 +++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32f769-disco.dts |  8 ++++++++
>   3 files changed, 52 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
