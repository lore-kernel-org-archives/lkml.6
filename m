Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF88C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DBD2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfBZK4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:56:10 -0500
Received: from 8bytes.org ([81.169.241.247]:41426 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfBZK4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:56:10 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0019B41A; Tue, 26 Feb 2019 11:56:08 +0100 (CET)
Date:   Tue, 26 Feb 2019 11:56:07 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     dwmw2@infradead.org, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, jisben@google.com,
        xmdong@google.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Check identity map for hot-added devices
Message-ID: <20190226105607.GI20740@8bytes.org>
References: <20190225024636.32418-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225024636.32418-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:46:36AM +0800, Lu Baolu wrote:
>  drivers/iommu/intel-iommu.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Added a Fixes: tag and applied the patch, thanks.

