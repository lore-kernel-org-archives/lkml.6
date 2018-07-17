Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29341ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9444208DC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9444208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeGQPjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:39:05 -0400
Received: from verein.lst.de ([213.95.11.211]:51935 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbeGQPjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:39:04 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DD14B6FC87; Tue, 17 Jul 2018 17:08:32 +0200 (CEST)
Date:   Tue, 17 Jul 2018 17:08:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 2/2] dma: remove unsupported gfp_mask parameter from
        dma_alloc_from_contiguous()
Message-ID: <20180717150832.GB22408@lst.de>
References: <20180709121956.20200-1-m.szyprowski@samsung.com> <CGME20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1@eucas1p2.samsung.com> <20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1~-sqUFoa-h2939329393eucas1p2Y@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1~-sqUFoa-h2939329393eucas1p2Y@eucas1p2.samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
