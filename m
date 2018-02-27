Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932373AbeB0P5w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:57:52 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3734 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932330AbeB0P5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:57:47 -0500
Subject: Re: [PATCH 0/3] USB OTG on STM32F7 boards
To: Amelie Delaunay <amelie.delaunay@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <06730939-11f4-c8da-02a8-7bab37f194ce@st.com>
Date: Tue, 27 Feb 2018 16:57:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie

On 02/15/2018 04:54 PM, Amelie Delaunay wrote:
> This patchset adds support for Peripheral mode on stm32f746 by adding
> dwc2 gadget fifo sizes and enables USB OTG HS in OTG (DRD) mode on
> stm32746g-eval and stm32f769-disco. It possible to use OTG HS in
> Peripheral or Host mode, depending on the USB connector.
> 
> Amelie Delaunay (3):
>    ARM: dts: stm32: add gadget fifo sizes to usbotg_hs on stm32f746
>    ARM: dts: stm32: select otg mode for usbotg_hs on stm32746g_eval
>    ARM: dts: stm32: enable USB HS on stm32f769-disco
> 
>   arch/arm/boot/dts/stm32746g-eval.dts  |  2 +-
>   arch/arm/boot/dts/stm32f746.dtsi      |  3 +++
>   arch/arm/boot/dts/stm32f769-disco.dts | 15 +++++++++++++++
>   3 files changed, 19 insertions(+), 1 deletion(-)
> 

Series applied on stm32-next.

Regards
Alex
