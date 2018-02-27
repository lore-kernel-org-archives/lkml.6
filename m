Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeB0Pzl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:55:41 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51487 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754304AbeB0Pzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:55:37 -0500
Subject: Re: [PATCH] ARM: dts: stm32: Fix HSE clock frequency for
 stm32h743i-disco board
To: <patrice.chotard@st.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <mcoquelin.stm32@gmail.com>
References: <1516983819-6567-1-git-send-email-patrice.chotard@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <08bbd782-7311-5d0a-a4c6-90700f26793a@st.com>
Date: Tue, 27 Feb 2018 16:55:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1516983819-6567-1-git-send-email-patrice.chotard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrice,

On 01/26/2018 05:23 PM, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> The HSE oscillator frequency was wrongly set to 125MHz instead of 25MHz.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>   arch/arm/boot/dts/stm32h743i-disco.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32h743i-disco.dts b/arch/arm/boot/dts/stm32h743i-disco.dts
> index 79e841d94079..45e088c55741 100644
> --- a/arch/arm/boot/dts/stm32h743i-disco.dts
> +++ b/arch/arm/boot/dts/stm32h743i-disco.dts
> @@ -63,7 +63,7 @@
>   };
>   
>   &clk_hse {
> -	clock-frequency = <125000000>;
> +	clock-frequency = <25000000>;
>   };
>   
>   &usart2 {
> 

Applied on stm32-next.

thanks
alex
