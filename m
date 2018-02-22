Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeBVXDb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:03:31 -0500
Received: from verein.lst.de ([213.95.11.211]:58327 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751432AbeBVXDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:03:30 -0500
Date: Fri, 23 Feb 2018 00:03:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: miles.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] lib/dma-debug.c: fix memory leakage
Message-ID: <20180222230329.GA2820@lst.de>
References: <1519298540-3071-1-git-send-email-miles.chen@mediatek.com> <6df7e9bd-2203-0692-97e4-8c6434304b0f@arm.com> <1519298540-3071-1-git-send-email-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6df7e9bd-2203-0692-97e4-8c6434304b0f@arm.com> <1519298540-3071-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied to the dma mapping tree for 4.16, including the Fixes
tag.
