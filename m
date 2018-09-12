Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39666C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E608720866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E608720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeILTnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:43:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726945AbeILTnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:43:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 59818E278A14B;
        Wed, 12 Sep 2018 22:38:32 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Wed, 12 Sep 2018
 22:38:30 +0800
Message-ID: <5B9924E5.1040600@huawei.com>
Date:   Wed, 12 Sep 2018 22:38:29 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Will Deacon <will.deacon@arm.com>
CC:     <catalin.marinas@arm.com>, <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] arm64: remove some extra semicolon
References: <1533824441-35661-1-git-send-email-zhongjiang@huawei.com> <20180903165934.GK6954@arm.com>
In-Reply-To: <20180903165934.GK6954@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/4 0:59, Will Deacon wrote:
> On Thu, Aug 09, 2018 at 10:20:39PM +0800, zhong jiang wrote:
>> There are some extra semicolon in arm64 architecture. Just remove them.
> These are trivial but certainly not urgent, so I guess Catalin can pick
> them up for 4.20.
Thanks,  

Catalin,  Do you can pick them up ?

Sincerely,
zhong jiang
> Will
>
>> zhong jiang (2):
>>   arm64/kprobes: remove an extra semicolon in arch_prepare_kprobe
>>   arm64:guest: remove some extra semicolon in kvm_target_cpu
>>
>>  arch/arm64/kernel/probes/kprobes.c | 2 +-
>>  arch/arm64/kvm/guest.c             | 6 +++---
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> -- 
>> 1.7.12.4
>>
> .
>


