Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3632397-1526025774-2-3125351903377420517
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526025774; b=AXc0/fuZT5czWaqo7uSpzLYNxFHCJhhrCgaguo3YVz4viWtMQZ
    2ai2TGEaBSfWrBJts+FETnC4RmFzeLZH4hl2igcB8KsZwZWCSPNiwYgbznw1sYC/
    ilc+wg64lDXz14wb3DH7kt48zqn9HMmZoVkniV8x2qrddgw3380S/a12RkMAT43g
    qRQHYVOBbyTv7VcMQEwRljtNhmKWhasAyIbe6UKqYofsaWbGCYEDsJUPQSyPsLg9
    6lwNs2OaRvUJyHgD08SjFHkC8JSDvigtm7tkAzYyYIhDBFqA3X1GT/ooDwSwbjxX
    Wt4Jt2AqN4vs6l18k88vlABkc5HU4XqIuAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526025774; bh=
    mc+66cpLgGJrF8TqjhED7vezJOUwyDTPecUGyKpn7oE=; b=jkcxCDA9jqQM928R
    AylIF3HoKgqclxU25K910I+oBrIPjy4rZmz7S5y4GYtJP4jhS5HT+LDep0+5/XRx
    H/RY47JzJnw6iBKWr+H5kxgvRqhYXNKEo6sRSkA35JxsO6yjewdY7FbvkuhGk/yv
    +9YJRRuyGiWRYyIzvqKWBiYqQVriOt77YlyyBeNsmWA1MzDbZ5NPzdUoyblhkemT
    6IItXmr08E+J6qjOrAUy0ZwItrvROtknl9/+JX8iKoQeKFwhBUoDnsZwErDcO27S
    Gx/SABnV9GcdKIwwgmjyyd9lWf3ya5/a6fbbzUYb96gxizgkBYbCB6eyVwTT+69O
    KT/hGw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=XwfyEMdk
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
      header.d=infradead.org header.i=@infradead.org header.b=XwfyEMdk
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
X-CM-Envelope: MS4wfKv5PX8WWbtW7DKtUNXKq3xXwnTDpkJj0UuSNJFktyzIJJ5u6Us68bHDjVMmrjlFERRa1Cy6/OcvdACIdgGmz7w/QipN14Tu5i9jCu3hJ40nSk0LS3KO
    aGOgaodK71PkdSzUQ8AXBaio6+Nnm+YBhHGUaZI7QoAYCKd4BfuIps9RwdJjGOwf+bnrbpbYnR5uoKSo8VGU9th9q5nurbWwF9z09uYYqIYvFUf7hpc2nFRP
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=4kK0doguKl6wwCPbyP0A:9
    a=2fRGtxBThEPbubwI:21 a=2YxqEkJN9SrATvaK:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeEKICs (ORCPT <rfc822;linux@kroah.com>);
        Fri, 11 May 2018 04:02:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeEKICT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 May 2018 04:02:19 -0400
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
Subject: [PATCH 15/20] sh: use dma_direct_ops for the CONFIG_DMA_COHERENT case
Date: Fri, 11 May 2018 09:59:40 +0200
Message-Id: <20180511075945.16548-16-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511075945.16548-1-hch@lst.de>
References: <20180511075945.16548-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a slight change in behavior as we avoid the detour through the
virtual mapping for the coherent allocator, but if this CPU really is
coherent that should be the right thing to do.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig                   | 1 +
 arch/sh/include/asm/dma-mapping.h | 4 ++++
 arch/sh/kernel/Makefile           | 4 ++--
 arch/sh/kernel/dma-nommu.c        | 4 ----
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7d521926041e..d0b095323d62 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -157,6 +157,7 @@ config SWAP_IO_SPACE
 	bool
 
 config DMA_COHERENT
+	select DMA_DIRECT_OPS
 	bool
 
 config DMA_NONCOHERENT
diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index 149e71f95be7..1ebc6a4eb1c5 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -6,7 +6,11 @@ extern const struct dma_map_ops nommu_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
+#ifdef CONFIG_DMA_NONCOHERENT
 	return &nommu_dma_ops;
+#else
+	return &dma_direct_ops;
+#endif
 }
 
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index dc80041f7363..cb5f1bfb52de 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -12,7 +12,7 @@ endif
 
 CFLAGS_REMOVE_return_address.o = -pg
 
-obj-y	:= debugtraps.o dma-nommu.o dumpstack.o 		\
+obj-y	:= debugtraps.o dumpstack.o 		\
 	   idle.o io.o irq.o irq_$(BITS).o kdebugfs.o			\
 	   machvec.o nmi_debug.o process.o				\
 	   process_$(BITS).o ptrace.o ptrace_$(BITS).o			\
@@ -45,7 +45,7 @@ obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o
 obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
-
+obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-nommu.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
 
 ccflags-y := -Werror
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index 79a9edafa5b0..d8689b1cb743 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -51,7 +51,6 @@ static int nommu_map_sg(struct device *dev, struct scatterlist *sg,
 	return nents;
 }
 
-#ifdef CONFIG_DMA_NONCOHERENT
 static void nommu_sync_single_for_device(struct device *dev, dma_addr_t addr,
 			      size_t size, enum dma_data_direction dir)
 {
@@ -67,16 +66,13 @@ static void nommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	for_each_sg(sg, s, nelems, i)
 		sh_sync_dma_for_device(sg_virt(s), s->length, dir);
 }
-#endif
 
 const struct dma_map_ops nommu_dma_ops = {
 	.alloc			= dma_generic_alloc_coherent,
 	.free			= dma_generic_free_coherent,
 	.map_page		= nommu_map_page,
 	.map_sg			= nommu_map_sg,
-#ifdef CONFIG_DMA_NONCOHERENT
 	.sync_single_for_device	= nommu_sync_single_for_device,
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
-#endif
 };
 EXPORT_SYMBOL(nommu_dma_ops);
-- 
2.17.0
