Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeDYIfY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 04:35:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57081 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750882AbeDYIfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 04:35:21 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <acme@kernel.org>
CC: <jolsa@redhat.com>, <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH] perf bench numa: Fixes typo in options
Date: Wed, 25 Apr 2018 16:25:07 +0800
Message-ID: <1524644707-11030-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'R' means access the data via reads instead of writes, fix this typo.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 tools/perf/bench/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 944070e..63eb4908 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -175,7 +175,7 @@ struct global_info {
 	OPT_UINTEGER('s', "nr_secs"	, &p0.nr_secs,		"max number of seconds to run (default: 5 secs)"),
 	OPT_UINTEGER('u', "usleep"	, &p0.sleep_usecs,	"usecs to sleep per loop iteration"),
 
-	OPT_BOOLEAN('R', "data_reads"	, &p0.data_reads,	"access the data via writes (can be mixed with -W)"),
+	OPT_BOOLEAN('R', "data_reads"	, &p0.data_reads,	"access the data via reads (can be mixed with -W)"),
 	OPT_BOOLEAN('W', "data_writes"	, &p0.data_writes,	"access the data via writes (can be mixed with -R)"),
 	OPT_BOOLEAN('B', "data_backwards", &p0.data_backwards,	"access the data backwards as well"),
 	OPT_BOOLEAN('Z', "data_zero_memset", &p0.data_zero_memset,"access the data via glibc bzero only"),
-- 
1.7.12.4
