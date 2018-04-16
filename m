Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeDPGmd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:42:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeDPGmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:42:32 -0400
Date: Sun, 15 Apr 2018 23:42:05 -0700
From: tip-bot for Kim Phillips <tipbot@zytor.com>
Message-ID: <tip-af72cfb80af5e4cafd8e0b58ac54f222c913aa1b@git.kernel.org>
Cc: jolsa@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, acme@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, kim.phillips@arm.com, brianrob@microsoft.com
Reply-To: mingo@kernel.org, jolsa@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        brianrob@microsoft.com, namhyung@kernel.org, kim.phillips@arm.com
In-Reply-To: <20180410191624.a3a468670dd4548c66d3d094@arm.com>
References: <20180410191624.a3a468670dd4548c66d3d094@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tests: Run dwarf unwind test on arm32
Git-Commit-ID: af72cfb80af5e4cafd8e0b58ac54f222c913aa1b
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

Commit-ID:  af72cfb80af5e4cafd8e0b58ac54f222c913aa1b
Gitweb:     https://git.kernel.org/tip/af72cfb80af5e4cafd8e0b58ac54f222c913aa1b
Author:     Kim Phillips <kim.phillips@arm.com>
AuthorDate: Tue, 10 Apr 2018 19:16:24 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 12 Apr 2018 09:30:37 -0300

perf tests: Run dwarf unwind test on arm32

Enable the unwind test on arm32:

  $ perf test unwind
  58: DWARF unwind                                          : Ok

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Brian Robbins <brianrob@microsoft.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180410191624.a3a468670dd4548c66d3d094@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/{arm64 => arm}/include/arch-tests.h | 0
 tools/perf/arch/arm/tests/Build                     | 2 ++
 tools/perf/arch/{arm64 => arm}/tests/arch-tests.c   | 0
 3 files changed, 2 insertions(+)

diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm/include/arch-tests.h
similarity index 100%
copy from tools/perf/arch/arm64/include/arch-tests.h
copy to tools/perf/arch/arm/include/arch-tests.h
diff --git a/tools/perf/arch/arm/tests/Build b/tools/perf/arch/arm/tests/Build
index b30eff9bcc83..883c57ff0c08 100644
--- a/tools/perf/arch/arm/tests/Build
+++ b/tools/perf/arch/arm/tests/Build
@@ -1,2 +1,4 @@
 libperf-y += regs_load.o
 libperf-y += dwarf-unwind.o
+
+libperf-y += arch-tests.o
diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
similarity index 100%
copy from tools/perf/arch/arm64/tests/arch-tests.c
copy to tools/perf/arch/arm/tests/arch-tests.c
