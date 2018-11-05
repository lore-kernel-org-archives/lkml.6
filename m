Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4960C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D66020685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D66020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeKETNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:13:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39762 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKETNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:13:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3147AEBD;
        Mon,  5 Nov 2018 01:54:40 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEBAB3F706;
        Mon,  5 Nov 2018 01:54:38 -0800 (PST)
Subject: Re: [GIT PULL] sprd dts for kernel v4.20-rc1
To:     Olof Johansson <olof@lixom.net>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     arm-soc <arm@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com>
 <20181102183246.r5xxwsic2mxwihsi@localhost>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <8fe7491c-74de-3192-c583-37cd1583cfd6@arm.com>
Date:   Mon, 5 Nov 2018 09:54:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181102183246.r5xxwsic2mxwihsi@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On 02/11/18 18:32, Olof Johansson wrote:
> On Thu, Oct 18, 2018 at 05:17:33PM +0800, Chunyan Zhang wrote:
>> Hi Arnd,
>>
>> For 4.20-rc1 there's one patch only for sprd devicetree, please pull from my git tree:
>>
>> https://github.com/lyrazhang/linux.git m-v4.19-rc1
>>
>> Please let me know if there's some problem.
>>
>> Thanks,
>> Chunyan
>>
>> ----------------------------------------------------------------
>>
>> Suzuki K Poulose (1):
>>    arm64: dts: sc9836/sc9860: Update coresight bindings for hardware
>>      ports
>>
>>   arch/arm64/boot/dts/sprd/sc9836.dtsi |  78 +++++++------
>>   arch/arm64/boot/dts/sprd/sc9860.dtsi | 215 ++++++++++++++++++-----------------
>>   2 files changed, 151 insertions(+), 142 deletions(-)
> 
> Hi,
> 
> This came in right before the merge window so it wasn't included since
> it's more of a cleanup.

A minor correction. This is not really a cleanup, but upgrading the
bindings to the new DTS bindings for Coresight. The driver will now
complain about old bindings, which could be hit on these boards. Not
the end of the world, it could be queued for 4.21.

Cheers
Suzuki
