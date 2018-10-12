Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103DCC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A062075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A062075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeJLXSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:18:43 -0400
Received: from foss.arm.com ([217.140.101.70]:53504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbeJLXSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:18:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 491861596;
        Fri, 12 Oct 2018 08:45:38 -0700 (PDT)
Received: from [10.1.196.46] (melchizedek.cambridge.arm.com [10.1.196.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A00843F5BC;
        Fri, 12 Oct 2018 08:45:36 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] arm/arm64: KVM: rename function
 kvm_arch_dev_ioctl_check_extension()
To:     Dongjiu Geng <gengdongjiu@huawei.com>
References: <1539284855-4035-1-git-send-email-gengdongjiu@huawei.com>
 <1539284855-4035-2-git-send-email-gengdongjiu@huawei.com>
From:   James Morse <james.morse@arm.com>
Cc:     christoffer.dall@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, peter.maydell@linaro.org,
        drjones@redhat.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Message-ID: <5743b2ce-232f-f7e9-b5e7-3fd017575d78@arm.com>
Date:   Fri, 12 Oct 2018 16:45:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1539284855-4035-2-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjiu Geng,

On 11/10/2018 20:07, Dongjiu Geng wrote:
> Rename kvm_arch_dev_ioctl_check_extension() to
> kvm_arch_vm_ioctl_check_extension(), because it does
> not have any relationship with device.
> 
> Renaming this function can make code readable.

Lots of things in the kernel are misnamed, its not normally worth fixing them.

But it confused me, so:
Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
