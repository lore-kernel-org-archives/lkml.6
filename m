Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeBWNu2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:50:28 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22806 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751276AbeBWNu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:50:26 -0500
Subject: Re: [PATCH 0/7] iio: adc: stm32-dfsdm: misc fixes and improvements
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <31c1cd66-f2f5-201e-04e4-5a79b2191560@st.com>
Date: Fri, 23 Feb 2018 14:49:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

For the series:
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thanks,
Arnaud

On 02/23/2018 01:50 PM, Fabrice Gasnier wrote:
> This series brings some fixes and improvements to STM32 DFSDM driver.
> 
> Fabrice Gasnier (7):
>   iio: adc: stm32-dfsdm: fix compatible data use
>   iio: adc: stm32-dfsdm: fix call to stop channel
>   iio: adc: stm32-dfsdm: fix clock source selection
>   iio: adc: stm32-dfsdm: fix multiple channel initialization
>   iio: adc: stm32-dfsdm: misc style improvements and fixes
>   iio: adc: stm32-dfsdm: add check on max filter id
>   iio: adc: stm32-dfsdm: add check on spi-max-frequency
> 
>  drivers/iio/adc/stm32-dfsdm-adc.c  | 52 ++++++++++++++++++++------------------
>  drivers/iio/adc/stm32-dfsdm-core.c | 17 +++++++++++--
>  2 files changed, 42 insertions(+), 27 deletions(-)
> 
