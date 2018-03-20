Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeCTG0v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:26:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47759 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeCTG0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:26:48 -0400
Date: Mon, 19 Mar 2018 23:26:16 -0700
From: tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-3d4caec1600e0bf34600a7b700599a20df03629e@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, hpa@zytor.com, namhyung@kernel.org,
        john.garry@huawei.com, will.deacon@arm.com, tglx@linutronix.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        mingo@kernel.org, jolsa@redhat.com, ganapatrao.kulkarni@cavium.com,
        wcohen@redhat.com, acme@redhat.com, zhangshaokun@hisilicon.com
Reply-To: alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        will.deacon@arm.com, namhyung@kernel.org, john.garry@huawei.com,
        hpa@zytor.com, mingo@kernel.org, ganapatrao.kulkarni@cavium.com,
        jolsa@redhat.com, ak@linux.intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, zhangshaokun@hisilicon.com,
        acme@redhat.com, wcohen@redhat.com
In-Reply-To: <1520506716-197429-12-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-12-git-send-email-john.garry@huawei.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events arm64: add HiSilicon hip08 JSON
 file
Git-Commit-ID: 3d4caec1600e0bf34600a7b700599a20df03629e
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

Commit-ID:  3d4caec1600e0bf34600a7b700599a20df03629e
Gitweb:     https://git.kernel.org/tip/3d4caec1600e0bf34600a7b700599a20df03629e
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Thu, 8 Mar 2018 18:58:36 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:54:59 -0300

perf vendor events arm64: add HiSilicon hip08 JSON file

This patch adds the HiSilicon hip08 JSON file. This platform follows the
ARMv8 recommended IMPLEMENTATION DEFINED events, where applicable.

Signed-off-by: John Garry <john.garry@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1520506716-197429-12-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/arm64/hisilicon/hip08/core-imp-def.json   | 122 +++++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 2 files changed, 123 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
new file mode 100644
index 000000000000..9f0f15d15f75
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
@@ -0,0 +1,122 @@
+[
+    {
+        "ArchStdEvent": "L1D_CACHE_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL",
+    },
+    {
+        "PublicDescription": "Level 1 instruction cache prefetch access count",
+        "EventCode": "0x102e",
+        "EventName": "L1I_CACHE_PRF",
+        "BriefDescription": "L1I cache prefetch access count",
+    },
+    {
+        "PublicDescription": "Level 1 instruction cache miss due to prefetch access count",
+        "EventCode": "0x102f",
+        "EventName": "L1I_CACHE_PRF_REFILL",
+        "BriefDescription": "L1I cache miss due to prefetch access count",
+    },
+    {
+        "PublicDescription": "Instruction queue is empty",
+        "EventCode": "0x1043",
+        "EventName": "IQ_IS_EMPTY",
+        "BriefDescription": "Instruction queue is empty",
+    },
+    {
+        "PublicDescription": "Instruction fetch stall cycles",
+        "EventCode": "0x1044",
+        "EventName": "IF_IS_STALL",
+        "BriefDescription": "Instruction fetch stall cycles",
+    },
+    {
+        "PublicDescription": "Instructions can receive, but not send",
+        "EventCode": "0x2014",
+        "EventName": "FETCH_BUBBLE",
+        "BriefDescription": "Instructions can receive, but not send",
+    },
+    {
+        "PublicDescription": "Prefetch request from LSU",
+        "EventCode": "0x6013",
+        "EventName": "PRF_REQ",
+        "BriefDescription": "Prefetch request from LSU",
+    },
+    {
+        "PublicDescription": "Hit on prefetched data",
+        "EventCode": "0x6014",
+        "EventName": "HIT_ON_PRF",
+        "BriefDescription": "Hit on prefetched data",
+    },
+    {
+        "PublicDescription": "Cycles of that the number of issuing micro operations are less than 4",
+        "EventCode": "0x7001",
+        "EventName": "EXE_STALL_CYCLE",
+        "BriefDescription": "Cycles of that the number of issue ups are less than 4",
+    },
+    {
+        "PublicDescription": "No any micro operation is issued and meanwhile any load operation is not resolved",
+        "EventCode": "0x7004",
+        "EventName": "MEM_STALL_ANYLOAD",
+        "BriefDescription": "No any micro operation is issued and meanwhile any load operation is not resolved",
+    },
+    {
+        "PublicDescription": "No any micro operation is issued and meanwhile there is any load operation missing L1 cache and pending data refill",
+        "EventCode": "0x7006",
+        "EventName": "MEM_STALL_L1MISS",
+        "BriefDescription": "No any micro operation is issued and meanwhile there is any load operation missing L1 cache and pending data refill",
+    },
+    {
+        "PublicDescription": "No any micro operation is issued and meanwhile there is any load operation missing both L1 and L2 cache and pending data refill from L3 cache",
+        "EventCode": "0x7007",
+        "EventName": "MEM_STALL_L2MISS",
+        "BriefDescription": "No any micro operation is issued and meanwhile there is any load operation missing both L1 and L2 cache and pending data refill from L3 cache",
+    },
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index cf14e23b6404..8f11aeb003a9 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -14,3 +14,4 @@
 #Family-model,Version,Filename,EventType
 0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
 0x00000000420f5160,v1,cavium/thunderx2,core
+0x00000000480fd010,v1,hisilicon/hip08,core
