Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeEKOAr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:00:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57778 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753063AbeEKOAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:00:46 -0400
Subject: Re: [PATCH 0/3] HiSilicon LPC defconfig and DT patches
To: John Garry <john.garry@huawei.com>
References: <1525101342-27120-1-git-send-email-john.garry@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <xuwei5@hisilicon.com>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5AF5A1FC.5000900@hisilicon.com>
Date: Fri, 11 May 2018 15:00:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1525101342-27120-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2018/4/30 16:15, John Garry wrote:
> This series introduces 3 patches, to enable the
> HISILICON_LPC config in the arm64 defconfig
> and also add the relevant LPC DT entries.
> 
> For hip06 UART support, we depend on this patch:
> https://lkml.org/lkml/2018/4/27/258
> 
> John Garry (3):
>   arm64: defconfig: Enable HISILICON_LPC
>   arm64: dts: hisi: Enable Hisi LPC node for hip06
>   arm64: dts: hisi: Enable Hisi LPC node for hip07
> 
>  arch/arm64/boot/dts/hisilicon/hip06-d03.dts |  8 ++++++++
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi    | 21 +++++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hip07-d05.dts |  4 ++++
>  arch/arm64/boot/dts/hisilicon/hip07.dtsi    | 14 ++++++++++++++
>  arch/arm64/configs/defconfig                |  1 +
>  5 files changed, 48 insertions(+)
> 

Series applied into the hisilicon tree.
Thanks!

BR,
Wei
