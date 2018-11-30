Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7881FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA532145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA532145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeK3W0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:26:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49721 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726459AbeK3W0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:26:41 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A12D3C54E6A6E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 19:17:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Fri, 30 Nov 2018
 19:17:41 +0800
Subject: Re: [PATCH] iwlwifi: mvm: remove duplicated include from ops.c
To:     <rafael.j.wysocki@intel.com>
References: <20181130111335.29208-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <11b3c0f2-8459-09ee-69df-51606a1df5be@huawei.com>
Date:   Fri, 30 Nov 2018 19:17:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181130111335.29208-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, pls ignore this

On 2018/11/30 19:13, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> index a31dc99..b85c877 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> @@ -82,7 +82,6 @@
>  #include "fw/api/scan.h"
>  #include "time-event.h"
>  #include "fw-api.h"
> -#include "fw/api/scan.h"
>  #include "fw/acpi.h"
>  
>  #define DRV_DESCRIPTION	"The new Intel(R) wireless AGN driver for Linux"
> 

