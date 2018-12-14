Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A15C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C74E206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbeLNUmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:42:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52221 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbeLNUmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:42:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKeCXI1456081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:40:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKeB3i1456077;
        Fri, 14 Dec 2018 12:40:11 -0800
Date:   Fri, 14 Dec 2018 12:40:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-9512bca1ede7cba3a718d90db33973c556c69534@git.kernel.org>
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        ak@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, mingo@kernel.org
Reply-To: jolsa@redhat.com, ak@linux.intel.com, peterz@infradead.org,
          acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          namhyung@kernel.org, tglx@linutronix.de,
          kan.liang@linux.intel.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20181203102200.GA104797@gmail.com>
References: <20181203102200.GA104797@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events intel: Fix diverse typos
Git-Commit-ID: 9512bca1ede7cba3a718d90db33973c556c69534
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

Commit-ID:  9512bca1ede7cba3a718d90db33973c556c69534
Gitweb:     https://git.kernel.org/tip/9512bca1ede7cba3a718d90db33973c556c69534
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Mon, 3 Dec 2018 11:22:00 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 14:12:30 -0300

perf vendor events intel: Fix diverse typos

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

( Care should be taken not to re-import these typos in the future,
  if the JSON files get updated by the vendor without fixing the typos. )

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease cherry
picking and/or backporting, split this into multiple patches.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/pmu-events/arch/x86/broadwell/cache.json  |  4 +--
 .../pmu-events/arch/x86/broadwell/pipeline.json    |  2 +-
 .../pmu-events/arch/x86/broadwellde/cache.json     |  4 +--
 .../pmu-events/arch/x86/broadwellde/pipeline.json  |  2 +-
 .../perf/pmu-events/arch/x86/broadwellx/cache.json |  4 +--
 .../pmu-events/arch/x86/broadwellx/pipeline.json   |  2 +-
 tools/perf/pmu-events/arch/x86/jaketown/cache.json |  4 +--
 .../pmu-events/arch/x86/jaketown/pipeline.json     |  2 +-
 .../pmu-events/arch/x86/knightslanding/cache.json  | 30 +++++++++++-----------
 .../pmu-events/arch/x86/sandybridge/cache.json     |  4 +--
 .../pmu-events/arch/x86/sandybridge/pipeline.json  |  2 +-
 .../pmu-events/arch/x86/skylakex/uncore-other.json | 12 ++++-----
 12 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/cache.json b/tools/perf/pmu-events/arch/x86/broadwell/cache.json
index bba3152ec54a..0b080b0352d8 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/cache.json
@@ -433,7 +433,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x41",
@@ -445,7 +445,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x42",
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
index 97c5d0784c6c..999cf3066363 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
@@ -317,7 +317,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts stalls occured due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occurred due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
         "EventCode": "0x87",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
index bf243fe2a0ec..4ad425312bdc 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
@@ -439,7 +439,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -451,7 +451,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "SampleAfterValue": "100003",
         "L1_Hit_Indication": "1",
         "CounterHTOff": "0,1,2,3"
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
index 920c89da9111..0d04bf9db000 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
@@ -322,7 +322,7 @@
         "BriefDescription": "Stalls caused by changing prefix length of the instruction.",
         "Counter": "0,1,2,3",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "This event counts stalls occured due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occurred due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json b/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
index bf0c51272068..141b1080429d 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
@@ -439,7 +439,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -451,7 +451,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "SampleAfterValue": "100003",
         "L1_Hit_Indication": "1",
         "CounterHTOff": "0,1,2,3"
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
index 920c89da9111..0d04bf9db000 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
@@ -322,7 +322,7 @@
         "BriefDescription": "Stalls caused by changing prefix length of the instruction.",
         "Counter": "0,1,2,3",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "This event counts stalls occured due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occurred due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/cache.json b/tools/perf/pmu-events/arch/x86/jaketown/cache.json
index f723e8f7bb09..ee22e4a5e30d 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/cache.json
@@ -31,7 +31,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This event counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This event counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x41",
@@ -42,7 +42,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This event counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This event counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x42",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
index 8a597e45ed84..34a519d9bfa0 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
@@ -778,7 +778,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceeding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
+        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
         "EventCode": "0x03",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
index 88ba5994b994..e434ec723001 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
@@ -121,7 +121,7 @@
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Prefetch requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts any Prefetch requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -187,7 +187,7 @@
         "EventName": "OFFCORE_RESPONSE.ANY_READ.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Read request  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts any Read request  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -253,7 +253,7 @@
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -319,7 +319,7 @@
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data write requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Demand cacheable data write requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -385,7 +385,7 @@
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -451,7 +451,7 @@
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any request that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts any request that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -539,7 +539,7 @@
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L1 data HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts L1 data HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -605,7 +605,7 @@
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Software Prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Software Prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -682,7 +682,7 @@
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Bus locks and split lock requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Bus locks and split lock requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -748,7 +748,7 @@
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -869,7 +869,7 @@
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -935,7 +935,7 @@
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 code HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts L2 code HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -1067,7 +1067,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand code reads and prefetch code reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts demand code reads and prefetch code reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -1133,7 +1133,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data writes that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Demand cacheable data writes that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -1199,7 +1199,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json b/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
index bef73c499f83..16b04a20bc12 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
@@ -31,7 +31,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This event counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This event counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x41",
@@ -42,7 +42,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This event counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This event counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x42",
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
index 8a597e45ed84..34a519d9bfa0 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
@@ -778,7 +778,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceeding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
+        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
         "EventCode": "0x03",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
index de6e70e552e2..adb42c72f5c8 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
@@ -428,7 +428,7 @@
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to it's home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This reponse will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
+        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to it's home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This response will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
         "UMask": "0x10",
         "Unit": "CHA"
     },
@@ -967,7 +967,7 @@
         "EventCode": "0x57",
         "EventName": "UNC_M2M_PREFCAM_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) recieves a prefetch request and inserts it into its outstanding prefetch queue.  Explanatory Side Note: the prefect queue is made from CAM: Content Addressable Memory",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) receives a prefetch request and inserts it into its outstanding prefetch queue.  Explanatory Side Note: the prefect queue is made from CAM: Content Addressable Memory",
         "Unit": "M2M"
     },
     {
@@ -1041,7 +1041,7 @@
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT0",
         "PerPkg": "1",
-        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot0 RxQ buffer (Receive Queue) and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transfered, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
+        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot0 RxQ buffer (Receive Queue) and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transferred, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
         "UMask": "0x1",
         "Unit": "UPI LL"
     },
@@ -1051,17 +1051,17 @@
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT1",
         "PerPkg": "1",
-        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot1 RxQ buffer  (Receive Queue) and passed directly across the BGF and into the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transfered, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
+        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot1 RxQ buffer  (Receive Queue) and passed directly across the BGF and into the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transferred, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
         "UMask": "0x2",
         "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "FLITs received which bypassed the Slot0 Recieve Buffer",
+        "BriefDescription": "FLITs received which bypassed the Slot0 Receive Buffer",
         "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT2",
         "PerPkg": "1",
-        "PublicDescription": "Counts incoming FLITs (FLow control unITs) whcih bypassed the slot2 RxQ buffer (Receive Queue)  and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transfered, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
+        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot2 RxQ buffer (Receive Queue)  and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transferred, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
         "UMask": "0x4",
         "Unit": "UPI LL"
     },
