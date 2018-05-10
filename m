Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757350AbeEJSN6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:13:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51271 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757277AbeEJSN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:13:56 -0400
Date: Thu, 10 May 2018 11:13:32 -0700
From: tip-bot for William Cohen <tipbot@zytor.com>
Message-ID: <tip-ea9032fa2e4e91ae15facff5b7c4b2a84c1e40af@git.kernel.org>
Cc: hpa@zytor.com, alexander.shishkin@linux.intel.com, wcohen@redhat.com,
        peterz@infradead.org, jolsa@redhat.com, namhyung@kernel.org,
        acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, wcohen@redhat.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com, jolsa@redhat.com,
        peterz@infradead.org
In-Reply-To: <20180503195032.28871-1-wcohen@redhat.com>
References: <20180503195032.28871-1-wcohen@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf vendor events intel: Remove duplicated entry
 for westmereep-dp in mapfile.csv
Git-Commit-ID: ea9032fa2e4e91ae15facff5b7c4b2a84c1e40af
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

Commit-ID:  ea9032fa2e4e91ae15facff5b7c4b2a84c1e40af
Gitweb:     https://git.kernel.org/tip/ea9032fa2e4e91ae15facff5b7c4b2a84c1e40af
Author:     William Cohen <wcohen@redhat.com>
AuthorDate: Thu, 3 May 2018 15:50:32 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 7 May 2018 15:23:45 -0300

perf vendor events intel: Remove duplicated entry for westmereep-dp in mapfile.csv

Signed-off-by: William Cohen <wcohen@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180503195032.28871-1-wcohen@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 93656f2fd53a..7e3cce3bcf3b 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -29,7 +29,6 @@ GenuineIntel-6-4D,v13,silvermont,core
 GenuineIntel-6-4C,v13,silvermont,core
 GenuineIntel-6-2A,v15,sandybridge,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
-GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-55,v1,skylakex,core
