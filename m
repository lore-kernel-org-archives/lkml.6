Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE6DC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101A320892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101A320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbeLFOQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:16:08 -0500
Received: from 8bytes.org ([81.169.241.247]:52136 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbeLFOQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:16:08 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 25A404EB; Thu,  6 Dec 2018 15:16:07 +0100 (CET)
Date:   Thu, 6 Dec 2018 15:16:07 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] iommu/of: Use helper functions to access
 dev->iommu_fwspec
Message-ID: <20181206141606.GF16835@8bytes.org>
References: <20181204163002.15800-1-joro@8bytes.org>
 <20181204163002.15800-8-joro@8bytes.org>
 <b78ab1d9-1f24-f792-04dd-26958a0739d3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b78ab1d9-1f24-f792-04dd-26958a0739d3@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:41:51PM +0000, Robin Murphy wrote:
> Nit: I think it makes sense to put this inside the "if (!err)" condition
> below rather than out here where it may or may not be relevant. The comment
> for that case is already supposed to imply that it's dealing with a fresh
> fwspec.

Right, updated that too.

Thanks,

	Joerg
