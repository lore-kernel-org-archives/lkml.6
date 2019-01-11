Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17224C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD13F20652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Djetj7JR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389832AbfAKSGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:06:21 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52076 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733081AbfAKSFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:37 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BI5Udi105150;
        Fri, 11 Jan 2019 12:05:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547229930;
        bh=YhKp4mYaOOcJ9E455NKq5+p5HeLNpDvyGEci1Zmv+kg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Djetj7JRSyZufWrp60zBKZUxJ7KC7DW93N7M3mxf0BRbjGfIiCi1JokmqCKiulyY4
         f6XnkolK4KvT4v9EFsE1y0w58xbTNUNziSArTzBO1uBHBwaxktJnhXr1bt8ecGhCXc
         mBCZGMpGaGvr4gS5WNFWF1vJjtrZX1QSqptmtBRI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BI5Ubi009004
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 12:05:30 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 12:05:29 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 12:05:29 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BI5T26006419;
        Fri, 11 Jan 2019 12:05:29 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.109.196])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BI5TU07730;
        Fri, 11 Jan 2019 12:05:29 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 06/14] staging: android: ion: Fixup some white-space issues
Date:   Fri, 11 Jan 2019 12:05:15 -0600
Message-ID: <20190111180523.27862-7-afd@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111180523.27862-1-afd@ti.com>
References: <20190111180523.27862-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add white-space for easier reading and remove some where it does
not belong. No functional changes, they just bug me..

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/staging/android/ion/ion_carveout_heap.c | 1 +
 drivers/staging/android/ion/ion_chunk_heap.c    | 2 +-
 drivers/staging/android/ion/ion_heap.c          | 6 ++++++
 drivers/staging/android/ion/ion_system_heap.c   | 6 +++++-
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion_carveout_heap.c b/drivers/staging/android/ion/ion_carveout_heap.c
index 891f5703220b..be80671df9c8 100644
--- a/drivers/staging/android/ion/ion_carveout_heap.c
+++ b/drivers/staging/android/ion/ion_carveout_heap.c
@@ -44,6 +44,7 @@ static void ion_carveout_free(struct ion_heap *heap, phys_addr_t addr,
 
 	if (addr == ION_CARVEOUT_ALLOCATE_FAIL)
 		return;
+
 	gen_pool_free(carveout_heap->pool, addr, size);
 }
 
diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
index c2321a047f0f..b82eac1c2d7a 100644
--- a/drivers/staging/android/ion/ion_chunk_heap.c
+++ b/drivers/staging/android/ion/ion_chunk_heap.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2012 Google, Inc.
  */
+
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/genalloc.h>
@@ -147,4 +148,3 @@ struct ion_heap *ion_chunk_heap_create(phys_addr_t base, size_t size, size_t chu
 	kfree(chunk_heap);
 	return ERR_PTR(ret);
 }
-
diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
index 6ee0ac6e4be4..473b465724f1 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -14,6 +14,7 @@
 #include <uapi/linux/sched/types.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
+
 #include "ion.h"
 
 void *ion_heap_map_kernel(struct ion_heap *heap,
@@ -92,6 +93,7 @@ int ion_heap_map_user(struct ion_heap *heap, struct ion_buffer *buffer,
 		if (addr >= vma->vm_end)
 			return 0;
 	}
+
 	return 0;
 }
 
@@ -254,6 +256,7 @@ int ion_heap_init_deferred_free(struct ion_heap *heap)
 		return PTR_ERR_OR_ZERO(heap->task);
 	}
 	sched_setscheduler(heap->task, SCHED_IDLE, &param);
+
 	return 0;
 }
 
@@ -265,8 +268,10 @@ static unsigned long ion_heap_shrink_count(struct shrinker *shrinker,
 	int total = 0;
 
 	total = ion_heap_freelist_size(heap) / PAGE_SIZE;
+
 	if (heap->ops->shrink)
 		total += heap->ops->shrink(heap, sc->gfp_mask, 0);
+
 	return total;
 }
 
@@ -295,6 +300,7 @@ static unsigned long ion_heap_shrink_scan(struct shrinker *shrinker,
 
 	if (heap->ops->shrink)
 		freed += heap->ops->shrink(heap, sc->gfp_mask, to_scan);
+
 	return freed;
 }
 
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index 643b32099488..ec526a464db8 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -13,6 +13,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+
 #include "ion.h"
 
 #define NUM_ORDERS ARRAY_SIZE(orders)
@@ -236,6 +237,7 @@ static int ion_system_heap_create_pools(struct ion_page_pool **pools)
 			goto err_create_pool;
 		pools[i] = pool;
 	}
+
 	return 0;
 
 err_create_pool:
@@ -274,6 +276,7 @@ static int ion_system_heap_create(void)
 	heap->name = "ion_system_heap";
 
 	ion_device_add_heap(heap);
+
 	return 0;
 }
 device_initcall(ion_system_heap_create);
@@ -355,6 +358,7 @@ static struct ion_heap *__ion_system_contig_heap_create(void)
 	heap->ops = &kmalloc_ops;
 	heap->type = ION_HEAP_TYPE_SYSTEM_CONTIG;
 	heap->name = "ion_system_contig_heap";
+
 	return heap;
 }
 
@@ -367,7 +371,7 @@ static int ion_system_contig_heap_create(void)
 		return PTR_ERR(heap);
 
 	ion_device_add_heap(heap);
+
 	return 0;
 }
 device_initcall(ion_system_contig_heap_create);
-
-- 
2.19.1

