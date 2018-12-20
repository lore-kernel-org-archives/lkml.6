Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F240C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F5321720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbeLTJNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:13:11 -0500
Received: from 8bytes.org ([81.169.241.247]:54910 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbeLTJNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:13:11 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C99043F4; Thu, 20 Dec 2018 10:13:09 +0100 (CET)
Date:   Thu, 20 Dec 2018 10:13:09 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jroedel@suse.de, Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
Message-ID: <20181220091309.GZ16835@8bytes.org>
References: <20181211150513.15161-1-joro@8bytes.org>
 <CGME20181211150640epcas5p4ffdd63a1900ebfe4a04eea24d2c86de6@epcas5p4.samsung.com>
 <20181211150513.15161-4-joro@8bytes.org>
 <30d86186-e0a2-2be1-2295-20510fbd74ba@samsung.com>
 <20181219143451.GY16835@8bytes.org>
 <442867b9-2d36-4b14-56ee-b4bb8e6be4c0@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442867b9-2d36-4b14-56ee-b4bb8e6be4c0@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Wed, Dec 19, 2018 at 03:53:51PM +0100, Marek Szyprowski wrote:
> Yes, it fixes this issue.

Thanks a lot, patch is sent out and in iommu tree.

Regards,

	Joerg
