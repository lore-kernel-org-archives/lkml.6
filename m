Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeD0S6C (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 14:58:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33325 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758075AbeD0S5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 14:57:54 -0400
From: Colin King <colin.king@canonical.com>
To: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Subject: [PATCH] ocfs2: fix spelling mistake: "ambigous" -> "ambiguous"
Date: Fri, 27 Apr 2018 19:57:48 +0100
Message-Id: <20180427185748.16618-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in mlog_bug_on_msg message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ocfs2/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index ddc3e9470c87..18d4aa8eace6 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -548,7 +548,7 @@ static int ocfs2_read_locked_inode(struct inode *inode,
 	 */
 	mlog_bug_on_msg(!!(fe->i_flags & cpu_to_le32(OCFS2_SYSTEM_FL)) !=
 			!!(args->fi_flags & OCFS2_FI_FLAG_SYSFILE),
-			"Inode %llu: system file state is ambigous\n",
+			"Inode %llu: system file state is ambiguous\n",
 			(unsigned long long)args->fi_blkno);
 
 	if (S_ISCHR(le16_to_cpu(fe->i_mode)) ||
-- 
2.17.0
