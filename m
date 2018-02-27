Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeB0QKz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:10:55 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44861 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751923AbeB0QKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:10:53 -0500
Subject: Re: [PATCH 0/2] RTC support on STM32H743
To: Amelie Delaunay <amelie.delaunay@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1518787000-10675-1-git-send-email-amelie.delaunay@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <d53b5d88-1efa-36ca-e989-bad441d6cb96@st.com>
Date: Tue, 27 Feb 2018 17:10:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518787000-10675-1-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie,

On 02/16/2018 02:16 PM, Amelie Delaunay wrote:
> This patchset add support for RTC on STM32H743 and enables it on stm32h743i-eval.
> Tested on stm32-next.
> 
> Amelie Delaunay (2):
>    ARM: dts: stm32: add RTC support on STM32H743
>    ARM: dts: stm32: enable RTC on stm32h743i-eval
> 
>   arch/arm/boot/dts/stm32h743.dtsi      | 15 +++++++++++++++
>   arch/arm/boot/dts/stm32h743i-eval.dts |  4 ++++
>   2 files changed, 19 insertions(+)
> 

Kbuild issue occurs on patch1 because MAINTAINER file is not correct for 
ARM/STM32. I send a patch to fix it: 
https://lkml.org/lkml/2018/2/26/386. There is no Kbuild issue if patches 
are applied on the correct branch: 
git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next.

So series applied on stm32-next.

regards
Alex
