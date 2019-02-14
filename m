Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725B2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A39D2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437522AbfBNIjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:39:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbfBNIjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:39:39 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 40B29DA122F0B147DC23;
        Thu, 14 Feb 2019 16:39:36 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 14 Feb 2019
 16:39:30 +0800
Subject: Re: [PATCH -next] swiotlb: drop pointless static qualifier in
 swiotlb_dma_supported()
To:     Christoph Hellwig <hch@lst.de>
References: <20190214014147.108653-1-yuehaibing@huawei.com>
 <20190214072658.GA10416@lst.de>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <c73333ab-18b9-c846-7f03-c91721cbd1ba@huawei.com>
Date:   Thu, 14 Feb 2019 16:39:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190214072658.GA10416@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/14 15:26, Christoph Hellwig wrote:
> On Thu, Feb 14, 2019 at 01:41:47AM +0000, YueHaibing wrote:
>> There is no need to have the 'struct dentry *d_swiotlb_usage' variable
>> static since new value always be assigned before use it.
> 
> FYI, this is in swiotlb_create_debugfs, not swiotlb_dma_supported.

Thank you, I will fix it.

> 
> .
> 

