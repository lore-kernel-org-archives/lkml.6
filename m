Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D411DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAFF20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfAQHCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:02:33 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47074 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbfAQHCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:02:33 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 54B7AD2B93414C46D630;
        Thu, 17 Jan 2019 15:02:31 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 17 Jan 2019
 15:02:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <darrick.wong@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] xfs: remove duplicated xfs_defer.h
Date:   Thu, 17 Jan 2019 15:02:17 +0800
Message-ID: <20190117070217.12432-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/xfs/xfs_trans_bmap.c     | 1 -
 fs/xfs/xfs_trans_extfree.c  | 1 -
 fs/xfs/xfs_trans_refcount.c | 1 -
 fs/xfs/xfs_trans_rmap.c     | 1 -
 4 files changed, 4 deletions(-)

diff --git a/fs/xfs/xfs_trans_bmap.c b/fs/xfs/xfs_trans_bmap.c
index 11cff44..e1c7d55 100644
--- a/fs/xfs/xfs_trans_bmap.c
+++ b/fs/xfs/xfs_trans_bmap.c
@@ -17,7 +17,6 @@
 #include "xfs_alloc.h"
 #include "xfs_bmap.h"
 #include "xfs_inode.h"
-#include "xfs_defer.h"
 
 /*
  * This routine is called to allocate a "bmap update done"
diff --git a/fs/xfs/xfs_trans_extfree.c b/fs/xfs/xfs_trans_extfree.c
index 0710434..8ee7a3f 100644
--- a/fs/xfs/xfs_trans_extfree.c
+++ b/fs/xfs/xfs_trans_extfree.c
@@ -18,7 +18,6 @@
 #include "xfs_alloc.h"
 #include "xfs_bmap.h"
 #include "xfs_trace.h"
-#include "xfs_defer.h"
 
 /*
  * This routine is called to allocate an "extent free done"
diff --git a/fs/xfs/xfs_trans_refcount.c b/fs/xfs/xfs_trans_refcount.c
index 6c947ff..8d73472 100644
--- a/fs/xfs/xfs_trans_refcount.c
+++ b/fs/xfs/xfs_trans_refcount.c
@@ -16,7 +16,6 @@
 #include "xfs_refcount_item.h"
 #include "xfs_alloc.h"
 #include "xfs_refcount.h"
-#include "xfs_defer.h"
 
 /*
  * This routine is called to allocate a "refcount update done"
diff --git a/fs/xfs/xfs_trans_rmap.c b/fs/xfs/xfs_trans_rmap.c
index a428909..5c7936b 100644
--- a/fs/xfs/xfs_trans_rmap.c
+++ b/fs/xfs/xfs_trans_rmap.c
@@ -16,7 +16,6 @@
 #include "xfs_rmap_item.h"
 #include "xfs_alloc.h"
 #include "xfs_rmap.h"
-#include "xfs_defer.h"
 
 /* Set the map extent flags for this reverse mapping. */
 static void
-- 
2.7.0


