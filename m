Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeECO6t (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:58:49 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36960 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750954AbeECO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:58:46 -0400
Subject: Re: [PATCH 0/3] ARM: dts: stm32: Add display support on
 stm32f469-disco
To: Philippe Cornu <philippe.cornu@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>
References: <20180215082014.30383-1-philippe.cornu@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <0b6b2bac-a9b5-2e08-5da6-e367a083b03d@st.com>
Date: Thu, 3 May 2018 16:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180215082014.30383-1-philippe.cornu@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe

On 02/15/2018 09:20 AM, Philippe Cornu wrote:
> This serie adds the mipi dsi support to stm32f469 and enables it
> on the stm32f469-disco board.
> 
> Philippe CORNU (1):
>    ARM: dts: stm32: Add display support on stm32f469-disco
> 
> Philippe Cornu (2):
>    ARM: dts: stm32: Add dt-bindings gpio.h include on stm32f469-disco
>    ARM: dts: stm32: Add new stm32f469 dtsi file with mipi dsi
> 
>   arch/arm/boot/dts/stm32f469-disco.dts | 54 +++++++++++++++++++++++++++++++++--
>   arch/arm/boot/dts/stm32f469.dtsi      | 19 ++++++++++++
>   2 files changed, 71 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/boot/dts/stm32f469.dtsi
> 

Thanks for new dtsi file. Series applied on stm32-next.

Regards
Alex
