Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeB0QE7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:04:59 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:30301 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751733AbeB0QE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:04:57 -0500
Subject: Re: [PATCH v2 0/3] USB OTG on STM32H743
To: Amelie Delaunay <amelie.delaunay@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1519029988-9261-1-git-send-email-amelie.delaunay@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <05b1ec7e-8db3-20df-fb1c-3a8853f99307@st.com>
Date: Tue, 27 Feb 2018 17:04:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519029988-9261-1-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie,

On 02/19/2018 09:46 AM, Amelie Delaunay wrote:
> This patchset adds support for USB OTG HS and FS on stm32h743 SoC.
> It also enables USB OTG HS on stm32h743i-eval board in OTG (DRD) mode. It is
> possible to use OTG HS in Peripheral or Host mode depending on the USB
> connector.
> 
> ---
> 
> Changes in v2:
> - Fix compatible string (https://patchwork.kernel.org/patch/10222153/)
> 
> Amelie Delaunay (3):
>    ARM: dts: stm32: add USB OTG HS support for STM32H743 SoC
>    ARM: dts: stm32: add USB OTG FS support for STM32H743 SoC
>    ARM: dts: stm32: enable USB OTG HS on stm32h743i-eval
> 
>   arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 20 ++++++++++++++++++++
>   arch/arm/boot/dts/stm32h743.dtsi         | 21 +++++++++++++++++++++
>   arch/arm/boot/dts/stm32h743i-eval.dts    | 16 ++++++++++++++++
>   3 files changed, 57 insertions(+)
> 

I squashed patch 1&2 and applied series on stm32-next.

Regards.
Alex
