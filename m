Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A2FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA53218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfA3QYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:24:36 -0500
Received: from 8bytes.org ([81.169.241.247]:35954 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfA3QYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:24:36 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C42D15B8; Wed, 30 Jan 2019 17:24:34 +0100 (CET)
Date:   Wed, 30 Jan 2019 17:24:33 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Leave scalable mode default off
Message-ID: <20190130162433.ac3gzibnurwgubzf@8bytes.org>
References: <20190124023132.20410-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124023132.20410-1-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 10:31:32AM +0800, Lu Baolu wrote:
> Commit 765b6a98c1de3 ("iommu/vt-d: Enumerate the scalable
> mode capability") enables VT-d scalable mode if hardware
> advertises the capability. As we will bring up different
> features and use cases to upstream in different patch
> series, it will leave some intermediate kernel versions
> which support partial features. Hence, end user might run
> into problems when they use such kernels on bare metals
> or virtualization environments.
> 
> This leaves scalable mode default off and end users could
> turn it on with "intel-iommu=sm_on" only when they have
> clear ideas about which scalable features are supported
> in the kernel.
> 
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Applied to iommu/fixes, thanks.
