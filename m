Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968543AbeE0PCS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:02:18 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:44864 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966919AbeE0PCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:02:13 -0400
X-Spam-Flag: NO
X-Spam-Score: -1
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 1/5] doc: typos and minor fixes
Date: Sun, 27 May 2018 16:55:56 +0200
Message-Id: <20180527145559.16411-2-federico.vaga@vaga.pv.it>
In-Reply-To: <20180527145559.16411-1-federico.vaga@vaga.pv.it>
References: <20180527145559.16411-1-federico.vaga@vaga.pv.it>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/doc-guide/kernel-doc.rst    | 2 +-
 Documentation/doc-guide/parse-headers.rst | 4 ++--
 Documentation/doc-guide/sphinx.rst        | 4 ++--
 Documentation/index.rst                   | 2 +-
 Documentation/sphinx/parse-headers.pl     | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 0268335414ce..d322367f70d7 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -262,7 +262,7 @@ comment block.
 
 The kernel-doc data structure comments describe each member of the structure, in
 order, with the ``@member:`` descriptions. The ``@member:`` descriptions must
-begin on the very next line following the opening brief function description
+begin on the very next line following the opening brief structure description
 line, with no intervening blank comment lines. The ``@member:`` descriptions may
 span multiple lines. The continuation lines may contain indentation.
 
diff --git a/Documentation/doc-guide/parse-headers.rst b/Documentation/doc-guide/parse-headers.rst
index 96a0423d5dba..cbfbd1748f8f 100644
--- a/Documentation/doc-guide/parse-headers.rst
+++ b/Documentation/doc-guide/parse-headers.rst
@@ -32,7 +32,7 @@ SYNOPSIS
 
 \ **parse_headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
 
-Where <options> can be: --debug, --help or --man.
+Where <options> can be: --debug, --usage or --help.
 
 
 OPTIONS
@@ -133,7 +133,7 @@ For both statements, \ **type**\  can be either one of the following:
 
 \ **symbol**\
 
- The ignore or replace statement will apply to the name of enum statements
+ The ignore or replace statement will apply to the name of enum values
  at C_FILE.
 
  For replace statements, \ **new_value**\  will automatically use :c:type:
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index a2417633fdd8..8d789a117a4f 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -28,7 +28,7 @@ The ReST markups currently used by the Documentation/ files are meant to be
 built with ``Sphinx`` version 1.3 or upper. If you're desiring to build
 PDF outputs, it is recommended to use version 1.4.6 or upper.
 
-There's a script that checks for the Spinx requirements. Please see
+There's a script that checks for the Sphinx requirements. Please see
 :ref:`sphinx-pre-install` for further details.
 
 Most distributions are shipped with Sphinx, but its toolchain is fragile,
@@ -266,7 +266,7 @@ some additional features:
 * row-span: with the role ``rspan`` a cell can be extended through
   additional rows
 
-* auto span rightmost cell of a table row over the missing cells on the right
+* auto-span: rightmost cell of a table row over the missing cells on the right
   side of that table-row.  With Option ``:fill-cells:`` this behavior can
   changed from *auto span* to *auto fill*, which automatically inserts (empty)
   cells instead of spanning the last cell.
diff --git a/Documentation/index.rst b/Documentation/index.rst
index cb7f1ba5b3b1..331da87c82c8 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -33,7 +33,7 @@ the kernel interface as seen by application developers.
 .. toctree::
    :maxdepth: 2
 
-   userspace-api/index	      
+   userspace-api/index
 
 
 Introduction to kernel development
diff --git a/Documentation/sphinx/parse-headers.pl b/Documentation/sphinx/parse-headers.pl
index a958d8b5e99d..27117194d41f 100755
--- a/Documentation/sphinx/parse-headers.pl
+++ b/Documentation/sphinx/parse-headers.pl
@@ -344,7 +344,7 @@ enums and defines and create cross-references to a Sphinx book.
 
 B<parse_headers.pl> [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
 
-Where <options> can be: --debug, --help or --man.
+Where <options> can be: --debug, --help or --usage.
 
 =head1 OPTIONS
 
-- 
2.14.3
