Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbeFEWuE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:50:04 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:34848 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752365AbeFEWuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:50:01 -0400
X-Spam-Flag: NO
X-Spam-Score: -1
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 3/6] doc: move away translations from top-level index
Date: Wed,  6 Jun 2018 00:49:00 +0200
Message-Id: <20180605224903.9483-4-federico.vaga@vaga.pv.it>
In-Reply-To: <20180605224903.9483-1-federico.vaga@vaga.pv.it>
References: <20180605224903.9483-1-federico.vaga@vaga.pv.it>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In translations/ we have now a dedicated index.rst where we add/remove
references to translations. Translations are in English alphabetical
order.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/index.rst              | 24 ++++--------------------
 Documentation/translations/index.rst | 12 ++++++++++++
 2 files changed, 16 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/translations/index.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 3b99ab931d41..f7ab4d6a281e 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -101,29 +101,13 @@ implementation.
 
    sh/index
 
-Korean translations
--------------------
+Translations
+------------
 
 .. toctree::
-   :maxdepth: 1
-
-   translations/ko_KR/index
-
-Chinese translations
---------------------
-
-.. toctree::
-   :maxdepth: 1
-
-   translations/zh_CN/index
-
-Japanese translations
----------------------
-
-.. toctree::
-   :maxdepth: 1
+   :maxdepth: 2
 
-   translations/ja_JP/index
+   translations/index
 
 Indices and tables
 ==================
diff --git a/Documentation/translations/index.rst b/Documentation/translations/index.rst
new file mode 100644
index 000000000000..4969c58920ef
--- /dev/null
+++ b/Documentation/translations/index.rst
@@ -0,0 +1,12 @@
+.. _translations:
+
+============
+Translations
+============
+
+.. toctree::
+   :maxdepth: 1
+
+   zh_CN/index
+   ko_KR/index
+   ja_JP/index
-- 
2.14.4
