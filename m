Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeENMXr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753270AbeENMXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:23:44 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/5] perf cs-etm: Remove redundant space
Date: Mon, 14 May 2018 09:23:20 -0300
Message-Id: <20180514122321.27304-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180514122321.27304-1-acme@kernel.org>
References: <20180514122321.27304-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

There have two spaces ahead function name cs_etm__set_pid_tid_cpu(), so
remove one space and correct indentation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1525924920-4381-2-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2bf28b5acc08..bf16dc9ee507 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -613,8 +613,8 @@ cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
 	return buff->len;
 }
 
-static void  cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
-				     struct auxtrace_queue *queue)
+static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
+				    struct auxtrace_queue *queue)
 {
 	struct cs_etm_queue *etmq = queue->priv;
 
-- 
2.14.3
