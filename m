Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B723EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E5021570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E5021570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeI0Ixz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 04:53:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35389 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727038AbeI0Ixz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 04:53:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6F09F99FB9092;
        Thu, 27 Sep 2018 10:37:55 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Thu, 27 Sep 2018
 10:37:54 +0800
Message-ID: <5BAC4281.7050508@huawei.com>
Date:   Thu, 27 Sep 2018 10:37:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <gregkh@linuxfoundation.org>
CC:     <gpiccoli@linux.vnet.ibm.com>, <arnd@arndb.de>,
        <haver@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] misc: genwqe: remove duplicated include and order header
 files alphabetically in card_utils.c
References: <1537931109-57092-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1537931109-57092-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/26 11:05, zhong jiang wrote:
> dma-mapping.h and delay.h have included twice. It is unnecessary. Meanwhile,
> Arrange header files in alphabetical sequence to improve readability.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/misc/genwqe/card_utils.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_utils.c
> index 8679e0b..994e8fa 100644
> --- a/drivers/misc/genwqe/card_utils.c
> +++ b/drivers/misc/genwqe/card_utils.c
> @@ -22,26 +22,24 @@
>   * Miscelanous functionality used in the other GenWQE driver parts.
>   */
>  
> -#include <linux/kernel.h>
> +#include <asm/pgtable.h>
> +#include <linux/ctype.h>
> +#include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/sched.h>
> -#include <linux/vmalloc.h>
> -#include <linux/page-flags.h>
> -#include <linux/scatterlist.h>
>  #include <linux/hugetlb.h>
>  #include <linux/iommu.h>
> -#include <linux/delay.h>
> -#include <linux/pci.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/ctype.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/page-flags.h>
> +#include <linux/pci.h>
>  #include <linux/platform_device.h>
> -#include <linux/delay.h>
> -#include <asm/pgtable.h>
> +#include <linux/scatteI wrlist.h>
> +#include <linux/sched.h>
> +#include <linux/vmalloc.h>
>  
> -#include "genwqe_driver.h"
>  #include "card_base.h"
>  #include "card_ddcb.h"
> +#include "genwqe_driver.h"
>  
>  /**
>   * __genwqe_writeq() - Write 64-bit register
Please igore the patch. I will repost . Thanks,

Sincerely,
zhong jiang

