Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeECNHJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:07:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54409 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750922AbeECNHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:07:00 -0400
Subject: Re: [PATCH 0/2] ARM: dts: stm32: add qspi support for stm32mp157c
To: Ludovic Barre <ludovic.Barre@st.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1525072281-17472-1-git-send-email-ludovic.Barre@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e6ab9571-c227-9246-3b34-f28420f0dbd5@st.com>
Date: Thu, 3 May 2018 15:06:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525072281-17472-1-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ludovic,

On 04/30/2018 09:11 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series adds qspi support for stm32mp157c SoC
> and its eval board.
> 
> Ludovic Barre (2):
>    ARM: dts: stm32: add qspi support for stm32mp157c
>    ARM: dts: stm32: add flash nor support on stm32mp157c eval board
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 45 +++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts     | 25 +++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c.dtsi        | 11 ++++++++
>   3 files changed, 81 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
