Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754213AbeB0Pys (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:54:48 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60262 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753644AbeB0Pyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:54:46 -0500
Subject: Re: [PATCH] ARM: dts: stm32: Add leds support to stm32f469 Discovery
 board
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20180117094005.20728-1-benjamin.gaignard@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f269a49a-b25b-7946-030c-f59c4447f2a0@st.com>
Date: Tue, 27 Feb 2018 16:54:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180117094005.20728-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/17/2018 10:40 AM, Benjamin Gaignard wrote:
> Add nodes for the four user leds.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32f469-disco.dts | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> index c18acbe4cf4e..5e9994840a24 100644
> --- a/arch/arm/boot/dts/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> @@ -70,6 +70,22 @@
>   		dma-ranges = <0xc0000000 0x0 0x10000000>;
>   	};
>   
> +	leds {
> +		compatible = "gpio-leds";
> +		green {
> +			gpios = <&gpiog 6 1>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +		orange {
> +			gpios = <&gpiod 4 1>;
> +		};
> +		red {
> +			gpios = <&gpiod 5 1>;
> +		};
> +		blue {
> +			gpios = <&gpiok 3 1>;
> +	};
> +
>   	/* This turns on vbus for otg for host mode (dwc2) */
>   	vcc5v_otg: vcc5v-otg-regulator {
>   		compatible = "regulator-fixed";
> 

Applied on stm32-next.

thanks
alex
