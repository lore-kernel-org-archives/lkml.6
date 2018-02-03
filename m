Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbeBCFhJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 00:37:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbeBCFhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 00:37:06 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Cc: Richard Guy Briggs <rgb@redhat.com>, Paul Moore <pmoore@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Eric Paris <eparis@redhat.com>
Subject: [PATCH] audit: update bugtracker and source URIs
Date: Sat,  3 Feb 2018 00:33:11 -0500
Message-Id: <94279d21d4f6094c19921ea09e7e5093ac3a829c.1517635943.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Linux Audit project has transitioned completely over to
github, update the MAINTAINERS file and the primary audit source file to
reflect that reality.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 MAINTAINERS    | 1 -
 kernel/audit.c | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 845fc25..fba4875 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2479,7 +2479,6 @@ M:	Paul Moore <paul@paul-moore.com>
 M:	Eric Paris <eparis@redhat.com>
 L:	linux-audit@redhat.com (moderated for non-subscribers)
 W:	https://github.com/linux-audit
-W:	https://people.redhat.com/sgrubb/audit
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 S:	Supported
 F:	include/linux/audit.h
diff --git a/kernel/audit.c b/kernel/audit.c
index 227db99..5c25449 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -38,7 +38,8 @@
  *	  6) Support low-overhead kernel-based filtering to minimize the
  *	     information that must be passed to user-space.
  *
- * Example user-space utilities: http://people.redhat.com/sgrubb/audit/
+ * Audit userspace, documentation, tests, and bug/issue trackers:
+ * 	https://github.com/linux-audit
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
1.8.3.1
