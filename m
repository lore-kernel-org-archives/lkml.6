Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1D0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F3F206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F3F206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeK2Cec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:34:32 -0500
Received: from mail1.windriver.com ([147.11.146.13]:46904 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbeK2Ceb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:34:31 -0500
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wASFWCRF011446
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 28 Nov 2018 07:32:12 -0800 (PST)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Wed, 28 Nov 2018 07:32:05 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 36C162E130B; Wed, 28 Nov 2018 10:32:05 -0500 (EST)
Date:   Wed, 28 Nov 2018 10:32:05 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular
Message-ID: <20181128153204.GI14659@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
 <1543271498-28966-6-git-send-email-paul.gortmaker@windriver.com>
 <cdded4c3-4bc5-39b3-ebc9-64fa145c9242@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cdded4c3-4bc5-39b3-ebc9-64fa145c9242@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular] On 28/11/2018 (Wed 12:50) Robin Murphy wrote:

> On 26/11/2018 22:31, Paul Gortmaker wrote:

[...]

> >diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> >index 9e2655f1c1bf..de39ef992d8a 100644
> >--- a/drivers/iommu/ipmmu-vmsa.c
> >+++ b/drivers/iommu/ipmmu-vmsa.c
> >@@ -1,6 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * IPMMU VMSA
> 
> Nit: this line doesn't convey any information that the module description
> below doesn't also say far more clearly, so you may as well just replace it
> entirely.

No problem. Will do in v2.

P.
--

> 
> Robin.
> 
> >+ * IOMMU API for Renesas VMSA-compatible IPMMU
> >+ * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[...]
