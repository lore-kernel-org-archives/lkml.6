Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FF2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23652084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfBHQX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:23:59 -0500
Received: from 8bytes.org ([81.169.241.247]:38998 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfBHQX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:23:59 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BDF8216F; Fri,  8 Feb 2019 17:23:57 +0100 (CET)
Date:   Fri, 8 Feb 2019 17:23:57 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unused end_pfn
Message-ID: <20190208162357.GX32526@8bytes.org>
References: <2017datesandletters@somehostname>
 <20190208140439.26738-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208140439.26738-1-murphyt7@tcd.ie>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 02:04:38PM +0000, Tom Murphy wrote:
> This variable is useless.
> 
> ---
>  drivers/iommu/dma-iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

A similar change is already in the iommu tree[1].

	Joerg

[1] https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=core

