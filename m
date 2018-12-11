Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01936C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EBB2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EBB2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeLKJ2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:28:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16107 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbeLKJ2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:28:21 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DEE0965860938;
        Tue, 11 Dec 2018 17:28:17 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Tue, 11 Dec 2018
 17:28:16 +0800
Subject: Re: [PATCH v2 -next] input: keyboard: remove duplicated include from
 mtk-pmic-keys.c
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <ebiederm@xmission.com>, <riel@surriel.com>,
        <keescook@chromium.org>, <guro@fb.com>,
        <marcos.souza.org@gmail.com>, <sfr@canb.auug.org.au>,
        <gregkh@linuxfoundation.org>
References: <20181211092131.23272-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <bc14ccc8-4977-4b0e-a65b-15b7b818fdef@huawei.com>
Date:   Tue, 11 Dec 2018 17:28:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181211092131.23272-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, Pls ignore this.

On 2018/12/11 17:21, YueHaibing wrote:
> alphabetise the header files and remove duplicated include
> file linux/kernel.h
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: alphabetise the header files
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 02c67a1..8e6ebab 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -14,18 +14,17 @@
>   *
>   */
>  
> -#include <linux/module.h>
> -#include <linux/kernel.h>
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
> -#include <linux/platform_device.h>
>  #include <linux/kernel.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> -#include <linux/regmap.h>
>  #include <linux/mfd/mt6323/registers.h>
> -#include <linux/mfd/mt6397/registers.h>
>  #include <linux/mfd/mt6397/core.h>
> +#include <linux/mfd/mt6397/registers.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  
>  #define MTK_PMIC_PWRKEY_RST_EN_MASK	0x1
>  #define MTK_PMIC_PWRKEY_RST_EN_SHIFT	6
> 

