Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ED0C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D96020989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D96020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeLGNIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:08:39 -0500
Received: from 8bytes.org ([81.169.241.247]:52404 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeLGNIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:08:39 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E3C16239; Fri,  7 Dec 2018 14:08:37 +0100 (CET)
Date:   Fri, 7 Dec 2018 14:08:34 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu: fix amd_iommu=force_isolation
Message-ID: <20181207130834.ggpiaersetqot5t2@8bytes.org>
References: <20181204223716.214159-1-yuzhao@google.com>
 <20181206213915.196205-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206213915.196205-1-yuzhao@google.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 02:39:15PM -0700, Yu Zhao wrote:
> Fixes: aafd8ba0ca74 ("iommu/amd: Implement add_device and remove_device")
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  drivers/iommu/amd_iommu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied, thanks.

