Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeAaChX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:37:23 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:38150 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753502AbeAaChI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:37:08 -0500
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: hyc.lee@gmail.com
X-Original-SENDERIP: 10.177.225.35
X-Original-MAILFROM: hyc.lee@gmail.com
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@lge.com,
        Hyunchul Lee <cheol.lee@lge.com>
Subject: [PATCH v2 3/3] f2fs: Add the 'whint_mode' mount option to f2fs documentation
Date: Wed, 31 Jan 2018 11:36:59 +0900
Message-Id: <1517366219-22166-4-git-send-email-hyc.lee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517366219-22166-1-git-send-email-hyc.lee@gmail.com>
References: <1517366219-22166-1-git-send-email-hyc.lee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunchul Lee <cheol.lee@lge.com>

Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
---
 Documentation/filesystems/f2fs.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 13c2ff0..414a160 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -174,6 +174,12 @@ offgrpjquota           Turn off group journelled quota.
 offprjjquota           Turn off project journelled quota.
 quota                  Enable plain user disk quota accounting.
 noquota                Disable all plain disk quota option.
+whint_mode=%s          Control which write hints are passed down to block
+                       layer. This supports "off", "user-based", and
+                       "fs-based".  In "off" mode (default), f2fs does not pass
+                       down hints. In "user-based" mode, f2fs tries to pass
+                       down hints given by users. And in "fs-based" mode, f2fs
+                       passes down hints with its policy.
 
 ================================================================================
 DEBUGFS ENTRIES
-- 
1.9.1
