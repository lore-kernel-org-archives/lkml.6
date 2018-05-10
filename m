Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753506AbeEJECa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 00:02:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45769 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEJEC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 00:02:26 -0400
X-Google-Smtp-Source: AB8JxZp3UvOoj4/FtIkOLJjU3Ibcaw0949pgYTxkrwTAb+cFpuF4r7ZIdkRtVTPjZEm2jdCWzp7sOw==
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND v2 2/2] perf cs-etm: Remove redundant space
Date: Thu, 10 May 2018 12:02:00 +0800
Message-Id: <1525924920-4381-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525924920-4381-1-git-send-email-leo.yan@linaro.org>
References: <1525924920-4381-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have two spaces ahead function name cs_etm__set_pid_tid_cpu(), so
remove one space and correct indentation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 69f21de..822ba91 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -611,8 +611,8 @@ cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
 	return buff->len;
 }
 
-static void  cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
-				     struct auxtrace_queue *queue)
+static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
+				    struct auxtrace_queue *queue)
 {
 	struct cs_etm_queue *etmq = queue->priv;
 
-- 
2.7.4
