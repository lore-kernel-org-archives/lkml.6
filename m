Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2463566-1526990779-2-7442110883038017476
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526990778; b=cM6Bm7LP/kWxCvrKfB7HWjNqKrKsinUmH5lRHSL01Ezy/Or7ag
    rLinuJp2M5y1amQI0UeWNxYJUfKuyh/64t3wY6KsC53IlLBJFfyiru7AwBh4nraq
    Ogo3jXXo56XHYKbepvMBS7Yk6IEpi6Fm3EAgMdn+puQFrBlVU5htc3bND8s2weM4
    5OvOh9I0Y8r7tl2ukJ0TIguWnjfRE6tjX7o+slwF/ocM5+ysr6ubdC22ji2k7/Dz
    8xpn6xH4cJHZdNSCqZRl7hjxaK9w3ypYxl2nxzyKTmVL//lbj78GElspiWhSBJRZ
    QyFg7H7j6gpiaJdu/lKJQW5AuOBjKKISgouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526990778; bh=
    E+ntzFfgx7YXA5epJcDsELMGSsFmVtfe/rYYmI+CxdA=; b=cllwX9tfUhbaRzhh
    f9MIqO5gsnNB/CNOzFWldAaC+yRI3kmlJDkrwOBC6/t/KuPeHrpEyzgjnv6tlXsK
    Rj6tr4JeDxgrugQSh7YHTrb1yqogoNVUWsLFJbPxAWSEBZIdXJxcgHMbHlO4lDYF
    ZnayffIJD9U5Y2/cNS+U4+o+CG48F+uTsyjSsxjxnJA13eIKEyzm9dzz1NmxygH6
    04lN9AsODlQWckqlNZJHc1CDveSeh15+FlQfr5JyJMfsnAE9Ab4eOSqjkYiJ4rFC
    PmW4lfWMBYdqhzs90GbqLdHLxju0kpiZsTh5ihi2erHWYH2Fk8lrPXAVajC8o7rU
    bCdDSg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=eXXJ7N8C
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=eXXJ7N8C
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
X-CM-Envelope: MS4wfAPGLsAuLI28ZNDUEicyiSgxNESaIukxePFsmKKyukcoryyY1AJ1LMICKBV12c15qZsGdANyXCk7Xon2gWckmH6ugdgHyp1ZwhmTrgq4hhzy/+2A6dUr
    U9jtXp4INoSQ+atiE/en8OXwdcURcoMx0n36OjcWzqLIftSWD3athumiFzaFGBW6p6P8u3U9BTfI8zxRII7k+2pS8mHbGXOSZ5GXEnHoSxVN7r2SSBtshY2B
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=6llCMZQGAES-Mta6dj4A:9
    a=DeZHcT2oNLa7kkqT:21 a=dUsOPc9ZFMnm9uUs:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeEVMGM (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 08:06:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeEVMGJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:06:09 -0400
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
Subject: [PATCH 22/25] sparc: use generic dma_noncoherent_ops
Date: Tue, 22 May 2018 14:04:27 +0200
Message-Id: <20180522120430.28709-23-hch@lst.de>
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

This removes the previous sync_single_for_device implementation, which
looks bogus given that no syncing is happening in the similar but more
important map_single case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/Kconfig                   |   2 +
 arch/sparc/include/asm/dma-mapping.h |   5 +-
 arch/sparc/kernel/ioport.c           | 151 ++-------------------------
 3 files changed, 14 insertions(+), 144 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 435dbc033afe..0889b4eabf8b 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -48,6 +48,8 @@ config SPARC
 
 config SPARC32
 	def_bool !64BIT
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select DMA_NONCOHERENT_OPS
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
 	select HAVE_UID16
diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 12ae33daf52f..e17566376934 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -7,7 +7,6 @@
 #include <linux/dma-debug.h>
 
 extern const struct dma_map_ops *dma_ops;
-extern const struct dma_map_ops pci32_dma_ops;
 
 extern struct bus_type pci_bus_type;
 
@@ -15,11 +14,11 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 #ifdef CONFIG_SPARC_LEON
 	if (sparc_cpu_model == sparc_leon)
-		return &pci32_dma_ops;
+		return &dma_noncoherent_ops;
 #endif
 #if defined(CONFIG_SPARC32) && defined(CONFIG_PCI)
 	if (bus == &pci_bus_type)
-		return &pci32_dma_ops;
+		return &dma_noncoherent_ops;
 #endif
 	return dma_ops;
 }
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 3bcef9ce74df..7954512c42e7 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -38,6 +38,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/of_device.h>
 
 #include <asm/io.h>
@@ -434,9 +435,8 @@ arch_initcall(sparc_register_ioport);
 /* Allocate and map kernel buffer using consistent mode DMA for a device.
  * hwdev should be valid struct pci_dev pointer for PCI devices.
  */
