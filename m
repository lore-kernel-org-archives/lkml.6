Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE86EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36422084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeLQJV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:21:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16576 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbeLQJV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:21:28 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4825B675EBCEE;
        Mon, 17 Dec 2018 17:21:24 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 17:21:22 +0800
Subject: Re: [PATCH 3/6] ACPI/IORT: Use device_iommu_mapped()
To:     Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
CC:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>, <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Paul Mackerras" <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, <jroedel@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <20181211134343.10664-1-joro@8bytes.org>
 <20181211134343.10664-4-joro@8bytes.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <2c279b05-f845-94ac-f0ad-a0c54f48a7ca@huawei.com>
Date:   Mon, 17 Dec 2018 17:21:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20181211134343.10664-4-joro@8bytes.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/11 21:43, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Replace the iommu-check with a proper and readable function
> call.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

