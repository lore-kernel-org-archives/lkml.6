Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968647AbeE3HLG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:11:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56719 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S968533AbeE3HLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:11:03 -0400
From: Yunlong Song <yunlong.song@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] f2fs-tools: do not ignore *.rej in git
Date: Wed, 30 May 2018 15:10:49 +0800
Message-ID: <1527664249-147982-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using git apply --reject to resolve the conflicts, we should better
see all the *.rej clear, or we will miss merging some *.rej patches.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 .gitignore | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 3f04e85..391c528 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,7 +11,6 @@
 *.mod.c
 *.lst
 *.orig
-*.rej
 
 CVS
 !.gitignore
-- 
1.8.5.2
