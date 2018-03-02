Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423418AbeCBNHA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:07:00 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:37017 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423109AbeCBNG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:06:58 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w22D5DqT003906
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: take over Kconfig maintainership
Date: Fri,  2 Mar 2018 22:04:59 +0900
Message-Id: <1519995899-18187-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have recently picked up Kconfig patches to my tree without any
declaration.  Making it official now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c95c60..4623caf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7602,8 +7602,10 @@ F:	mm/kasan/
 F:	scripts/Makefile.kasan
 
 KCONFIG
+M:	Masahiro Yamada <yamada.masahiro@socionext.com>
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kconfig
 L:	linux-kbuild@vger.kernel.org
-S:	Orphan
+S:	Maintained
 F:	Documentation/kbuild/kconfig-language.txt
 F:	scripts/kconfig/
 
-- 
2.7.4
