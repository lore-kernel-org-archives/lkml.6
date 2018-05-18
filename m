Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeERCBN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 22:01:13 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37255 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbeERCBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 22:01:10 -0400
X-Google-Smtp-Source: AB8JxZoswBBQC3GFo0IWFE7MPnZTsZBT7RlHcuNGEjEu8bqwQTG4HvtjZi53jEiZbkZau+aiXUBKgg==
From: Li Qiang <liq3ea@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Qiang <liq3ea@gmail.com>
Subject: [PATCH] fs.h: fix outdated comment about file flags
Date: Thu, 17 May 2018 19:01:03 -0700
Message-Id: <1526608863-4701-1-git-send-email-liq3ea@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __dentry_open function was removed in
commit <2a027e7a18738>("fold __dentry_open() into its sole caller").

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 760d8da1b6c7..7f07977bdfd7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -94,7 +94,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 
 /*
  * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond
- * to O_WRONLY and O_RDWR via the strange trick in __dentry_open()
+ * to O_WRONLY and O_RDWR via the strange trick in do_dentry_open()
  */
 
 /* file is open for reading */
-- 
2.16.3
