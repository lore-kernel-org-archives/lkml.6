Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeEGKo7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:44:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51014 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbeEGKod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:44:33 -0400
X-Google-Smtp-Source: AB8JxZruN7FCSfXuXbH5bV6gAvi8ah2MxrFT/WjCzKQClARJOU5DqcFlPoQLKm6VRVMoaa/kNAYvNQ==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@linux.vnet.ibm.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [RFC PATCH v3 5/6] Documentation/features/lib: Remove arch support status file for 'strncasecmp'
Date: Mon,  7 May 2018 12:43:42 +0200
Message-Id: <1525689823-3340-6-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
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
