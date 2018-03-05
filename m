Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933043AbeCEInU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:43:20 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53101 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932681AbeCEInQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:43:16 -0500
Subject: Re: [PATCH] ARM: dts: stm32: add SPI support on STM32H743 SoC
To: Amelie Delaunay <amelie.delaunay@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1519814190-3208-1-git-send-email-amelie.delaunay@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f14b8e89-6487-1a1c-7f66-a0dcd3cd705b@st.com>
Date: Mon, 5 Mar 2018 09:42:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519814190-3208-1-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie

On 02/28/2018 11:36 AM, Amelie Delaunay wrote:
> This patch adds all SPI instances of the STM32H743 SoC.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---

Applied on stm32-next.

Thanks.
Alex

>   arch/arm/boot/dts/stm32h743.dtsi | 61 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 3a28cd2..2bb103e 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -101,6 +101,27 @@
>   			};
>   		};
>   
> +		spi2: spi@40003800 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32h7-spi";
> +			reg = <0x40003800 0x400>;
> +			interrupts = <36>;
> +			clocks = <&rcc SPI2_CK>;
> +			status = "disabled";
> +
> +		};
> +
> +		spi3: spi@40003c00 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32h7-spi";
> +			reg = <0x40003c00 0x400>;
> +			interrupts = <51>;
> +			clocks = <&rcc SPI3_CK>;
> +			status = "disabled";
> +		};
> +
>   		usart2: serial@40004400 {
>   			compatible = "st,stm32f7-uart";
>   			reg = <0x40004400 0x400>;
> @@ -141,6 +162,36 @@
>   			clocks = <&rcc USART1_CK>;
>   		};
>   
> +		spi1: spi@40013000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32h7-spi";
> +			reg = <0x40013000 0x400>;
> +			interrupts = <35>;
> +			clocks = <&rcc SPI1_CK>;
> +			status = "disabled";
> +		};
> +
> +		spi4: spi@40013400 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32h7-spi";
> +			reg = <0x40013400 0x400>;
> +			interrupts = <84>;
> +			clocks = <&rcc SPI4_CK>;
> +			status = "disabled";
> +		};
> +
> +		spi5: spi@40015000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32h7-spi";
> +			reg = <0x40015000 0x400>;
> +			interrupts = <85>;
> +			clocks = <&rcc SPI5_CK>;
> +			status = "disabled";
> +		};
> +
>   		dma1: dma@40020000 {
>   			compatible = "st,stm32-dma";
>   			reg = <0x40020000 0x400>;
> @@ -262,6 +313,16 @@
>   			reg = <0x58000400 0x400>;
>   		};
>   
> +		spi6: spi@58001400 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32h7-spi";
> +			reg = <0x58001400 0x400>;
> +			interrupts = <86>;
> +			clocks = <&rcc SPI6_CK>;
> +			status = "disabled";
> +		};
> +
>   		lptimer2: timer@58002400 {
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> 
