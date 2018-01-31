Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753930AbeAaJjK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:39:10 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40313 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753765AbeAaJfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:35:53 -0500
X-Google-Smtp-Source: AH8x224DJAYMLkQpdYTbmQ2KoN8+YHanD0BsufToQ8lyPzz9oSiNKvCGHWKjKTCGL7ax8KgUGCpNOg==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, rdunlap@infradead.org, dan.carpenter@oracle.com,
        pebolle@tiscali.nl, Ulf Magnusson <ulfalizer@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 06/11] lib/Kconfig.debug: Remove blank help text
Date: Wed, 31 Jan 2018 10:34:25 +0100
Message-Id: <20180131093434.20050-7-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180131093434.20050-1-ulfalizer@gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blank help texts are probably either a typo, a Kconfig misunderstanding,
or some kind of half-committing to adding a help text (in which case a
TODO comment would be clearer, if the help text really can't be added
right away).

Best to remove them, IMO.

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
