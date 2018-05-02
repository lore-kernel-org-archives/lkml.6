Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeEBOZE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:25:04 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27951 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751020AbeEBOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:25:02 -0400
Subject: Re: [PATCH v1 0/4] Add DMAv2 and DMAMUX Support on STM32MP157C
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e720dec2-2ea8-c0ba-cfc9-b8c001c06328@st.com>
Date: Wed, 2 May 2018 16:24:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 04/20/2018 11:14 AM, Pierre-Yves MORDRET wrote:
> This patch adds DMAv2 and DMAMUX support on STM32MP157C with configs and device tree.
> ---
>    Version history:
>       v1:
>          * Initial
> ---
> 
> Pierre-Yves MORDRET (4):
>    ARM: configs: stm32: Add DMAv2 support on STM32MP157C machine
>    ARM: configs: stm32: Add DMAMUX support on STM32MP157C
>    ARM: dts: stm32: Add DMAv2 support on STM32MP157C
>    ARM: dts: stm32: Add DMAMUX support on STM32MP157C
> 
>   arch/arm/boot/dts/stm32mp157c.dtsi | 44 ++++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-stm32/Kconfig        |  2 ++
>   2 files changed, 46 insertions(+)
> 
Series applied on stm32-next. As said before I modified commit header 
for mach-stm32/Kconfig patch.

Regards
Alex
