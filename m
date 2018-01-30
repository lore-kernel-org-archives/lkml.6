Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbeA3T0M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:26:12 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40507 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbeA3TYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:24:54 -0500
X-Google-Smtp-Source: AH8x224Hn9lu2fItTwukn62z2tHM/zhA/ZbuDZiS2d9JNV79tTaORELvmnpNTf9ZGbE5pcMzfl6SnQ==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH v2 06/10] lib/Kconfig.debug: Remove empty help text
Date: Tue, 30 Jan 2018 20:23:01 +0100
Message-Id: <20180130192349.8420-7-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130192349.8420-1-ulfalizer@gmail.com>
References: <20180130192349.8420-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding a warning ("kconfig: Warn if help text is
blank"): https://lkml.org/lkml/2018/1/30/516

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 lib/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b66c264d4194..6088408ef26c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -351,7 +351,6 @@ config SECTION_MISMATCH_WARN_ONLY
 #
 config ARCH_WANT_FRAME_POINTERS
 	bool
-	help
 
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
-- 
2.14.1
