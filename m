Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2195DC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD132133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD132133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeIMHJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:09:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbeIMHJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:09:33 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BD02B4A90B72D;
        Thu, 13 Sep 2018 10:02:15 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Thu, 13 Sep 2018
 10:02:11 +0800
Subject: Re: [PATCH v5 0/5] add non-strict mode support for arm-smmu-v3
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
 <20180912165700.GC16071@arm.com>
 <d0775377-206f-ae3e-051d-3b829b499471@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        John Garry <john.garry@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B99C523.7060704@huawei.com>
Date:   Thu, 13 Sep 2018 10:02:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <d0775377-206f-ae3e-051d-3b829b499471@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/13 1:12, Robin Murphy wrote:
> On 12/09/18 17:57, Will Deacon wrote:
>> Hi all,
>>
>> On Wed, Aug 15, 2018 at 09:28:25AM +0800, Zhen Lei wrote:
>>> v4 -> v5:
>>> 1. change the type of global variable and struct member named "non_strict" from
>>>     "int" to "bool".
>>> 2. cancel the unnecessary parameter "strict" of __arm_lpae_unmap which was added
>>>     in v4.
>>> 3. change boot option "arm_iommu" to "iommu.non_strict".
>>> 4. convert __iommu_dma_unmap to use iommu_unmap_fast()/iommu_tlb_sync(), because
>>>     non-leaf unmaps still need to be synchronous.
>>>
>>> Thanks for Robin's review comments.
>>
>> Since this is 90% of the way there now, I suggest Robin picks up what's here
>> and incorporates his remaining review comments directly (especially since it
>> sounded like Zhen Lei hasn't got much free time lately). With that, I can
>> queue this lot via my smmu branch, which already has some stuff queued
>> for SMMUv3 and io-pgtable.
>>
>> Please shout if you have any objections, but I'm keen for this not to
>> languish on the lists given how close it is!
> 
> Sure, having got this far I'd like to see it get done too. I'll make some time and give it a go.

Thank you very much.

I've been too busy lately, at least I still have no time this week, I also think it's been too long.

So sorry and thanks again.

> 
> Robin.
> 
> .
> 

-- 
Thanks!
BestRegards

