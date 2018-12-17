Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC257C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886E62084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbeLQJPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:15:01 -0500
Received: from 8bytes.org ([81.169.241.247]:54448 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeLQJPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:15:01 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A47E93F4; Mon, 17 Dec 2018 10:14:59 +0100 (CET)
Date:   Mon, 17 Dec 2018 10:14:55 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/24] Tegra GART driver clean up and optimization
Message-ID: <20181217091455.kkxpyojp4r4fyhrw@8bytes.org>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:38:43PM +0300, Dmitry Osipenko wrote:
> Dmitry Osipenko (24):
>   iommu/tegra: gart: Remove pr_fmt and clean up includes
>   iommu/tegra: gart: Clean up driver probe errors handling
>   iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
>   iommu: Introduce iotlb_sync_map callback
>   iommu/tegra: gart: Optimize mapping / unmapping performance
>   dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
>   ARM: dts: tegra20: Update Memory Controller node to the new binding
>   memory: tegra: Don't invoke Tegra30+ specific memory timing setup on
>     Tegra20
>   memory: tegra: Adapt to Tegra20 device-tree binding changes
>   memory: tegra: Read client ID on GART page fault
>   memory: tegra: Use of_device_get_match_data()
>   memory: tegra: Use relaxed versions of readl/writel
>   iommu/tegra: gart: Integrate with Memory Controller driver
>   memory: tegra: Do not try to probe SMMU on Tegra20
>   memory: tegra: Do not ask for IRQ sharing
>   memory: tegra: Clean up error messages
>   iommu/tegra: gart: Fix spinlock recursion
>   iommu/tegra: gart: Fix NULL pointer dereference
>   iommu/tegra: gart: Allow only one active domain at a time
>   iommu/tegra: gart: Don't use managed resources
>   iommu/tegra: gart: Prepend error/debug messages with "gart:"
>   iommu/tegra: gart: Don't detach devices from inactive domains
>   iommu/tegra: gart: Simplify clients-tracking code
>   iommu/tegra: gart: Perform code refactoring

Applied, thanks.
