Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeECMQ7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:16:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50217 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751075AbeECMQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:16:57 -0400
Subject: Re: [PATCH v1 0/3] Enable CEC on stm32mp157c-ev1 board
To: yannick fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Kamel Kholti <kamel.kholti@st.com>
CC: Benjamin Gaignard <benjamin.gaignard@st.com>
References: <1524556449-5262-1-git-send-email-yannick.fertre@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <038aa5e4-b637-d021-c8d8-09d247e109c6@st.com>
Date: Thu, 3 May 2018 14:16:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524556449-5262-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On 04/24/2018 09:54 AM, yannick fertre wrote:
> This patch-set enables CEC (Consumer Electronics Control) on stm32mp157c
> eval board.
> 
> yannick fertre (3):
>    ARM: dts: stm32: add cec support on stm32mp157c
>    ARM: dts: stm32: add cec pins to stm32mp157c
>    ARM: dts: stm32: add cec support on stm32mp157c-ev1
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 9 +++++++++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts     | 6 ++++++
>   arch/arm/boot/dts/stm32mp157c.dtsi        | 9 +++++++++
>   3 files changed, 24 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
