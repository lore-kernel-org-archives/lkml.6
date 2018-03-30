Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeC3BdU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 21:33:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:18372 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbeC3BdS (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 21:33:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="212506349"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 6/6] perf Documentation: Create perf-version.txt
Date: Fri, 30 Mar 2018 17:27:16 +0800
Message-Id: <1522402036-22915-7-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522402036-22915-1-git-send-email-yao.jin@linux.intel.com>
References: <1522402036-22915-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a new option '--build-options' is created for 'perf version',
so we need to document it.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-version.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 tools/perf/Documentation/perf-version.txt

diff --git a/tools/perf/Documentation/perf-version.txt b/tools/perf/Documentation/perf-version.txt
new file mode 100644
index 0000000..e207b7c
--- /dev/null
+++ b/tools/perf/Documentation/perf-version.txt
@@ -0,0 +1,24 @@
+perf-version(1)
+===============
+
+NAME
+----
+perf-version - display the version of perf binary
+
+SYNOPSIS
+--------
+'perf version' [--build-options]
+
+DESCRIPTION
+-----------
+With no options given, the 'perf version' prints the perf version
+on the standard output.
+
+If the option '--build-options' is given, then the status of
+compiled-in libraries are printed on the standard output.
+
+OPTIONS
+-------
+--build-options::
+        Prints the status of compiled-in libraries on the
+        standard output.
-- 
2.7.4
