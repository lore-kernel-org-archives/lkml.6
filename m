Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887EDC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548DF20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548DF20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeLLKne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:43:34 -0500
Received: from 8bytes.org ([81.169.241.247]:53782 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeLLKnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:43:33 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5145D3D8; Wed, 12 Dec 2018 11:43:31 +0100 (CET)
Date:   Wed, 12 Dec 2018 11:43:31 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/21] IOMMU: Tegra GART driver clean up and
 optimization
Message-ID: <20181212104331.GW16835@8bytes.org>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181211095317.tv43aaefnsezmic7@8bytes.org>
 <20181212102415.GM15092@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212102415.GM15092@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry, Hi Dmitry,

On Wed, Dec 12, 2018 at 11:24:15AM +0100, Thierry Reding wrote:
> So appart from the one issue in the "memory controller integration"
> patch this looks good and I've acked the remaining patches. Once the one
> remaining issue is fixed I think this is ready to be merged.
> 
> Joerg, given the dependencies between the various parts of the series, I
> think it may be better for you to merge everything through the IOMMU
> tree if you don't mind.

Sounds good. Dmitry, can you please address Thierry's comments on patch
13, add his Acks on the other patches and re-send? I'll queue it in the
iommu-tree then.

Regards,

	Joerg
