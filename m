Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeCXH2f (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 03:28:35 -0400
Received: from out3140-154.mail.aliyun.com ([42.120.140.154]:4357 "EHLO
        out3140-154.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750763AbeCXH2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 03:28:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2629046|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03302;MF=zhenwei.pi@youruncloud.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.BQJ.4.8_1521876508;
From: "zhenwei.pi" <zhenwei.pi@youruncloud.com>
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: zhenwei.pi@youruncloud.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ext4 : fix comments in ext4_swap_extents
Date: Sat, 24 Mar 2018 15:28:24 +0800
Message-Id: <1521876504-18326-1-git-send-email-zhenwei.pi@youruncloud.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"mark_unwritten" in comment and "unwritten" in variable
argument lists is mismatch.

Signed-off-by: zhenwei.pi <zhenwei.pi@youruncloud.com>
---
 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 054416e..2fc4227 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5751,7 +5751,7 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
  * @lblk1:	Start block for first inode
  * @lblk2:	Start block for second inode
  * @count:	Number of blocks to swap
- * @mark_unwritten: Mark second inode's extents as unwritten after swap
+ * @unwritten: Mark second inode's extents as unwritten after swap
  * @erp:	Pointer to save error value
  *
  * This helper routine does exactly what is promise "swap extents". All other
-- 
2.7.4
