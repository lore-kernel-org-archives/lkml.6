Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E04C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA6F2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA6F2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeJIUL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:11:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37288 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeJIUL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:11:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C4227A9;
        Tue,  9 Oct 2018 05:55:09 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66DA33F5B3;
        Tue,  9 Oct 2018 05:55:08 -0700 (PDT)
Subject: Re: fix up nowarn confusion in the dma mapping layer
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20181001201257.366-1-hch@lst.de> <20181008070358.GA3182@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8da56b4f-0625-cb44-fa21-d7c1c04a56b0@arm.com>
Date:   Tue, 9 Oct 2018 13:55:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008070358.GA3182@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/18 08:03, Christoph Hellwig wrote:
> Any comments on these rather trivial patches?

Nope ;)

For both,
Acked-by: Robin Murphy <robin.murphy@arm.com>

> On Mon, Oct 01, 2018 at 01:12:55PM -0700, Christoph Hellwig wrote:
>> Hi all,
>>
>> this series sorts out how we deal with the nowarn flags in the dma
>> mapping code.  We still support __GFP_NOWARN for the legacy APIs that
>> don't support passing the dma specific flags, but we generally want
>> every implementation to actually check DMA_ATTR_NO_WARN instead.
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> ---end quoted text---
> 
