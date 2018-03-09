Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeCIPca (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:32:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751096AbeCIPc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:32:29 -0500
Subject: Re: [PATCH] arm64: defconfig: enable IOSCHED_DEADLINE
To: John Garry <john.garry@huawei.com>
References: <1517318577-56430-1-git-send-email-john.garry@huawei.com>
CC: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <arnd@arndb.de>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5AA2A8EB.6050405@hisilicon.com>
Date: Fri, 9 Mar 2018 15:31:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1517318577-56430-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2018/1/30 13:22, John Garry wrote:
> For certain workloads the deadline IO scheduler offers
> particular advantages over other schedulers and has shown
> to perform better, so enable it.
> 
> The default IO scheduler is unaffected by this change, and
> currently is CFQ.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Applied into hisilicon defconfig tree.
Thanks!

BR,
Wei

> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 634b373..40c72e6 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -31,7 +31,6 @@ CONFIG_PROFILING=y
>  CONFIG_JUMP_LABEL=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> -# CONFIG_IOSCHED_DEADLINE is not set
>  CONFIG_ARCH_SUNXI=y
>  CONFIG_ARCH_ALPINE=y
>  CONFIG_ARCH_BCM2835=y
> 
