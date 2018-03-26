Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeCZGld (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:41:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57316 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750859AbeCZGlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 02:41:32 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: David Howells <dhowells@redhat.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linux-afs@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] afs: Make symbol 'afs_cell_gc_delay' static
Date: Mon, 26 Mar 2018 06:47:02 +0000
Message-ID: <1522046822-20276-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warnings:

fs/afs/cell.c:21:24: warning:
 symbol 'afs_cell_gc_delay' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 fs/afs/cell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 3d2c5e0..c17e03b 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -18,7 +18,7 @@
 #include <keys/rxrpc-type.h>
 #include "internal.h"
 
-unsigned __read_mostly afs_cell_gc_delay = 10;
+static unsigned __read_mostly afs_cell_gc_delay = 10;
 
 static void afs_manage_cell(struct work_struct *);
