Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbeAaSEA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:04:00 -0500
Received: from serv1.kernkonzept.com ([88.99.87.17]:51890 "EHLO
        mx.kernkonzept.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932373AbeAaSD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:03:28 -0500
From: Matthias Lange <matthias.lange@kernkonzept.com>
To: linux@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org,
        Matthias Lange <matthias.lange@kernkonzept.com>
Subject: [PATCH] Fix copy and paste typo in documentation
Date: Wed, 31 Jan 2018 18:35:34 +0100
Message-Id: <1517420134-7665-1-git-send-email-matthias.lange@kernkonzept.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's 'optional' instead of 'optinal'.

Signed-off-by: Matthias Lange <matthias.lange@kernkonzept.com>
---
 arch/arm/include/asm/dma-mapping.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index daf8374..34d8d3e 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -147,7 +147,7 @@ static inline void dma_mark_clean(void *addr, size_t size) { }
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @size: required memory size
  * @handle: bus-specific DMA address
- * @attrs: optinal attributes that specific mapping properties
+ * @attrs: optional attributes that specific mapping properties
  *
  * Allocate some memory for a device for performing DMA.  This function
  * allocates pages, and will return the CPU-viewed address, and sets @handle
@@ -162,7 +162,7 @@ extern void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
  * @size: size of memory originally requested in dma_alloc_coherent
  * @cpu_addr: CPU-view address returned from dma_alloc_coherent
  * @handle: device-view address returned from dma_alloc_coherent
- * @attrs: optinal attributes that specific mapping properties
+ * @attrs: optional attributes that specific mapping properties
  *
  * Free (and unmap) a DMA buffer previously allocated by
  * arm_dma_alloc().
@@ -180,7 +180,7 @@ extern void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
  * @cpu_addr: kernel CPU-view address returned from dma_alloc_coherent
  * @handle: device-view address returned from dma_alloc_coherent
  * @size: size of memory originally requested in dma_alloc_coherent
- * @attrs: optinal attributes that specific mapping properties
+ * @attrs: optional attributes that specific mapping properties
  *
  * Map a coherent DMA buffer previously allocated by dma_alloc_coherent
  * into user space.  The coherent DMA buffer must not be freed by the
-- 
2.7.4
