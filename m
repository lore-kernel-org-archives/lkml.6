Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3404AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C5220652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="quIOiofc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389649AbfAKSFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:05:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44206 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733253AbfAKSFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:40 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BI5Xxb067747;
        Fri, 11 Jan 2019 12:05:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547229933;
        bh=j+pOCWud2cX3YCzm6ALAF5aeJ85HnYKhGDqRt481drw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=quIOiofcFw+3fO6DFD8buWeiTsgElkaA8LDqRBWDCPSCPqfqF+mymmkjsqT1evwnU
         s9K8GRrX2deqPPbbQHXzq5e/Zk/BAh40+o1BnkoCO2iolxn+A0/026VOLeCVHDD9lO
         nnNUaz0LculNS01e6i2K+bd49dArAbY5EfJ/Z3A8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BI5XVd059297
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 12:05:33 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 12:05:33 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 12:05:33 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BI5XuX017185;
        Fri, 11 Jan 2019 12:05:33 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.109.196])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BI5WU07752;
        Fri, 11 Jan 2019 12:05:32 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 10/14] staging: android: ion: Remove unused headers
Date:   Fri, 11 Jan 2019 12:05:19 -0600
Message-ID: <20190111180523.27862-11-afd@ti.com>
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

Various cleanups have removed the use of some headers in ION, remove
these here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/staging/android/ion/ion.c               | 3 ---
 drivers/staging/android/ion/ion_carveout_heap.c | 4 ++--
 drivers/staging/android/ion/ion_chunk_heap.c    | 3 +--
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 2d6d8c0994b2..bba5f682bc25 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2011 Google, Inc.
  */
 
-#include <linux/anon_inodes.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
@@ -14,10 +13,8 @@
 #include <linux/file.h>
 #include <linux/freezer.h>
 #include <linux/fs.h>
-#include <linux/idr.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
-#include <linux/memblock.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/mm_types.h>
diff --git a/drivers/staging/android/ion/ion_carveout_heap.c b/drivers/staging/android/ion/ion_carveout_heap.c
index ab9b72adca9c..bb9d614767a2 100644
--- a/drivers/staging/android/ion/ion_carveout_heap.c
+++ b/drivers/staging/android/ion/ion_carveout_heap.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2011 Google, Inc.
  */
-#include <linux/spinlock.h>
+
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/genalloc.h>
@@ -12,7 +12,7 @@
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
+
 #include "ion.h"
 
 #define ION_CARVEOUT_ALLOCATE_FAIL	-1
diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
index 899380beeee1..3cdde9c1a717 100644
--- a/drivers/staging/android/ion/ion_chunk_heap.c
+++ b/drivers/staging/android/ion/ion_chunk_heap.c
@@ -8,11 +8,10 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/genalloc.h>
-#include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
+
 #include "ion.h"
 
 struct ion_chunk_heap {
-- 
2.19.1

