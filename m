Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeDXPDE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:03:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45706 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbeDXPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:02:57 -0400
X-Google-Smtp-Source: AIpwx49z+7tWrdYbELqJbd/6fkBqi5BZMlEe8DPrBVQQ4TGy3Kb0rTG4FrAYyta4HW/VH/I10Sddmg==
From: Masanari Iida <standby24x7@gmail.com>
To: linux-kernel@vger.kernel.org, ak@linux.intel.com, acme@kernel.org,
        peterz@infradead.org, mingo@redhat.com
Cc: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] perf vendor events intel: Fix double words "are are" in cache.json
Date: Wed, 25 Apr 2018 00:02:49 +0900
Message-Id: <20180424150249.26644-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.17.0.140.g0b0cc9f86731
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix double words "are are".

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/perf/pmu-events/arch/x86/silvermont/cache.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/silvermont/cache.json b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
index 82be7d1b8b81..d961a8cb8215 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/cache.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
@@ -641,7 +641,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand and DCU prefetch instruction cacheline that are are outstanding, per cycle, from the time of the L2 miss to when any response is received.",
+        "BriefDescription": "Counts demand and DCU prefetch instruction cacheline that are outstanding, per cycle, from the time of the L2 miss to when any response is received.",
         "Offcore": "1"
     },
     {
@@ -696,7 +696,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand and DCU prefetch RFOs that are are outstanding, per cycle, from the time of the L2 miss to when any response is received.",
+        "BriefDescription": "Counts demand and DCU prefetch RFOs that are outstanding, per cycle, from the time of the L2 miss to when any response is received.",
         "Offcore": "1"
     },
     {
@@ -751,7 +751,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand and DCU prefetch data read that are are outstanding, per cycle, from the time of the L2 miss to when any response is received.",
+        "BriefDescription": "Counts demand and DCU prefetch data read that are outstanding, per cycle, from the time of the L2 miss to when any response is received.",
         "Offcore": "1"
     },
     {
@@ -809,4 +809,4 @@
         "BriefDescription": "Counts demand and DCU prefetch data read that have any response type.",
         "Offcore": "1"
     }
-]
\ No newline at end of file
+]
-- 
2.17.0.140.g0b0cc9f86731
