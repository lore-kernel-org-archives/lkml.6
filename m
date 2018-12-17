Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284A2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEE9206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbeLQJkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:40:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726653AbeLQJkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:40:23 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7EEDBFEA504C7;
        Mon, 17 Dec 2018 17:40:18 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 17:40:18 +0800
Subject: Re: [PATCH 4/4] ACPI/IORT: Don't call iommu_ops->add_device directly
To:     Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>, <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>
References: <20181211150513.15161-1-joro@8bytes.org>
 <20181211150513.15161-5-joro@8bytes.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <cc867349-aafe-1cba-83fc-49a47b5307fc@huawei.com>
Date:   Mon, 17 Dec 2018 17:40:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20181211150513.15161-5-joro@8bytes.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/11 23:05, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make sure to invoke this call-back through the proper
> function of the IOMMU-API.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/acpi/arm64/iort.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Robin and Lorenzo know this better than me, but it's
pretty straight forward to me,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

