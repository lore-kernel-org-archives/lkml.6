Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeEBO0I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:26:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2996 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750921AbeEBO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:26:07 -0400
Subject: Re: [PATCH v1 0/2] Add MDMA Support on STM32MP157C
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1524215707-14642-1-git-send-email-pierre-yves.mordret@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <0bcb0bea-cdc1-483e-4396-517d33e9e69f@st.com>
Date: Wed, 2 May 2018 16:25:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524215707-14642-1-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/20/2018 11:15 AM, Pierre-Yves MORDRET wrote:
> This patch adds MDMA support on STM32MP157C with configs and device tree.
> ---
>    Version history:
>       v1:
>          * Initial
> ---
> 
> Pierre-Yves MORDRET (2):
>    ARM: configs: stm32: Add MDMA support on STM32MP157C
>    ARM: dts: stm32: Add MDMA support on STM32MP157C
> 
>   arch/arm/boot/dts/stm32mp157c.dtsi | 10 ++++++++++
>   arch/arm/mach-stm32/Kconfig        |  1 +
>   2 files changed, 11 insertions(+)
> 

Series applied on stm32-next.
As said before I modified commit header for mach-stm32/Kconfig patch.

Regards
Alex
