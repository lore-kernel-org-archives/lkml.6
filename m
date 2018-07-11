Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E916CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05A120C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05A120C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389611AbeGKQPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:15:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39542 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387728AbeGKQPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:15:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8483B7A9;
        Wed, 11 Jul 2018 09:10:53 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2879B3F589;
        Wed, 11 Jul 2018 09:10:53 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/7] KVM: arm/arm64: Introduce helpers to manupulate page table entries
References: <20180709143835.28971-1-punit.agrawal@arm.com>
        <20180709144124.29164-1-punit.agrawal@arm.com>
        <20180709144124.29164-2-punit.agrawal@arm.com>
        <691fcde0-b0a2-d258-ac99-49c6c4794247@arm.com>
Date:   Wed, 11 Jul 2018 17:10:51 +0100
In-Reply-To: <691fcde0-b0a2-d258-ac99-49c6c4794247@arm.com> (Suzuki
        K. Poulose's message of "Wed, 11 Jul 2018 14:00:48 +0100")
Message-ID: <87va9loir8.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suzuki K Poulose <Suzuki.Poulose@arm.com> writes:

> On 09/07/18 15:41, Punit Agrawal wrote:
>> Introduce helpers to abstract architectural handling of the conversion
>> of pfn to page table entries and marking a PMD page table entry as a
>> block entry.
>>
>> The helpers are introduced in preparation for supporting PUD hugepages
>> at stage 2 - which are supported on arm64 but do not exist on arm.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Acked-by: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Other than the query on Patch 7 I've incorporated all your suggestions
locally.

Thanks a lot for reviewing the patches.

Punit

ps: Just noticed the typo (manupulate) in the subject. I've fixed it up
locally.
