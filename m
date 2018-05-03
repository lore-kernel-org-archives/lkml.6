Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbeECHuP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:50:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53468 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750942AbeECHuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:50:12 -0400
Subject: Re: [PATCH v2 0/4] Add STM32 USBPHYC to stm32mp157c
To: Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1524562905-19361-1-git-send-email-amelie.delaunay@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e6d141c3-7ee1-cb12-5708-18bf9d0986ae@st.com>
Date: Thu, 3 May 2018 09:49:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524562905-19361-1-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie,

On 04/24/2018 11:41 AM, Amelie Delaunay wrote:
> This series adds support for STM32 USB PHY Controller (USBPHYC) to
> stm32mp157c SoC and enables it on stm32mp157c-ev1 board.
> 
> ---
> Changes in v2:
> * Add reset dt-bindings include
> * Add fixed regulators
> * Enable CONFIG_PHY_STM32_USBPHYC in multi_v7_defconfig
> 
> Amelie Delaunay (4):
>    ARM: dts: stm32: add USBPHYC support to stm32mp157c
>    ARM: dts: stm32: add supplies to usbphyc ports on stm32mp157c-ed1
>    ARM: dts: stm32: enable USBPHYC on stm32mp157c-ev1
>    ARM: multi_v7_defconfig: enable STM32 USB PHY Controller (USBPHYC)
> 
>   arch/arm/boot/dts/stm32mp157c-ed1.dts | 36 +++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts |  5 +++++
>   arch/arm/boot/dts/stm32mp157c.dtsi    | 21 ++++++++++++++++++++
>   arch/arm/configs/multi_v7_defconfig   |  1 +
>   4 files changed, 63 insertions(+)
> 

Series applied on stm32-next. To avoid DTC warnings using W=12, I just 
renamed "vdd_usb" node by "vdd-usb".

Regards
Alex
