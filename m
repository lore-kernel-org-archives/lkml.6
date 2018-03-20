Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeCTGZ5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:25:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38275 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeCTGZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:25:54 -0400
Date: Mon, 19 Mar 2018 23:25:15 -0700
From: tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-ae43053bd2595dc98f0909505dc1d7e1ed8bd239@git.kernel.org>
Cc: namhyung@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, wcohen@redhat.com,
        ganapatrao.kulkarni@cavium.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        john.garry@huawei.com, jolsa@redhat.com, zhangshaokun@hisilicon.com,
        mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org
Reply-To: ak@linux.intel.com, namhyung@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, ganapatrao.kulkarni@cavium.com,
        hpa@zytor.com, wcohen@redhat.com, alexander.shishkin@linux.intel.com,
        john.garry@huawei.com, jolsa@redhat.com, acme@redhat.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@kernel.org,
        zhangshaokun@hisilicon.com
In-Reply-To: <1520506716-197429-10-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-10-git-send-email-john.garry@huawei.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events arm64: Fixup ThunderX2 to use
 recommended events
Git-Commit-ID: ae43053bd2595dc98f0909505dc1d7e1ed8bd239
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

Commit-ID:  ae43053bd2595dc98f0909505dc1d7e1ed8bd239
Gitweb:     https://git.kernel.org/tip/ae43053bd2595dc98f0909505dc1d7e1ed8bd239
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Thu, 8 Mar 2018 18:58:34 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:54:48 -0300

perf vendor events arm64: Fixup ThunderX2 to use recommended events

This patch fixes the Cavium ThunderX2 JSON to use event definitions from
the ARMv8 recommended events.

Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1520506716-197429-10-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 50 +++++-----------------
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
index 2db45c40ebc7..bc03c06c3918 100644
--- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
@@ -1,62 +1,32 @@
 [
     {
-        "PublicDescription": "Attributable Level 1 data cache access, read",
-        "EventCode": "0x40",
-        "EventName": "l1d_cache_rd",
-        "BriefDescription": "L1D cache read",
+        "ArchStdEvent": "L1D_CACHE_RD",
     },
     {
-        "PublicDescription": "Attributable Level 1 data cache access, write ",
-        "EventCode": "0x41",
-        "EventName": "l1d_cache_wr",
-        "BriefDescription": "L1D cache write",
+        "ArchStdEvent": "L1D_CACHE_WR",
     },
     {
-        "PublicDescription": "Attributable Level 1 data cache refill, read",
-        "EventCode": "0x42",
-        "EventName": "l1d_cache_refill_rd",
-        "BriefDescription": "L1D cache refill read",
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
     },
     {
-        "PublicDescription": "Attributable Level 1 data cache refill, write",
-        "EventCode": "0x43",
-        "EventName": "l1d_cache_refill_wr",
-        "BriefDescription": "L1D refill write",
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
     },
     {
-        "PublicDescription": "Attributable Level 1 data TLB refill, read",
-        "EventCode": "0x4C",
-        "EventName": "l1d_tlb_refill_rd",
-        "BriefDescription": "L1D tlb refill read",
+        "ArchStdEvent": "L1D_TLB_REFILL_RD",
     },
     {
-        "PublicDescription": "Attributable Level 1 data TLB refill, write",
-        "EventCode": "0x4D",
-        "EventName": "l1d_tlb_refill_wr",
-        "BriefDescription": "L1D tlb refill write",
+        "ArchStdEvent": "L1D_TLB_REFILL_WR",
     },
     {
-        "PublicDescription": "Attributable Level 1 data or unified TLB access, read",
-        "EventCode": "0x4E",
-        "EventName": "l1d_tlb_rd",
-        "BriefDescription": "L1D tlb read",
+        "ArchStdEvent": "L1D_TLB_RD",
     },
     {
-        "PublicDescription": "Attributable Level 1 data or unified TLB access, write",
-        "EventCode": "0x4F",
-        "EventName": "l1d_tlb_wr",
-        "BriefDescription": "L1D tlb write",
+        "ArchStdEvent": "L1D_TLB_WR",
     },
     {
-        "PublicDescription": "Bus access read",
-        "EventCode": "0x60",
-        "EventName": "bus_access_rd",
-        "BriefDescription": "Bus access read",
+        "ArchStdEvent": "BUS_ACCESS_RD",
    },
    {
-        "PublicDescription": "Bus access write",
-        "EventCode": "0x61",
-        "EventName": "bus_access_wr",
-        "BriefDescription": "Bus access write",
+        "ArchStdEvent": "BUS_ACCESS_WR",
    }
 ]
