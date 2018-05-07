Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeEGK0R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:26:17 -0400
Received: from verein.lst.de ([213.95.11.211]:59780 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeEGK0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:26:03 -0400
Date: Mon, 7 May 2018 12:29:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>,
        linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
        openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: dma-debug cleanups, including removing the arch hook
Message-ID: <20180507102915.GA25974@lst.de>
References: <20180424140235.9125-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424140235.9125-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments?  I'd like to move forward with this rather sooner
than later, so any reviews welcome!

On Tue, Apr 24, 2018 at 04:02:32PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series has a few dma-debug cleanups, most notably removing the need
> for architectures to explicitly initialize dma-debug.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
