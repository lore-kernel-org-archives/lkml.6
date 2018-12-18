Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67901C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B7D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Atmm6hpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeLRMP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:15:29 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:28572 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeLRMP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:15:29 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wBICDpsf002936;
        Tue, 18 Dec 2018 21:13:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wBICDpsf002936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545135232;
        bh=Fny4sQ1wIicVFqX9IiMyqw0OnbAlw6OSpZTCLGAezD8=;
        h=From:To:Cc:Subject:Date:From;
        b=Atmm6hpTBGfCFZ8paAYRt/t2KABIQJRuFV3jVHcibdxIl9hb8YvGiH7XGx0hyuBk+
         FUoPTMwfQzBy37TU1B4JxWIQ1T7mZAlQVNKVfpWHK/eqvPOzwR3UmIsFlnS7O+3v7t
         h+n/MADHQP2HxmAbUdPZElNxfFG0kA938Ru2IXcV9OvWGoouHrMtAlJJqtZ87E1JMB
         4hCBzE71BOo/OQlQ4/6DyjbmlGKzuuhZInaiKaFB63ZWYM20cFLb3t66S/8G4y3gjg
         JslykSlvg0W5wETWF5p+n9oE2nschPJDaMA0DPf8t9pdbzuL93z10EcT/2iNhsJivd
         H1x9rHs1iFbnQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] kconfig: convert to SPDX License Identifier
Date:   Tue, 18 Dec 2018 21:13:35 +0900
Message-Id: <1545135215-18427-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All files in lxdialog/ are licensed under GPL-2.0+, and the rest are
under GPL-2.0. I added GPL-2.0 tags to python test scripts in tests/.

Documentation/process/license-rules.rst does not suggest anything
about the flex/bison files. Because flex does not accept the C++
comment style at the very top of a file, I used the C style for
zconf.l, and so for zconf.y for consistency.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/conf.c                                    |  2 +-
 scripts/kconfig/confdata.c                                |  2 +-
 scripts/kconfig/expr.c                                    |  2 +-
 scripts/kconfig/expr.h                                    |  2 +-
 scripts/kconfig/gconf.c                                   |  5 +----
 scripts/kconfig/images.c                                  |  2 +-
 scripts/kconfig/lkc.h                                     |  2 +-
 scripts/kconfig/lxdialog/checklist.c                      | 15 +--------------
 scripts/kconfig/lxdialog/dialog.h                         | 15 +--------------
 scripts/kconfig/lxdialog/inputbox.c                       | 15 +--------------
 scripts/kconfig/lxdialog/menubox.c                        | 15 +--------------
 scripts/kconfig/lxdialog/textbox.c                        | 15 +--------------
 scripts/kconfig/lxdialog/util.c                           | 15 +--------------
 scripts/kconfig/lxdialog/yesno.c                          | 15 +--------------
 scripts/kconfig/mconf.c                                   |  2 +-
 scripts/kconfig/menu.c                                    |  2 +-
 scripts/kconfig/merge_config.sh                           | 11 ++---------
 scripts/kconfig/nconf.c                                   |  5 ++---
 scripts/kconfig/nconf.gui.c                               |  5 ++---
 scripts/kconfig/nconf.h                                   |  5 ++---
 scripts/kconfig/qconf.cc                                  |  2 +-
 scripts/kconfig/qconf.h                                   |  2 +-
 scripts/kconfig/streamline_config.pl                      |  2 +-
 scripts/kconfig/symbol.c                                  |  2 +-
 scripts/kconfig/tests/auto_submenu/__init__.py            |  1 +
 scripts/kconfig/tests/choice/__init__.py                  |  1 +
 scripts/kconfig/tests/choice_value_with_m_dep/__init__.py |  1 +
 scripts/kconfig/tests/err_recursive_inc/__init__.py       |  1 +
 scripts/kconfig/tests/inter_choice/__init__.py            |  1 +
 scripts/kconfig/tests/new_choice_with_dep/__init__.py     |  1 +
 scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py   |  1 +
 scripts/kconfig/tests/rand_nested_choice/__init__.py      |  1 +
 scripts/kconfig/util.c                                    |  3 +--
 scripts/kconfig/zconf.l                                   |  8 ++++----
 scripts/kconfig/zconf.y                                   |  4 ++--
 35 files changed, 43 insertions(+), 140 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 98e0c7a..da89ef7 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
  */
 
 #include <ctype.h>
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 91d0a5c..e32ada9 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
  */
 
 #include <sys/stat.h>
diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index e1a39e9..ddb9c86 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
  */
 
 #include <stdio.h>
diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 7c329e1..8807fcf 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
  */
 
 #ifndef EXPR_H
diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 36f5784..14fc0fa 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -1,9 +1,6 @@
-/* Hey EMACS -*- linux-c -*- */
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Copyright (C) 2002-2003 Romain Lievin <roms@tilp.info>
- * Released under the terms of the GNU GPL v2.0.
- *
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/scripts/kconfig/images.c b/scripts/kconfig/images.c
index d4f84bd..ef43b81 100644
--- a/scripts/kconfig/images.c
+++ b/scripts/kconfig/images.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
  */
 
 static const char *xpm_load[] = {
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index ff6b3e4..4ff33cd 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
  */
 
 #ifndef LKC_H
diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index 2e96323..fd161cf 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  checklist.c -- implements the checklist box
  *
@@ -5,20 +6,6 @@
  *     Stuart Herbert - S.Herbert@sheffield.ac.uk: radiolist extension
  *     Alessandro Rubini - rubini@ipvvis.unipv.it: merged the two
  *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcap@cfw.com)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version 2
- *  of the License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include "dialog.h"
diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index 0b00be5..68b565e 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  *  dialog.h -- common declarations for all dialog modules
  *
  *  AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version 2
- *  of the License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include <sys/types.h>
diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index fe82ff6..6119456 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  inputbox.c -- implements the input box
  *
  *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
  *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcap@cfw.com)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version 2
- *  of the License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include "dialog.h"
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index d70cab3..58c2f8a 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  menubox.c -- implements the menu box
  *
  *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
  *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcapw@cfw.com)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version 2
- *  of the License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 /*
diff --git a/scripts/kconfig/lxdialog/textbox.c b/scripts/kconfig/lxdialog/textbox.c
index 88d2818..4e339b1 100644
--- a/scripts/kconfig/lxdialog/textbox.c
+++ b/scripts/kconfig/lxdialog/textbox.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  textbox.c -- implements the text box
  *
  *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
  *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcap@cfw.com)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version 2
- *  of the License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include "dialog.h"
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index f7abdeb..1b490d4 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  util.c
  *
  *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
  *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcap@cfw.com)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version 2
- *  of the License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include <stdarg.h>
diff --git a/scripts/kconfig/lxdialog/yesno.c b/scripts/kconfig/lxdialog/yesno.c
index cd1223c..bcaac9b 100644
--- a/scripts/kconfig/lxdialog/yesno.c
+++ b/scripts/kconfig/lxdialog/yesno.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  yesno.c -- implements the yes/no box
  *
  *  ORIGINAL AUTHOR: Savio Lam (lam836@cs.cuhk.hk)
  *  MODIFIED FOR LINUX KERNEL CONFIG BY: William Roadcap (roadcap@cfw.com)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version 2
- *  of the License, or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include "dialog.h"
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 143c05f..5f8c82a 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
  *
  * Introduced single menu mode (show all sub-menus in one large tree).
  * 2002-11-06 Petr Baudis <pasky@ucw.cz>
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 7e2b2c9..d9d1646 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
  */
 
 #include <ctype.h>
diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index 0ef9064..743e387 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -1,4 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
 #  merge_config.sh - Takes a list of config fragment values, and merges
 #  them one by one. Provides warnings on overridden values, and specified
 #  values that did not make it to the resulting .config file (due to missed
