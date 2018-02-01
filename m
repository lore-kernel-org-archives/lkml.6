Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeBAMEl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:04:41 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32909 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeBAMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:04:38 -0500
X-Google-Smtp-Source: AH8x225KuRMACTDrsnfMTzVpeJpqD8W7weuKni3c00cEM+oxPHa9kjN/hUEKH79DPWw1pwXdPcx7oQ==
From: Andrea Parri <parri.andrea@gmail.com>
To: stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: add the Memory Consistency Model subsystem
Date: Thu,  1 Feb 2018 13:04:26 +0100
Message-Id: <1517486666-11011-1-git-send-email-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integrate (and then remove) tools/memory-model/MAINTAINERS into the
main MAINTAINERS file. This way get_maintainer.pl can give a "right
answer" for tools/memory-model/.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 MAINTAINERS                    | 16 ++++++++++++++++
 tools/memory-model/MAINTAINERS | 15 ---------------
 2 files changed, 16 insertions(+), 15 deletions(-)
 delete mode 100644 tools/memory-model/MAINTAINERS

diff --git a/MAINTAINERS b/MAINTAINERS
index 217a8759e897e..08454be9237d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8091,6 +8091,22 @@ M:	Kees Cook <keescook@chromium.org>
 S:	Maintained
 F:	drivers/misc/lkdtm*
 
+LINUX KERNEL MEMORY CONSISTENCY MODEL
+M:	Alan Stern <stern@rowland.harvard.edu>
+M:	Andrea Parri <parri.andrea@gmail.com>
+M:	Will Deacon <will.deacon@arm.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+M:	Boqun Feng <boqun.feng@gmail.com>
+M:	Nicholas Piggin <npiggin@gmail.com>
+M:	David Howells <dhowells@redhat.com>
+M:	Jade Alglave <j.alglave@ucl.ac.uk>
+M:	Luc Maranget <luc.maranget@inria.fr>
+M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
+F:	tools/memory-model/
+
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 M:	Chris Wright <chrisw@sous-sol.org>
 L:	linux-security-module@vger.kernel.org
diff --git a/tools/memory-model/MAINTAINERS b/tools/memory-model/MAINTAINERS
deleted file mode 100644
index db3bd3fc0435b..0000000000000
--- a/tools/memory-model/MAINTAINERS
+++ /dev/null
@@ -1,15 +0,0 @@
-LINUX KERNEL MEMORY CONSISTENCY MODEL
-M:	Alan Stern <stern@rowland.harvard.edu>
-M:	Andrea Parri <parri.andrea@gmail.com>
-M:	Will Deacon <will.deacon@arm.com>
-M:	Peter Zijlstra <peterz@infradead.org>
-M:	Boqun Feng <boqun.feng@gmail.com>
-M:	Nicholas Piggin <npiggin@gmail.com>
-M:	David Howells <dhowells@redhat.com>
-M:	Jade Alglave <j.alglave@ucl.ac.uk>
-M:	Luc Maranget <luc.maranget@inria.fr>
-M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
-L:	linux-kernel@vger.kernel.org
-S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
-F:	tools/memory-model/
-- 
2.7.4
