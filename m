Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031913AbeEZPG5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 11:06:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56702 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031848AbeEZPG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 11:06:56 -0400
From: Colin King <colin.king@canonical.com>
To: Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: fix spelling mistake "Uknown" -> "Unknown"
Date: Sat, 26 May 2018 16:06:50 +0100
Message-Id: <20180526150650.10562-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in pr_info message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/9p/v9fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 0429c8ee58f1..89bac3d2f05b 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -343,7 +343,7 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 				v9ses->uid = make_kuid(current_user_ns(), uid);
 				if (!uid_valid(v9ses->uid)) {
 					ret = -EINVAL;
-					pr_info("Uknown uid %s\n", s);
+					pr_info("Unknown uid %s\n", s);
 				}
 			}
 
-- 
2.17.0
