Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032352AbeBPNsa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:48:30 -0500
Received: from osg.samsung.com ([64.30.133.232]:44082 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032299AbeBPNs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:48:29 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Tom Saeger <tom.saeger@oracle.com>
Subject: [PATCH 2/6] doc-guide: kernel-doc: fix example for inlined comments
Date: Fri, 16 Feb 2018 11:48:16 -0200
Message-Id: <ef85148bf900859b44675c628d1807f886f8549b.1518788761.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without ending with a ";", kernel-doc doesn't recognize it
as an struct, and it fails to parse the example.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/doc-guide/kernel-doc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 9fce378dccb2..3c00ce0c84e5 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -237,7 +237,7 @@ on a line of their own, like all other kernel-doc comments::
         int baz;
         /** @foobar: Single line description. */
         int foobar;
-  }
+  };
 
 Nested structs/unions
 ~~~~~~~~~~~~~~~~~~~~~
-- 
2.14.3
