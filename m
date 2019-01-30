Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3B1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA1A2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbfA3QbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:31:15 -0500
Received: from 8bytes.org ([81.169.241.247]:35972 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731839AbfA3QbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:31:12 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 85F2E5B8; Wed, 30 Jan 2019 17:31:11 +0100 (CET)
Date:   Wed, 30 Jan 2019 17:31:10 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 2/2] iommu/amd: Remove clear_flush_young notifier
Message-ID: <20190130163110.muqt3wt2bpvmyseq@8bytes.org>
References: <20190130055758.3994-1-peterx@redhat.com>
 <20190130055758.3994-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130055758.3994-3-peterx@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:57:58PM +0800, Peter Xu wrote:
> AMD IOMMU driver is using the clear_flush_young() to do cache flushing
> but that's actually already covered by invalidate_range().  Remove the
> extra notifier and the chunks.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Applied to x86/amd, thanks.

