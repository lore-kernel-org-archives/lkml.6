Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175B3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64DD20663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64DD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438105AbeKWCrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:47:47 -0500
Received: from 8bytes.org ([81.169.241.247]:49000 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391891AbeKWCrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:47:47 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 27EB1435; Thu, 22 Nov 2018 17:07:47 +0100 (CET)
Date:   Thu, 22 Nov 2018 17:07:45 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Handle domain agaw being less than iommu agaw
Message-ID: <20181122160745.mloa7lnuylsc22sw@8bytes.org>
References: <20181121232933.158582-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121232933.158582-1-sohil.mehta@intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 03:29:33PM -0800, Sohil Mehta wrote:
>  drivers/iommu/intel-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
