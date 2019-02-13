Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D06C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34568218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393608AbfBMSNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:13:21 -0500
Received: from verein.lst.de ([213.95.11.211]:44486 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388861AbfBMSNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:13:21 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ABB6468C8E; Wed, 13 Feb 2019 19:13:19 +0100 (CET)
Date:   Wed, 13 Feb 2019 19:13:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: add config symbols for arch_{setup,teardown}_dma_ops
Message-ID: <20190213181319.GB19606@lst.de>
References: <20190204081420.15083-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204081420.15083-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Catalin and Paul.  I've merged this into the dma-mapping
for-next branch.
