Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeCIImT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:42:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeCIImO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:42:14 -0500
Date: Fri, 9 Mar 2018 00:41:50 -0800
From: tip-bot for Takashi Iwai <tipbot@zytor.com>
Message-ID: <tip-ea66536ab2cac7ba1553a677b8114f1b120cd9f2@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, tiwai@suse.de, acme@redhat.com,
        peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        tiwai@suse.de, acme@redhat.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20180307105441.28512-1-tiwai@suse.de>
References: <20180307105441.28512-1-tiwai@suse.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Correct title markers for asciidoctor
Git-Commit-ID: ea66536ab2cac7ba1553a677b8114f1b120cd9f2
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

Commit-ID:  ea66536ab2cac7ba1553a677b8114f1b120cd9f2
Gitweb:     https://git.kernel.org/tip/ea66536ab2cac7ba1553a677b8114f1b120cd9f2
Author:     Takashi Iwai <tiwai@suse.de>
AuthorDate: Wed, 7 Mar 2018 11:54:41 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 7 Mar 2018 10:26:32 -0300

perf tools: Correct title markers for asciidoctor

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
