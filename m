Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AEDC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F6F21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfAXOUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:20:02 -0500
Received: from 8bytes.org ([81.169.241.247]:59608 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbfAXOUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:20:02 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7E20A25A; Thu, 24 Jan 2019 15:20:00 +0100 (CET)
Date:   Thu, 24 Jan 2019 15:19:59 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH v3] iommu: amd: Fix IOMMU page flush when detach device
 from a domain
Message-ID: <20190124141958.q3zwkpulwyr32fge@8bytes.org>
References: <20190124041619.1974-1-Suravee.Suthikulpanit@amd.com>
 <20190124141145.GM32526@8bytes.org>
 <c965ccfb-1a98-1fc2-5980-2d7f17688e54@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c965ccfb-1a98-1fc2-5980-2d7f17688e54@amd.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 02:17:34PM +0000, Suthikulpanit, Suravee wrote:
> On 1/24/19 9:11 PM, joro@8bytes.org wrote:
> > On Thu, Jan 24, 2019 at 04:16:45AM +0000, Suthikulpanit, Suravee wrote:
> >>   drivers/iommu/amd_iommu.c | 15 +++++++++++----
> >>   1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > Applied, thanks Suravee.
> > 
> 
> Thanks. Also, should this also back-ported to stable tree as well?

I added a Fixes tag, so stable should pick it up.


	Joerg
