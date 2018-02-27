Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754224AbeB0QBq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:01:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52007 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753622AbeB0QBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:01:45 -0500
Subject: Re: [PATCH] ARM: dts: stm32: enable RTC on stm32f769-disco
To: Amelie Delaunay <amelie.delaunay@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1518788832-21714-1-git-send-email-amelie.delaunay@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <b4e88f63-f48b-8333-ca79-0d6f1617a449@st.com>
Date: Tue, 27 Feb 2018 17:00:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518788832-21714-1-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie

On 02/16/2018 02:47 PM, Amelie Delaunay wrote:
> This patch enables RTC on stm32f769-disco.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>   arch/arm/boot/dts/stm32f769-disco.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> index 4463ca1..48cb47f 100644
> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> @@ -73,6 +73,10 @@
>   	clock-frequency = <25000000>;
>   };
>   
> +&rtc {
> +	status = "okay";
> +};
> +
>   &usart1 {
>   	pinctrl-0 = <&usart1_pins_a>;
>   	pinctrl-names = "default";
> 

Applied on stm32-next.

Thanks.
Alex
