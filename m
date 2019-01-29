Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108D8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE64E2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfA2RNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:13:55 -0500
Received: from verein.lst.de ([213.95.11.211]:47392 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfA2RNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:13:54 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E2B0C68D93; Tue, 29 Jan 2019 18:13:52 +0100 (CET)
Date:   Tue, 29 Jan 2019 18:13:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
Subject: Re: [PATCH 5/5] virtio-blk: Consider virtio_max_dma_size() for
 maximum segment size
Message-ID: <20190129171352.GE15195@lst.de>
References: <20190129084342.26030-1-joro@8bytes.org> <20190129084342.26030-6-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129084342.26030-6-joro@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 09:43:42AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Segments can't be larger than the maximum DMA mapping size
> supported on the platform. Take that into account when
> setting the maximum segment size for a block device.
> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
