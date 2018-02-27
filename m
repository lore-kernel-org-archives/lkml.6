Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbeB0N0T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:26:19 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26358 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752573AbeB0N0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:26:17 -0500
Subject: Re: [PATCH v3 00/14] Add MMCI support for STM32F SoCs family
To: <patrice.chotard@st.com>, Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c4f78733-2544-6cef-97e5-fedcc23de404@st.com>
Date: Tue, 27 Feb 2018 14:25:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrice,

On 01/18/2018 03:34 PM, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> This series reworks patches submitted one year ago by Andrea Merello [1]
> but without succeed to merged it.
> 
> STM32F4 and STM32F7 SoCs families embeds a variant of the ARM PrimeCell
> PL18x SD host controller, for which the mmci driver exists.
> This series adds support for these SoCs to the mmci driver.
> 
> As other variants, this one need some specific quirks, that this
> series address.
> 
> This series has been tested on following boards :
> 	_ stm32f429-eval
> 	_ stm32f469-disco
> 	_ stm32f746-eval
> 	_ stm32f769-disco
> 
> DT update for stm32f7 pinctrl, stm32f746-eval and stm32f769-disco boards
> will be sent later to avoid conflict with pending stm32f7 series [1] which
> is not yet merged on kernel mainline.
> 
> [1] https://www.spinics.net/lists/linux-mmc/msg41616.html
> [2] https://patchwork.kernel.org/patch/10104447/
>
...

Patches 6 to 13 (DT/SoC/configs) applied on stm32-next.

Thanks
Alex
