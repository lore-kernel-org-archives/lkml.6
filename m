Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9CFC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CED20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CED20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeICQtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:49:45 -0400
Received: from foss.arm.com ([217.140.101.70]:54806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbeICQtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:49:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74BB918A;
        Mon,  3 Sep 2018 05:29:49 -0700 (PDT)
Received: from [10.4.13.76] (ostrya.emea.arm.com [10.4.13.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA89F3F614;
        Mon,  3 Sep 2018 05:29:46 -0700 (PDT)
Subject: Re: [RFC 09/13] iommu/smmuv3: Get prepared for nested stage support
To:     Auger Eric <eric.auger@redhat.com>, "\"eric.auger.pro"@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        "yi.l.liu\""@linux.intel.com, will.deacon@arm.com,
        robin.murphy@arm.com
Cc:     marc.zyngier@arm.com, peter.maydell@linaro.org,
        christoffer.dall@arm.com
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
 <1535026656-8450-10-git-send-email-eric.auger@redhat.com>
 <538a2b88-dec5-a6fa-d918-486284eb56a9@arm.com>
 <012d4950-7a06-2d59-85a0-44d511ad893b@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <e6de91f7-2410-b0dd-b118-674c32bae5e8@arm.com>
Date:   Mon, 3 Sep 2018 13:29:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <012d4950-7a06-2d59-85a0-44d511ad893b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2018 15:11, Auger Eric wrote:
> Yep this works with my setup but I was waiting for such kind of comments
> to turn this prototype into something more "production level" ;-) Did
> you send anything upstream, related to this branch?

No I didn't have time to clean it up yet, and don't know when I'll be
able to send it out. With host SVA and virtio-iommu, I have enough
patches in flight to keep me busy for a while :) But you can obviously
pick patches from that branch if they help.

Thanks,
Jean
