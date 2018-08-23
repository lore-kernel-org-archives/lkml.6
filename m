Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80969C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CED2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CED2152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbeHWOxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:53:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727302AbeHWOxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:53:13 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85E9F6A9A990D;
        Thu, 23 Aug 2018 19:23:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Thu, 23 Aug 2018
 19:23:52 +0800
Message-ID: <5B7E9947.5000005@huawei.com>
Date:   Thu, 23 Aug 2018 19:23:51 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <yong.zhi@intel.com>, <sakari.ailus@linux.intel.com>,
        <bingbu.cao@intel.com>, <mchehab@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <tian.shu.qiu@intel.com>, <jian.xu.zheng@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: Re: [PATCH 0/2] media: Use dma_zalloc_coherent to replace dma_alloc_coherent
 + memset
References: <1534605415-11452-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1534605415-11452-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping,  Anyone has any objections about the patcheset?

Best wishes,
zhong jiang
On 2018/8/18 23:16, zhong jiang wrote:
> The issue is detected with the help of Coccinelle.
>
> zhong jiang (2):
>   media: ipu3-cio2: Use dma_zalloc_coherent to replace
>     dma_alloc_coherent + memset
>   media: mtk_vcodec_util: Use dma_zalloc_coherent to replace
>     dma_alloc_coherent + memset
>
>  drivers/media/pci/intel/ipu3/ipu3-cio2.c            | 6 ++----
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c | 5 +----
>  2 files changed, 3 insertions(+), 8 deletions(-)
>


