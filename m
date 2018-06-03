Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbeFCEuK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 00:50:10 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33177 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeFCEuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 00:50:08 -0400
X-Google-Smtp-Source: ADUXVKKSF6n5X+ow4NBPLt9GDFTh0LcDX5aBmDDh72dxVJGf2ekIMCZHGBtf8avAYj5x8ZWEjTGN8Q==
From: tomkpz@gmail.com
X-Google-Original-From: tomKPZ@gmail.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Thomas Anderson <tomKPZ@gmail.com>
Subject: [PATCH v2] exec: binfmt_misc: update reference to documentation
Date: Sat,  2 Jun 2018 21:49:35 -0700
Message-Id: <20180603044935.18011-1-tomKPZ@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Anderson <tomKPZ@gmail.com>

Documentation/binfmt_misc.txt was moved to
Documentation/admin-guide/binfmt-misc.rst in 9d85025b.  This change
updates a reference to the file.

Signed-off-by: Thomas Anderson <tomKPZ@gmail.com>
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
