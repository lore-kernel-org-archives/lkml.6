Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937272AbeE3HER (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:04:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937222AbeE3HEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:04:15 -0400
From: Yunlong Song <yunlong.song@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] f2fs-tools: fix to ignore sg_write_buffer in git
Date: Wed, 30 May 2018 15:03:49 +0800
Message-ID: <1527663829-144341-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tools/sg_write_buffer/sg_write_buffer to .gitignore.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index d5ca55d..3f04e85 100644
--- a/.gitignore
+++ b/.gitignore
@@ -50,6 +50,7 @@ stamp-h1
 /tools/fibmap.f2fs
 /tools/parse.f2fs
 /tools/f2fscrypt
+/tools/sg_write_buffer/sg_write_buffer
 
 # cscope files
 cscope.*
-- 
1.8.5.2
