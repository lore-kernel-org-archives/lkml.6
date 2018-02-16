Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753836AbeBPTTq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:19:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753744AbeBPTTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:19:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1540217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/41] perf report: Fix description for --mem-mode
Date: Fri, 16 Feb 2018 16:17:35 -0300
Message-Id: <20180216191746.11095-31-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

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
index a76b871f78a6..cba16d8a970e 100644
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
-- 
2.14.3
