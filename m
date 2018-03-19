Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970820AbeCSTCY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970158AbeCSTCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:02:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD3021836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 10/14] perf top: Document --ignore-vmlinux
Date: Mon, 19 Mar 2018 16:01:32 -0300
Message-Id: <20180319190136.7441-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180319190136.7441-1-acme@kernel.org>
References: <20180319190136.7441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We've had this since 2013, document it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Willy Tarreau <w@1wt.eu>
Fixes: fc2be6968e99 ("perf symbols: Add new option --ignore-vmlinux for perf top")
Link: https://lkml.kernel.org/n/tip-0jwfueooddwfsw9r603belxi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index a039407d63b8..114fda12aa49 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -67,6 +67,9 @@ Default is to monitor all CPUS.
 --vmlinux=<path>::
 	Path to vmlinux.  Required for annotation functionality.
 
+--ignore-vmlinux::
+	Ignore vmlinux files.
+
 -m <pages>::
 --mmap-pages=<pages>::
 	Number of mmap data pages (must be a power of two) or size
-- 
2.14.3
