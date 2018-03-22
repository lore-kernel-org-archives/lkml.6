Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeCVU6h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:58:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40376 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCVU6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:58:35 -0400
X-Google-Smtp-Source: AG47ELs09r/IrKcRiPejsS/f84QsVWE9E8VzHg/tr/8gZ39nDz1nsOGhKFPbMkaxNvap8jJONtoBfw==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Kbuild entry with a few paths
Date: Thu, 22 Mar 2018 21:58:27 +0100
Message-Id: <20180322205827.24578-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to send some modpost patches to old addresses of both
Masahiro and Michal, and omitted linux-kbuild from cc, because my
tried and trusted scripts/get_maintainer wrapper failed me. Add the
modpost directory to the MAINTAINERS entry, and while at it make the
Makefile glob match scripts/Makefile itself, and add one matching the
Kbuild.include file as well.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Hi Kbuild maintainers. Hope you don't mind me extending this entry a bit.

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e62756936fa..5f5d4faddc74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7640,9 +7640,11 @@ L:	linux-kbuild@vger.kernel.org
 S:	Maintained
 F:	Documentation/kbuild/
 F:	Makefile
-F:	scripts/Makefile.*
+F:	scripts/Kbuild*
+F:	scripts/Makefile*
 F:	scripts/basic/
 F:	scripts/mk*
+F:	scripts/mod/
 F:	scripts/package/
 
 KERNEL JANITORS
-- 
2.15.1
