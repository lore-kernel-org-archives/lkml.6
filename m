Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754244AbeB0PzI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:55:08 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56790 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754229AbeB0PzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:55:06 -0500
Subject: Re: [PATCH] ARM: dts: stm32: Add leds support to stm32f769 Discovery
 board
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20180117094005.20728-1-benjamin.gaignard@st.com>
 <20180117094005.20728-2-benjamin.gaignard@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <58d38d05-5b78-356a-b563-839e2844d1f5@st.com>
Date: Tue, 27 Feb 2018 16:54:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180117094005.20728-2-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 01/17/2018 10:40 AM, Benjamin Gaignard wrote:
> Add nodes for the two user leds.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32f769-disco.dts | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> index 4463ca13a740..25a4b71f0317 100644
> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> @@ -61,6 +61,16 @@
>   		serial0 = &usart1;
>   	};
>   
> +	leds {
> +		compatible = "gpio-leds";
> +		green {
> +			gpios = <&gpioj 5 0>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +		red {
> +			gpios = <&gpioj 13 0>;
> +		};
> +	};
>   };
>   
>   &cec {
> 

Applied on stm32-next.

thanks
alex
