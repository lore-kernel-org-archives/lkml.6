Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeDHQcG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 12:32:06 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35557 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbeDHQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 12:31:38 -0400
X-Google-Smtp-Source: AIpwx4/rczzWZLwjKMFKENYWsLeoFwetMMLfMTlDL163G2aUnJigu4hHSV2Xh0f2fPtoQV3eOdf4xg==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@linux.vnet.ibm.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [RFC PATCH v2 5/6] Documentation/features/lib: Remove arch support status file for 'strncasecmp'
Date: Sun,  8 Apr 2018 18:30:26 +0200
Message-Id: <1523205027-31786-6-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523205027-31786-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1523205027-31786-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 .../features/lib/strncasecmp/arch-support.txt      | 33 ----------------------
 1 file changed, 33 deletions(-)
 delete mode 100644 Documentation/features/lib/strncasecmp/arch-support.txt

diff --git a/Documentation/features/lib/strncasecmp/arch-support.txt b/Documentation/features/lib/strncasecmp/arch-support.txt
deleted file mode 100644
index 6148f42c3d902..0000000000000
--- a/Documentation/features/lib/strncasecmp/arch-support.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# Feature name:          strncasecmp
-#         Kconfig:       __HAVE_ARCH_STRNCASECMP
-#         description:   arch provides an optimized strncasecmp() function
-#
-    -----------------------
-    |         arch |status|
-    -----------------------
-    |       alpha: | TODO |
-    |         arc: | TODO |
-    |         arm: | TODO |
-    |       arm64: | TODO |
-    |         c6x: | TODO |
-    |       h8300: | TODO |
-    |     hexagon: | TODO |
-    |        ia64: | TODO |
-    |        m68k: | TODO |
-    |  microblaze: | TODO |
-    |        mips: | TODO |
-    |       nds32: | TODO |
-    |       nios2: | TODO |
-    |    openrisc: | TODO |
-    |      parisc: | TODO |
-    |     powerpc: | TODO |
-    |       riscv: | TODO |
-    |        s390: | TODO |
-    |          sh: | TODO |
-    |       sparc: | TODO |
-    |          um: | TODO |
-    |   unicore32: | TODO |
-    |         x86: | TODO |
-    |      xtensa: | TODO |
-    -----------------------
-- 
2.7.4
