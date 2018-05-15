Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeEOSFl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:05:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752971AbeEOSFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:05:37 -0400
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] swiotlb: remove a pointless comment
Date: Tue, 15 May 2018 20:05:18 +0200
Message-Id: <20180515180523.3038-2-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515180523.3038-1-hch@lst.de>
References: <20180515180523.3038-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This comments describes an aspect of the map_sg interface that isn't
even exploited by swiotlb.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 16ace0e25d52..721f93677eee 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -927,12 +927,6 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
  * appropriate dma address and length.  They are obtained via
  * sg_dma_{address,length}(SG).
  *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
  * Device ownership issues as mentioned above for swiotlb_map_page are the
  * same here.
  */
-- 
2.17.0
