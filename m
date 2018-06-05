Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeFEWtv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:49:51 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:34836 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752365AbeFEWts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:49:48 -0400
X-Spam-Flag: NO
X-Spam-Score: -1
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 1/6] doc:doc-guide: fix a typo and an error
Date: Wed,  6 Jun 2018 00:48:58 +0200
Message-Id: <20180605224903.9483-2-federico.vaga@vaga.pv.it>
In-Reply-To: <20180605224903.9483-1-federico.vaga@vaga.pv.it>
References: <20180605224903.9483-1-federico.vaga@vaga.pv.it>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typo in sphinx.rst
error in parse-header.rst

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/doc-guide/parse-headers.rst | 2 +-
 Documentation/doc-guide/sphinx.rst        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/doc-guide/parse-headers.rst b/Documentation/doc-guide/parse-headers.rst
index 82a3e43b6864..684490c68acb 100644
--- a/Documentation/doc-guide/parse-headers.rst
+++ b/Documentation/doc-guide/parse-headers.rst
@@ -133,7 +133,7 @@ For both statements, \ **type**\  can be either one of the following:
 
 \ **symbol**\
 
- The ignore or replace statement will apply to the name of enum statements
+ The ignore or replace statement will apply to the name of enum value
  at C_FILE.
 
  For replace statements, \ **new_value**\  will automatically use :c:type:
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index a2417633fdd8..f0796daa95b4 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -28,7 +28,7 @@ The ReST markups currently used by the Documentation/ files are meant to be
 built with ``Sphinx`` version 1.3 or upper. If you're desiring to build
 PDF outputs, it is recommended to use version 1.4.6 or upper.
 
-There's a script that checks for the Spinx requirements. Please see
+There's a script that checks for the Sphinx requirements. Please see
 :ref:`sphinx-pre-install` for further details.
 
 Most distributions are shipped with Sphinx, but its toolchain is fragile,
-- 
2.14.4