@@ -10,15 +12,6 @@
 #
 #  Copyright (c) 2009-2010 Wind River Systems, Inc.
 #  Copyright 2011 Linaro
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License version 2 as
-#  published by the Free Software Foundation.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-#  See the GNU General Public License for more details.
 
 clean_up() {
 	rm -f $TMP_FILE
diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 1ef232a..a4670f4 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2008 Nir Tzachar <nir.tzachar@gmail.com?
- * Released under the terms of the GNU GPL v2.0.
+ * Copyright (C) 2008 Nir Tzachar <nir.tzachar@gmail.com>
  *
  * Derived from menuconfig.
- *
  */
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
diff --git a/scripts/kconfig/nconf.gui.c b/scripts/kconfig/nconf.gui.c
index 88874ac..7be620a 100644
--- a/scripts/kconfig/nconf.gui.c
+++ b/scripts/kconfig/nconf.gui.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2008 Nir Tzachar <nir.tzachar@gmail.com?
- * Released under the terms of the GNU GPL v2.0.
+ * Copyright (C) 2008 Nir Tzachar <nir.tzachar@gmail.com>
  *
  * Derived from menuconfig.
- *
  */
 #include "nconf.h"
 #include "lkc.h"
diff --git a/scripts/kconfig/nconf.h b/scripts/kconfig/nconf.h
index 2b9e19f..fa5245e 100644
--- a/scripts/kconfig/nconf.h
+++ b/scripts/kconfig/nconf.h
@@ -1,9 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2008 Nir Tzachar <nir.tzachar@gmail.com?
- * Released under the terms of the GNU GPL v2.0.
+ * Copyright (C) 2008 Nir Tzachar <nir.tzachar@gmail.com>
  *
  * Derived from menuconfig.
- *
  */
 
 #include <ctype.h>
diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index ef4310f..c897998 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1,7 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
  * Copyright (C) 2015 Boris Barbulovski <bbarbulovski@gmail.com>
- * Released under the terms of the GNU GPL v2.0.
  */
 
 #include <qglobal.h>
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index a40036d..41df466 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -1,6 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
  */
 
 #include <QTextBrowser>
diff --git a/scripts/kconfig/streamline_config.pl b/scripts/kconfig/streamline_config.pl
index 4686531..08d76d7 100755
--- a/scripts/kconfig/streamline_config.pl
+++ b/scripts/kconfig/streamline_config.pl
@@ -1,7 +1,7 @@
 #!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright 2005-2009 - Steven Rostedt
-# Licensed under the terms of the GNU GPL License version 2
 #
 #  It's simple enough to figure out how this works.
 #  If not, then you can ask me at stripconfig@goodmis.org
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 703b9b8..364afa1 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
  */
 
 #include <ctype.h>
diff --git a/scripts/kconfig/tests/auto_submenu/__init__.py b/scripts/kconfig/tests/auto_submenu/__init__.py
index 32e79b8..25abd92 100644
--- a/scripts/kconfig/tests/auto_submenu/__init__.py
+++ b/scripts/kconfig/tests/auto_submenu/__init__.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 """
 Create submenu for symbols that depend on the preceding one.
 
diff --git a/scripts/kconfig/tests/choice/__init__.py b/scripts/kconfig/tests/choice/__init__.py
index 9edcc52..4318fce 100644
--- a/scripts/kconfig/tests/choice/__init__.py
+++ b/scripts/kconfig/tests/choice/__init__.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 """
 Basic choice tests.
 
diff --git a/scripts/kconfig/tests/choice_value_with_m_dep/__init__.py b/scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
index f8d728c..075b4e0 100644
--- a/scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
+++ b/scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 """
 Hide tristate choice values with mod dependency in y choice.
 
diff --git a/scripts/kconfig/tests/err_recursive_inc/__init__.py b/scripts/kconfig/tests/err_recursive_inc/__init__.py
index 0e4c839..27aa189 100644
--- a/scripts/kconfig/tests/err_recursive_inc/__init__.py
+++ b/scripts/kconfig/tests/err_recursive_inc/__init__.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 """
 Detect recursive inclusion error.
 
diff --git a/scripts/kconfig/tests/inter_choice/__init__.py b/scripts/kconfig/tests/inter_choice/__init__.py
index 5c7fc36..ffea6b1 100644
--- a/scripts/kconfig/tests/inter_choice/__init__.py
+++ b/scripts/kconfig/tests/inter_choice/__init__.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 """
 Do not affect user-assigned choice value by another choice.
 
diff --git a/scripts/kconfig/tests/new_choice_with_dep/__init__.py b/scripts/kconfig/tests/new_choice_with_dep/__init__.py
index f0e0ead..fe9d322 100644
--- a/scripts/kconfig/tests/new_choice_with_dep/__init__.py
+++ b/scripts/kconfig/tests/new_choice_with_dep/__init__.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 """
 Ask new choice values when they become visible.
 
diff --git a/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py b/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
index 207261b..ffd469d 100644
--- a/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
+++ b/scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 """
 Do not write choice values to .config if the dependency is unmet.
 
diff --git a/scripts/kconfig/tests/rand_nested_choice/__init__.py b/scripts/kconfig/tests/rand_nested_choice/__init__.py
index e729a4e..9e4b2db 100644
--- a/scripts/kconfig/tests/rand_nested_choice/__init__.py
+++ b/scripts/kconfig/tests/rand_nested_choice/__init__.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 """
 Set random values recursively in nested choices.
 
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index d999683..2958539 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2002-2005 Roman Zippel <zippel@linux-m68k.org>
  * Copyright (C) 2002-2005 Sam Ravnborg <sam@ravnborg.org>
- *
- * Released under the terms of the GNU GPL v2.0.
  */
 
 #include <stdarg.h>
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 690108f..960e6c6 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -1,11 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
+ */
 %option nostdinit noyywrap never-interactive full ecs
 %option 8bit nodefault yylineno
 %x ASSIGN_VAL HELP STRING
 %{
-/*
- * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
- */
 
 #include <assert.h>
 #include <limits.h>
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 35c373d..8a4d029 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -1,8 +1,8 @@
-%{
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
  */
+%{
 
 #include <ctype.h>
 #include <stdarg.h>
-- 
2.7.4

