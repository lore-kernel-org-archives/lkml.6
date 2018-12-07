Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AA9C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF95E20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF95E20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLGO1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:27:15 -0500
Received: from foss.arm.com ([217.140.101.70]:45976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeLGO1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:27:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AE7215AB;
        Fri,  7 Dec 2018 06:27:15 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8B033F59C;
        Fri,  7 Dec 2018 06:27:13 -0800 (PST)
Subject: Re: linux-next: manual merge of the arm64 tree with Linus' tree
To:     Will Deacon <will.deacon@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181207091847.1db6a48e@canb.auug.org.au>
 <20181207121609.GA26721@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <0e7534a0-ae7b-7968-d97b-b3dec9a7be8d@arm.com>
Date:   Fri, 7 Dec 2018 14:27:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207121609.GA26721@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will, Stephen

On 07/12/2018 12:16, Will Deacon wrote:
> On Fri, Dec 07, 2018 at 09:18:47AM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the arm64 tree got a conflict in:
>>
>>    arch/arm64/kernel/cpu_errata.c
>>
>> between commit:
>>
>>    ce8c80c536da ("arm64: Add workaround for Cortex-A76 erratum 1286807")
>>
>> from Linus' tree and commit:
>>
>>    c9460dcb06ee ("arm64: capabilities: Merge entries for ARM64_WORKAROUND_CLEAN_CACHE")
>>
>> from the arm64 tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
> 
> Thanks, Stephen, this looks correct to me. Suzuki -- can you please confirm?
> 


Yes, it looks correct to me did a boot test.

Thanks Stephen!

Cheers
Suzuki
