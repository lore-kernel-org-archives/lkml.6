Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63E8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939C32086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939C32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbeK0VJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:09:21 -0500
Received: from 8bytes.org ([81.169.241.247]:50428 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730433AbeK0VJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:09:21 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A177632E; Tue, 27 Nov 2018 11:11:56 +0100 (CET)
Date:   Tue, 27 Nov 2018 11:11:56 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <gnurou@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Hiroshi Doyu <hdoyu@nvidia.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nate Watterson <nwatters@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Simon Xue <xxm@rock-chips.com>,
        Stepan Moskovchenko <stepanm@codeaurora.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/9] iommu: clean up/remove modular stuff from
 non-modules.
Message-ID: <20181127101156.GA12298@8bytes.org>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

thanks for your cleanup!

The iommu-tree uses another rule for the subject line of patches. Can
you please resend with correct subject lines? See below for what is
used.

The general format is:

	iommu/<driver>: _C_apital letter starting subject

Please also collect the Acks you get and add them to the patches before
the resend.

On Mon, Nov 26, 2018 at 05:31:29PM -0500, Paul Gortmaker wrote:
> Paul Gortmaker (9):
>   iommu: audit and remove any unnecessary uses of module.h
Fine.
>   iommu: rockchip: make it explicitly non-modular
	iommu/rockchip: Make it explicitly non-modular
>   iommu: msm_iommu: make it explicitly non-modular
	iommu/msm: Make it explicitly non-modular
>   iommu: mtk_iommu: make it explicitly non-modular
	iommu/mediatek: Make it explicitly non-modular
>   iommu: ipmmu-vmsa: make it explicitly non-modular
	iommu/ipmmu-vmsa: Make it explicitly non-modular
>   iommu: qcom_iommu: make it explicitly non-modular
	iommu/qcom: Make it explicitly non-modular
>   iommu: tegra-gart: make it explicitly non-modular
	iommu/tegra: Make it explicitly non-modular
>   iommu: arm-smmu: make it explicitly non-modular
	iommu/arm-smmu: Make arm-smmu explicitly non-modular
>   iommu: arm-smmu-v3: make it explicitly non-modular
	iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular

Thanks a lot,

       Joerg
