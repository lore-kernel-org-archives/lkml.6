Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeEBMkE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:40:04 -0400
Received: from verein.lst.de ([213.95.11.211]:39011 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751137AbeEBMkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:40:03 -0400
Date: Wed, 2 May 2018 14:42:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: Fix inversed DMA_ATTR_NO_WARN test
Message-ID: <20180502124236.GB22857@lst.de>
References: <20180501132411.2311-1-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180501132411.2311-1-michel@daenzer.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 03:24:11PM +0200, Michel Dänzer wrote:
> From: Michel Dänzer <michel.daenzer@amd.com>
> 
> The result was printing the warning only when we were explicitly asked
> not to.

Thanks, applied to the dma-mapping tree for 4.17.
