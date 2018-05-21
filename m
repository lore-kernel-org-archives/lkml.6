Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753427AbeEURfs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:35:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32986 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753132AbeEURfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:35:15 -0400
X-Google-Smtp-Source: AB8JxZpQr13u1H7ABZM4+5q2g8MzDQ21b101rZVmpXyHyNhNgIY9wlb49L2Isjge2Lj+Y9LkV9bQLw==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org, jsimmons@infradead.org,
        andreas.dilger@intel.com, oleg.drokin@intel.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH v2 4/4] staging: lustre: Fix block comments style
Date: Mon, 21 May 2018 19:34:30 +0200
Message-Id: <20180521173430.9759-4-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180520124408.GA10692@kroah.com>
References: <20180520124408.GA10692@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
Changes in v2:
 - Removed trailing whitespace at lustre_idl.h:1532.

 .../staging/lustre/include/uapi/linux/lustre/lustre_idl.h   | 6 ++++--
 .../staging/lustre/include/uapi/linux/lustre/lustre_user.h  | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
index aac98dbcf6e3..8a7301a76122 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_idl.h
@@ -1526,9 +1526,11 @@ struct mdt_rec_setattr {
 #define MDS_OPEN_HAS_OBJS    020000000000 /* Just set the EA the obj exist */
 #define MDS_OPEN_NORESTORE  0100000000000ULL /* Do not restore file at open */
 #define MDS_OPEN_NEWSTRIPE  0200000000000ULL /* New stripe needed (restripe or
-					      * hsm restore) */
+					      * hsm restore)
+					      */
 #define MDS_OPEN_VOLATILE   0400000000000ULL /* File is volatile = created
-						unlinked */
+					      * unlinked
+					      */
 #define MDS_OPEN_LEASE	   01000000000000ULL /* Open the file and grant lease
 					      * delegation, succeed if it's not
 					      * being opened with conflict mode.
diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h
index 5e332e3af68a..69387f36d1f1 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_user.h
@@ -405,7 +405,8 @@ static inline __u32 lov_user_md_size(__u16 stripes, __u32 lmm_magic)
 
 /* Compile with -D_LARGEFILE64_SOURCE or -D_GNU_SOURCE (or #define) to
  * use this.  It is unsafe to #define those values in this header as it
- * is possible the application has already #included <sys/stat.h>. */
+ * is possible the application has already #included <sys/stat.h>.
+ */
 #ifdef HAVE_LOV_USER_MDS_DATA
 #define lov_user_mds_data lov_user_mds_data_v1
 struct lov_user_mds_data_v1 {
@@ -468,7 +469,8 @@ struct ll_fid {
 	__u64 id;	 /* holds object id */
 	__u32 generation; /* holds object generation */
 	__u32 f_type;     /* holds object type or stripe idx when passing it to
-			   * OST for saving into EA. */
+			   * OST for saving into EA.
+			   */
 };
 
 #define UUID_MAX	40
-- 
2.17.0
