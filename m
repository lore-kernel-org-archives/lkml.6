Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeCHTvg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:51:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751574AbeCHTvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:51:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF2720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/54] perf tools: Correct title markers for asciidoctor
Date: Thu,  8 Mar 2018 16:49:53 -0300
Message-Id: <20180308195029.14991-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

I've tested to process the perf man pages with asciidoctor that is
picker than asciidoc, and it revealed minor syntax errors in some
documents.  Namely, the title markers aren't aligned with the previous
line, hence asciidoctor didn't recognize as titles.

This patch corrects these markers to be processed properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307105441.28512-1-tiwai@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index cf9f4040ea5c..f3c620951f6e 100644
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
2.14.3
