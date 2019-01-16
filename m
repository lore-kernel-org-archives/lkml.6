Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8DEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D5020675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394526AbfAPRJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:09:38 -0500
Received: from 8bytes.org ([81.169.241.247]:58038 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731892AbfAPRJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:09:38 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0F7A6396; Wed, 16 Jan 2019 18:09:36 +0100 (CET)
Date:   Wed, 16 Jan 2019 18:09:36 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Message-ID: <20190116170936.GE4681@8bytes.org>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
 <df209299-8fd1-189c-9c44-b398cf790d1a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df209299-8fd1-189c-9c44-b398cf790d1a@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 02:40:59PM +0000, Suthikulpanit, Suravee wrote:
> Actually, device_flush_dte(alias) should be needed regardless of this patch.
> Are you planning to add this?

Yes, I stumbled over this while writing the diff. I'll submit that as a
separate patch.

Thanks,

	Joerg
