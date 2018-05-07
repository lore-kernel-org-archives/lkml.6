Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeEGJjq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:39:46 -0400
Received: from osg.samsung.com ([64.30.133.232]:57534 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752454AbeEGJgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:36:06 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 04/18] docs: admin-guide: add bcache documentation
Date: Mon,  7 May 2018 06:35:40 -0300
Message-Id: <5d7918e6b5eb59dfb6d938e84425cd90c7524e60.1525684985.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bcache.txt is already in ReST format. So, move it to the
admin guide, where it belongs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/00-INDEX                               | 2 --
 Documentation/{bcache.txt => admin-guide/bcache.rst} | 0
 Documentation/admin-guide/index.rst                  | 1 +
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename Documentation/{bcache.txt => admin-guide/bcache.rst} (100%)

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 708dc4c166e4..53699c79ee54 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -64,8 +64,6 @@ auxdisplay/
 	- misc. LCD driver documentation (cfag12864b, ks0108).
 backlight/
 	- directory with info on controlling backlights in flat panel displays
-bcache.txt
-	- Block-layer cache on fast SSDs to improve slow (raid) I/O performance.
 block/
 	- info on the Block I/O (BIO) layer.
 blockdev/
diff --git a/Documentation/bcache.txt b/Documentation/admin-guide/bcache.rst
similarity index 100%
rename from Documentation/bcache.txt
rename to Documentation/admin-guide/bcache.rst
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index cac906fb0ed0..52eb3408f9a0 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -60,6 +60,7 @@ configure specific aspects of kernel behavior to your liking.
    mono
    java
    ras
+   bcache
    pm/index
    thunderbolt
    LSM/index
-- 
2.17.0
