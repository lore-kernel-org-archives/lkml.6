Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbeDPGrB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:47:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55423 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbeDPGrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:47:00 -0400
Date: Sun, 15 Apr 2018 23:46:40 -0700
From: tip-bot for Takuya Yamamoto <tipbot@zytor.com>
Message-ID: <tip-8fzo0dlsi1mku5aqx8brep5s@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com, tkydevel@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org
Reply-To: mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, tkydevel@gmail.com, acme@redhat.com,
        linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf sched: Fix documentation for timehist
Git-Commit-ID: e8103e44cebe2ef891bc3a5c6c4b74854846968b
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

Commit-ID:  e8103e44cebe2ef891bc3a5c6c4b74854846968b
Gitweb:     https://git.kernel.org/tip/e8103e44cebe2ef891bc3a5c6c4b74854846968b
Author:     Takuya Yamamoto <tkydevel@gmail.com>
AuthorDate: Tue, 10 Apr 2018 23:35:39 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 12 Apr 2018 10:33:36 -0300

perf sched: Fix documentation for timehist

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
