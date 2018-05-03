Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeECPjG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:39:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39762 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750954AbeECPjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:39:05 -0400
Subject: Re: [RESEND PATCH 3/3] ARM: dts: stm32: update pwm-cells for LPTimer
 on stm32h743
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <thierry.reding@gmail.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <benjamin.gaignard@linaro.org>
References: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
 <1519392965-28235-4-git-send-email-fabrice.gasnier@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e531b9d2-e2d3-aedb-b388-ab639d0530d8@st.com>
Date: Thu, 3 May 2018 17:38:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1519392965-28235-4-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 02/23/2018 02:36 PM, Fabrice Gasnier wrote:
> LPTimer pwm cells should be updated to 3, to allow initialization of
> channel, period and polarity.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---


Applied on stm32-next.

Thanks.
Alex


>   arch/arm/boot/dts/stm32h743.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index bbfcbac..40d7d76 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -85,6 +85,7 @@
>   
>   			pwm {
>   				compatible = "st,stm32-pwm-lp";
> +				#pwm-cells = <3>;
>   				status = "disabled";
>   			};
>   
> @@ -238,6 +239,7 @@
>   
>   			pwm {
>   				compatible = "st,stm32-pwm-lp";
> +				#pwm-cells = <3>;
>   				status = "disabled";
>   			};
>   
> @@ -264,6 +266,7 @@
>   
>   			pwm {
>   				compatible = "st,stm32-pwm-lp";
> +				#pwm-cells = <3>;
>   				status = "disabled";
>   			};
>   
> @@ -285,6 +288,7 @@
>   
>   			pwm {
>   				compatible = "st,stm32-pwm-lp";
> +				#pwm-cells = <3>;
>   				status = "disabled";
>   			};
>   		};
> @@ -300,6 +304,7 @@
>   
>   			pwm {
>   				compatible = "st,stm32-pwm-lp";
> +				#pwm-cells = <3>;
>   				status = "disabled";
>   			};
>   		};
> 
