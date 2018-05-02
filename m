Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeEBPuo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:50:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51209 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751020AbeEBPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:50:41 -0400
Subject: Re: [PATCH 0/4] ARM: dts: Add cryptographic support for stm32mp157c
To: Lionel Debieve <lionel.debieve@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180423151947.2526-1-lionel.debieve@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <27c3293a-bfbf-6410-68da-6750371e79e6@st.com>
Date: Wed, 2 May 2018 17:50:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423151947.2526-1-lionel.debieve@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lionel,

On 04/23/2018 05:19 PM, Lionel Debieve wrote:
> Patches serie add support or RNG, CRYP and CRC IPs for stm32mp157c SoC
> and add RNG default support for ev1 board.
> 
> Lionel Debieve (4):
>    ARM: dts: stm32: Add RNG support on stm32mp157c
>    ARM: dts: stm32: Enable RNG for stm32mp157c-ed1
>    ARM: dts: stm32: Add CRYP support on stm32mp157c
>    ARM: dts: stm32: Add CRC support on stm32mp157c
> 
>   arch/arm/boot/dts/stm32mp157c-ed1.dts |  4 ++++
>   arch/arm/boot/dts/stm32mp157c.dtsi    | 25 +++++++++++++++++++++++++
>   2 files changed, 29 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
