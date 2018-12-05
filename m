Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD94C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0F22082D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0F22082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeLEPOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:14:22 -0500
Received: from 8bytes.org ([81.169.241.247]:51878 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbeLEPOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:14:21 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 68680345; Wed,  5 Dec 2018 16:14:20 +0100 (CET)
Date:   Wed, 5 Dec 2018 16:14:20 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 2/4] iommu: Consolitate ->add/remove_device() calls
Message-ID: <20181205151420.GA16835@8bytes.org>
References: <20181205143646.4876-1-joro@8bytes.org>
 <20181205143646.4876-3-joro@8bytes.org>
 <20181205145418.GA14251@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205145418.GA14251@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 06:54:18AM -0800, Christoph Hellwig wrote:
> > +void  iommu_release_device(struct device *dev)
> 
> Nitpick: there seems to be a double space here.
> 
> > +int iommu_probe_device(struct device *dev);
> > +void  iommu_release_device(struct device *dev);
> 
> .. and here.

Right, thanks. I fixed it in my development branch.
