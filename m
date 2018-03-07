Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeCGKyt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:54:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:45445 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbeCGKyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:54:45 -0500
From: Takashi Iwai <tiwai@suse.de>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] perf: doc: Correct title markers for asciidoctor
Date: Wed,  7 Mar 2018 11:54:41 +0100
Message-Id: <20180307105441.28512-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've tested to process the perf man pages with asciidoctor that is
picker than asciidoc, and it revealed minor syntax errors in some
documents.  Namely, the title markers aren't aligned with the previous
line, hence asciidoctor didn't recognize as titles.

This patch corrects these markers to be processed properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 tools/perf/Documentation/perf-data.txt        | 2 +-
 tools/perf/Documentation/perf-ftrace.txt      | 2 +-
 tools/perf/Documentation/perf-kallsyms.txt    | 2 +-
 tools/perf/Documentation/perf-sched.txt       | 2 +-
 tools/perf/Documentation/perf-script-perl.txt | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
index 90bb4aabe4f8..c87180764829 100644
--- a/tools/perf/Documentation/perf-data.txt
+++ b/tools/perf/Documentation/perf-data.txt
@@ -1,5 +1,5 @@
 perf-data(1)
-==============
+============
 
 NAME
 ----
diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 721a447f046e..b80c84307dc9 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -1,5 +1,5 @@
 perf-ftrace(1)
-=============
+==============
 
 NAME
 ----
diff --git a/tools/perf/Documentation/perf-kallsyms.txt b/tools/perf/Documentation/perf-kallsyms.txt
index 954ea9e21236..cdd421cd1c57 100644
--- a/tools/perf/Documentation/perf-kallsyms.txt
+++ b/tools/perf/Documentation/perf-kallsyms.txt
@@ -1,5 +1,5 @@
 perf-kallsyms(1)
-==============
+================
 
 NAME
 ----
diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index c7e50f263887..bb33601a823b 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -1,5 +1,5 @@
 perf-sched(1)
-==============
+=============
 
 NAME
 ----
diff --git a/tools/perf/Documentation/perf-script-perl.txt b/tools/perf/Documentation/perf-script-perl.txt
index 142606c0ec9c..5a1f68122f50 100644
--- a/tools/perf/Documentation/perf-script-perl.txt
+++ b/tools/perf/Documentation/perf-script-perl.txt
@@ -1,5 +1,5 @@
 perf-script-perl(1)
-==================
+===================
 
 NAME
 ----
-- 
2.16.2
