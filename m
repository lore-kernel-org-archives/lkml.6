Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbeBQFtA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:49:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:1052 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbeBQFs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:48:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863320"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 01/17] Documentation: add Linux tracing to Sphinx TOC tree
Date: Sat, 17 Feb 2018 13:39:34 +0800
Message-Id: <1518845990-20733-2-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

This just add a index.rst for trace subsystem. More docs will
be added later.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 Documentation/index.rst       | 1 +
 Documentation/trace/index.rst | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 Documentation/trace/index.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index ef5080c..3b99ab9 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -64,6 +64,7 @@ merged much easier.
    dev-tools/index
    doc-guide/index
    kernel-hacking/index
+   trace/index
    maintainer/index
 
 Kernel API documentation
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
new file mode 100644
index 0000000..d986ead
--- /dev/null
+++ b/Documentation/trace/index.rst
@@ -0,0 +1,6 @@
+==========================
+Linux Tracing Technologies
+==========================
+
+.. toctree::
+   :maxdepth: 2
-- 
2.7.4
