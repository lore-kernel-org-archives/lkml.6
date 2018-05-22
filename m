Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2473873-1526991521-2-14003652139312658949
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526991521; b=MXQGNfH4/Hk94XMXllKvCaAiJJVMtdux4WQJWo8HQuJ0t0QFMw
    /eawM+0Sm+sJ8fRSXJqX3nANTrvqa30jRf3BpmomczTxFy/Khpwd+c05za7L0MR9
    dBYvGfmAxlaTEUPHexEl6eHew8n1BWbUGkELg9cpiuPGz1OmqHwEeqoazSrdNJvf
    sww1P9+iXz22uicq1JiSm37jTvx1SEQaeyjZn1kYbpFf4Jnw8IdPd5HCjTHsU1Jt
    rplB8vIVw5+S2RAjn1CjIkiKO1tZ6BGBXgJRUQjilWk2/MXHsJqF4wayOHKZAKtE
    x6TCe2mO5NFNS+YBT+kaho0uBpmpCp0bL8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526991521; bh=
    kyE6Aw4cnPgHCFpsr9oNYySxeLLSSUyXyyh2DPozdAg=; b=aJ4qaHZMdBcA+sfK
    RYeE/O8NLvsRSurLrp/QDE+fjY7VZE2SM58TTQjLfdV4tkJ4MNVcxbcnCq04Q6gn
    pLjhOfD8dSUJZCSRti7mjNLjM1L9eN849v/a+SFmpliVOrxPOfvPYfzQwH2QlqkY
    /Rp8oZfC4VDnXi3srpq5N5TE2kDl3jig/St1jcZsNz8aX5i4bxLaZE8dGrcimV7h
    Rstd8CCiHVPdSEdbDfzhlJyX4i5ZxtvZl8H7xv37iF8y9xV93O+Lx17P+pzevYjC
    l+HRErqX+Va01ZZZ05rktr41y9OZf2jLpzuH1VI4LgFC5EK4E88kgn35W0sUTxLO
    KWLIVw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=LeDIcUb4
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=LeDIcUb4
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
X-CM-Envelope: MS4wfLgqsc17E6VI89pLgIh5rcGr/ebmQS0ZVEUfAr9uMAN1yfjnhU79Q9/n7GJbWSR7oanu7FePrEBLewc1ddN6LWJBITZdpk1Kf09D+170df3PLxnwX0zB
    ztR+DQM655EkfFNcON8LSj3tm3ikVfRtTFK6GWEoOw9HqNiWxcbVDIDlaLkYw58e2w1mFYn8pqeZgRATXlwQ2ixmWrhokpRmxSDF9QfkXpjVhM91yJGpYef/
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=1Globa1LCAbgVrIlkOEA:9
    a=LiGxKPD4eg6FFFP1:21 a=eYkWQm3U0N5MAjXa:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeEVMSg (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 08:18:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeEVME6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:04:58 -0400
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
Subject: [PATCH 04/25] m68k: use generic dma_noncoherent_ops
Date: Tue, 22 May 2018 14:04:09 +0200
Message-Id: <20180522120430.28709-5-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522120430.28709-1-hch@lst.de>
References: <20180522120430.28709-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Switch to the generic noncoherent direct mapping implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/Kconfig                   |  2 +
 arch/m68k/include/asm/Kbuild        |  1 +
 arch/m68k/include/asm/dma-mapping.h | 12 -----
 arch/m68k/kernel/dma.c              | 68 ++++-------------------------
 4 files changed, 11 insertions(+), 72 deletions(-)
 delete mode 100644 arch/m68k/include/asm/dma-mapping.h

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 785612b576f7..3f61327da2d5 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -2,6 +2,7 @@
 config M68K
 	bool
 	default y
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select HAVE_IDE
@@ -24,6 +25,7 @@ config M68K
 	select MODULES_USE_ELF_RELA
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
+	select DMA_NONCOHERENT_OPS if HAS_DMA
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 88a9d27df1ac..a853c00f1374 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,5 +1,6 @@
 generic-y += barrier.h
 generic-y += device.h
+generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
diff --git a/arch/m68k/include/asm/dma-mapping.h b/arch/m68k/include/asm/dma-mapping.h
deleted file mode 100644
index e3722ed04fbb..000000000000
--- a/arch/m68k/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _M68K_DMA_MAPPING_H
-#define _M68K_DMA_MAPPING_H
-
-extern const struct dma_map_ops m68k_dma_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-        return &m68k_dma_ops;
-}
-
-#endif  /* _M68K_DMA_MAPPING_H */
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index c01b9b8f97bf..3d561c577d35 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -6,7 +6,7 @@
 
 #undef DEBUG
 
-#include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/scatterlist.h>
@@ -18,7 +18,7 @@
 
 #if defined(CONFIG_MMU) && !defined(CONFIG_COLDFIRE)
 
-static void *m68k_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		gfp_t flag, unsigned long attrs)
 {
 	struct page *page, **map;
@@ -61,7 +61,7 @@ static void *m68k_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	return addr;
 }
 
-static void m68k_dma_free(struct device *dev, size_t size, void *addr,
+void arch_dma_free(struct device *dev, size_t size, void *addr,
 		dma_addr_t handle, unsigned long attrs)
 {
 	pr_debug("dma_free_coherent: %p, %x\n", addr, handle);
@@ -72,8 +72,8 @@ static void m68k_dma_free(struct device *dev, size_t size, void *addr,
 
 #include <asm/cacheflush.h>
 
-static void *m68k_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	void *ret;
 
@@ -88,7 +88,7 @@ static void *m68k_dma_alloc(struct device *dev, size_t size,
 	return ret;
 }
 
-static void m68k_dma_free(struct device *dev, size_t size, void *vaddr,
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	free_pages((unsigned long)vaddr, get_order(size));
@@ -96,8 +96,8 @@ static void m68k_dma_free(struct device *dev, size_t size, void *vaddr,
 
 #endif /* CONFIG_MMU && !CONFIG_COLDFIRE */
 
-static void m68k_dma_sync_single_for_device(struct device *dev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t handle,
+		size_t size, enum dma_data_direction dir)
 {
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
@@ -113,55 +113,3 @@ static void m68k_dma_sync_single_for_device(struct device *dev,
 		break;
 	}
 }
-
-static void m68k_dma_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sglist, int nents, enum dma_data_direction dir)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nents, i) {
-		dma_sync_single_for_device(dev, sg->dma_address, sg->length,
-					   dir);
-	}
-}
-
-static dma_addr_t m68k_dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	dma_addr_t handle = page_to_phys(page) + offset;
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_sync_single_for_device(dev, handle, size, dir);
-
-	return handle;
-}
-
-static int m68k_dma_map_sg(struct device *dev, struct scatterlist *sglist,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nents, i) {
-		sg->dma_address = sg_phys(sg);
-
-		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-			continue;
-
-		dma_sync_single_for_device(dev, sg->dma_address, sg->length,
-					   dir);
-	}
-	return nents;
-}
-
-const struct dma_map_ops m68k_dma_ops = {
-	.alloc			= m68k_dma_alloc,
-	.free			= m68k_dma_free,
-	.map_page		= m68k_dma_map_page,
-	.map_sg			= m68k_dma_map_sg,
-	.sync_single_for_device	= m68k_dma_sync_single_for_device,
-	.sync_sg_for_device	= m68k_dma_sync_sg_for_device,
-};
-EXPORT_SYMBOL(m68k_dma_ops);
-- 
2.17.0
