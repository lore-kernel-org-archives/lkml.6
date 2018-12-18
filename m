Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D196CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7480217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeLROIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:08:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50433 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbeLROIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:08:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIE8Dkt2853624
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:08:13 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIE8D0t2853618;
        Tue, 18 Dec 2018 06:08:13 -0800
Date:   Tue, 18 Dec 2018 06:08:13 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-1a7ea3283f7d15d7ce76a30870c3ca648adf1fc4@git.kernel.org>
Cc:     acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, jolsa@redhat.com,
        peterz@infradead.org, mingo@kernel.org
Reply-To: acme@redhat.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          jolsa@redhat.com, peterz@infradead.org, mingo@kernel.org
In-Reply-To: <20181203102200.GA104797@gmail.com>
References: <20181203102200.GA104797@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools Documentation: Fix diverse typos
Git-Commit-ID: 1a7ea3283f7d15d7ce76a30870c3ca648adf1fc4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1a7ea3283f7d15d7ce76a30870c3ca648adf1fc4
Gitweb:     https://git.kernel.org/tip/1a7ea3283f7d15d7ce76a30870c3ca648adf1fc4
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Mon, 3 Dec 2018 11:22:00 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:56:36 -0300

perf tools Documentation: Fix diverse typos

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease cherry
picking and/or backporting, split this into multiple patches.

In this particular case, it affects documentation, so may be interesting
to cherry pick as it is information that is presented to the user.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt   | 2 +-
 tools/perf/Documentation/perf-report.txt | 2 +-
 tools/perf/Documentation/perf-stat.txt   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 667c14e56031..138fb6e94b3c 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -172,7 +172,7 @@ like cycles and instructions and some software events.
 Other PMUs and global measurements are normally root only.
 Some event qualifiers, such as "any", are also root only.
 
-This can be overriden by setting the kernel.perf_event_paranoid
+This can be overridden by setting the kernel.perf_event_paranoid
 sysctl to -1, which allows non root to use these events.
 
 For accessing trace point events perf needs to have read access to
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index ed2bf37ab132..1a27bfe05039 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -252,7 +252,7 @@ OPTIONS
 	          Usually more convenient to use --branch-history for this.
 
 	value can be:
-	- percent: diplay overhead percent (default)
+	- percent: display overhead percent (default)
 	- period: display event period
 	- count: display event count
 
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index b10a90b6a718..4bc2085e5197 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -50,7 +50,7 @@ report::
 	  /sys/bus/event_source/devices/<pmu>/format/*
 
 	Note that the last two syntaxes support prefix and glob matching in
-	the PMU name to simplify creation of events accross multiple instances
+	the PMU name to simplify creation of events across multiple instances
 	of the same type of PMU in large systems (e.g. memory controller PMUs).
 	Multiple PMU instances are typical for uncore PMUs, so the prefix
 	'uncore_' is also ignored when performing this match.
@@ -277,7 +277,7 @@ echo 0 > /proc/sys/kernel/nmi_watchdog
 for best results. Otherwise the bottlenecks may be inconsistent
 on workload with changing phases.
 
-This enables --metric-only, unless overriden with --no-metric-only.
+This enables --metric-only, unless overridden with --no-metric-only.
 
 To interpret the results it is usually needed to know on which
 CPUs the workload runs on. If needed the CPUs can be forced using
