Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F040EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA612184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbfA3Q04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:26:56 -0500
Received: from 8bytes.org ([81.169.241.247]:35968 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbfA3Q04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:26:56 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 10C0C5B8; Wed, 30 Jan 2019 17:26:54 +0100 (CET)
Date:   Wed, 30 Jan 2019 17:26:53 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: print reason for iommu_map_page failure in
 map_sg
Message-ID: <20190130162653.ji6megm3al3uf6zt@8bytes.org>
References: <20190129005937.32487-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129005937.32487-1-jsnitsel@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:59:37PM -0700, Jerry Snitselaar wrote:
> Since there are multiple possible failures in iommu_map_page
> it would be useful to know which case is being hit when the
> error message is printed in map_sg. While here, fix up checkpatch
> complaint about using function name in a string instead of
> __func__.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Applied, thanks.

