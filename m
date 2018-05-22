Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2401354-1526990743-2-9522956895396580948
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526990743; b=CvucgoeepUGeF/kn3EmouVhKVTlD9PBn9KhDf/rkjI+i+RK/t5
    CBvVrp7Qh2PO4+N0yb/2G8xZx2DQqtA2n2toHms+MK7F1UX3veLcw2broANgc0iC
    fIMHLlItdbc/IsOpUuLk8vto1tW2IJvYJD9qvTp98QkmZMWEneeeSsiaudmse3/J
    Oxtq5PzgHEO7l2gghjYqP2qxberl3QT2incRCmXfSWiIWMLjNtliBADmsvq4uBP/
    ZWJohtcoxbFQ0aDkhQI7RLh1UxWjOCkVvOmfHMyQ9xH6jq9qGK4SfcfPCrxawWZh
    n7fBXW1W1aZkuKVW4WZs8OPtftyMZ8JPvIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526990743; bh=
    By986hH0zoJAF0egojGGYE/aPSnpLAiQwpxv7XTUbxM=; b=Do3OTBK5yZ2Jvkmn
    +BuU9M6GV8wZrO5fKwCSIPQ0XetNQNCV8LDaQ4NkxAJM5PaETjNqn7s5lzHxV7oq
    ePNYfj4/3jM2xCj9cVqOoAkOffPA0Xa8cMX3WdXovI54IEI5TwgX5+Yet0NFs8h8
    TnScO5hAXpponb6ZlzNEcXBtAUthkGosw4xysVfsyMvfH8tZZnzttCOfYH/VG36F
    FNAW4s4ZMgqFEXr2Zxi0zx+AvVZStsjtrZ8j0TAG1Xx/FO9N9XfS/8TbVbyStl9T
    c9gBxZN6O5w2eeSd4WeeYeIir2pmcC5P30wXc7/1ZgGLBpIBEW3fEv8BrQ10LpxB
    ewWiSA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=S6dUD3dF
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=S6dUD3dF
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJSBQUZ4RKITJXXYG+azhgKpAb2xwe6yHyj8fdXc5lt1NZBOk2+v55x0bgDTY4DvTsoBpGc+Xtjd8fBh2RYcpYVCuM3GOi9DUCf8VEpBK5p64tWm70aH
    p1Y4AEObZPXyPSC/8fK9UkjJ2PnWzmyF57UVdeAoIusJ3xT7zJ+yCcWfVeRmIEBhmalS//1KAsB4BXXJXJKd/qo75fgDDvdzqDLFmgaz4qUZxblPldyrbBGg
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=Nn8QFJ3ae3rVoCDfBIgA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeEVMFk (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 08:05:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeEVMFf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:05:35 -0400
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/25] openrisc: remove the no-op unmap_page and unmap_sg DMA operations
Date: Tue, 22 May 2018 14:04:18 +0200
Message-Id: <20180522120430.28709-14-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/kernel/dma.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 47601274abf7..7cadff93d179 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -171,14 +171,6 @@ or1k_map_page(struct device *dev, struct page *page,
 	return addr;
 }
 
-static void
-or1k_unmap_page(struct device *dev, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	/* Nothing special to do here... */
-}
-
 static int
 or1k_map_sg(struct device *dev, struct scatterlist *sg,
 	    int nents, enum dma_data_direction dir,
@@ -195,19 +187,6 @@ or1k_map_sg(struct device *dev, struct scatterlist *sg,
 	return nents;
 }
 
-static void
-or1k_unmap_sg(struct device *dev, struct scatterlist *sg,
-	      int nents, enum dma_data_direction dir,
-	      unsigned long attrs)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		or1k_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, 0);
-	}
-}
-
 static void
 or1k_sync_single_for_device(struct device *dev,
 			    dma_addr_t dma_handle, size_t size,
@@ -226,9 +205,7 @@ const struct dma_map_ops or1k_dma_map_ops = {
 	.alloc = or1k_dma_alloc,
 	.free = or1k_dma_free,
 	.map_page = or1k_map_page,
-	.unmap_page = or1k_unmap_page,
 	.map_sg = or1k_map_sg,
-	.unmap_sg = or1k_unmap_sg,
 	.sync_single_for_device = or1k_sync_single_for_device,
 };
 EXPORT_SYMBOL(or1k_dma_map_ops);
-- 
2.17.0
