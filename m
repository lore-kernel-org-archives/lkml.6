Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032565AbeBPNsh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:48:37 -0500
Received: from osg.samsung.com ([64.30.133.232]:59041 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032341AbeBPNsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:48:30 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Tom Saeger <tom.saeger@oracle.com>
Subject: [PATCH 3/6] doc-guide: kernel-doc: move in-line section to be after nested struct
Date: Fri, 16 Feb 2018 11:48:17 -0200
Message-Id: <fd5a2d5195256a658708820563b9849ac8ae6c59.1518788761.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to give some examples about how to do in-line comments
for nested structs. So, move it to be after nested structs/unions
chapter.

The section content was not changed on this patch.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/doc-guide/kernel-doc.rst | 56 +++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 3c00ce0c84e5..1ddfe35c0e78 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -211,34 +211,6 @@ Example::
       int d;
   };
 
-In-line member documentation comments
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-The structure members may also be documented in-line within the definition.
-There are two styles, single-line comments where both the opening ``/**`` and
-closing ``*/`` are on the same line, and multi-line comments where they are each
-on a line of their own, like all other kernel-doc comments::
-
-  /**
-   * struct foo - Brief description.
-   * @foo: The Foo member.
-   */
-  struct foo {
-        int foo;
-        /**
-         * @bar: The Bar member.
-         */
-        int bar;
-        /**
-         * @baz: The Baz member.
-         *
-         * Here, the member description may contain several paragraphs.
-         */
-        int baz;
-        /** @foobar: Single line description. */
-        int foobar;
-  };
-
 Nested structs/unions
 ~~~~~~~~~~~~~~~~~~~~~
 
@@ -290,6 +262,34 @@ It is possible to document nested structs and unions, like::
    #) When the nested struct/union is anonymous, the member ``bar`` in it
       should be documented as ``@bar:``
 
+In-line member documentation comments
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The structure members may also be documented in-line within the definition.
+There are two styles, single-line comments where both the opening ``/**`` and
+closing ``*/`` are on the same line, and multi-line comments where they are each
+on a line of their own, like all other kernel-doc comments::
+
+  /**
+   * struct foo - Brief description.
+   * @foo: The Foo member.
+   */
+  struct foo {
+        int foo;
+        /**
+         * @bar: The Bar member.
+         */
+        int bar;
+        /**
+         * @baz: The Baz member.
+         *
+         * Here, the member description may contain several paragraphs.
+         */
+        int baz;
+        /** @foobar: Single line description. */
+        int foobar;
+  };
+
 Typedef documentation
 ---------------------
 
-- 
2.14.3
