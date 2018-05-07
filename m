Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeEGUNv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752158AbeEGUNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:13:47 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Yisheng Xie <xieyisheng1@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/6] perf bench numa: Fix typo in options
Date: Mon,  7 May 2018 17:13:28 -0300
Message-Id: <20180507201333.26990-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507201333.26990-1-acme@kernel.org>
References: <20180507201333.26990-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yisheng Xie <xieyisheng1@huawei.com>

'R' means access the data via reads instead of writes, fix this typo.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1524644707-11030-1-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 944070e98a2c..63eb49082774 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -175,7 +175,7 @@ static const struct option options[] = {
 	OPT_UINTEGER('s', "nr_secs"	, &p0.nr_secs,		"max number of seconds to run (default: 5 secs)"),
 	OPT_UINTEGER('u', "usleep"	, &p0.sleep_usecs,	"usecs to sleep per loop iteration"),
 
-	OPT_BOOLEAN('R', "data_reads"	, &p0.data_reads,	"access the data via writes (can be mixed with -W)"),
+	OPT_BOOLEAN('R', "data_reads"	, &p0.data_reads,	"access the data via reads (can be mixed with -W)"),
 	OPT_BOOLEAN('W', "data_writes"	, &p0.data_writes,	"access the data via writes (can be mixed with -R)"),
 	OPT_BOOLEAN('B', "data_backwards", &p0.data_backwards,	"access the data backwards as well"),
 	OPT_BOOLEAN('Z', "data_zero_memset", &p0.data_zero_memset,"access the data via glibc bzero only"),
-- 
2.14.3
