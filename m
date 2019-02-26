Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03128C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03B52173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfBZKK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:10:59 -0500
Received: from 8bytes.org ([81.169.241.247]:41370 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfBZKK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:10:59 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 66B84447; Tue, 26 Feb 2019 11:10:57 +0100 (CET)
Date:   Tue, 26 Feb 2019 11:10:55 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dmitry Osipenko <digetx@gmail.com>, Baoquan He <bhe@redhat.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iommu: Kerneldoc improvements
Message-ID: <20190226101055.GD20740@8bytes.org>
References: <20190220130053.784-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220130053.784-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, Feb 20, 2019 at 02:00:50PM +0100, Geert Uytterhoeven wrote:
> This series contains a fix for an incorrect kerneldoc parameter, and
> adds the missing kerneldoc for two recently added IOMMU methods.
> 
> Thanks!
> 
> Geert Uytterhoeven (3):
>   iommu: Fix kerneldoc for iommu_ops.flush_iotlb_all()
>   iommu: Document iommu_ops.iotlb_sync_map()
>   iommu: Document iommu_ops.is_attach_deferred()
> 
>  include/linux/iommu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied patches 2 and 3, I already have a change similar to patch 1 in
the tree.

Thanks,

	Joerg
