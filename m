Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeBZRCB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:02:01 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50178 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751581AbeBZRCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:02:00 -0500
Subject: Re: [PATCH v4] arch: arm: mach-stm32: Fix copyright
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        <linux@armlinux.org.uk>, <mcoquelin.stm32@gmail.com>,
        <pombredanne@nexb.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20171130084950.23873-1-benjamin.gaignard@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <29bf34f5-9b63-9184-b219-879155f7f78f@st.com>
Date: Mon, 26 Feb 2018 18:01:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20171130084950.23873-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 11/30/2017 09:49 AM, Benjamin Gaignard wrote:
> Uniformize STMicroelectronics copyrights header
> Add SPDX identifier
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>   arch/arm/mach-stm32/board-dt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
> index e918686e4191..548a19f97129 100644
> --- a/arch/arm/mach-stm32/board-dt.c
> +++ b/arch/arm/mach-stm32/board-dt.c
> @@ -1,7 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) Maxime Coquelin 2015
> + * Copyright (C) STMicroelectronics 2017
>    * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
> - * License terms:  GNU General Public License (GPL), version 2
>    */
>   
>   #include <linux/kernel.h>
> 

Applied on stm32-next.

Regards
Alex
