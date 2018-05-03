Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeECPjl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:39:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35554 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751007AbeECPjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:39:36 -0400
Subject: Re: [PATCH v1 0/2] Add I2C support for STM32H743
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1524215122-14046-1-git-send-email-pierre-yves.mordret@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <73ba5cf4-3ea5-497f-b5c1-808aadff1515@st.com>
Date: Thu, 3 May 2018 17:38:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524215122-14046-1-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/20/2018 11:05 AM, Pierre-Yves MORDRET wrote:
> Add I2C support on STM32H743 SoC.
> Activate I2C1 on STM32H743I Evaluation Board.
> ---
>    Version history:
>       v1:
>          * Initial
> ---
> 
> Pierre-Yves MORDRET (2):
>    ARM: dts: stm32: Add I2C support for STM32H743 SoC
>    ARM: dts: stm32: Add I2C1 support for STM32H743I-EVAL Board
> 
>   arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 10 +++++++
>   arch/arm/boot/dts/stm32h743.dtsi         | 48 ++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32h743i-eval.dts    |  8 ++++++
>   3 files changed, 66 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
