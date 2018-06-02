Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbeFBUL0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 16:11:26 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42860 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeFBULY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 16:11:24 -0400
X-Google-Smtp-Source: ADUXVKLblYLXPeYnhV1zEQ6skv0XVb+78WBbOI/auPVdtdqLleOy5I428ZBmfcGDQjurdURV3jzNRA==
From: tomkpz@gmail.com
X-Google-Original-From: tomKPZ@gmail.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: tomKPZ <tomKPZ@gmail.com>
Subject: [PATCH] exec: binfmt_misc: update reference to documentation
Date: Sat,  2 Jun 2018 13:11:15 -0700
Message-Id: <20180602201115.3426-1-tomKPZ@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tomKPZ <tomKPZ@gmail.com>

Documentation/binfmt_misc.txt was moved to
Documentation/admin-guide/binfmt-misc.rst in 9d85025b.  This change
updates a reference to the file.
---
 fs/binfmt_misc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a41b48f82a70..5ad89b838c79 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -4,7 +4,8 @@
  * Copyright (C) 1997 Richard Günther
  *
  * binfmt_misc detects binaries via a magic or filename extension and invokes
- * a specified wrapper. See Documentation/binfmt_misc.txt for more details.
+ * a specified wrapper. See Documentation/admin-guide/binfmt-misc.rst for more
+ * details.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.17.1
