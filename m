Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033549AbeCARoL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:44:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033522AbeCARoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:44:09 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 1/6] proc/sysctl: Fix typo in sysctl_check_table_array()
Date: Thu,  1 Mar 2018 12:43:35 -0500
Message-Id: <1519926220-7453-2-git-send-email-longman@redhat.com>
In-Reply-To: <1519926220-7453-1-git-send-email-longman@redhat.com>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/proc/proc_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c41ab26..493c975 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1086,7 +1086,7 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 	if ((table->proc_handler == proc_douintvec) ||
 	    (table->proc_handler == proc_douintvec_minmax)) {
 		if (table->maxlen != sizeof(unsigned int))
-			err |= sysctl_err(path, table, "array now allowed");
+			err |= sysctl_err(path, table, "array not allowed");
 	}
 
 	return err;
-- 
1.8.3.1
