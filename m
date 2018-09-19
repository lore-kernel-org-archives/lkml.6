Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C355C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21112098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21112098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbeISVKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:10:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728054AbeISVKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:10:54 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A1D2F616BEAA1;
        Wed, 19 Sep 2018 23:32:21 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 23:32:20 +0800
Subject: Re: [PATCH 0/4] Add HiSilicon Hi3670 SoC and HiKey970 board
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <robh+dt@kernel.org>
References: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amit.kucheria@linaro.org>, <guodong.xu@linaro.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5BA26BFF.1020906@hisilicon.com>
Date:   Wed, 19 Sep 2018 16:32:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180810175339.25421-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

On 2018/8/10 18:53, Manivannan Sadhasivam wrote:
> This patchset adds support for Hi3670 SoC and HiKey970 board. Hi3670 SoC
> is very similar to the Hi3660 SoC with additional NPU support. For now,
> only UART6 has been enabled which is configured by the bootloader for
> console support.
> 
> HiKey970 board is one of the 96Boards Consumer Edition and AI platform
> based on the Hi3670 SoC.
> 
> With this patchset, the Hikey970 board is able to boot into ramdisk with
> 8 cores.
> 
> Thanks,
> Mani
> 
> Manivannan Sadhasivam (4):
>   dt-bindings: arm: hisilicon: Add binding for Hi3670 SoC
>   arm64: dts: Add devicetree for Hisilicon Hi3670 SoC
>   dt-bindings: arm: hisilicon: Add binding for HiKey970 board
>   arm64: dts: Add devicetree support for HiKey970 board
> 
>  .../bindings/arm/hisilicon/hisilicon.txt      |   8 +
>  arch/arm64/boot/dts/hisilicon/Makefile        |   1 +
>  .../boot/dts/hisilicon/hi3670-hikey970.dts    |  35 ++++
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 162 ++++++++++++++++++
>  4 files changed, 206 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> 

Thanks!
Fine to me and applied the series to the hisilicon dts tree.

Best Regards,
Wei

