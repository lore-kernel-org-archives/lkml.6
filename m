Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeEOGle (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:41:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54125 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeEOGld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:41:33 -0400
Date: Mon, 14 May 2018 23:41:12 -0700
From: tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-3a0887997d6731e1005ba09c93aa5c2898c78931@git.kernel.org>
Cc: leo.yan@linaro.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mathieu.poirier@linaro.org, jolsa@redhat.com,
        peterz@infradead.org, acme@redhat.com, hpa@zytor.com
Reply-To: namhyung@kernel.org, jolsa@redhat.com, mathieu.poirier@linaro.org,
        acme@redhat.com, peterz@infradead.org, hpa@zytor.com,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de
In-Reply-To: <1525924920-4381-2-git-send-email-leo.yan@linaro.org>
References: <1525924920-4381-2-git-send-email-leo.yan@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf cs-etm: Remove redundant space
Git-Commit-ID: 3a0887997d6731e1005ba09c93aa5c2898c78931
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

Commit-ID:  3a0887997d6731e1005ba09c93aa5c2898c78931
Gitweb:     https://git.kernel.org/tip/3a0887997d6731e1005ba09c93aa5c2898c78931
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Thu, 10 May 2018 12:02:00 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 11 May 2018 10:46:36 -0300

perf cs-etm: Remove redundant space

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
 
