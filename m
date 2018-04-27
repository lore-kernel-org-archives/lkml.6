Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758310AbeD0SwM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 14:52:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33276 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757996AbeD0SwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 14:52:10 -0400
From: Colin King <colin.king@canonical.com>
To: Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Subject: [PATCH] perf vendor events: fix spelling mistake: "alloacated" -> "allocated"
Date: Fri, 27 Apr 2018 19:52:06 +0100
Message-Id: <20180427185206.16347-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes in json text strings

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/perf/pmu-events/arch/x86/nehalemep/cache.json     | 4 ++--
 tools/perf/pmu-events/arch/x86/nehalemex/cache.json     | 4 ++--
 tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json | 4 ++--
 tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json | 4 ++--
 tools/perf/pmu-events/arch/x86/westmereex/cache.json    | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
index a11029efda2f..c20ff6b3cb9d 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
@@ -333,7 +333,7 @@
         "UMask": "0x7",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 lines alloacated"
+        "BriefDescription": "L2 lines allocated"
     },
     {
         "EventCode": "0xF1",
@@ -3226,4 +3226,4 @@
         "BriefDescription": "Offcore prefetch requests that HITM in a remote cache",
         "Offcore": "1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
index 21a0f8fd057e..79f7120c50a5 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
@@ -333,7 +333,7 @@
         "UMask": "0x7",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 lines alloacated"
+        "BriefDescription": "L2 lines allocated"
     },
     {
         "EventCode": "0xF1",
@@ -3181,4 +3181,4 @@
         "BriefDescription": "Offcore prefetch requests that HITM in a remote cache",
         "Offcore": "1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
index 6e61ae20d01a..08fa9ebf056a 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
@@ -213,7 +213,7 @@
         "UMask": "0x7",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 lines alloacated"
+        "BriefDescription": "L2 lines allocated"
     },
     {
         "EventCode": "0xF1",
@@ -2814,4 +2814,4 @@
         "BriefDescription": "REQUEST = PREFETCH and RESPONSE = REMOTE_CACHE_HITM",
         "Offcore": "1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
index dad20f0e3cac..be612cda6b68 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
@@ -213,7 +213,7 @@
         "UMask": "0x7",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 lines alloacated"
+        "BriefDescription": "L2 lines allocated"
     },
     {
         "EventCode": "0xF1",
@@ -3230,4 +3230,4 @@
         "BriefDescription": "Offcore prefetch requests that HITM in a remote cache",
         "Offcore": "1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/cache.json b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
index f9bc7fdd48d6..c5896ed6542c 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
@@ -213,7 +213,7 @@
         "UMask": "0x7",
         "EventName": "L2_LINES_IN.ANY",
         "SampleAfterValue": "100000",
-        "BriefDescription": "L2 lines alloacated"
+        "BriefDescription": "L2 lines allocated"
     },
     {
         "EventCode": "0xF1",
@@ -3222,4 +3222,4 @@
         "BriefDescription": "Offcore prefetch requests that HITM in a remote cache",
         "Offcore": "1"
     }
-]
\ No newline at end of file
+]
-- 
2.17.0