-static void *pci32_alloc_coherent(struct device *dev, size_t len,
-				  dma_addr_t *pba, gfp_t gfp,
-				  unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t len, dma_addr_t *pba, gfp_t gfp,
+		unsigned long attrs)
 {
 	unsigned long len_total = PAGE_ALIGN(len);
 	void *va;
@@ -488,8 +488,8 @@ static void *pci32_alloc_coherent(struct device *dev, size_t len,
  * References to the memory and mappings associated with cpu_addr/dma_addr
  * past this call are illegal.
  */
-static void pci32_free_coherent(struct device *dev, size_t n, void *p,
-				dma_addr_t ba, unsigned long attrs)
+void arch_dma_free(struct device *dev, size_t n, void *p, dma_addr_t ba,
+		unsigned long attrs)
 {
 	struct resource *res;
 
@@ -519,146 +519,15 @@ static void pci32_free_coherent(struct device *dev, size_t n, void *p,
 	free_pages((unsigned long)phys_to_virt(ba), get_order(n));
 }
 
-/*
- * Same as pci_map_single, but with pages.
- */
-static dma_addr_t pci32_map_page(struct device *dev, struct page *page,
-				 unsigned long offset, size_t size,
-				 enum dma_data_direction dir,
-				 unsigned long attrs)
-{
-	/* IIep is write-through, not flushing. */
-	return page_to_phys(page) + offset;
-}
-
-static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
-			     enum dma_data_direction dir, unsigned long attrs)
-{
-	if (dir != PCI_DMA_TODEVICE && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_make_coherent(ba, PAGE_ALIGN(size));
-}
-
-/* Map a set of buffers described by scatterlist in streaming
- * mode for DMA.  This is the scatter-gather version of the
- * above pci_map_single interface.  Here the scatter gather list
- * elements are each tagged with the appropriate dma address
- * and length.  They are obtained via sg_dma_{address,length}(SG).
- *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
- * Device ownership issues as mentioned above for pci_map_single are
- * the same here.
- */
-static int pci32_map_sg(struct device *device, struct scatterlist *sgl,
-			int nents, enum dma_data_direction dir,
-			unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int n;
-
-	/* IIep is write-through, not flushing. */
-	for_each_sg(sgl, sg, nents, n) {
-		sg->dma_address = sg_phys(sg);
-		sg->dma_length = sg->length;
-	}
-	return nents;
-}
-
-/* Unmap a set of streaming mode DMA translations.
- * Again, cpu read rules concerning calls here are the same as for
- * pci_unmap_single() above.
- */
-static void pci32_unmap_sg(struct device *dev, struct scatterlist *sgl,
-			   int nents, enum dma_data_direction dir,
-			   unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int n;
-
-	if (dir != PCI_DMA_TODEVICE && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
-		for_each_sg(sgl, sg, nents, n) {
-			dma_make_coherent(sg_phys(sg), PAGE_ALIGN(sg->length));
-		}
-	}
-}
+/* IIep is write-through, not flushing on cpu to device transfer. */
 
-/* Make physical memory consistent for a single
- * streaming mode DMA translation before or after a transfer.
- *
- * If you perform a pci_map_single() but wish to interrogate the
- * buffer using the cpu, yet do not wish to teardown the PCI dma
- * mapping, you must call this function before doing so.  At the
- * next point you give the PCI dma address back to the card, you
- * must first perform a pci_dma_sync_for_device, and then the
- * device again owns the buffer.
- */
-static void pci32_sync_single_for_cpu(struct device *dev, dma_addr_t ba,
-				      size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-	if (dir != PCI_DMA_TODEVICE) {
-		dma_make_coherent(ba, PAGE_ALIGN(size));
-	}
-}
-
-static void pci32_sync_single_for_device(struct device *dev, dma_addr_t ba,
-					 size_t size, enum dma_data_direction dir)
-{
-	if (dir != PCI_DMA_TODEVICE) {
-		dma_make_coherent(ba, PAGE_ALIGN(size));
-	}
+	if (dir != PCI_DMA_TODEVICE)
+		dma_make_coherent(paddr, PAGE_ALIGN(size));
 }
 
-/* Make physical memory consistent for a set of streaming
- * mode DMA translations after a transfer.
- *
- * The same as pci_dma_sync_single_* but for a scatter-gather list,
- * same rules and usage.
- */
-static void pci32_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
-				  int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int n;
-
-	if (dir != PCI_DMA_TODEVICE) {
-		for_each_sg(sgl, sg, nents, n) {
-			dma_make_coherent(sg_phys(sg), PAGE_ALIGN(sg->length));
-		}
-	}
-}
-
-static void pci32_sync_sg_for_device(struct device *device, struct scatterlist *sgl,
-				     int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int n;
-
-	if (dir != PCI_DMA_TODEVICE) {
-		for_each_sg(sgl, sg, nents, n) {
-			dma_make_coherent(sg_phys(sg), PAGE_ALIGN(sg->length));
-		}
-	}
-}
-
-/* note: leon re-uses pci32_dma_ops */
-const struct dma_map_ops pci32_dma_ops = {
-	.alloc			= pci32_alloc_coherent,
-	.free			= pci32_free_coherent,
-	.map_page		= pci32_map_page,
-	.unmap_page		= pci32_unmap_page,
-	.map_sg			= pci32_map_sg,
-	.unmap_sg		= pci32_unmap_sg,
-	.sync_single_for_cpu	= pci32_sync_single_for_cpu,
-	.sync_single_for_device	= pci32_sync_single_for_device,
-	.sync_sg_for_cpu	= pci32_sync_sg_for_cpu,
-	.sync_sg_for_device	= pci32_sync_sg_for_device,
-};
-EXPORT_SYMBOL(pci32_dma_ops);
-
 const struct dma_map_ops *dma_ops = &sbus_dma_ops;
 EXPORT_SYMBOL(dma_ops);
 
-- 
2.17.0
