Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA046C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B212E214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B212E214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbeLFPgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:36:47 -0500
Received: from 8bytes.org ([81.169.241.247]:52156 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeLFPgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:36:47 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2B517209; Thu,  6 Dec 2018 16:36:45 +0100 (CET)
Date:   Thu, 6 Dec 2018 16:36:45 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Introduce device_iommu_maped() function
Message-ID: <20181206153644.GH16835@8bytes.org>
References: <20181204172504.19708-1-joro@8bytes.org>
 <e34dcbe8-2f1b-31bb-2093-542361635cf5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e34dcbe8-2f1b-31bb-2093-542361635cf5@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:17:29PM +0000, Robin Murphy wrote:
> On 04/12/2018 17:24, Joerg Roedel wrote:

> Nice, we can also clean up a whole load of vague iommu_present() usage and
> even one or two odd iommu_get_domain_for_dev() calls once we have this.

Right, I didn't think of that yet, but it's certainly true.

> There looks to be one more here:
> 
> drivers/dma/sh/rcar-dmac.c: rcar_dmac_probe()

True, I added a patch for that too.

> Other than that and a minor comment on the OF/IORT part, though, for the
> whole series:
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks, I added you Acked-by to the 5 patches I posted here.


Regards,

	Joerg
