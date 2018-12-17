Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DE7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7F02084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbeLQJSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:18:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16575 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbeLQJSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:18:14 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 60326D4EF6307;
        Mon, 17 Dec 2018 17:18:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 17:18:10 +0800
Subject: Re: [PATCH 2/9] ACPI/IORT: Use helper functions to access
 dev->iommu_fwspec
To:     Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>
References: <20181211121910.5604-1-joro@8bytes.org>
 <20181211121910.5604-3-joro@8bytes.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <20f1319b-c9f7-888c-51f8-31ead4c58dde@huawei.com>
Date:   Mon, 17 Dec 2018 17:17:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20181211121910.5604-3-joro@8bytes.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/11 20:19, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Use the new helpers dev_iommu_fwspec_get()/set() to access
> the dev->iommu_fwspec pointer. This makes it easier to move
> that pointer later into another struct.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/acpi/arm64/iort.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

