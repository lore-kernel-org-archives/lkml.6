Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEAEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58F22086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58F22086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbeGKNFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:05:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35300 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732420AbeGKNFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:05:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D00D7A9;
        Wed, 11 Jul 2018 06:00:52 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 413BF3F5AD;
        Wed, 11 Jul 2018 06:00:50 -0700 (PDT)
Subject: Re: [PATCH v5 2/7] KVM: arm/arm64: Introduce helpers to manupulate
 page table entries
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20180709143835.28971-1-punit.agrawal@arm.com>
 <20180709144124.29164-1-punit.agrawal@arm.com>
 <20180709144124.29164-2-punit.agrawal@arm.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <691fcde0-b0a2-d258-ac99-49c6c4794247@arm.com>
Date:   Wed, 11 Jul 2018 14:00:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709144124.29164-2-punit.agrawal@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 15:41, Punit Agrawal wrote:
> Introduce helpers to abstract architectural handling of the conversion
> of pfn to page table entries and marking a PMD page table entry as a
> block entry.
> 
> The helpers are introduced in preparation for supporting PUD hugepages
> at stage 2 - which are supported on arm64 but do not exist on arm.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
