Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeEPHja (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:39:30 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33685 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751395AbeEPHj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:39:28 -0400
Subject: Re: [PATCH] MAINTAINERS: Add entry for STM32 timer and lptimer
 drivers
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <mcoquelin.stm32@gmail.com>,
        <jic23@kernel.org>, <thierry.reding@gmail.com>, <lee.jones@linaro.org>
CC: <vilhelm.gray@gmail.com>, <benjamin.gaignard@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1526398399-31753-1-git-send-email-fabrice.gasnier@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c2539e10-81c1-d5e9-c284-14d5142e1a2a@st.com>
Date: Wed, 16 May 2018 09:38:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526398399-31753-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 05/15/2018 05:33 PM, Fabrice Gasnier wrote:
> Add an entry to make myself a maintainer of STM32 timer and lptimer
> drivers.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   MAINTAINERS | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b65225..94d8e47 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13425,6 +13425,16 @@ T:	git git://linuxtv.org/media_tree.git
>   S:	Maintained
>   F:	drivers/media/usb/stk1160/
>   
> +STM32 TIMER/LPTIMER DRIVERS
> +M:	Fabrice Gasnier <fabrice.gasnier@st.com>
> +S:	Maintained
> +F:	drivers/*/stm32-*timer*
> +F:	drivers/pwm/pwm-stm32*
> +F:	include/linux/*/stm32-*tim*
> +F:	Documentation/ABI/testing/*timer-stm32
> +F:	Documentation/devicetree/bindings/*/stm32-*timer
> +F:	Documentation/devicetree/bindings/pwm/pwm-stm32*
> +
>   STMMAC ETHERNET DRIVER
>   M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
>   M:	Alexandre Torgue <alexandre.torgue@st.com>
> 

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
