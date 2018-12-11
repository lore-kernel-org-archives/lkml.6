Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B1DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7808320811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7808320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLKJqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:46:46 -0500
Received: from 8bytes.org ([81.169.241.247]:53018 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeLKJqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:46:45 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 069133AF; Tue, 11 Dec 2018 10:46:43 +0100 (CET)
Date:   Tue, 11 Dec 2018 10:46:42 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        peterx@redhat.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/12] iommu/vt-d: Add scalable mode support
Message-ID: <20181211094642.hdrgyv4shu74ykrv@8bytes.org>
References: <20181210015906.27929-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210015906.27929-1-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 09:58:54AM +0800, Lu Baolu wrote:
> Lu Baolu (12):
>   iommu/vt-d: Enumerate the scalable mode capability
>   iommu/vt-d: Manage scalalble mode PASID tables
>   iommu/vt-d: Move page table helpers into header
>   iommu/vt-d: Add 256-bit invalidation descriptor support
>   iommu/vt-d: Reserve a domain id for FL and PT modes
>   iommu/vt-d: Add second level page table interface
>   iommu/vt-d: Setup pasid entry for RID2PASID support
>   iommu/vt-d: Pass pasid table to context mapping
>   iommu/vt-d: Setup context and enable RID2PASID support
>   iommu/vt-d: Add first level page table interface
>   iommu/vt-d: Shared virtual address in scalable mode
>   iommu/vt-d: Remove deferred invalidation

Applied, thanks.
