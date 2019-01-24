Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AE9C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB4B218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfAXNWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:22:54 -0500
Received: from 8bytes.org ([81.169.241.247]:59588 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfAXNWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:22:54 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 10E37389; Thu, 24 Jan 2019 14:22:51 +0100 (CET)
Date:   Thu, 24 Jan 2019 14:22:50 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Leave scalable mode default off
Message-ID: <20190124132250.k3rnlpaqazmatzaf@8bytes.org>
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

I don't get it, can you be more specific about the problems that users
might run into? And is this patch needed as a fix for v5.0 or is it just
a precaution because future patches might break something for users?


Regards,

	Joerg
