Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC28C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C95621855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfAXOLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:11:47 -0500
Received: from 8bytes.org ([81.169.241.247]:59600 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727596AbfAXOLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:11:47 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0C0B3389; Thu, 24 Jan 2019 15:11:45 +0100 (CET)
Date:   Thu, 24 Jan 2019 15:11:45 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH v3] iommu: amd: Fix IOMMU page flush when detach device
 from a domain
Message-ID: <20190124141145.GM32526@8bytes.org>
References: <20190124041619.1974-1-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124041619.1974-1-Suravee.Suthikulpanit@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 04:16:45AM +0000, Suthikulpanit, Suravee wrote:
>  drivers/iommu/amd_iommu.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Applied, thanks Suravee.
