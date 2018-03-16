Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753479AbeCPJLF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:11:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41190 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750847AbeCPJK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:10:59 -0400
Subject: Re: [PATCH 0/2] iio: stm32-dfsdm-adc: fix filter & rate setting
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>
References: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <1ddfcfad-f06e-738f-53cf-11dc56e61da1@st.com>
Date: Fri, 16 Mar 2018 10:10:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

For the series:
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thanks,
Arnaud

On 03/13/2018 03:23 PM, Fabrice Gasnier wrote:
> This series brings fixes to STM32 DFSDM ADC driver.
> 
> Fabrice Gasnier (2):
>   iio: adc: stm32-dfsdm: fix successive oversampling settings
>   iio: adc: stm32-dfsdm: fix sample rate for div2 spi clock
> 
>  drivers/iio/adc/stm32-dfsdm-adc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
