Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1F3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C269220872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfAKL3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:29:45 -0500
Received: from 8bytes.org ([81.169.241.247]:56896 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbfAKL3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:29:44 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 156AA44C; Fri, 11 Jan 2019 12:29:42 +0100 (CET)
Date:   Fri, 11 Jan 2019 12:29:41 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Support page request in scalable mode
Message-ID: <20190111112941.nv6p2veleipwyirs@8bytes.org>
References: <20190111050457.27234-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111050457.27234-1-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 01:04:57PM +0800, Lu Baolu wrote:
> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> VT-d Rev3.0 has made a few changes to the page request interface,
> 
> 1. widened PRQ descriptor from 128 bits to 256 bits;
> 2. removed streaming response type;
> 3. introduced private data that requires page response even the
>    request is not last request in group (LPIG).
> 
> This is a supplement to commit 1c4f88b7f1f92 ("iommu/vt-d: Shared
> virtual address in scalable mode") and makes the svm code compliant
> with VT-d Rev3.0.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Applied for v5.1, thanks.
