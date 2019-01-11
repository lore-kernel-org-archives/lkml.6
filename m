Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850D1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D84721848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfAKKFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:05:47 -0500
Received: from 8bytes.org ([81.169.241.247]:56786 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731608AbfAKKFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:05:45 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E3556434; Fri, 11 Jan 2019 11:05:43 +0100 (CET)
Date:   Fri, 11 Jan 2019 11:05:43 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix typo. Change tlb_range_add to iotlb_range_add and
 tlb_sync to iotlb_sync
Message-ID: <20190111100543.GD5825@8bytes.org>
References: <20181204182734.20184-1-murphyt7@tcd.ie>
 <20181205160439.bjbh7stdey32hjgj@8bytes.org>
 <CALQxJutDpN6SagB89=cPvNczmD8kRXwaq-yzor7kULU4iLt2uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQxJutDpN6SagB89=cPvNczmD8kRXwaq-yzor7kULU4iLt2uA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 03:47:28PM +0000, Tom Murphy wrote:
> Ah shoot, it looks like I forgot to change flush_tlb_all -> flush_iotlb_all
> 
> Should I submit another patch?

Yes, please.

