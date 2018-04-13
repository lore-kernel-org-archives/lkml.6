Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754960AbeDMODj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754414AbeDMOCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:02:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481162183C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Takuya Yamamoto <tkydevel@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/17] perf sched: Fix documentation for timehist
Date: Fri, 13 Apr 2018 11:01:06 -0300
Message-Id: <20180413140111.25313-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takuya Yamamoto <tkydevel@gmail.com>

Fixed a incorrect option and usage to those shown by "perf sched timehist -h",
i.e. the default is really --call-graph, which is equivalent to -g.

Signed-off-by: Takuya Yamamoto <tkydevel@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-8fzo0dlsi1mku5aqx8brep5s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-sched.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index bb33601a823b..63f938b887dd 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -104,8 +104,8 @@ OPTIONS for 'perf sched timehist'
     kallsyms pathname
 
 -g::
---no-call-graph::
-	Do not display call chains if present.
+--call-graph::
+	Display call chains if present (default on).
 
 --max-stack::
 	Maximum number of functions to display in backtrace, default 5.
-- 
2.14.3
