Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638D3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006112086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006112086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeJJJt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 05:49:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13609 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbeJJJt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 05:49:57 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CF1F21B8AF867;
        Wed, 10 Oct 2018 10:29:55 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Wed, 10 Oct 2018
 10:29:54 +0800
Subject: Re: [PATCH v2 1/2] arm/arm64: KVM: rename function
 kvm_arch_dev_ioctl_check_extension()
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <peter.maydell@linaro.org>, <drjones@redhat.com>,
        <james.morse@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>
References: <1539002088-21215-1-git-send-email-gengdongjiu@huawei.com>
 <1539002088-21215-2-git-send-email-gengdongjiu@huawei.com>
 <e5e5f84b-4664-7ba0-9462-5b69a987fd9d@arm.com>
From:   gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <aa6d8da8-7452-7d43-e50b-36388e60ca59@huawei.com>
Date:   Wed, 10 Oct 2018 10:29:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e5e5f84b-4664-7ba0-9462-5b69a987fd9d@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 2018/10/10 0:34, Suzuki K Poulose wrote:
> Hi,
> 
> On 08/10/18 13:34, Dongjiu Geng wrote:
>> Rename kvm_arch_dev_ioctl_check_extension() to
>> kvm_arch_vm_ioctl_check_extension(), because it does
>> not have any relationship with device.
>>
>> Renaming this function can make code readable.
> 
> +1. The current name is not really intuitive.
> 
>>
>> Cc: James Morse <james.morse@arm.com>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks very much for the review

> 
> .
> 

