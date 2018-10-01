Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1E2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E22B213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E22B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbeJAUhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:37:33 -0400
Received: from foss.arm.com ([217.140.101.70]:49570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729182AbeJAUhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:37:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 413727A9;
        Mon,  1 Oct 2018 06:59:37 -0700 (PDT)
Received: from [10.4.13.85] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D1AE3F5B7;
        Mon,  1 Oct 2018 06:59:36 -0700 (PDT)
Subject: Re: [PATCH 0/2] arm64: remove some extra semicolon
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     zhong jiang <zhongjiang@huawei.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org
References: <1533824441-35661-1-git-send-email-zhongjiang@huawei.com>
 <20180903165934.GK6954@arm.com> <20181001134017.GF25071@arrakis.emea.arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <12e7b3a6-6861-e2ab-7d89-1d71d8f62b04@arm.com>
Date:   Mon, 1 Oct 2018 14:59:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001134017.GF25071@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/18 14:40, Catalin Marinas wrote:
> On Mon, Sep 03, 2018 at 05:59:35PM +0100, Will Deacon wrote:
>> On Thu, Aug 09, 2018 at 10:20:39PM +0800, zhong jiang wrote:
>>> There are some extra semicolon in arm64 architecture. Just remove them.
>>
>> These are trivial but certainly not urgent, so I guess Catalin can pick
>> them up for 4.20.
>>
>> Will
>>
>>> zhong jiang (2):
>>>    arm64/kprobes: remove an extra semicolon in arch_prepare_kprobe
>>>    arm64:guest: remove some extra semicolon in kvm_target_cpu
> 
> I picked up the first patch. I'll leave the second to Marc in case there
> are any conflicts with the kvm tree.
> 
> In case it got lost in inbox, here's the second patch.
> 
> https://lore.kernel.org/lkml/1533824441-35661-3-git-send-email-zhongjiang@huawei.com/raw

Ah, thanks for pointing this out. I've queued it now.

	M.
-- 
Jazz is not dead. It just smells funny...
