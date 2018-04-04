Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeDDFdH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:33:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53967 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbeDDFdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:33:06 -0400
Date: Tue, 3 Apr 2018 22:32:45 -0700
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-709846725673a944ee38da1c275a6dfbf0576d0f@git.kernel.org>
Cc: hpa@zytor.com, acme@redhat.com, yao.jin@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        peterz@infradead.org, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, kan.liang@intel.com,
        ak@linux.intel.com, mingo@kernel.org
Reply-To: jolsa@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        acme@redhat.com, yao.jin@intel.com, hpa@zytor.com, mingo@kernel.org,
        ak@linux.intel.com, kan.liang@intel.com,
        alexander.shishkin@linux.intel.com, yao.jin@linux.intel.com,
        peterz@infradead.org
In-Reply-To: <1522402036-22915-7-git-send-email-yao.jin@linux.intel.com>
References: <1522402036-22915-7-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf version: Add man page
Git-Commit-ID: 709846725673a944ee38da1c275a6dfbf0576d0f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  709846725673a944ee38da1c275a6dfbf0576d0f
Gitweb:     https://git.kernel.org/tip/709846725673a944ee38da1c275a6dfbf0576d0f
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 30 Mar 2018 17:27:16 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 2 Apr 2018 13:52:23 -0300

perf version: Add man page

Since a new option '--build-options' is created for 'perf version', so
we need to document it.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1522402036-22915-7-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-version.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/Documentation/perf-version.txt b/tools/perf/Documentation/perf-version.txt
new file mode 100644
index 000000000000..e207b7cfca26
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
