Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBZIns (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:43:48 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42755 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751855AbeBZInn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:43:43 -0500
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 14/15] clk: stm32: Add clk entry for SDMMC2 on
 stm32F769
Thread-Topic: [PATCH v2 14/15] clk: stm32: Add clk entry for SDMMC2 on
 stm32F769
Thread-Index: AQHTjsXnDEj4hoAlSUGJJyv3Mfq8kKO2jM6A
Date: Mon, 26 Feb 2018 08:41:13 +0000
Message-ID: <fb3b26e8-0102-122b-1386-68a661139706@st.com>
References: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
 <1516105859-3525-15-git-send-email-patrice.chotard@st.com>
In-Reply-To: <1516105859-3525-15-git-send-email-patrice.chotard@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A88FDEF8E44142408AB72F0919C1903F@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1Q8hoUP017393

Hi Stephen, Michael

It's a gentle reminder as this patch is present on mailing list and 
acked-by since 01/12/2018

Thanks

Patrice

On 01/16/2018 01:30 PM, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> STM32F769 has 2 SDMMC port, add clock entry for the second one.
> 
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> v2 _ Add Acked-by
> 
>   drivers/clk/clk-stm32f4.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
> index 96c6b6b..8f8a178 100644
> --- a/drivers/clk/clk-stm32f4.c
> +++ b/drivers/clk/clk-stm32f4.c
> @@ -282,6 +282,7 @@ struct stm32f4_gate_data {
>   
>   	{ STM32F4_RCC_APB2ENR,  0,	"tim1",		"apb2_mul" },
>   	{ STM32F4_RCC_APB2ENR,  1,	"tim8",		"apb2_mul" },
> +	{ STM32F4_RCC_APB2ENR,  7,	"sdmmc2",	"sdmux"    },
>   	{ STM32F4_RCC_APB2ENR,  8,	"adc1",		"apb2_div" },
>   	{ STM32F4_RCC_APB2ENR,  9,	"adc2",		"apb2_div" },
>   	{ STM32F4_RCC_APB2ENR, 10,	"adc3",		"apb2_div" },
> @@ -315,7 +316,7 @@ struct stm32f4_gate_data {
>   
>   static const u64 stm32f746_gate_map[MAX_GATE_MAP] = { 0x000000f17ef417ffull,
>   						      0x0000000000000003ull,
> -						      0x04f77f033e01c9ffull };
> +						      0x04f77f833e01c9ffull };
>   
>   static const u64 *stm32f4_gate_map;
>   
> 
