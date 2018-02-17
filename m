Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeBQLoD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:44:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40665 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbeBQLoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:44:02 -0500
Date: Sat, 17 Feb 2018 03:33:55 -0800
From: tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-v0gcd4u9tktrvjjsp6y7ouv4@git.kernel.org>
Cc: jolsa@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, acme@redhat.com, mingo@kernel.org
Reply-To: jolsa@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org, acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Fix description for --mem-mode
Git-Commit-ID: fc2f52379b9d2232487d5e1dadb77883c10cdf47
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

Commit-ID:  fc2f52379b9d2232487d5e1dadb77883c10cdf47
Gitweb:     https://git.kernel.org/tip/fc2f52379b9d2232487d5e1dadb77883c10cdf47
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 9 Feb 2018 08:39:09 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:46 -0300

perf report: Fix description for --mem-mode

The "mem-loads" event only works when PEBS is enabled, so add the "/p"
("precise") suffix to the examples.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 20180209163909.9240-1-andi@firstfloor.org
Link: https://lkml.kernel.org/n/tip-v0gcd4u9tktrvjjsp6y7ouv4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index a76b871..cba16d8 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -368,7 +368,7 @@ OPTIONS
 	Use the data addresses of samples in addition to instruction addresses
 	to build the histograms.  To generate meaningful output, the perf.data
 	file must have been obtained using perf record -d -W and using a
-	special event -e cpu/mem-loads/ or -e cpu/mem-stores/. See
+	special event -e cpu/mem-loads/p or -e cpu/mem-stores/p. See
 	'perf mem' for simpler access.
 
 --percent-limit::
