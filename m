Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932557AbeCSLlN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:41:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57622 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755299AbeCSLlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:41:07 -0400
From: Colin King <colin.king@canonical.com>
To: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>, ocfs2-devel@oss.oracle.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: fix spelling mistake: "Migrateable" -> "Migratable"
Date: Mon, 19 Mar 2018 11:41:01 +0000
Message-Id: <20180319114101.2051-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in mlog message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ocfs2/dlm/dlmmaster.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 03766fb41dbe..81d500211f43 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -2543,7 +2543,7 @@ static int dlm_is_lockres_migrateable(struct dlm_ctxt *dlm,
 			return 0;
 	}
 
-	mlog(0, "%s: res %.*s, Migrateable\n", dlm->name, res->lockname.len,
+	mlog(0, "%s: res %.*s, Migratable\n", dlm->name, res->lockname.len,
 	     res->lockname.name);
 
 	return 1;
-- 
2.15.1
